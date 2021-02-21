print('Datenkrake is starting ...')
-- v1.2.2 fixed string bool concant (fuck lua)
-- v1.2.1 Initial Release
function s (e, v)
-- Insert your domain:
  local r = 'https://yourdomain.tld/datenkrake.php?event=' .. e .. v
  local res = Net:GetHTTP(r)
  print(r)
end

-- Round Management
Events:Subscribe('Level:Loaded', function(levelName, gameMode, round, roundsPerMap)
    s('ROUND_START',   "&name=" .. levelName
    				.. "&mode=" .. gameMode )
end)

Events:Subscribe('Server:RoundOver', function(roundTime, winningTeam)
    s('ROUND_END', "&win=" 		.. winningTeam
    			.. "&players=" 	.. tostring(PlayerManager:GetPlayerCount()) )
end)

-- Player Join / Leave
Events:Subscribe('Player:Joining', function(name, playerGuid, ipAddress, accountGuid)
    s('PLAYER_JOINED', "&name=" .. name
                    .. "&pall=" .. tostring(PlayerManager:GetPlayerCount())
                    .. "&ping=0"
                    .. "&guid=0")
end)

Events:Subscribe('Player:Left', function(player)
    s('PLAYER_LEFT', "&name="       .. player.name
    				.. "&pall="     .. tostring(PlayerManager:GetPlayerCount())
    				.. "&ping="     .. tostring(player.ping)
    				.. "&points="   .. tostring(player.score) )
end)

-- Kill and Supress

Events:Subscribe('Player:Killed', function(player, inflictor, position, weapon, isRoadKill, isHeadShot, wasVictimInReviveState, info)
	local killer 		= ''
	local killerping 	= 0
	local distance 		= 0
	if (inflictor ~= nil) then
		killer 			= inflictor.name
		killerping 		= inflictor.ping
	end
	if info.giver then
		distance =  info.giver.soldier.transform.trans:Distance(position)
	end

    s('PLAYER_KILLED', "&name=" 		.. player.name
    				.. "&ping=" 		.. tostring(player.ping)
    				.. "&killer=" 		.. killer
    				.. "&killerping=" 	.. tostring(killerping)
    				.. "&weapon=" 		.. weapon
    				.. "&distance=" 	.. tostring(distance)
    				.. "&roadkill=" 	.. tostring(isRoadKill)    -- This is the reason for the frikn 2.7.2 update. UUUhhhh I'm lua, I'm to
    				.. "&headshot=" 	.. tostring(isHeadShot) )  -- dumb to cast a bool to an string when concenating ... but why does it work with ints?
end)                                                               -- This language IS aids and yet no one on vu devtalk understands. I want to kill myself.
                                                                   -- why dont embedd c#? dynamicly compiling with roslyn and embedding mods this way would meke this so easy

Events:Subscribe('Player:SuppressedEnemy', function(player, enemy)
    s('PLAYER_SUPPRESSED', "&name="         .. player.name
                        .. "&ping="         .. tostring(player.ping)
                        .. "&enemy="        .. enemy.name
                        .. "&enemyping="    .. tostring(enemy.ping))
end)


Events:Subscribe('Player:ChangingWeapon', function(player)
    s('WEAPON_CHANGED', "&name=" .. player.name)
end)

Events:Subscribe('Player:EnteredCapturePoint', function(player, capturePoint)
    s('ENTERED_POINT', "&name=" .. player.name)
end)

Events:Subscribe('Player:KickedFromSquad', function(player, squad)
    s('SQUAD_KICKED', "&name=" .. player.name)
end)


Events:Subscribe('Player:ReviveAccepted', function(player, reviver)
    if(reviver ~= nil) then
        s('PLAYER_REVIVED',  "&name=" .. player.name
                          .. "&revi=" .. reviver.name)
    end
end)

Events:Subscribe('Player:SpawnOnPlayer', function(player, playerToSpawnOn)
    s('PLAYER_SPAWN_ON',   "&name="   .. player.name
                        .. "&on="     .. playerToSpawnOn.name)
end)


Events:Subscribe('Player:Resupply', function(player, givenMagsCount, supplier)
    if (supplier ~= nil) then
        s('PLAYER_RESUPPLY',   "&name="     .. player.name
                            .. "&giver="    .. supplier.name
                            .. "&count="    .. tostring(givenMagsCount) )
    end
end)

Events:Subscribe('Player:Reload', function(player, weaponName, position)
    s('WEAPON_RELOAD', "&name="     .. player.name
                    .. "&weapon="   .. weaponName)
end)



print('READY: Datenkrake v1.2.2 by SmR.b')
print('Coded under the influence of weed, alcohol and good music.')
print('v1.2.2 changes done under the influence of MDMA and some opiods')
