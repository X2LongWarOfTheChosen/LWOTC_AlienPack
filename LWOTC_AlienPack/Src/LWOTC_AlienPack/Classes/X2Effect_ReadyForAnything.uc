class X2Effect_ReadyForAnything extends X2Effect_Persistent;

function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local XComGameState_Ability					AbilityState;

	if (XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID)) == none)
		return false;

	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
	if (AbilityState != none)
	{
		if (kAbility.GetMyTemplateName() == 'StandardShot')
		{
			if (SourceUnit.NumActionPoints() == 0)
			{
				SourceUnit.ReserveActionPoints.AddItem(class'X2CharacterTemplateManager'.default.OverwatchReserveActionPoint);
				NewGameState.AddStateObject(SourceUnit);
				`XEVENTMGR.TriggerEvent('ReadyForAnythingTriggered', AbilityState, SourceUnit, NewGameState);
				return true;
			}

		}
	}
	return false;
}
