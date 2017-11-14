//---------------------------------------------------------------------------------------
//  FILE:    XComGameState_Effect_IncomingReactionFire_AP.uc
//  AUTHOR:  John Lumpkin / Amineri (Long War Studios)
//  PURPOSE: This is a component extension for Effect GameStates, which listens for
//		incoming reaction fire for the purpose of triggering other abilities.
//---------------------------------------------------------------------------------------

class XComGameState_Effect_IncomingReactionFire_AP extends XComGameState_Effect_EffectCounter_AP config (LW_AlienPack);

var config array<name> LR_REACTION_FIRE_ABILITYNAMES;
var bool FlyoverTriggered;

function XComGameState.EventListenerReturn IncomingReactionFireCheck(Object EventData, Object EventSource, XComGameState GameState, name EventID)
{
    local XComGameState_Unit			AttackingUnit, DefendingUnit;
    local XComGameState_Ability			ActivatedAbilityState;
    local XComGameStateContext_Ability	AbilityContext;

    AbilityContext = XComGameStateContext_Ability(GameState.GetContext());	
	DefendingUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
	if (DefendingUnit != none)
	{
		if (DefendingUnit.HasSoldierAbility('LightningReflexes_LW_AP'))
		{
			AttackingUnit = class'X2TacticalGameRulesetDataStructures'.static.GetAttackingUnitState(GameState);
			if(AttackingUnit != none && AttackingUnit.IsEnemyUnit(DefendingUnit))
			{
				ActivatedAbilityState = XComGameState_Ability(EventData);
				if (ActivatedAbilityState != none)
				{		
					if (default.LR_REACTION_FIRE_ABILITYNAMES.Find(ActivatedAbilityState.GetMyTemplateName()) != -1)
					{						
						//`LOG ("IRFC HIT, TRIGGERING:" @ string(uses));
						`XEVENTMGR.TriggerEvent('LightningReflexesLWTriggered_AP', ActivatedAbilityState, DefendingUnit, GameState);
						`XEVENTMGR.TriggerEvent('LightningReflexesLWTriggered_AP2', ActivatedAbilityState, DefendingUnit, GameState);
					}
				}
			}
		}	
	}
	return ELR_NoInterrupt;
}


function XComGameState_Effect_IncomingReactionFire_AP InitFlyoverComponent()
{
	FlyoverTriggered = false;
	return self;
}

function XComGameState.EventListenerReturn TriggerLRFlyover(Object EventData, Object EventSource, XComGameState GameState, name EventID)
{
	local XComGameState_Unit	DefendingUnit;
	local XGUnit TargetUnitUnit;
	local XComGameState								NewGameState;
	local XComGameState_Effect_IncomingReactionFire_AP ThisEffect;

	DefendingUnit = XComGameState_Unit(EventSource);
	if (DefendingUnit != none)
	{
		if (DefendingUnit.HasSoldierAbility('LightningReflexes_LW_AP'))
		{
			if (!FlyoverTriggered)
			{
				TargetUnitUnit = XGUnit(`XCOMHISTORY.GetVisualizer(DefendingUnit.ObjectID));
				if (TargetUnitUnit != none)
					class'UIWorldMessageMgr'.static.DamageDisplay(TargetUnitUnit.GetPawn().GetHeadShotLocation(), TargetUnitUnit.GetVisualizedStateReference(), class'XLocalizedData'.default.LightningReflexesMessage);

				NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Update: Toggle LR flyover");
				ThisEffect=XComGameState_Effect_IncomingReactionFire_AP(NewGameState.CreateStateObject(Class,ObjectID));
				ThisEffect.FlyoverTriggered = true;
				NewGameState.AddStateObject(ThisEffect);
				`TACTICALRULES.SubmitGameState(NewGameState);    	
			}
		}
	}
	return ELR_NoInterrupt;
}

simulated function EventListenerReturn ResetFlyover(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
    local XComGameState								NewGameState;
	local XComGameState_Effect_IncomingReactionFire_AP ThisEffect;
	
	if(FlyoverTriggered)
	{
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Update: Reset Flyover");
		ThisEffect=XComGameState_Effect_IncomingReactionFire_AP(NewGameState.CreateStateObject(Class,ObjectID));
		ThisEffect.FlyoverTriggered = false;
		NewGameState.AddStateObject(ThisEffect);
		`TACTICALRULES.SubmitGameState(NewGameState);    
	}
	return ELR_NoInterrupt;
}
