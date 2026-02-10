-- Practice Problems

-- A. Basic SELECT and WHERE
-- 1. List all wizards with mana >= 170, showing full_name, rank, mana.
SELECT full_name, wizard_rank, mana
FROM wizards
WHERE mana >= 170;

-- 2. List all spells that are Rare or Legendary, show name, school, rarity.
SELECT name, school, rarity
FROM spells
WHERE rarity = 'Rare' OR rarity = 'Legendary';

-- 3. Find all quests with danger_level = 'High' and reward at least 200.
SELECT title, danger_level, reward_gold
FROM quests
WHERE danger_level = 'High' AND reward_gold >= 200;

-- B.) JOIN practice
-- 1. Show each wizard and their house name. (wizard name + house name)
SELECT full_name, name as 'house_name'
FROM wizards INNER JOIN houses
ON wizards.house_id = houses.house_id;

-- 2. Show each wizard and their guild name (include wizards with no guild).
SELECT full_name, name as 'guild_name'
FROM wizards INNER JOIN guilds 
ON wizards.guild_id = guilds.guild_id;

-- 3. List every familiar with its wizard’s name and house name.
SELECT familiars.name AS 'familiar', full_name, houses.name AS 'house_name'
FROM familiars INNER JOIN wizards ON familiars.wizard_id = wizards.wizard_id
INNER JOIN houses ON houses.house_id = wizards.house_id;

-- 4. Show each quest with the guild that posted it (include quests with no posting guild if any appear later).
SELECT quests.title, guilds.name
FROM quests INNER JOIN guilds ON quests.posted_by_guild_id = guilds.guild_id;

-- C.) Aggregation + GROUP BY
-- 1. Count how many wizards are in each house.
SELECT houses.name, COUNT(wizards.wizard_id)
FROM houses INNER JOIN wizards ON houses.house_id = wizards.house_id
GROUP BY houses.name;

-- 2. For each guild, show the number of wizards in that guild (include guilds with 0).
SELECT guilds.name, COUNT(wizards.wizard_id)
FROM guilds INNER JOIN wizards ON guilds.guild_id = wizards.guild_id
GROUP BY guilds.name;

-- 3. Show the average mana by rank.
SELECT wizard_rank, AVG(mana)
FROM wizards
GROUP BY wizard_rank;

-- 4. For each duel, show total mana spent across all casts.
SELECT duels.duel_id, AVG(spell_casts.mana_spent)
FROM duels INNER JOIN spell_casts ON duels.duel_id = spell_casts.duel_id
GROUP BY duels.duel_id;

-- D.) HAVING (the “filter groups” unit)
-- 1. List houses that have 2+ wizards.
SELECT houses.name, COUNT(wizards.wizard_id)
FROM houses INNER JOIN wizards ON houses.house_id = wizards.house_id
GROUP BY houses.name
HAVING COUNT(wizards.wizard_id) >= 2;

-- 2. List spells that have been learned by 2+ spellbooks.
SELECT spells.name, COUNT(spellbook_spells.spell_id)
FROM spells INNER JOIN spellbook_spells ON spells.spell_id = spellbook_spells.spell_id
GROUP BY spells.name
HAVING COUNT(spellbook_spells.spell_id) >= 2;

-- 3. List duels where the winner cast more than 1 spell (hint: join duels to spell_casts, group by duel).
SELECT duels.duel_id, COUNT(spell_casts.spell_id) AS 'num_spells_casted'
FROM duels INNER JOIN spell_casts ON duels.duel_id = spell_casts.duel_id
GROUP BY duels.duel_id
HAVING COUNT(spell_casts.spell_id) >= 1;

-- E.) Subqueries (non-join questions / “use subquery” style)
-- 1. Find wizards whose mana is greater than the average mana of all wizards.
SELECT wizards.full_name
FROM wizards
WHERE wizards.mana > (SELECT AVG(mana) FROM wizards);

-- 2. Find spells whose base_mana_cost is above the average for their school (correlated subquery).
SELECT s.name
FROM spells s
WHERE s.base_mana_cost > (
  SELECT AVG(s2.base_mana_cost)
  FROM spells s2
  WHERE s2.school = s.school
);

