//---------------------------------------------------------------------------------------
//  FILE:    X2Ability_PPAlienAbilities
//  AUTHOR:  Amineri / John Lumpkin (Long War Studios)
//  PURPOSE: Defines alienpack ability templates copied from PerkPack
//---------------------------------------------------------------------------------------

class X2Ability_PPAlienAbilities extends X2Ability config(LWOTC_AlienPack);

//Tactical Sense
//DepthPerception
//Infighter
//LightningReflexes_LW
//LightEmUp
//DamnGoodGround
//Executioner
//CenterMass
//HitandRun
//LockedOn
//TraverseFire

var config float AREA_SUPPRESSION_RADIUS;
var config int AREA_SUPPRESSION_AMMO_COST;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(AddCenterMassAbility());
	Templates.AddItem(AddDamnGoodGroundAbility());
	Templates.AddItem(AddDepthPerceptionAbility());
	Templates.AddItem(AddExecutionerAbility());
	Templates.AddItem(AddHitandRunAbility());
	Templates.AddItem(AddInfighterAbility());
	Templates.AddItem(AddLightEmUpAbility());
	Templates.AddItem(AddLightningReflexes_LWAbility());
	Templates.AddItem(AddLockedOnAbility());
	Templates.AddItem(AddTacticalSenseAbility());
	Templates.AddItem(AddTraverseFireAbility());
	TEmplates.AddItem(AddAreaSuppressionAbility());
	Templates.AddItem(AreaSuppressionShot_LW_AP());
	return Templates;
}

static function X2AbilityTemplate AddCenterMassAbility()
{
	local X2AbilityTemplate						Template;
	local X2Effect_PrimaryHitBonusDamage_AP     DamageEffect;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'CenterMass_AP');
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityCenterMass"; //TODO
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	DamageEffect = new class'X2Effect_PrimaryHitBonusDamage_AP';
	DamageEffect.BonusDmg = 1;
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(DamageEffect);
	Template.bCrossClassEligible = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

static function X2AbilityTemplate AddHitandRunAbility()
{
	local X2AbilityTemplate				Template;
	local X2Effect_HitandRun_AP			HitandRunEffect;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'HitandRun_AP');
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityHitandRun"; //TODO:
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	HitandRunEffect = new class'X2Effect_HitandRun_AP';
	HitandRunEffect.BuildPersistentEffect(1, true, false, false);
	HitandRunEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage,,,Template.AbilitySourceName);
	HitandRunEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(HitandRunEffect);
	Template.bCrossClassEligible = false;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: Visualization handled in X2Effect_HitandRun_AP
	return Template;
}


static function X2AbilityTemplate AddDamnGoodGroundAbility()
{
	local X2AbilityTemplate					Template;
	local X2Effect_DamnGoodGround_AP		AimandDefModifiers;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'DamnGoodGround_AP');
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityDamnGoodGround"; //TODO
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	AimandDefModifiers = new class 'X2Effect_DamnGoodGround_AP';
	AimandDefModifiers.BuildPersistentEffect (1, true, true);
	AimandDefModifiers.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect (AimandDefModifiers);
	Template.bCrossClassEligible = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

static function X2AbilityTemplate AddExecutionerAbility()
{
	local X2AbilityTemplate					Template;
	local X2Effect_Executioner_AP			AimandCritModifiers;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'Executioner_AP');
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityExecutioner"; //TODO
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	AimandCritModifiers = new class 'X2Effect_Executioner_AP';
	AimandCritModifiers.BuildPersistentEffect (1, true, true);
	AimandCritModifiers.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect (AimandCritModifiers);
	Template.bCrossClassEligible = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}


static function X2AbilityTemplate AddTacticalSenseAbility()
{
	local X2AbilityTemplate				Template;
	local X2Effect_TacticalSense_AP		MyDefModifier;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'TacticalSense_AP');
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityTacticalSense"; //TODO
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bIsPassive = true;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	MyDefModifier = new class 'X2Effect_TacticalSense_AP';
	MyDefModifier.BuildPersistentEffect (1, true, true);
	MyDefModifier.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect (MyDefModifier);
	Template.bCrossClassEligible = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}


