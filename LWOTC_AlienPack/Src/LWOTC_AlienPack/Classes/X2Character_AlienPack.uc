//---------------------------------------------------------------------------------------
//  FILE:    X2Character_AlienPack
//  AUTHOR:  Amineri (Long War Studios)
//  PURPOSE: Configured character templates for all AlienPack aliens
//---------------------------------------------------------------------------------------
class X2Character_AlienPack extends X2Character config(LWOTC_AlienPack);

//struct AIJobInfo_Addition
//{
	//var Name JobName;						// Name of this job.
	//var Name Preceding;						// Name of unit before current in the list, if any
	//var Name Succeeding;					// Name of unit after current in the list, if any
	//var int DefaultPosition;				// Default index to insert at if cannot find based on name
//};

//var config array<AIJobInfo_Addition> JobListingAdditions; // Definition of qualifications for each job for this new character

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateTemplate_MutonM2_LW());
	Templates.AddItem(CreateTemplate_MutonM3_LW());

	Templates.AddItem(CreateTemplate_Naja('NajaM1'));
	Templates.AddItem(CreateTemplate_Naja('NajaM2'));
	Templates.AddItem(CreateTemplate_Naja('NajaM3'));

	Templates.AddItem(CreateTemplate_Sidewinder('SidewinderM1'));
	Templates.AddItem(CreateTemplate_Sidewinder('SidewinderM2'));
	Templates.AddItem(CreateTemplate_Sidewinder('SidewinderM3'));

	Templates.AddItem(CreateTemplate_Viper_LW('ViperM2_LW'));
	Templates.AddItem(CreateTemplate_Viper_LW('ViperM3_LW'));

	Templates.AddItem(CreateTemplate_ArchonM2_LW());

	Templates.AddItem(CreateTemplate_SectoidM2_LW());

	Templates.AddItem(CreateTemplate_AdvGunner('AdvGunnerM1'));
	Templates.AddItem(CreateTemplate_AdvGunner('AdvGunnerM2'));
	Templates.AddItem(CreateTemplate_AdvGunner('AdvGunnerM3'));

	Templates.AddItem(CreateTemplate_AdvSentry('AdvSentryM1'));
	Templates.AddItem(CreateTemplate_AdvSentry('AdvSentryM2'));
	Templates.AddItem(CreateTemplate_AdvSentry('AdvSentryM3'));

	Templates.AddItem(CreateTemplate_AdvGrenadier('AdvGrenadierM1'));
	Templates.AddItem(CreateTemplate_AdvGrenadier('AdvGrenadierM2'));
	Templates.AddItem(CreateTemplate_AdvGrenadier('AdvGrenadierM3'));

	Templates.AddItem(CreateTemplate_AdvRocketeer('AdvRocketeerM1'));
	Templates.AddItem(CreateTemplate_AdvRocketeer('AdvRocketeerM2'));
	Templates.AddItem(CreateTemplate_AdvRocketeer('AdvRocketeerM3'));

	Templates.AddItem(CreateTemplate_AdvMec_M3());

	Templates.AddItem(CreateTemplate_AdvMECArcher('AdvMECArcherM1'));
	Templates.AddItem(CreateTemplate_AdvMECArcher('AdvMECArcherM2'));

	Templates.AddItem(CreateTemplate_Drone('LWDroneM1'));
	Templates.AddItem(CreateTemplate_Drone('LWDroneM2'));

	Templates.Additem(CreateTemplate_ChryssalidSoldier());
	Templates.AddItem(CreateTemplate_HiveQueen());

	Templates.AddItem(CreateTemplate_MutonM2_Dummy());

	return Templates;
}

static function X2CharacterTemplate CreateTemplate_MutonM2_LW()
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'MutonM2_LW');
	CharTemplate.CharacterGroupName = 'Muton';
	CharTemplate.DefaultLoadout='MutonM2_LW_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("LWMutonM2.ARC_GameUnit_MutonM2");
	Loot.ForceLevel=0;
	Loot.LootTableName='Muton_BaseLoot';  // TODO : possibly create new LootTable entry for MutonM2_LW
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'Muton_TimedLoot';  // TODO : possibly create new Timed LootTable entry for MutonM2_LW
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);

	Loot.LootTableName = 'Muton_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	//CharTemplate.strMatineePackage = "CIN_Muton";
	CharTemplate.strMatineePackages.AddItem("CIN_Muton"); //update with new cinematic?

	CharTemplate.UnitSize = 1;
	// Traversal Rules -- same as base Muton
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.Abilities.AddItem('CounterattackPreparation');
	CharTemplate.Abilities.AddItem('CounterattackDescription');
	CharTemplate.Abilities.AddItem('WarCry');
	CharTemplate.Abilities.AddItem('Beastmaster');

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;
	CharTemplate.strBehaviorTree = "MutonM2_LWRoot";  // new config behavior tree parsing means we could use the group instead

	//probably keep cinematic intro, since it's a lot of work to create a new one -- alternatively no cinematic intro for tier 2
	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Central_AlienSightings_Muton');

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}


