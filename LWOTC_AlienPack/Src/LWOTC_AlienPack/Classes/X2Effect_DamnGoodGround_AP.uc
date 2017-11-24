//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_DamnGoodGround
//  AUTHOR:  John Lumpkin (Long War Studios)
//  PURPOSE: Sets up aim and defense bonuses for DG
//---------------------------------------------------------------------------------------

class X2Effect_DamnGoodGround_AP extends X2Effect_Persistent config (LWOTC_AlienPack);

var config int DGG_AIM_BONUS;
var config int DGG_DEF_BONUS;

function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
  local XComGameState_Item SourceWeapon;
  local ShotModifierInfo ShotInfo;

  SourceWeapon = AbilityState.GetSourceWeapon();
  if(SourceWeapon != none)
  {
    if (Attacker.HasHeightAdvantageOver(Target, true))
    {
      ShotInfo.ModType = eHit_Success;
      ShotInfo.Reason = FriendlyName;
      ShotInfo.Value = default.DGG_AIM_BONUS;
      ShotModifiers.AddItem(ShotInfo);
    }
  }
}

function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
  local ShotModifierInfo ShotInfo;

  if (Target.HasHeightAdvantageOver(Attacker, true))
  {
    ShotInfo.ModType = eHit_Success;
    ShotInfo.Reason = FriendlyName;
    ShotInfo.Value = -default.DGG_DEF_BONUS;
    ShotModifiers.AddItem(ShotInfo);
  }
}

defaultproperties
{
  DuplicateResponse=eDupe_Ignore
  EffectName="DamnGoodGround"
}
