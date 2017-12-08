//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_RepairServos
//  AUTHOR:  John Lumpkin (Long War Studios)
//  PURPOSE: Sets up armor bonuses for Repair Servos effect
//---------------------------------------------------------------------------------------
class X2Effect_RepairServos extends X2Effect_BonusArmor config (LWOTC_AlienPack);

var int RepairServosBonusArmor;

function int GetArmorChance(XComGameState_Effect EffectState, XComGameState_Unit UnitState)
{
  return 100;
}

function int GetArmorMitigation(XComGameState_Effect EffectState, XComGameState_Unit UnitState)
{
  return RepairServosBonusArmor;
}
