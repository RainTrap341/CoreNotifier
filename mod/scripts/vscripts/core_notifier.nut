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
            continue;

        // if (IsCoreAvailable(you)) { // not work properly
        if (IsCoreChargeAvailable(you, you.GetTitanSoul())) {
            CoreReadyMessage(you)
        }


    }
}


