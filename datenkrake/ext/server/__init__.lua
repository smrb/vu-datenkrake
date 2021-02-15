print('Datenkrake is starting ...')

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
    			.. "&players=" 	.. PlayerManager:GetPlayerCount() )
end)

-- Player Join / Leave
Events:Subscribe('Player:Joining', function(name, playerGuid, ipAddress, accountGuid)
    s('PLAYER_JOINED', "&name=" .. name
                    .. "&pall=" .. PlayerManager:GetPlayerCount()
                    .. "&ping=0"
                    .. "&guid=0")
end)

Events:Subscribe('Player:Left', function(player)
    s('PLAYER_LEFT', "&name=" .. player.name
    				.. "&pall=" .. PlayerManager:GetPlayerCount()
    				.. "&ping=" .. player.ping
    				.. "&points=" .. player.score )
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
    				.. "&ping=" 		.. player.ping
    				.. "&killer=" 		.. killer
    				.. "&killerping=" 	.. killerping
    				.. "&weapon=" 		.. weapon
    				.. "&distance=" 	.. distance
    				.. "&roadkill=" 	.. isRoadKill
    				.. "&headshot=" 	.. isHeadShot )
end)

Events:Subscribe('Player:SuppressedEnemy', function(player, enemy)
    s('PLAYER_SUPPRESSED', "&name="         .. player.name
                        .. "&ping="         .. player.ping
                        .. "&enemy="        .. enemy.name
                        .. "&enemyping="    .. enemy.ping)
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
                            .. "&count="    .. givenMagsCount)
    end
end)

Events:Subscribe('Player:Reload', function(player, weaponName, position)
    s('WEAPON_RELOAD', "&name="     .. player.name
                    .. "&weapon="   .. weaponName)
end)



print('READY: Datenkrake v0.2.1 by SmR.b')
print('Coded under the influence of weed, alcohol and good music.')