static function X2CharacterTemplate CreateTemplate_MutonM2_Dummy()
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'MutonM2');
	CharTemplate.CharacterGroupName = 'Muton';
	CharTemplate.DefaultLoadout='MutonM2_LW_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("LWMutonM2.ARC_GameUnit_MutonM2");
	Loot.ForceLevel=0;
	Loot.LootTableName='Muton_BaseLoot';  // TODO : possibly create new LootTable entry for MutonM2_LW
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'Muton_TimedLoot';  // TODO : possibly create new Timed LootTable entry for MutonM2_LW
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);

	//CharTemplate.strMatineePackage = "CIN_Muton";
	CharTemplate.strMatineePackages.AddItem("CIN_Muton"); //update with new cinematic?

	CharTemplate.UnitSize = 1;
	// Traversal Rules -- same as base Muton
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.Abilities.AddItem('CounterattackPreparation');
	CharTemplate.Abilities.AddItem('CounterattackDescription');
	CharTemplate.Abilities.AddItem('WarCry');
	CharTemplate.Abilities.AddItem('Beastmaster');

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;
	CharTemplate.strBehaviorTree = "MutonM2_LWRoot";  // new config behavior tree parsing means we could use the group instead

	//probably keep cinematic intro, since it's a lot of work to create a new one -- alternatively no cinematic intro for tier 2
	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Central_AlienSightings_Muton');

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_MutonM3_LW()
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'MutonM3_LW');
	CharTemplate.CharacterGroupName = 'Muton';
	CharTemplate.DefaultLoadout='MutonM3_LW_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("LWMutonM3.Archetypes.ARC_GameUnit_MutonM3"); // SCRUBBED AFTER S&R

	Loot.ForceLevel=0;
	Loot.LootTableName='Muton_BaseLoot';  // TODO : possibly create new LootTable entry for MutonM2_LW
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'Muton_TimedLoot';  // TODO : possibly create new Timed LootTable entry for MutonM2_LW
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);

	Loot.LootTableName = 'Muton_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	//CharTemplate.strMatineePackage = "CIN_Muton";
	CharTemplate.strMatineePackages.AddItem("CIN_Muton"); //update with new cinematic?

	CharTemplate.UnitSize = 1;
	// Traversal Rules -- same as base Muton
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.Abilities.AddItem('CounterattackPreparation');
	CharTemplate.Abilities.AddItem('CounterattackDescription');
	CharTemplate.Abilities.AddItem('WarCry');
	CharTemplate.Abilities.AddItem('Beastmaster');

	CharTemplate.Abilities.AddItem('TacticalSense_AP');
	CharTemplate.Abilities.AddItem('PersonalShield');
	// LightEmUp: Weapon Template

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;
	CharTemplate.strBehaviorTree = "MutonM3_LWRoot"; // new config behavior tree parsing means we could use the group instead

	//probably keep cinematic intro, since it's a lot of work to create a new one -- alternatively no cinematic intro for tier 3
	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Central_AlienSightings_Muton');

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_Naja(name TemplateName)
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, TemplateName);
	CharTemplate.CharacterGroupName = 'Viper';

	if (TemplateName == 'NajaM1')
		CharTemplate.DefaultLoadout='NajaM1_Loadout';
	if (TemplateName == 'NajaM2')
		CharTemplate.DefaultLoadout='NajaM2_Loadout';
	if (TemplateName == 'NajaM3')
		CharTemplate.DefaultLoadout='NajaM3_Loadout';

	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("LWNaja.Archetypes.ARC_GameUnit_Naja_F");
	CharTemplate.strPawnArchetypes.AddItem("LWNaja.Archetypes.ARC_GameUnit_Naja_M");
	Loot.ForceLevel=0;
	Loot.LootTableName='Viper_BaseLoot';
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'Viper_TimedLoot';
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	Loot.LootTableName = 'Viper_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_Viper");
	CharTemplate.strMatineePackages.AddItem("CIN_AdventMEC");
	//CharTemplate.strTargetingMatineePrefix = "CIN_AdventMEC_FF_StartPos";

	CharTemplate.UnitSize = 1;
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = true; // WALL CLIMB!
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bSetGenderAlways = true;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.ImmuneTypes.AddItem('Poison');

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.Abilities.AddItem('Squadsight'); //character perk
	if (TemplateName == 'NajaM2' || TemplateName == 'NajaM3')
	{
		//reserved for future use
	}
	if (TemplateName == 'NajaM3')
	{
		CharTemplate.Abilities.AddItem('DepthPerception_AP'); //character perk
	}

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Tygan_AlienSightings_Viper');
	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Central_AlienSightings_Viper');

	CharTemplate.strBehaviorTree = "LWNajaRoot"; // new config behavior tree parsing means we could use the group instead

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_Sidewinder(name TemplateName)
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, TemplateName);
	CharTemplate.CharacterGroupName = 'Viper';

	if (TemplateName == 'SidewinderM1')
		CharTemplate.DefaultLoadout='SidewinderM1_Loadout';
	if (TemplateName == 'SidewinderM2')
		CharTemplate.DefaultLoadout='SidewinderM2_Loadout';
	if (TemplateName == 'SidewinderM3')
		CharTemplate.DefaultLoadout='SidewinderM3_Loadout';

	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("LWSidewinder.Archetypes.ARC_GameUnit_Sidewinder_M");
	CharTemplate.strPawnArchetypes.AddItem("LWSidewinder.Archetypes.ARC_GameUnit_Sidewinder_F");
	Loot.ForceLevel=0;
	Loot.LootTableName='Viper_BaseLoot';
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'Viper_TimedLoot';
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	Loot.LootTableName = 'Viper_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_Viper");
	CharTemplate.strMatineePackages.AddItem("CIN_AdventMEC");
	//CharTemplate.strTargetingMatineePrefix = "CIN_AdventMEC_FF_StartPos";

	CharTemplate.UnitSize = 1;
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = true;  // let the mambas go everywhere
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.ImmuneTypes.AddItem('Poison');

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.Abilities.AddItem('Shadowstep');

	switch(TemplateName)
	{
		case 'SidewinderM1':
			CharTemplate.strBehaviorTree = "LWSidewinderRoot"; // new config behavior tree parsing means we could use the group instead
			break;
		case 'SidewinderM2':
		case 'SidewinderM3':
			CharTemplate.strBehaviorTree = "LWSidewinderHitAndRunRoot"; // new config behavior tree parsing means we could use the group instead
		default:
	}

	switch(TemplateName)
	{
		case 'SidewinderM3':
			CharTemplate.Abilities.AddItem('Infighter_AP');
			//TODO: Hit and Run
		case 'SidewinderM2':
		case 'SidewinderM1':
		default:
		break;
	}

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Tygan_AlienSightings_Viper');
	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Central_AlienSightings_Viper');

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}


