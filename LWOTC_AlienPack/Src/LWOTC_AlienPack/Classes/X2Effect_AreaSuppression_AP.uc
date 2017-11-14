///---------------------------------------------------------------------------------------
//  FILE:    X2Effect_AreaSuppression
//  AUTHOR:  Amineri (Long War Studios)
//  PURPOSE: Implements AoE Damage immunities for Bastion, based on Solace ability
//---------------------------------------------------------------------------------------
class X2Effect_AreaSuppression_AP extends X2Effect_Suppression config(LW_PerkPack);

function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	if(Target.IsUnitAffectedByEffectName(class'X2Effect_Suppression'.default.EffectName))
		return;

	super.GetToHitModifiers(EffectState, Attacker, Target, AbilityState, ToHitType, bMelee, bFlanking, bIndirectFire, ShotModifiers);
}

simulated function OnEffectRemoved(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState, bool bCleansed, XComGameState_Effect RemovedEffectState)
{
	local XComGameStateHistory History;
	local XComGameState_Unit SourceState, TargetState;
	local name TestEffectName;
	local int count;
	local XComGameState_Effect EffectState;
	local bool bCanMaintainSuppression;
	local StateObjectReference NullRef;

	History = `XCOMHISTORY;
	bCanMaintainSuppression = false;

	SourceState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(RemovedEffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	if(SourceState == none)
	{
		SourceState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', RemovedEffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
		NewGameState.AddStateObject(SourceState);
	}
	foreach SourceState.AppliedEffectNames(TestEffectName, count)
	{
		if(TestEffectName == default.EffectName)
		{
			EffectState = XComGameState_Effect(History.GetGameStateForObjectID( SourceState.AppliedEffects[ count ].ObjectID ) );
			TargetState = XComGameState_Unit(History.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
			if(TargetState != none)
			{
				if(TargetState.IsAlive())
				{
					SourceState.m_MultiTurnTargetRef = TargetState.GetReference();
					bCanMaintainSuppression = true;
					break;
				}
			}
		}
	}

	if(!bCanMaintainSuppression)
	{
		SourceState.m_MultiTurnTargetRef = NullRef;
	}

	super.OnEffectRemoved(ApplyEffectParameters, NewGameState, bCleansed, RemovedEffectState);
}

simulated function XComGameState_Unit UpdateAreaSuppressionTarget(XComGameState VisualizeGameState, out VisualizationTrack BuildTrack, const name EffectApplyResult, XComGameState_Effect RemovedEffect)
{
	local XComGameStateHistory History;
	local XComGameState_Unit SourceState, TargetState;
	local name TestEffectName;
	local int count;
	local XComGameState_Effect EffectState;
	//local bool bCanMaintainSuppression;
	local XGUnit SourceUnit, TargetUnit;

	History = `XCOMHISTORY;

	SourceState = XComGameState_Unit(History.GetGameStateForObjectID(RemovedEffect.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	//bCanMaintainSuppression = false;
	foreach SourceState.AppliedEffectNames(TestEffectName, count)
	{
		if(TestEffectName == default.EffectName)
		{
			EffectState = XComGameState_Effect(History.GetGameStateForObjectID( SourceState.AppliedEffects[ count ].ObjectID ) );
			TargetState = XComGameState_Unit(History.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
			if(TargetState != none)
			{
				if(TargetState.IsAlive())
				{
					//bCanMaintainSuppression = true;
					SourceUnit = XGUnit(SourceState.GetVisualizer());
					if(SourceUnit.m_kForceConstantCombatTarget != none)
					{
						// remove the marking on the old target, so it doesn't disable the suppression state in the XGUnit.OnDeath
						SourceUnit.m_kForceConstantCombatTarget.m_kConstantCombatUnitTargetingMe = none;
					}
					TargetUnit = XGUnit(TargetState.GetVisualizer());
					
					SourceUnit.ConstantCombatSuppressArea(false);
					SourceUnit.ConstantCombatSuppress(true, TargetUnit);
					SourceUnit.IdleStateMachine.CheckForStanceUpdate();
					return TargetState;
				}
			}
		}
	}
	//return bCanMaintainSuppression;
}

simulated function AddX2ActionsForVisualization_RemovedSource(XComGameState VisualizeGameState, out VisualizationTrack BuildTrack, const name EffectApplyResult, XComGameState_Effect RemovedEffect)
{
	local X2Action_EnterCover Action;
	local XComGameStateHistory History;
	local XComGameState_Unit SourceState;

	if(UpdateAreaSuppressionTarget(VisualizeGameState, BuildTrack, EffectApplyResult, RemovedEffect) != none)
		return;

	History = `XCOMHISTORY;
	SourceState = XComGameState_Unit(History.GetGameStateForObjectID(RemovedEffect.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	class'X2Action_StopSuppression'.static.AddToVisualizationTrack(BuildTrack, VisualizeGameState.GetContext());
	Action = X2Action_EnterCover(class'X2Action_EnterCover'.static.AddToVisualizationTrack(BuildTrack, VisualizeGameState.GetContext()));
	Action.AbilityContext = SourceState.m_SuppressionAbilityContext;
}

simulated function CleansedSuppressionVisualization(XComGameState VisualizeGameState, out VisualizationTrack BuildTrack, const name EffectApplyResult)
{
	local XComGameStateHistory History;
	local XComGameState_Effect EffectState, SuppressionEffect;
	local X2Action_EnterCover Action;
	local XComGameState_Unit UnitState;

	foreach VisualizeGameState.IterateByClassType(class'XComGameState_Effect', EffectState)
	{
		if (EffectState.bRemoved && EffectState.GetX2Effect() == self)
		{
			SuppressionEffect = EffectState;
			break;
		}
	}
	if (SuppressionEffect != none)
	{
		if(UpdateAreaSuppressionTarget(VisualizeGameState, BuildTrack, EffectApplyResult, SuppressionEffect) != none)
			return;

		History = `XCOMHISTORY;

		UnitState = XComGameState_Unit(History.GetGameStateForObjectID(SuppressionEffect.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
		BuildTrack.TrackActor = History.GetVisualizer(SuppressionEffect.ApplyEffectParameters.SourceStateObjectRef.ObjectID);
		History.GetCurrentAndPreviousGameStatesForObjectID(SuppressionEffect.ApplyEffectParameters.SourceStateObjectRef.ObjectID, BuildTrack.StateObject_OldState, BuildTrack.StateObject_NewState, eReturnType_Reference, VisualizeGameState.HistoryIndex);
		if (BuildTrack.StateObject_NewState == none)
			BuildTrack.StateObject_NewState = BuildTrack.StateObject_OldState;

		class'X2Action_StopSuppression'.static.AddToVisualizationTrack(BuildTrack, VisualizeGameState.GetContext());
		Action = X2Action_EnterCover(class'X2Action_EnterCover'.static.AddToVisualizationTrack(BuildTrack, VisualizeGameState.GetContext()));

		Action.AbilityContext = UnitState.m_SuppressionAbilityContext;
	}
}

DefaultProperties
{
	EffectName="AreaSuppression_AP"
}