//---------------------------------------------------------------------------------------
//  FILE:    UIScreenListener_GameLoad
//  AUTHOR:  Amineri / Long War Studios
//
//  PURPOSE: Implements hooks to execute things when a new save is loaded or a campaign entered
//			This implementation "polls" more often that is desired, since we don't have a good way to detect when a new save has been loade
//--------------------------------------------------------------------------------------- 

class UIScreenListener_GameLoad extends UIScreenListener;

//DEPRECATED

// This event is triggered after a screen is initialized
//event OnInit(UIScreen Screen)
//{
	//local XComGameState_CampaignSettings CampaignSettingsStateObject;
	//local XComGameState_AlienCustomizationManager AlienCustomizationManager;
//
	//CampaignSettingsStateObject = XComGameState_CampaignSettings(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_CampaignSettings', true));
	//if(CampaignSettingsStateObject == none) return;
	//if(CampaignSettingsStateObject.GameIndex == LastGameIndex) return;
//
	//LastGameIndex = CampaignSettingsStateObject.GameIndex;
//
	//AlienCustomizationManager =  XComGameState_AlienCustomizationManager(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_AlienCustomizationManager', true));
	//if(AlienCustomizationManager == none) 
	//{
		//AlienCustomizationManager = class'XComGameState_AlienCustomizationManager'.static.CreateAlienCustomizationManager();
	//}
//
	//AlienCustomizationManager.RegisterListeners();
	//if(`TACTICALRULES.TacticalGameIsInPlay())
		//AlienCustomizationManager.UpdateAllCustomizations();
//}

// This event is triggered after a screen receives focus
//event OnReceiveFocus(UIScreen Screen);

// This event is triggered after a screen loses focus
//event OnLoseFocus(UIScreen Screen);

// This event is triggered when a screen is removed
//event OnRemoved(UIScreen Screen)
//{
	//local XComGameState_AlienCustomizationManager AlienCustomizationManager;
//
	//if(UILoadGame(Screen) != none)
	//{
		//AlienCustomizationManager =  XComGameState_AlienCustomizationManager(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_AlienCustomizationManager', true));
		//if(AlienCustomizationManager == none) 
		//{
			//AlienCustomizationManager = class'XComGameState_AlienCustomizationManager'.static.CreateAlienCustomizationManager();
		//}
//
		//AlienCustomizationManager.RegisterListeners();
		//if(`TACTICALRULES.TacticalGameIsInPlay())
			//AlienCustomizationManager.UpdateAllCustomizations();
	//}
//}

defaultproperties
{
	// Leave this none so it can be triggered anywhere, gate inside the OnInit
	ScreenClass = UITacticalHUD;
}
