global function CoreNotifierInit


var rui


void function CoreNotifierInit(){

    thread Precache()
}

void function Precache(){
    WaitFrame()
    thread Monitor()
}


void function Monitor(){
    while(true)
    {
        WaitFrame()
        if(IsLobby() || IsMenuLevel())
            continue
        entity you = GetLocalClientPlayer()
        if(you == null || IsSpectre(you))
            continue

        if ( GetLocalClientPlayer() != GetLocalViewPlayer() )
        continue

        // if (IsCoreAvailable(you)) { // not work properly
        if (IsCoreChargeAvailable(you, you.GetTitanSoul())) {
            _CoreReadyMessage(you)
        }


    }
}

///

void function _CoreReadyMessage( entity player )
{
	if ( !GamePlayingOrSuddenDeath() )
		return

	if ( !IsAlive( player ) )
		return

	if ( GetDoomedState( player ) )
		return

	if ( !player.IsTitan() )
		return

	entity weapon = player.GetOffhandWeapon( OFFHAND_EQUIPMENT )

	string coreOnlineMessage = expect string( weapon.GetWeaponInfoFileKeyField( "readymessage" ) )
	string coreOnlineHint = expect string( weapon.GetWeaponInfoFileKeyField( "readyhint" ) )

	AnnouncementData announcement = CreateAnnouncementMessage( player, coreOnlineMessage, coreOnlineHint, TEAM_COLOR_YOU )
    // announcement.announcementStyle = ANNOUNCEMENT_STYLE_BIG
	announcement.displayConditionCallback = ConditionPlayerIsTitan
	announcement.subText = coreOnlineHint
    announcement.duration = 1.0

    announcement.announcementStyle = ANNOUNCEMENT_STYLE_QUICK
	announcement.soundAlias = SFX_HUD_ANNOUNCE_QUICK

	AnnouncementFromClass( player, announcement )

}


bool function ConditionPlayerIsTitan()
{
	entity player = GetLocalClientPlayer()
	if ( !IsAlive( player ) )
		return false

	return player.IsTitan()
}

