//---------------------------------------------------------------------------------------
//  FILE:    X2DownloadableContentInfo_LWAlienPack.uc
//  AUTHOR:  Amineri / Long War Studios
//  PURPOSE: Initializes AlienPack mod settings on campaign start or when loading campaign without mod previously active
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_LWOTCAlienPack extends X2DownloadableContentInfo;

`include(LWOTC_AlienPack\Src\LWOTC_AlienPack.uci)

var config array<name> droneNames;

/// <summary>
/// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the
/// DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
/// create without the content installed. Subsequent saves will record that the content was installed.
/// </summary>
static event OnLoadedSavedGame()
{
	local XComGameState_AlienCustomizationManager AlienCustomizationManager;

	AlienCustomizationManager = class'XComGameState_AlienCustomizationManager'.static.CreateAlienCustomizationManager();
	AlienCustomizationManager.RegisterListeners();
}

/// <summary>
/// Called when the player starts a new campaign while this DLC / Mod is installed. When a new campaign is started the initial state of the world
/// is contained in a strategy start state. Never add additional history frames inside of InstallNewCampaign, add new state objects to the start state
/// or directly modify start state objects
/// </summary>
static event InstallNewCampaign(XComGameState StartState)
{
	local XComGameState_AlienCustomizationManager AlienCustomizationManager;

	AlienCustomizationManager = class'XComGameState_AlienCustomizationManager'.static.CreateAlienCustomizationManager(StartState);
	AlienCustomizationManager.RegisterListeners();
}

/// <summary>
/// This method is run when the player loads a saved game directly into Strategy while this DLC is installed
/// </summary>
static event OnLoadedSavedGameToStrategy()
{
	AddAndRegisterCustomizationManager();
}

/// <summary>
/// Called after the player exits the post-mission sequence while this DLC / Mod is installed.
/// </summary>
static event OnExitPostMissionSequence()
{
	AddAndRegisterCustomizationManager();
}

static function AddAndRegisterCustomizationManager()
{
	local XComGameState_AlienCustomizationManager AlienCustomizationManager;

	AlienCustomizationManager =  XComGameState_AlienCustomizationManager(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_AlienCustomizationManager', true));
	if(AlienCustomizationManager == none)
	{
		AlienCustomizationManager = class'XComGameState_AlienCustomizationManager'.static.CreateAlienCustomizationManager();
		AlienCustomizationManager.RegisterListeners();
	}

	// not needed since we aren't going to try and install the AlienCustomization manager when loading into tactical mission
	//if(`TACTICALRULES.TacticalGameIsInPlay())
		//AlienCustomizationManager.UpdateAllCustomizations();
}

/// <summary>
/// Called after the Templates have been created (but before they are validated) while this DLC / Mod is installed.
/// </summary>
static event OnPostTemplatesCreated()
{
	UpdateForAreaSuppression();
	`APDEBUG("ALIEN PACK VERSION 1.0");
}

static function UpdateForAreaSuppression()
{
	local X2AbilityTemplateManager			AbilityTemplateManager;
	local X2AbilityTemplate					AbilityTemplate;
	local X2Condition						Condition;
	local X2Condition_UnitEffects           SuppressedCondition;
	local X2Condition_UnitProperty			UnitProperty;
	local name								AbilityName;
	local X2Effect							AbilityTargetEffect;

	AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	foreach class'LWAlienPack_Utilities'.default.AREA_SUPPRESSION_EXCLUDE_ABILITIES(AbilityName)
	{
		AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate(AbilityName);
		if(AbilityTemplate != none)
		{
			foreach AbilityTemplate.AbilityShooterConditions(Condition)
			{
				SuppressedCondition = X2Condition_UnitEffects(Condition);
				if(SuppressedCondition != none)
				{
					if(SuppressedCondition.ExcludeEffects.Find('EffectName', class'X2Effect_Suppression'.default.EffectName) != -1)
					{
						//found the correct condition, so add the new exclude condition
						`APDEBUG("Updating " $ AbilityName $ " for AreaSuppression Exclusion");
						SuppressedCondition.AddExcludeEffect(class'X2Effect_AreaSuppression_AP'.default.EffectName, 'AA_UnitIsSuppressed');
					}
				}
			}
		}
	}

	// fix for ChryssalidSlash attempt to apply poison to non-units, which results in a CTD
	AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('ChryssalidSlash');
	if (AbilityTemplate != none)
	{
		foreach AbilityTemplate.AbilityTargetEffects(AbilityTargetEffect)
		{
			if (AbilityTargetEffect.IsA('X2Effect_ParthenogenicPoison'))
			{
				foreach AbilityTargetEffect.TargetConditions(Condition)
				{
					UnitProperty = X2Condition_UnitProperty(Condition);
					if (UnitProperty != none)
					{
						UnitProperty.FailOnNonUnits = true;
						break;
					}
				}
			}
		}
	}
}

//=========================================================================================
//================== BEGIN EXEC LONG WAR CONSOLE EXEC =====================================
//=========================================================================================

// this spawns a debug activity with a specified mission
exec function LWDumpAIJobs(optional name JobName)
{
	local X2AIJobManager JobMgr;
	local AIJobInfo JobInfo;

	//retrieve Managers
	JobMgr = `AIJOBMGR;

	if(JobName != '')
	{
		JobInfo = JobMgr.GetJobListing(JobName);
		`LOG("LWDumpAIJobs: Job Name=" $ JobName);
		DumpOneAIJob(JobInfo);
	}
	else
	{
		foreach JobMgr.JobListings(JobInfo)
		{
			`LOG("LWDumpAIJobs: Job Name=" $ JobInfo.JobName);
			DumpOneAIJob(JobInfo);
		}
	}
}

function DumpOneAIJob(AIJobInfo JobInfo)
{
	local int Count;
	local name CharacterName;

	foreach JobInfo.ValidChar(CharacterName, Count)
	{
		`LOG("LWDumpAIJobs: ValidChar[" $ Count $ "]= " $ CharacterName);
	}
}

exec function LWDumpAIJobNames()
{
	local X2AIJobManager JobMgr;
	local AIJobInfo JobInfo;

	//retrieve Managers
	JobMgr = `AIJOBMGR;

	foreach JobMgr.JobListings(JobInfo)
	{
		`LOG("LWDumpAIJobNames: Job Name=" $ JobInfo.JobName);
	}
}