static function X2AbilityTemplate AddInfighterAbility()
{
	local X2AbilityTemplate						Template;
	local X2Effect_Infighter_AP					DodgeBonus;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'Infighter_AP');
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityInfighter"; //TODO
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	DodgeBonus = new class 'X2Effect_Infighter_AP';
	DodgeBonus.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	DodgeBonus.BuildPersistentEffect(1, true);
	Template.AddTargetEffect(DodgeBonus);
	Template.bCrossClassEligible = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  No visualization
	return Template;
}

static function X2AbilityTemplate AddDepthPerceptionAbility()
{
	local X2AbilityTemplate					Template;
	local X2Effect_DepthPerception_AP		AttackBonus;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'DepthPerception_AP');
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityDepthPerception"; //TODO
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	//Template.bIsPassive = true;
	AttackBonus = new class 'X2Effect_DepthPerception_AP';
	AttackBonus.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	AttackBonus.BuildPersistentEffect(1, true);
	Template.AddTargetEffect(AttackBonus);
	Template.bCrossClassEligible = false;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

static function X2AbilityTemplate AddLightEmUpAbility()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCost_Ammo                AmmoCost;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local array<name>                       SkipExclusions;
	local X2Effect_Knockback				KnockbackEffect;
	local X2Condition_Visibility            VisibilityCondition;

	// Macro to do localisation and stuffs
	`CREATE_X2ABILITY_TEMPLATE(Template, 'LightEmUp_AP');

	// Icon Properties
	Template.bDontDisplayInAbilitySummary = false;
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityLightEmUp"; //TODO
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STANDARD_SHOT_PRIORITY;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.DisplayTargetHitChance = true;
	Template.AbilitySourceName = 'eAbilitySource_Standard';                                       // color of the icon
	// Activated by a button press; additionally, tells the AI this is an activatable
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	// Targeting Details
	// Can only shoot visible enemies
	VisibilityCondition = new class'X2Condition_Visibility';
	VisibilityCondition.bRequireGameplayVisible = true;
	VisibilityCondition.bAllowSquadsight = true;
	Template.AbilityTargetConditions.AddItem(VisibilityCondition);
	// Can't target dead; Can't target friendlies
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	// Can't shoot while dead
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	// Only at single targets that are in range.
	Template.AbilityTargetStyle = default.SimpleSingleTarget;

	// Action Point
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = false; //THIS IS THE DIFFERENCE BETWEEN STANDARD SHOT
	Template.AbilityCosts.AddItem(ActionPointCost);

	// Ammo
	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);
	Template.bAllowAmmoEffects = true; //

	// Weapon Upgrade Compatibility
	Template.bAllowFreeFireWeaponUpgrade = true;                        // Flag that permits action to become 'free action' via 'Hair Trigger' or similar upgrade / effects

	//  Put holo target effect first because if the target dies from this shot, it will be too late to notify the effect.
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());
	//  Various Soldier ability specific effects - effects check for the ability before applying
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect());

	// Damage Effect
	Template.AddTargetEffect(default.WeaponUpgradeMissDamage);

	// Hit Calculation (Different weapons now have different calculations for range)
	Template.AbilityToHitCalc = default.SimpleStandardAim;
	Template.AbilityToHitOwnerOnMissCalc = default.SimpleStandardAim;

	// Targeting Method
	Template.TargetingMethod = class'X2TargetingMethod_OverTheShoulder';
	Template.bUsesFiringCamera = true;
	Template.CinescriptCameraType = "StandardGunFiring";

	Template.AssociatedPassives.AddItem('HoloTargeting');

	// MAKE IT LIVE!
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;

	Template.bDisplayInUITooltip = true;
	Template.bDisplayInUITacticalText = true;

	KnockbackEffect = new class'X2Effect_Knockback';
	KnockbackEffect.KnockbackDistance = 2;
	Template.AddTargetEffect(KnockbackEffect);

	Template.OverrideAbilities.AddItem('StandardShot');

	return Template;
}



static function X2AbilityTemplate AddTraverseFireAbility()
{
	local X2AbilityTemplate					Template;
	local X2Effect_TraverseFire_AP			ActionEffect;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'TraverseFire_AP');
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityTraverseFire"; //TODO
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	ActionEffect = new class 'X2Effect_TraverseFire_AP';
	ActionEffect.SetDisplayInfo (ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	ActionEffect.BuildPersistentEffect(1, true);
	Template.AddTargetEffect(ActionEffect);
	Template.bCrossClassEligible = false;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	// Visualization handled in Effect
	return Template;
}

static function X2AbilityTemplate AddLockedOnAbility()
{
	local X2AbilityTemplate         Template;
	local X2Effect_LockedOn_AP		LockedOnEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'LockedOn_AP');
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityLockedOn"; //TODO
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	Template.bCrossClassEligible = true;
	LockedOnEffect = new class'X2Effect_LockedOn_AP';
	LockedOnEffect.BuildPersistentEffect(1, true, true,, eGameRule_TacticalGameStart);
	LockedOnEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(LockedOnEffect);
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}


static function X2AbilityTemplate AddLightningReflexes_LWAbility()
{
	local X2AbilityTemplate                 Template;
	local X2Effect_LightningReflexes_LW_AP	PersistentEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'LightningReflexes_LW_AP');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_lightningreflexes";
	Template.Hostility = eHostility_Neutral;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	PersistentEffect = new class'X2Effect_LightningReflexes_LW_AP';
	PersistentEffect.BuildPersistentEffect(1, true, false);
	PersistentEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,, Template.AbilitySourceName);
	Template.AddTargetEffect(PersistentEffect);
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.bCrossClassEligible = true;
	return Template;
}


static function X2AbilityTemplate AddAreaSuppressionAbility()
{
	local X2AbilityTemplate								Template;
	local X2AbilityCost_Ammo							AmmoCost;
	local X2AbilityCost_ActionPoints					ActionPointCost;
	local X2AbilityMultiTarget_Radius					RadiusMultiTarget;
	local X2Effect_ReserveActionPoints					ReserveActionPointsEffect;
	local X2Condition_UnitInventory						InventoryCondition, InventoryCondition2;
	local X2Effect_Suppression							SuppressionEffect;
	local X2AbilityTarget_Single						PrimaryTarget;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AreaSuppression_AP');
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityAreaSuppression";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY;
	Template.Hostility = eHostility_Offensive;
	Template.bDisplayInUITooltip = false;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.bCrossClassEligible = false;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.bIsASuppressionEffect = true;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	Template.AssociatedPassives.AddItem('HoloTargeting');

	InventoryCondition = new class'X2Condition_UnitInventory';
	InventoryCondition.RelevantSlot=eInvSlot_PrimaryWeapon;
	InventoryCondition.ExcludeWeaponCategory = 'shotgun';
	Template.AbilityShooterConditions.AddItem(InventoryCondition);

	InventoryCondition2 = new class'X2Condition_UnitInventory';
	InventoryCondition2.RelevantSlot=eInvSlot_PrimaryWeapon;
	InventoryCondition2.ExcludeWeaponCategory = 'sniper_rifle';
	Template.AbilityShooterConditions.AddItem(InventoryCondition2);

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = default.AREA_SUPPRESSION_AMMO_COST;
	Template.AbilityCosts.AddItem(AmmoCost);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.bConsumeAllPoints = true;   //  this will guarantee the unit has at least 1 action point
	ActionPointCost.bFreeCost = true;           //  ReserveActionPoints effect will take all action points away
	Template.AbilityCosts.AddItem(ActionPointCost);

	ReserveActionPointsEffect = new class'X2Effect_ReserveActionPoints';
	ReserveActionPointsEffect.ReserveType = 'Suppression';
	Template.AddShooterEffect(ReserveActionPointsEffect);

	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);

	PrimaryTarget = new class'X2AbilityTarget_Single';
	PrimaryTarget.OnlyIncludeTargetsInsideWeaponRange = false;
	PrimaryTarget.bAllowInteractiveObjects = false;
	PrimaryTarget.bAllowDestructibleObjects = false;
	PrimaryTarget.bIncludeSelf = false;
	PrimaryTarget.bShowAOE = true;
	Template.AbilityTargetSTyle = PrimaryTarget;

	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	RadiusMultiTarget.bAllowDeadMultiTargetUnits = false;
	RadiusMultiTarget.bExcludeSelfAsTargetIfWithinRadius = true;
	RadiusMultiTarget.bUseWeaponRadius = false;
	RadiusMultiTarget.ftargetradius = default.AREA_SUPPRESSION_RADIUS;
	RadiusMultiTarget.AddAbilityBonusRadius('DangerZone', 2); // LWOTC
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	Template.AbilityMultiTargetConditions.AddItem(default.LivingHostileUnitOnlyProperty);

	SuppressionEffect = new class'X2Effect_AreaSuppression_AP';
	SuppressionEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
	SuppressionEffect.bRemoveWhenTargetDies = true;
	SuppressionEffect.bRemoveWhenSourceDamaged = true;
	SuppressionEffect.bBringRemoveVisualizationForward = true;
	SuppressionEffect.SetDisplayInfo(ePerkBuff_Penalty, Template.LocFriendlyName, class'X2Ability_GrenadierAbilitySet'.default.SuppressionTargetEffectDesc, Template.IconImage);
	SuppressionEffect.SetSourceDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, class'X2Ability_GrenadierAbilitySet'.default.SuppressionSourceEffectDesc, Template.IconImage);
	Template.AddTargetEffect(SuppressionEffect);
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());
	Template.AddMultiTargetEffect(SuppressionEffect);
	Template.AddMultiTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());

	Template.AdditionalAbilities.AddItem('AreaSuppressionShot_AP');
	//Template.AdditionalAbilities.AddItem('LockdownBonuses');

	//Template.TargetingMethod = class'X2TargetingMethod_AreaSuppression';

	Template.BuildVisualizationFn = AreaSuppressionBuildVisualization_LW;
	Template.BuildAppliedVisualizationSyncFn = AreaSuppressionBuildVisualizationSync;
	Template.CinescriptCameraType = "StandardSuppression";
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;

}


static function X2AbilityTemplate AreaSuppressionShot_LW_AP()
{
	local X2AbilityTemplate                 		Template;
	local X2AbilityCost_ReserveActionPoints 		ReserveActionPointCost;
	local X2AbilityToHitCalc_StandardAim    		StandardAim;
	local X2Condition_Visibility            		TargetVisibilityCondition;
	local X2AbilityTrigger_Event	        		Trigger;
	local X2Condition_UnitEffectsWithAbilitySource 	TargetEffectCondition;
	local X2Effect_RemoveEffects            		RemoveSuppression;
	local X2Effect                          		ShotEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AreaSuppressionShot_AP');

	Template.bDontDisplayInAbilitySummary = true;
	ReserveActionPointCost = new class'X2AbilityCost_ReserveActionPoints';
	ReserveActionPointCost.iNumPoints = 1;
	ReserveActionPointCost.AllowedTypes.AddItem('Suppression');
	Template.AbilityCosts.AddItem(ReserveActionPointCost);

	StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	StandardAim.BuiltInHitMod = 0;
	StandardAim.bReactionFire = true;

	Template.AbilityToHitCalc = StandardAim;
	Template.AbilityToHitOwnerOnMissCalc = StandardAim;

	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);

	TargetEffectCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	TargetEffectCondition.AddRequireEffect(class'X2Effect_AreaSuppression_AP'.default.EffectName, 'AA_UnitIsNotSuppressed');
	Template.AbilityTargetConditions.AddItem(TargetEffectCondition);

	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.bAllowAmmoEffects = true;

	RemoveSuppression = new class'X2Effect_RemoveEffects';
	RemoveSuppression.EffectNamesToRemove.AddItem(class'X2Effect_AreaSuppression_AP'.default.EffectName);
	RemoveSuppression.bCheckSource = true;
	RemoveSuppression.SetupEffectOnShotContextResult(true, true);
	Template.AddShooterEffect(RemoveSuppression);

	Template.AbilityTargetStyle = default.SimpleSingleTarget;

	//Trigger on movement - interrupt the move
	Trigger = new class'X2AbilityTrigger_Event';
	Trigger.EventObserverClass = class'X2TacticalGameRuleset_MovementObserver';
	Trigger.MethodName = 'InterruptGameState';
	Template.AbilityTriggers.AddItem(Trigger);

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_supression";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;

	//don't want to exit cover, we are already in suppression/alert mode.
	Template.bSkipExitCoverWhenFiring = true;

	Template.bAllowFreeFireWeaponUpgrade = true;
	//  Put holo target effect first because if the target dies from this shot, it will be too late to notify the effect.
	ShotEffect = class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect();
	ShotEffect.TargetConditions.AddItem(class'X2Ability_DefaultAbilitySet'.static.OverwatchTargetEffectsCondition());
	Template.AddTargetEffect(ShotEffect);
	//  Various Soldier ability specific effects - effects check for the ability before applying
	ShotEffect = class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect();
	ShotEffect.TargetConditions.AddItem(class'X2Ability_DefaultAbilitySet'.static.OverwatchTargetEffectsCondition());
	Template.AddTargetEffect(ShotEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}

//Adds multitarget visualization
static function AreaSuppressionBuildVisualization_LW(XComGameState VisualizeGameState)
{
	local XComGameStateHistory 			History;
	local XComGameStateContext_Ability  Context;
	local StateObjectReference          InteractingUnitRef;
	local VisualizationActionMetadata   EmptyTrack;
	local VisualizationActionMetadata   BuildTrack;
	local XComGameState_Ability         Ability;
	local X2Action_PlaySoundAndFlyOver  SoundAndFlyOver;

	History = `XCOMHISTORY;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	InteractingUnitRef = Context.InputContext.SourceObject;

	//Configure the visualization track for the shooter
	//****************************************************************************************
	BuildTrack = EmptyTrack;
	BuildTrack.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	BuildTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

	class'X2Action_ExitCover'.static.AddToVisualizationTree(BuildTrack, Context);
	class'X2Action_StartSuppression'.static.AddToVisualizationTree(BuildTrack, Context);
	//****************************************************************************************
	//Configure the visualization track for the primary target

	InteractingUnitRef = Context.InputContext.PrimaryTarget;
	Ability = XComGameState_Ability(History.GetGameStateForObjectID(Context.InputContext.AbilityRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1));
	BuildTrack = EmptyTrack;
	BuildTrack.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	BuildTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(BuildTrack, Context));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, Ability.GetMyTemplate().LocFlyOverText, '', eColor_Bad);
	if (XComGameState_Unit(BuildTrack.StateObject_OldState).ReserveActionPoints.Length != 0 && XComGameState_Unit(BuildTrack.StateObject_NewState).ReserveActionPoints.Length == 0)
	{
		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(BuildTrack, Context));
		SoundAndFlyOver.SetSoundAndFlyOverParameters(none, class'XLocalizedData'.default.OverwatchRemovedMsg, '', eColor_Bad);
	}

	//Configure for the rest of the targets in AOE Suppression
	if (Context.InputContext.MultiTargets.Length > 0)
	{
		foreach Context.InputContext.MultiTargets(InteractingUnitRef)
		{
			Ability = XComGameState_Ability(History.GetGameStateForObjectID(Context.InputContext.AbilityRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1));
			BuildTrack = EmptyTrack;
			BuildTrack.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
			BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
			BuildTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);
			SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(BuildTrack, Context));
			SoundAndFlyOver.SetSoundAndFlyOverParameters(None, Ability.GetMyTemplate().LocFlyOverText, '', eColor_Bad);
			if (XComGameState_Unit(BuildTrack.StateObject_OldState).ReserveActionPoints.Length != 0 && XComGameState_Unit(BuildTrack.StateObject_NewState).ReserveActionPoints.Length == 0)
			{
				SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(BuildTrack, Context));
				SoundAndFlyOver.SetSoundAndFlyOverParameters(none, class'XLocalizedData'.default.OverwatchRemovedMsg, '', eColor_Bad);
			}
		}
	}
}

static function AreaSuppressionBuildVisualizationSync(name EffectName, XComGameState VisualizeGameState, out VisualizationActionMetadata BuildTrack)
{
	local X2Action_ExitCover ExitCover;

	if (EffectName == class'X2Effect_AreaSuppression_AP'.default.EffectName)
	{
		ExitCover = X2Action_ExitCover(class'X2Action_ExitCover'.static.AddToVisualizationTree( BuildTrack, VisualizeGameState.GetContext() ));
		ExitCover.bIsForSuppression = true;

		class'X2Action_StartSuppression'.static.AddToVisualizationTree( BuildTrack, VisualizeGameState.GetContext() );
	}
}
