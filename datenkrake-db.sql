CREATE TABLE `Captures` (
  `id` int(11) NOT NULL,
  `round_id` int(11) NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `player_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ConnectionRounds` (
  `id` int(11) NOT NULL,
  `connection_id` int(11) NOT NULL,
  `round_id` int(11) NOT NULL,
  `points` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Connections` (
  `id` int(11) NOT NULL,
  `connection_start` datetime NOT NULL,
  `connection_end` datetime DEFAULT NULL,
  `player_name` text NOT NULL,
  `guid` text NOT NULL,
  `ping` int(11) NOT NULL,
  `players_total` int(11) NOT NULL,
  `players_end` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Kills` (
  `id` int(11) NOT NULL,
  `round_id` int(11) NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `player_name` text NOT NULL,
  `player_ping` int(11) NOT NULL,
  `damager_name` text NOT NULL,
  `damager_ping` int(11) NOT NULL,
  `weapon` text NOT NULL,
  `distance` int(11) NOT NULL,
  `isRoadKill` tinyint(1) NOT NULL,
  `isHeadShot` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `PlayerSpawns` (
  `id` int(11) NOT NULL,
  `round_id` int(11) NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `player_name` text NOT NULL,
  `spawn_on_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Reloads` (
  `id` int(11) NOT NULL,
  `round_id` int(11) NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `player_name` int(11) NOT NULL,
  `weapon` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Resupplies` (
  `id` int(11) NOT NULL,
  `round_id` int(11) NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `player_name` text NOT NULL,
  `supplier_name` text NOT NULL,
  `mag_count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Revives` (
  `id` int(11) NOT NULL,
  `round_id` int(11) NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `player_name` text NOT NULL,
  `reviver_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Rounds` (
  `id` int(11) NOT NULL,
  `round_start` datetime NOT NULL,
  `round_end` datetime DEFAULT NULL,
  `server_name` text NOT NULL,
  `map` text NOT NULL,
  `gamemode` text NOT NULL,
  `modlist` text NOT NULL,
  `players_max` int(11) NOT NULL DEFAULT 0,
  `players_start` int(11) NOT NULL DEFAULT 0,
  `players_end` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `SquadKicks` (
  `id` int(11) NOT NULL,
  `round_id` int(11) NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `player_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Supressions` (
  `id` int(11) NOT NULL,
  `round_id` int(11) NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `player_name` text NOT NULL,
  `player_ping` int(11) NOT NULL,
  `enemy_name` text NOT NULL,
  `enemy_ping` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `WeaponChanges` (
  `id` int(11) NOT NULL,
  `round_id` int(11) NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `player_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `Captures`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `ConnectionRounds`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `Connections`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `Kills`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `PlayerSpawns`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `Reloads`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `Revives`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `Rounds`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `SquadKicks`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `WeaponChanges`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `Captures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `ConnectionRounds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `Connections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `Kills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `PlayerSpawns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `Reloads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `Revives`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `Rounds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `SquadKicks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `WeaponChanges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;