static function X2CharacterTemplate CreateTemplate_ArchonM2_LW()
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'ArchonM2_LW');
	CharTemplate.CharacterGroupName = 'Archon';
	CharTemplate.DefaultLoadout='ArchonM2_LW_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_Archon.ARC_GameUnit_Archon");
	Loot.ForceLevel=0;
	Loot.LootTableName='Archon_BaseLoot';
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'Archon_TimedLoot';
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	Loot.LootTableName = 'Archon_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_Archon");
	CharTemplate.strMatineePackages.AddItem("CIN_AdventMEC");
	CharTemplate.strTargetingMatineePrefix = "CIN_AdventMEC_FF_StartPos";

	CharTemplate.UnitSize = 1;
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = false;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = false;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = false;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanUse_eTraversal_Launch = true;
	CharTemplate.bCanUse_eTraversal_Flying = true;
	CharTemplate.bCanUse_eTraversal_Land = true;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = false;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strScamperBT = "ScamperRoot_NoCover";

	CharTemplate.Abilities.AddItem('FrenzyDamageListener');
	CharTemplate.Abilities.AddItem('BlazingPinionsStage1');
	//TODO: Add CloseCombatSpecialist to new weapon variant

	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.Enemy_Sighted_Archon');

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_SectoidM2_LW()  // I have big brains
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'SectoidM2_LW');
	CharTemplate.CharacterGroupName = 'Sectoid';
	CharTemplate.DefaultLoadout='SectoidM2_LW_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("LWSectoidM2.Archetypes.ARC_GameUnit_SectoidM2"); //SCRUBBED AFTER S&R
	Loot.ForceLevel=0;
	Loot.LootTableName='Sectoid_BaseLoot'; // TODO: new loot table?
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'Sectoid_TimedLoot'; // TODO: new loot table?
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	Loot.LootTableName = 'Sectoid_VultureLoot'; // TODO: new loot table?
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_Sectoid");

	CharTemplate.UnitSize = 1;
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = true;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.Abilities.AddItem('VulnerabilityMelee');
	CharTemplate.Abilities.AddItem('DelayedPsiExplosion');
	CharTemplate.Abilities.AddItem('KillSiredZombies');
	CharTemplate.Abilities.AddItem('SectoidDeathOverride');  // A: Not sure what this does, but it sounds cool

	CharTemplate.Abilities.AddItem('MassMindspin');
	CharTemplate.Abilities.AddItem('MassReanimation_LW');

	// OTHERS?

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strBehaviorTree = "SectoidM2_LWRoot"; // new config behavior tree parsing means we could use the group instead

	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Tygan_AlienSightings_Sectoid');

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_Viper_LW(name TemplateName)
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, TemplateName);
	CharTemplate.CharacterGroupName = 'Viper';

	if (TemplateName == 'ViperM2_LW')
		CharTemplate.DefaultLoadout='ViperM2_LW_Loadout';

	if (TemplateName == 'ViperM3_LW')
		CharTemplate.DefaultLoadout='ViperM3_LW_Loadout';

	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_Viper.ARC_GameUnit_Viper");
	Loot.ForceLevel=0;
	Loot.LootTableName='Viper_BaseLoot';
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'Viper_TimedLoot';
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	Loot.LootTableName = 'Viper_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_Viper");
	CharTemplate.strMatineePackages.AddItem("CIN_AdventMEC");
	CharTemplate.strTargetingMatineePrefix = "CIN_AdventMEC_FF_StartPos";

	CharTemplate.UnitSize = 1;
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.ImmuneTypes.AddItem('Poison');

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.Abilities.AddItem('Bind');

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Tygan_AlienSightings_Viper');
	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Central_AlienSightings_Viper');

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}


