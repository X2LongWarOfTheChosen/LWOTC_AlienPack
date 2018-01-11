class UIScreenListener_TacticalHUD_DroneMatinee extends UIScreenListener;

event OnInit(UIScreen Screen)
{
	local Object TriggerObj;
	if (UITacticalHUD(Screen) != none)
	{
		TriggerObj = self;
		`XEVENTMGR.UnregisterFromAllEvents(TriggerObj);
		`XEVENTMGR.RegisterForEvent(TriggerObj, 'OnCreateCinematicPawn', OnCinematicPawnCreated, ELD_Immediate);
	}
}


//handles updating cinematic pawn creation
function EventListenerReturn OnCinematicPawnCreated(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameState_Unit UnitState;
	local XComUnitPawn CinematicPawn;
	
	UnitState = XComGameState_Unit(EventSource);
	CinematicPawn = XComUnitPawn(EventData);

	if(UnitState == none || CinematicPawn == none)
		return ELR_NoInterrupt;
	
	// check if it's a drone
	if (class'X2DownloadableContentInfo_LWOTCAlienPack'.default.droneNames.Find(UnitState.GetMyTemplateName()) == INDEX_NONE)
		return ELR_NoInterrupt;

	CinematicPawn.InitiateBuiltInParticleEffects();
	
	return ELR_NoInterrupt;
} 
