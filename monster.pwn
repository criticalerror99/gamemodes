#include <rwmp>

enum Player_Info {
	FirsSpawn = 0
};

new actor_veh[MAX_PLAYERS];
new actor_kill[MAX_PLAYERS];
new vehicle[MAX_PLAYERS];

new 
	Player[MAX_PLAYERS][Player_Info],
	Zone;

main()
{
    print("\n\n\n");

	new str[128];
	format(str, sizeof(str), "Кириллица, как дела? Рандом: %d", random(10));
	print(str);

	format(str, sizeof(str), "/Кириллица, как дела? Рандом: %d", random(10));
	print(str);

	print("\n\n\n");
}

stock GetName(playerid)
{
	new temp[25];
    GetPlayerName(playerid, temp, sizeof(temp));
	return temp;
}

forward TimeDate();

public OnGameModeInit()
{
	SetGameModeText("Monster GM");
	new Float:monsterX = 414.914, count;
	for (new id = 254; id <= 288; id++)
	{
		if (id == 265) id = 274;
		AddPlayerClass(id, 389.867, 2543.005, 16.539, 173.765, 0, 0, 0, 0, 0, 0);
	}
	for(count = 0; count <= 30; count++) AddStaticVehicle(557, monsterX, 2482.486, 16.859, 0.0, 1, 1), monsterX -= 9.0;
	
	AddStaticVehicle(513, 324.766, 2546.098, 16.488, 178.866, -1, -1);
	AddStaticVehicle(513, 290.271, 2544.777, 16.500, 178.018, -1, -1);
	AddStaticVehicle(487, 261.907, 2522.699, 16.405, 175.940, -1, -1);
	AddStaticVehicle(487, 244.052, 2524.352, 16.417, 180.832, -1, -1);
	AddStaticVehicle(532, 101.555, 2584.073, 17.454, 178.032, -1, -1);

	
	Zone = GangZoneCreate(1082.962, -2787.229, 2942.549, -1859.51);
    
    DisableInteriorEnterExits();
    return 1;
}

public OnPlayerConnect(playerid)
{
	SetPlayerColor(playerid, 0xEE5555FF);
	SetPlayerWantedLevel(playerid, 6);
 	SetPlayerMapIcon(playerid, 1, 2204.9468, 1986.2877, 16.7380, 52, 1, MAPICON_GLOBAL);
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	Player[playerid][FirsSpawn] = 0;
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
 	SetPlayerWeather(playerid, 1);
 	SetPlayerTime(playerid, 8, 0);
	SetPlayerPos(playerid, 398.408, 2540.505, 19.631);
	SetPlayerCameraPos(playerid, 398.408, 2530.505, 19.631);
	SetPlayerCameraLookAt(playerid, 398.408, 2540.505, 19.631);
	SetPlayerFacingAngle(playerid, 180.000);
	return 1;
}
public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	
	if(!strcmp(cmdtext, "/driver"))
	{
	    if(actor_veh[playerid] <= 0)
	    {
		    new Float:X, Float:Y, Float:Z;
		    GetPlayerPos(playerid, X, Y, Z);
			actor_veh[playerid] = CreateActor("kyeman",254,X+3,Y,Z,173.7645);
			vehicle[playerid] = AddStaticVehicle(420, X + 5, Y, Z, 270.000, -1, -1);
			PutActorInVehicle(actor_veh[playerid], vehicle[playerid], true);
		    ActorDriveVehicleTo(actor_veh[playerid], vehicle[playerid], 0.0, 0.0, 0.0, 30.0, 1, 10.0, 10.0);
		}

		return 1;
	}
	
	if(!strcmp(cmdtext, "/killer"))
	{
	    if(actor_kill[playerid] <= 0)
	    {
		    new Float:X, Float:Y, Float:Z;
		    GetPlayerPos(playerid, X, Y, Z);
			actor_kill[playerid] = CreateActor("kyeman",254,X+3,Y,Z,173.7645);
			ActorKillPlayer(actor_kill[playerid], playerid, 22);
		}
		return 1;
	}
	
	if(!strcmp(cmdtext, "/follow"))
	{
	    if(actor_kill[playerid] <= 0)
	    {
		    new Float:X, Float:Y, Float:Z;
		    GetPlayerPos(playerid, X, Y, Z);
			actor_kill[playerid] = CreateActor("kyeman",254,X+3,Y,Z,173.7645);
			ActorMoveTo(actor_kill[playerid], 1, X, Y, Z);
		}
		return 1;
	}
	
	return 0;
}

public OnPlayerSpawn(playerid)
{
	GangZoneShowForPlayer(playerid, Zone, 0xFFFF0096);
	
	TogglePlayerHUDComponent(playerid, HUD_COMPONENT_HEALTH, false);
	SetPlayerHUDComponentColor(playerid, HUD_COLOUR_MONEY_POSITIVE, 0xE9967AFF);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	GameTextForPlayer(playerid, "~r~Wasted", 5000, 2);
 	return 1;
}

public OnPlayerText(playerid, text[])
{
	if (strlen(text) == 0) return 0;
	new temp[2048];
	format(temp, sizeof(temp), "{%06x}%s: {FFFFFF}%s", GetPlayerColor(playerid) >>> 8, GetName(playerid), text);
	SendClientMessageToAll(-1, temp);
	return 0;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerRconAttempt(playerid, successfull)
{
	return 1;
}

public OnActorCreate(actorid)
{
	return 1;
}

public OnActorDestroy(actorid)
{
	return 1;
}

public OnRconCommand(playerid, cmd[])
{
	return 0;
}

public OnVehicleDamageStatusUpdate(vehicleid)
{
    return 1;
}
