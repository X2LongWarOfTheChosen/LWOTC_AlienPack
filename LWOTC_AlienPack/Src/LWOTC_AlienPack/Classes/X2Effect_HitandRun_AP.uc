//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_HitAndRun
//  AUTHOR:  John Lumpkin (Long War Studios)
//  PURPOSE: Hit and Run effect to grant free action
//---------------------------------------------------------------------------------------

class X2Effect_HitandRun_AP extends X2Effect_Persistent config (LWOTC_AlienPack);

//var config bool HITANDRUN_FULLACTION;
var config array<name> HNR_ABILITYNAMES;

function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager			EventMgr;
	local XComGameState_Unit		UnitState;
	local Object					EffectObj;

	EventMgr = `XEVENTMGR;
	EffectObj = EffectGameState;
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	EventMgr.RegisterForEvent(EffectObj, 'HitandRun', EffectGameState.TriggerAbilityFlyover, ELD_OnStateSubmitted, , UnitState);
}

function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local XComGameStateHistory					History;
	local XComGameState_Unit					TargetUnit;
	local X2EventManager						EventMgr;
	local XComGameState_Ability					AbilityState;
	local GameRulesCache_VisibilityInfo			VisInfo;

	//  if under the effect of Serial, let that handle restoring the full action cost - will this work?
	if (SourceUnit.IsUnitAffectedByEffectName(class'X2Effect_Serial'.default.EffectName))
		return false;

	// Ditto for Death From Above
	if (SourceUnit.IsUnitAffectedByEffectName(class'X2Effect_DeathfromAbove'.default.EffectName))
		return false;

	if (PreCostActionPoints.Find('RunAndGun') != -1)
		return false;

	//  match the weapon associated with Hit and Run to the attacking weapon
	if (kAbility.SourceWeapon == EffectState.ApplyEffectParameters.ItemStateObjectRef)
	{
		History = `XCOMHISTORY;
		TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
		if (!AbilityState.IsMeleeAbility() && TargetUnit != none)
		{
			if(X2TacticalGameRuleset(XComGameInfo(class'Engine'.static.GetCurrentWorldInfo().Game).GameRuleset).VisibilityMgr.GetVisibilityInfo(SourceUnit.ObjectID, TargetUnit.ObjectID, VisInfo))
			{
				if (TargetUnit.IsEnemyUnit(SourceUnit) && SourceUnit.CanFlank() && TargetUnit.CanTakeCover() && VisInfo.TargetCover == CT_None)
				{
					if (default.HNR_ABILITYNAMES.Find(kAbility.GetMyTemplateName()) != -1)
					{
						if (SourceUnit.NumActionPoints() < 2 && PreCostActionPoints.Length > 0)
						{
							AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
							if (AbilityState != none)
							{
								SourceUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.MoveActionPoint);
								EventMgr = `XEVENTMGR;
								EventMgr.TriggerEvent('HitandRun', AbilityState, SourceUnit, NewGameState);
								return true;
							}
						}
					}
				}
			}
		}
	}
	return false;
}