static function X2CharacterTemplate CreateTemplate_AdvGunner(name TemplateName)
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, TemplateName);
	CharTemplate.CharacterGroupName = 'AdventTrooper';  // TODO : create new character group?
	if (TemplateName == 'AdvGunnerM1')
		CharTemplate.DefaultLoadout='AdvGunnerM1_Loadout';
	if (TemplateName == 'AdvGunnerM2')
		CharTemplate.DefaultLoadout='AdvGunnerM2_Loadout';
	if (TemplateName == 'AdvGunnerM3')
		CharTemplate.DefaultLoadout='AdvGunnerM3_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	//CharTemplate.strPawnArchetypes.AddItem("LWAdvGunner.Archetypes.ARC_GameUnit_AdvGunnerM1_M");
	//CharTemplate.strPawnArchetypes.AddItem("LWAdvGunner.Archetypes.ARC_GameUnit_AdvGunnerM1_F");
	//CharTemplate.strPawnArchetypes.AddItem("XAdventTrooper.Archetypes.GameUnit_AdvSoldier_F");
	CharTemplate.strPawnArchetypes.AddItem("XAdventTrooper.Archetypes.GameUnit_AdvSoldier_M");

	Loot.ForceLevel=0;
	if (TemplateName == 'AdvGunnerM1')
		Loot.LootTableName='AdvTrooperM1_BaseLoot';
	if (TemplateName == 'AdvGunnerM2')
		Loot.LootTableName='AdvTrooperM2_BaseLoot';
	if (TemplateName == 'AdvGunnerM3')
		Loot.LootTableName='AdvTrooperM3_BaseLoot';
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	Loot.ForceLevel = 0;
	if (TemplateName == 'AdvGunnerM1')
		Loot.LootTableName='AdvTrooperM1_TimedLoot';
	if (TemplateName == 'AdvGunnerM2')
		Loot.LootTableName='AdvTrooperM2_TimedLoot';
	if (TemplateName == 'AdvGunnerM3')
		Loot.LootTableName='AdvTrooperM3_TimedLoot';
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);

	if (TemplateName == 'AdvGunnerM1')
		Loot.LootTableName='AdvTrooperM1_VultureLoot';
	if (TemplateName == 'AdvGunnerM2')
		Loot.LootTableName='AdvTrooperM2_VultureLoot';
	if (TemplateName == 'AdvGunnerM3')
		Loot.LootTableName='AdvTrooperM3_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_Advent");
	CharTemplate.RevealMatineePrefix = "CIN_Advent_Trooper";
	CharTemplate.GetRevealMatineePrefixFn = GetAdventMatineePrefix;

	CharTemplate.UnitSize = 1;
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bSetGenderAlways = true;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bAppearanceDefinesPawn = false;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bAllowSpawnFromATT = true;

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strBehaviorTree = "LWAdventGunnerRoot"; // new config behavior tree parsing means we could use the group instead

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_captain_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvSentry(name TemplateName)
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, TemplateName);
	CharTemplate.CharacterGroupName = 'AdventTrooper';  // TODO : create new character group?

	if (TemplateName == 'AdvSentryM1')
		CharTemplate.DefaultLoadout='AdvSentryM1_Loadout';
	if (TemplateName == 'AdvSentryM2')
		CharTemplate.DefaultLoadout='AdvSentryM2_Loadout';
	if (TemplateName == 'AdvSentryM3')
		CharTemplate.DefaultLoadout='AdvSentryM3_Loadout';

	CharTemplate.BehaviorClass=class'XGAIBehavior';
	//CharTemplate.strPawnArchetypes.AddItem("LWAdvSentry.Archetypes.ARC_GameUnit_AdvSentryM1_M");
	//CharTemplate.strPawnArchetypes.AddItem("LWAdvSentry.Archetypes.ARC_GameUnit_AdvSentryM1_F");
	CharTemplate.strPawnArchetypes.AddItem("XAdventTrooper.Archetypes.GameUnit_AdvSoldier_M");
	Loot.ForceLevel=0;

	if (TemplateName == 'AdvSentryM1')
		Loot.LootTableName='AdvTrooperM1_BaseLoot';
	if (TemplateName == 'AdvSentryM2')
		Loot.LootTableName='AdvTrooperM2_BaseLoot';
	if (TemplateName == 'AdvSentryM3')
		Loot.LootTableName='AdvTrooperM3_BaseLoot';
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;

	if (TemplateName == 'AdvSentryM1')
		Loot.LootTableName='AdvTrooperM1_TimedLoot';
	if (TemplateName == 'AdvSentryM2')
		Loot.LootTableName='AdvTrooperM2_TimedLoot';
	if (TemplateName == 'AdvSentryM3')
		Loot.LootTableName='AdvTrooperM3_TimedLoot';
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);

	if (TemplateName == 'AdvSentryM1')
		Loot.LootTableName='AdvTrooperM1_VultureLoot';
	if (TemplateName == 'AdvSentryM2')
		Loot.LootTableName='AdvTrooperM2_VultureLoot';
	if (TemplateName == 'AdvSentryM3')
		Loot.LootTableName='AdvTrooperM3_VultureLoot';

	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_Advent");
	CharTemplate.RevealMatineePrefix = "CIN_Advent_Trooper";
	CharTemplate.GetRevealMatineePrefixFn = GetAdventMatineePrefix;

	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bSetGenderAlways = true;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bAllowSpawnFromATT = true;

	CharTemplate.Abilities.AddItem('ReadyForAnything');

	if (TemplateName == 'AdvSentryM3')
		CharTemplate.Abilities.AddItem('TacticalSense_AP');

	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Central_AlienSightings_AdvTrooperM1');

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strBehaviorTree = "LWAdventSentryRoot"; // new config behavior tree parsing means we could use the group instead

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_captain_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvGrenadier(name TemplateName)
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, TemplateName);
	CharTemplate.CharacterGroupName = 'AdventTrooper';  // TODO : create new character group?

	if (TemplateName == 'AdvGrenadierM1')
		CharTemplate.DefaultLoadout='AdvGrenadierM1_Loadout';
	if (TemplateName == 'AdvGrenadierM2')
		CharTemplate.DefaultLoadout='AdvGrenadierM2_Loadout';
	if (TemplateName == 'AdvGrenadierM3')
		CharTemplate.DefaultLoadout='AdvGrenadierM3_Loadout';

	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("XAdventTrooper.Archetypes.GameUnit_AdvSoldier_M");

	Loot.ForceLevel=0;
	if (TemplateName == 'AdvGrenadierM1')
		Loot.LootTableName='AdvTrooperM1_BaseLoot';
	if (TemplateName == 'AdvGrenadierM2')
		Loot.LootTableName='AdvTrooperM2_BaseLoot';
	if (TemplateName == 'AdvGrenadierM3')
		Loot.LootTableName='AdvTrooperM3_BaseLoot';

	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	if (TemplateName == 'AdvGrenadierM1')
		Loot.LootTableName='AdvTrooperM1_TimedLoot';
	if (TemplateName == 'AdvGrenadierM2')
		Loot.LootTableName='AdvTrooperM2_TimedLoot';
	if (TemplateName == 'AdvGrenadierM3')
		Loot.LootTableName='AdvTrooperM3_TimedLoot';

	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	if (TemplateName == 'AdvGrenadierM1')
		Loot.LootTableName='AdvTrooperM1_VultureLoot';
	if (TemplateName == 'AdvGrenadierM2')
		Loot.LootTableName='AdvTrooperM2_VultureLoot';
	if (TemplateName == 'AdvGrenadierM3')
		Loot.LootTableName='AdvTrooperM3_VultureLoot';

	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_Advent");
	CharTemplate.RevealMatineePrefix = "CIN_Advent_Trooper";
	CharTemplate.GetRevealMatineePrefixFn = GetAdventMatineePrefix;

	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bSetGenderAlways = true;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bAllowSpawnFromATT = true;

	if (TemplateName == 'AdvGrenadierM3')
	{
		CharTemplate.Abilities.AddItem('Salvo');
		CharTemplate.Abilities.AddItem('BiggestBooms');
	}

	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Central_AlienSightings_AdvTrooperM1');

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strBehaviorTree = "LWAdventGrenadierRoot"; // new config behavior tree parsing means we could use the group instead

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;
	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_captain_icon";

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvRocketeer(name TemplateName)
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, TemplateName);
	CharTemplate.CharacterGroupName = 'AdventTrooper';  // TODO : create new character group?
	CharTemplate.DefaultLoadout=name(TemplateName $ "_Loadout"); //'AdvRocketeerM1_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	//CharTemplate.strPawnArchetypes.AddItem("LWAdvRocketeer.Archetypes.ARC_GameUnit_AdvRocketeerM1_M");
	//CharTemplate.strPawnArchetypes.AddItem("LWAdvRocketeer.Archetypes.ARC_GameUnit_AdvRocketeerM1_F");
	CharTemplate.strPawnArchetypes.AddItem("XAdventTrooper.Archetypes.GameUnit_AdvSoldier_M");
	Loot.ForceLevel=0;
	if (TemplateName == 'AdvRocketeerM1')
		Loot.LootTableName='AdvTrooperM1_BaseLoot';
	if (TemplateName == 'AdvRocketeerM2')
		Loot.LootTableName='AdvTrooperM2_BaseLoot';
	if (TemplateName == 'AdvRocketeerM3')
		Loot.LootTableName='AdvTrooperM3_BaseLoot';
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);

	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	if (TemplateName == 'AdvRocketeerM1')
		Loot.LootTableName='AdvTrooperM1_TimedLoot';
	if (TemplateName == 'AdvRocketeerM2')
		Loot.LootTableName='AdvTrooperM2_TimedLoot';
	if (TemplateName == 'AdvRocketeerM3')
		Loot.LootTableName='AdvTrooperM3_TimedLoot';

	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);

	if (TemplateName == 'AdvRocketeerM1')
		Loot.LootTableName='AdvTrooperM1_VultureLoot';
	if (TemplateName == 'AdvRocketeerM2')
		Loot.LootTableName='AdvTrooperM2_VultureLoot';
	if (TemplateName == 'AdvRocketeerM3')
		Loot.LootTableName='AdvTrooperM3_VultureLoot';

	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_Advent");
	CharTemplate.RevealMatineePrefix = "CIN_Advent_Trooper";
	CharTemplate.GetRevealMatineePrefixFn = GetAdventMatineePrefix;

	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bSetGenderAlways = true;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bAllowSpawnFromATT = true;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	if (TemplateName == 'AdvRocketeerM3')
		CharTemplate.Abilities.AddItem('BiggestBooms');

	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Central_AlienSightings_AdvTrooperM1');

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strBehaviorTree = "LWAdventRocketeerRoot"; // new config behavior tree parsing means we could use the group instead

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_captain_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvMec_M3()
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'AdvMEC_M3_LW');
	CharTemplate.CharacterGroupName = 'AdventMEC';
	CharTemplate.DefaultLoadout='AdvMEC_M2_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("XComAlienPawn'LWAdvMec.Archetypes.GameUnit_AdvMEC_M3'");
	Loot.ForceLevel=0;
	Loot.LootTableName='AdvMEC_M2_BaseLoot';
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'AdvMEC_M2_TimedLoot';
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	Loot.LootTableName = 'AdvMEC_M2_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_AdventMEC");
	CharTemplate.strTargetingMatineePrefix = "CIN_AdventMEC_FF_StartPos";

	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = true;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = false;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = true;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bAllowSpawnFromATT = true;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bFacesAwayFromPod = true;

	//CharTemplate.strScamperBT = "ScamperRoot_NoCover";
	CharTemplate.strScamperBT = "ScamperRoot_Overwatch";

	CharTemplate.Abilities.AddItem('RobotImmunities');
	CharTemplate.Abilities.AddItem('RepairServos');

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_robot_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvMECArcher(name TemplateName)
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, TemplateName);
	CharTemplate.CharacterGroupName = 'AdventMEC';
	CharTemplate.DefaultLoadout='AdvMECArcher_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("LWAdvMecArcher.Archetypes.ARC_GameUnit_AdvMECArcher");
	Loot.ForceLevel=0;
	Loot.LootTableName='AdvMEC_M2_BaseLoot';  // TODO: add Archer-specific base loot
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'AdvMEC_M2_TimedLoot';  // TODO: add Archer-specific timed loot
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	Loot.LootTableName = 'AdvMEC_M2_VultureLoot';   // TODO: add Archer-specific vulture loot
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_AdventMEC");
	CharTemplate.strTargetingMatineePrefix = "CIN_AdventMEC_FF_StartPos";

	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = true;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = false;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = true;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bAllowSpawnFromATT = true;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bFacesAwayFromPod = true;

	//CharTemplate.strScamperBT = "ScamperRoot_NoCover";
	CharTemplate.strScamperBT = "ScamperRoot_Overwatch";

	CharTemplate.Abilities.AddItem('RobotImmunities');

	if (TemplateName == 'AdvMecArcherM2')
		CharTemplate.Abilities.AddItem('BiggestBooms');

	CharTemplate.strBehaviorTree = "LWAdventMECArcherRoot"; // new config behavior tree parsing means we could use the group instead

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_robot_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;

	return CharTemplate;
}

