-- ---------- Seed Data ----------
INSERT INTO houses (name, element, motto) VALUES
('Emberclaw','Fire','Burn bright, stay kind.'),
('Tidewhisper','Water','Flow around obstacles.'),
('Stonebloom','Earth','Grow slow, stand forever.'),
('Skylumen','Air','Rise above, see farther.'),
('Nullspire','Aether','Reality is negotiable.');

INSERT INTO guilds (name, specialty) VALUES
('The Crucible Circle','Alchemy'),
('Silver Sigil Arena','Dueling'),
('Moonwell Hospice','Healing'),
('Starglass Seers','Divination'),
('Mapmakers of Mistvale','Exploration'),
('Obsidian Choir','Dark Arts');

INSERT INTO wizards (full_name, house_id, guild_id, wizard_rank, mana, graduation_year) VALUES
('Valeria Stormquill', 4, 2, 'Adept', 180, 2024),
('Orin Ashwalker',     1, 2, 'Adept', 150, 2023),
('Mira Tideweaver',    2, 3, 'Master', 260, 2018),
('Galen Rootbinder',   3, 1, 'Adept', 140, 2022),
('Nyx Nullborn',       5, 6, 'Master', 300, 2016),
('Pip Sootspark',      1, 1, 'Apprentice', 90, 2026),
('Eira Starbloom',     3, 4, 'Adept', 170, 2021),
('Cassio Vale',        4, NULL, 'Apprentice', 110, 2025);

INSERT INTO familiars (wizard_id, name, species, bond_level) VALUES
(1,'Comet','Raven',8),
(2,'Cinder','Fox',6),
(3,'Pearl','Owl',9),
(4,'Moss','Cat',7),
(5,'Hex','Sprite',10),
(6,'Pebble','Toad',4),
(7,'Lumen','Owl',6);

INSERT INTO spellbooks (wizard_id, title, created_year, is_cursed) VALUES
(1,'Aeromancy for Overachievers', 2022, FALSE),
(2,'Firebrand Forms Vol. I',      2021, FALSE),
(3,'Tides & Triage',              2017, FALSE),
(4,'Practical Alchemy Notes',     2022, FALSE),
(5,'Unwelcome Truths',            2015, TRUE),
(6,'Kitchen Cantrips',            2026, FALSE),
(7,'Starglass Almanac',           2020, FALSE);

INSERT INTO spells (name, school, base_mana_cost, rarity) VALUES
('Guststep','Elemental', 12, 'Common'),
('Skyneedle','Elemental', 25, 'Uncommon'),
('Emberlash','Elemental', 20, 'Common'),
('Cinder Ward','Healing', 18, 'Uncommon'),
('Tide Mend','Healing', 22, 'Common'),
('Mirror Mirth','Illusion', 15, 'Common'),
('Bone Lantern','Necromancy', 40, 'Rare'),
('Fate Thread','Divination', 35, 'Rare'),
('Lead to Gold?','Transmutation', 28, 'Uncommon'),
('Null Veil','Dark Arts', 55, 'Legendary');

INSERT INTO spellbook_spells (spellbook_id, spell_id, learned_on) VALUES
(1,1,'2022-09-01'), (1,2,'2023-02-14'), (1,6,'2022-10-10'),
(2,3,'2021-10-02'), (2,4,'2022-01-11'),
(3,5,'2017-05-03'), (3,4,'2017-08-20'),
(4,9,'2022-03-12'),
(5,7,'2016-04-09'), (5,10,'2017-11-30'),
(6,6,'2026-01-15'), (6,3,'2026-01-20'),
(7,8,'2020-06-06'), (7,6,'2020-06-07');

INSERT INTO quests (title, danger_level, reward_gold, posted_by_guild_id) VALUES
('Retrieve a lost compass from Mistvale', 'Medium', 120, 5),
('Brew antidote for basilisk rash',       'Low',     60, 1),
('Escort healer to Moonwell Outpost',     'High',   200, 3),
('Investigate haunted lanterns',          'High',   240, 4),
('Seal a Nullspire rift (do not blink)',  'Fatal',  500, 2);

INSERT INTO quest_assignments (quest_id, wizard_id, status, assigned_on, completed_on) VALUES
(1,1,'Completed','2026-01-10','2026-01-13'),
(1,8,'Failed',   '2026-01-10','2026-01-12'),
(2,4,'Completed','2026-01-15','2026-01-15'),
(3,3,'Assigned', '2026-02-01',NULL),
(4,7,'Assigned', '2026-02-02',NULL),
(5,5,'Assigned', '2026-02-05',NULL),
(5,2,'Assigned', '2026-02-05',NULL);

INSERT INTO duels (challenger_id, defender_id, location, duel_date, winner_id) VALUES
(2,1,'Silver Sigil Arena','2026-01-18',1),
(6,8,'Dorm Hallway','2026-01-22',8),
(5,3,'Nullspire Balcony','2026-02-06',5);

INSERT INTO spell_casts (duel_id, caster_id, spell_id, mana_spent, was_critical, cast_order) VALUES
(1,2,3,20,FALSE,1),
(1,1,2,25,TRUE, 2),
(1,2,4,18,FALSE,3),
(1,1,1,12,FALSE,4),

(2,6,6,15,FALSE,1),
(2,8,3,20,TRUE, 2),

(3,5,10,60,TRUE, 1),
(3,3,5,22,FALSE,2),
(3,5,7,40,FALSE,3);