-- 3. Find guild(s) that posted the highest reward quest (if tie, return all).
SELECT g.name
FROM guilds g
WHERE g.guild_id IN (
	SELECT q.posted_by_guild_id 
    FROM quests q
    WHERE q.reward_gold = (SELECT MAX(q2.reward_gold)
								FROM quests q2)
);

-- F.) Anti-join (find non-matches)
-- 1. Find wizards who have no familiar.
SELECT w.full_name, f.name
FROM wizards w
LEFT JOIN familiars f ON f.wizard_id = w.wizard_id
WHERE f.name IS NULL;

-- 2. Find wizards who have no spellbook.
SELECT w.full_name, s.title
FROM wizards w
LEFT JOIN spellbooks s ON w.wizard_id = s.wizard_id
WHERE s.title IS NULL;

-- 3. Find spells that have never been cast in any duel.
SELECT s.spell_id, sp.cast_id
FROM spells s
LEFT JOIN spell_casts sp ON sp.spell_id = s.spell_id
WHERE sp.cast_id IS NULL;


-- G.) Multi-join "story problems"
-- 1. List each wizard with: house name, guild name (or NULL), number of quests assigned
SELECT w.full_name AS 'wizard_name', h.name AS 'house_name', g.name AS 'guild_name', a.num_quests
FROM wizards w 
INNER JOIN houses h ON w.house_id = h.house_id
LEFT JOIN guilds g ON w.guild_id = g.guild_id
LEFT JOIN (SELECT w.full_name, COUNT(*) AS 'num_quests'
FROM wizards w INNER JOIN quest_assignments q
ON w.wizard_id = q.wizard_id 
GROUP BY w.full_name
) as a ON a.full_name = w.full_name;

-- 2. Which wizard has completed the most quests? (ties included)
SELECT w.full_name AS 'wizard_name', a.num_quests_completed 
FROM wizards w 
INNER JOIN (SELECT wizard_id, COUNT(*) AS 'num_quests_completed'
			FROM quest_assignments
            WHERE status = 'Completed'
            GROUP BY wizard_id
            ) AS a ON a.wizard_id = w.wizard_id
WHERE a.num_quests_completed = (SELECT MAX(num_quests_completed) FROM
	(SELECT wizard_id, COUNT(*) AS 'num_quests_completed'
			FROM quest_assignments
            WHERE status = 'Completed'
            GROUP BY wizard_id) as b);

-- 3. For each duel, show: duel_date, challenger name, defender name, winner name, number of spells cast total
SELECT d.duel_date, spells_casted, w.full_name AS 'challenger', w2.full_name AS 'defender', w3.full_name AS 'winner'
FROM duels d INNER JOIN wizards w ON d.challenger_id = w.wizard_id
INNER JOIN wizards w2 ON d.defender_id = w2.wizard_id
INNER JOIN wizards w3 ON d.winner_id = w3.wizard_id 
INNER JOIN (SELECT duel_id, COUNT(*) AS 'spells_casted'
			FROM spell_casts
			GROUP BY duel_id) AS a ON a.duel_id = d.duel_id;

-- H.) DML/DDL Tasks
-- 1. Insert a new wizard (your choice), assign them a house, and give them a familiar.
INSERT INTO wizards
VALUES (9, "Valerie Williams", 5, 4, 'Master', 300, 2026, NOW());
INSERT INTO familiars 
VALUES (8, 9, 'Aika', 'Fox', 10);

-- 2. Update all Apprentice wizards: add +10 mana.
UPDATE wizards
SET mana = mana + 10, wizard_rank = 'Adept'
WHERE wizard_rank = 'Apprentice';

-- 3. Delete a quest assignment that was Failed (careful with your WHERE clause).
DELETE FROM quest_assignments
WHERE status = 'Failed';

-- 4. Add a constraint so that reward_gold can’t exceed 9999 (ALTER TABLE with CHECK).
ALTER TABLE quests
ADD CONSTRAINT gold_limit
CHECK (reward_gold <= 9999);