simulated function string GetAdventMatineePrefix(XComGameState_Unit UnitState)
{
	if(UnitState.kAppearance.iGender == eGender_Male)
	{
		return UnitState.GetMyTemplate().RevealMatineePrefix $ "_Male";
	}
	else
	{
		return UnitState.GetMyTemplate().RevealMatineePrefix $ "_Female";
	}
}

static function X2CharacterTemplate CreateTemplate_Drone(name TemplateName)
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, TemplateName);
	CharTemplate.CharacterGroupName = 'AdventDrone';
	if(TemplateName == 'LWDroneM1')
		CharTemplate.DefaultLoadout='LWDroneM1_Loadout';
	if(TemplateName == 'LWDroneM2')
		CharTemplate.DefaultLoadout='LWDroneM2_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';

	if(TemplateName == 'LWDroneM1')
		CharTemplate.strPawnArchetypes.AddItem("LWDrone.Archetypes.ARC_GameUnit_DroneM1");
	else if(TemplateName == 'LWDroneM2')
		CharTemplate.strPawnArchetypes.AddItem("LWDrone.Archetypes.ARC_GameUnit_DroneM3");

	Loot.ForceLevel=0;
	Loot.LootTableName='LWDroneM1_BaseLoot';
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	if(TemplateName == 'LWDroneM1')
		Loot.LootTableName = 'LWDroneM1_TimedLoot';
	if(TemplateName == 'LWDroneM2')
		Loot.LootTableName = 'LWDroneM2_TimedLoot';
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);

	if(TemplateName == 'LWDroneM1')
		Loot.LootTableName = 'LWDroneM1_VultureLoot';
	if(TemplateName == 'LWDroneM2')
		Loot.LootTableName = 'LWDroneM2_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);


	//NEW CINEMATIC?

	CharTemplate.UnitSize = 1;

	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = false;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = false;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = false;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanUse_eTraversal_Launch = true;
	CharTemplate.bCanUse_eTraversal_Flying = true;
	CharTemplate.bCanUse_eTraversal_Land = true;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = false;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = true;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = false;

	CharTemplate.bAllowSpawnFromATT = true;  // If true, this unit can be spawned from an Advent Troop Transport
	CharTemplate.bWeakAgainstTechLikeRobot = true;

	CharTemplate.Abilities.AddItem('LWDroneMeleeStun');
	CharTemplate.Abilities.AddItem('RobotImmunities');

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;
	CharTemplate.strBehaviorTree = "LWDroneRoot"; // new config behavior tree parsing means we could use the group instead

	//TODO: investigate possibilities for adding first-sighting narrative moment for new unit
	//CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Central_AlienSightings_Muton');

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_robot_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;  // TODO: Add new icon for advent drones?

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_ChryssalidSoldier()
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'ChryssalidSoldier');
	CharTemplate.CharacterGroupName = 'Chryssalid';
	CharTemplate.DefaultLoadout='Chryssalid_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("LWHiveQueen.Archetypes.ARC_GameUnit_ChryssalidM2");
	Loot.ForceLevel=0;
	Loot.LootTableName='Chryssalid_BaseLoot';  // TODO : add new loot table
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	//Loot.ForceLevel = 0;
	//Loot.LootTableName = 'Chryssalid_TimedLoot';
	//CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	//Loot.LootTableName = 'Chryssalid_VultureLoot';
	//CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_Chryssalid");

	CharTemplate.UnitSize = 2;
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = true;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = false;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bIsMeleeOnly = true;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;
	CharTemplate.strScamperBT = "ChryssalidScamperRoot";

	CharTemplate.Abilities.AddItem('ChryssalidSlash');
	CharTemplate.Abilities.AddItem('ChryssalidBurrow'); // REMOVE?
	CharTemplate.Abilities.AddItem('ChyssalidPoison');
	CharTemplate.Abilities.AddItem('ChryssalidImmunities');
	CharTemplate.Abilities.AddItem('ChryssalidSoldierSlash');
	CharTemplate.Abilities.AddItem('LightningReflexes_LW_AP');

	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Central_AlienSightings_Cryssalid');

	CharTemplate.strBehaviorTree = "LWHiveQueenRoot"; // new config behavior tree parsing means we could use the group instead

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_HiveQueen()
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'HiveQueen');
	CharTemplate.CharacterGroupName = 'Chryssalid';
	CharTemplate.DefaultLoadout='Chryssalid_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("LWHiveQueen.Archetypes.ARC_GameUnit_ChryssalidM3");
	Loot.ForceLevel=0;
	Loot.LootTableName='Chryssalid_BaseLoot';  // TODO : add new loot table
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	//Loot.ForceLevel = 0;
	//Loot.LootTableName = 'Chryssalid_TimedLoot';
	//CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	//Loot.LootTableName = 'Chryssalid_VultureLoot';
	//CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_Chryssalid");

	CharTemplate.UnitSize = 3; // really, truly big
	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = true;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = false;

	CharTemplate.bIsAlien = true;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bIsMeleeOnly = true;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;

	CharTemplate.bAllowSpawnFromATT = false;

	CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;
	CharTemplate.strScamperBT = "ChryssalidScamperRoot";

	CharTemplate.Abilities.AddItem('ChryssalidSlash');
	CharTemplate.Abilities.AddItem('ChryssalidBurrow'); // REMOVE?
	CharTemplate.Abilities.AddItem('ChyssalidPoison');
	CharTemplate.Abilities.AddItem('ChryssalidImmunities');
	CharTemplate.Abilities.AddItem('HiveQueenSlash');

	CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Central_AlienSightings_Cryssalid');

	CharTemplate.strBehaviorTree = "LWHiveQueenRoot"; // new config behavior tree parsing means we could use the group instead

	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Alien;

	return CharTemplate;
}
// ------------------------------------------------------------
// ------ AI Jobs -- currently not working --------------------

