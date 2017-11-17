//---------------------------------------------------------------------------------------
//  FILE:    UIScreenListener_Shell
//  AUTHOR:  Amineri / Long War Studios
//
//  PURPOSE: Early game hook to allow template modifications.
//---------------------------------------------------------------------------------------

class UIScreenListener_Shell extends UIScreenListener config(LWOTC_AlienPack);

// `include(LWOTC_AlienPack\Src\LWOTC_AlienPack.uci)
//
// struct AIJobInfo_Addition
// {
// 	var name JobName;						// Name of this job.
// 	var name NewCharacterName;				// The name of the new character type being added
// 	var name BeforeUnit;					// Put the NewCharacter Before this unit, if possible
// 	var name AfterUnit;						// Put the NewCharacter After this unit, if possible
// 	var int DefaultPosition;				// Default index to insert at if cannot find based on name
// };
//
// struct InclusionExclusionList_Addition
// {
// 	var name ListID;		// name of the ListID we are adding to
// 	var name NewName;		// name we are adding to the ListID
// };
//
// var config array<AIJobInfo_Addition> JobListingAdditions; // Definition of qualifications for each job for this new character
// var config array<InclusionExclusionList_Addition> InclusionExclusionMods;
//
// var private bool HasInited;
//
// event OnInit(UIScreen Screen)
// {
// 	if(UIShell(Screen) == none)
// 		return;
//
//     // We only want to perform this once per game cycle. If the user goes back to the main menu
//     // after starting/loading a game, we don't want to perform all the manipulations again.
//     if (HasInited)
//     {
//         return;
//     }
//
//     HasInited = true;
//
//     // Apply all AI Jobs, adding new items as needed
//     UpdateAIJobs();
//
// 	//update all InclusionExclusion Lists
// 	UpdateInclusionExclusionLists();
// }
//
// simulated function UpdateInclusionExclusionLists()
// {
// 	local XComTacticalMissionManager MissionManager;
// 	local int ListIdx;
// 	local InclusionExclusionList ListItem;
// 	local InclusionExclusionList_Addition Addition;
//
// 	MissionManager = `TACTICALMISSIONMGR;
//
// 	foreach InclusionExclusionMods(Addition)
// 	{
// 		ListIdx = MissionManager.InclusionExclusionLists.Find('ListID', Addition.ListID);
// 		ListItem = MissionManager.InclusionExclusionLists[ListIdx];
// 		ListItem = ListItem; // HAX to prevent warning
// 		ListItem.TemplateName.AddItem(Addition.NewName);
// 	}
// }
//
// simulated function UpdateAIJobs()
// {
// 	local X2AIJobManager JobMgr;
// 	local X2CharacterTemplateManager CharacterMgr;
// 	local X2CharacterTemplate CharTemplate;
// 	local AIJobInfo_Addition Addition;
// 	local int AdditionIndex, JobIdx;
// 	local AIJobInfo JobInfo;
// 	local name MyName;
//
// 	//retrieve Managers
// 	JobMgr = `AIJOBMGR;
// 	CharacterMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
//
// 	//for debugging, to verify that the AIJobManager is alive and has data
// 	foreach JobMgr.JobListings(JobInfo)
// 	{
// 		`APTRACE("UpdateAIJobs : Found Job " $ JobInfo.JobName);
// 	}
//
// 	foreach JobListingAdditions(Addition)
// 	{
// 		`APTRACE("UpdateAIJobs : Parsing Addition " $ Addition.JobName $ " / " $ Addition.NewCharacterName);
// 		MyName = Addition.NewCharacterName;
// 		CharTemplate = CharacterMgr.FindCharacterTemplate(MyName);
// 		if(CharTemplate == none)
// 		{
// 			`REDSCREEN("UpdateAIJobs : Invalid character template = " $ MyName);
// 			continue;
// 		}
//
// 		//JobInfo = JobMgr.GetJobListing(Addition.JobName);
// 		JobIdx = JobMgr.JobListings.Find('JobName', Addition.JobName);
//
// 		if(JobMgr.JobListings[JobIdx].JobName == '')
// 		{
// 			`REDSCREEN("UpdateAIJobs : Invalid job name = " $ Addition.JobName);
// 			continue;
// 		}
//
// 		if(Addition.BeforeUnit != '')
// 		{
// 			AdditionIndex = JobMgr.JobListings[JobIdx].ValidChar.Find(Addition.BeforeUnit);
// 			if(AdditionIndex != INDEX_NONE)
// 			{
// 				`APTRACE("UpdateAIJobs : found " $ Addition.BeforeUnit $ ", inserting " $ MyName $ " just before.");
// 				JobMgr.JobListings[JobIdx].ValidChar.InsertItem(AdditionIndex, MyName);
// 				continue;
// 			}
// 		}
//
// 		if(Addition.AfterUnit != '')
// 		{
// 			AdditionIndex = JobMgr.JobListings[JobIdx].ValidChar.Find(Addition.AfterUnit);
// 			if(AdditionIndex != INDEX_NONE)
// 			{
// 				`APTRACE("UpdateAIJobs : found " $ Addition.AfterUnit $ ", inserting " $ MyName $ " just after.");
// 				JobMgr.JobListings[JobIdx].ValidChar.InsertItem(AdditionIndex+1, MyName);
// 				continue;
// 			}
// 		}
// 		//default to default index value
// 		AdditionIndex = Addition.DefaultPosition;
// 		if(AdditionIndex >= JobMgr.JobListings[JobIdx].ValidChar.Length)
// 		{
// 			`APTRACE("UpdateAIJobs : defaulting to adding " $ MyName $ " to end of list");
// 			JobMgr.JobListings[JobIdx].ValidChar.AddItem(MyName);
// 		}
// 		else
// 		{
// 			AdditionIndex = Max(0, AdditionIndex);
// 			`APTRACE("UpdateAIJobs : defaulting to adding " $ MyName $ " to position " $ AdditionIndex);
// 			JobMgr.JobListings[JobIdx].ValidChar.InsertItem(AdditionIndex, MyName);
// 		}
// 	}
// }
//
//
// defaultProperties
// {
//     ScreenClass = none
// }
