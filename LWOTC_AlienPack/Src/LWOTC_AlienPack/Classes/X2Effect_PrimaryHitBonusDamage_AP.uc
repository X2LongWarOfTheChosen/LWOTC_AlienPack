class X2Effect_PrimaryHitBonusDamage_AP extends X2Effect_Persistent;

var int BonusDmg;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	if (class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult))
	{
		if(AbilityState.SourceWeapon == EffectState.ApplyEffectParameters.ItemStateObjectRef)
		{
			return BonusDmg;
		}
	}
}