//static function AddAIJobs()
//{
	//local X2AIJobManager JobMgr;
	//local AIJobInfo_Addition Addition;
	//local int AdditionIndex;
	//local AIJobInfo JobInfo;
	//local name MyName;
//
	//MyName = 'MutonM2_LW';
	//
	////retrieve AIJobManager
	//JobMgr = `AIJOBMGR;
//
	////TODO : figure out how to insert additional characters into the X2AIJobManager.JobInfo.ValidChar array
	//foreach default.JobListingAdditions(Addition)
	//{
		//JobInfo = JobMgr.GetJobListing(Addition.JobName);
		//if(JobInfo.JobName == '') continue;
		//
		//if(Addition.Preceding != '')
		//{
			//AdditionIndex = JobInfo.ValidChar.Find(Addition.Preceding);
			//if(AdditionIndex != INDEX_NONE)
			//{
				//// found preceding, insert addition after it
				//JobInfo.ValidChar.InsertItem(AdditionIndex+1, MyName);
				//continue;
			//}
		//}
		//if(Addition.Succeeding != '')
		//{
			//AdditionIndex = JobInfo.ValidChar.Find(Addition.Succeeding);
			//if(AdditionIndex != INDEX_NONE)
			//{
				//// found succeeding, insert addition before it
				//JobInfo.ValidChar.InsertItem(AdditionIndex, MyName);
				//continue;
			//}
		//}
//
		////default to default index value
		//if (Addition.DefaultPosition < JobInfo.ValidChar.Length)
		//if(Addition.DefaultPosition < 0)
		//{
			//JobInfo.ValidChar.InsertItem(0, MyName);
		//}
		//
		//if (JobInfo.ValidChar.Length > 0)
		//{
			//if (Addition.DefaultPosition < JobInfo.ValidChar.Length)
			//{
				//JobInfo.ValidChar.InsertItem(Addition.DefaultPosition, MyName);
			//} else {  //  if this tile is not configured, use the last configured tile
				//JobInfo.ValidChar.AddItem(MyName);
			//}
		//}
	//}
//}
//
