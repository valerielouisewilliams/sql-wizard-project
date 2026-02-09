- =========================================================
-- WIZARDS & WONDER: A MySQL practice database
-- MySQL 8+
-- =========================================================

DROP DATABASE IF EXISTS wizarding_world;
CREATE DATABASE wizarding_world;
USE wizarding_world;

-- ---------- Tables ----------
CREATE TABLE houses (
  house_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL UNIQUE,
  element ENUM('Fire','Water','Earth','Air','Aether') NOT NULL,
  motto VARCHAR(120)
);

CREATE TABLE guilds (
  guild_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(80) NOT NULL UNIQUE,
  specialty ENUM('Alchemy','Dueling','Healing','Divination','Exploration','Dark Arts') NOT NULL
);

CREATE TABLE wizards (
  wizard_id INT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(80) NOT NULL,
  house_id INT NOT NULL,
  guild_id INT NULL,
  wizard_rank ENUM('Apprentice','Adept','Master','Archmage') NOT NULL DEFAULT 'Apprentice',
  mana INT NOT NULL,
  graduation_year INT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_wizards_house FOREIGN KEY (house_id) REFERENCES houses(house_id),
  CONSTRAINT fk_wizards_guild FOREIGN KEY (guild_id) REFERENCES guilds(guild_id)
);

CREATE TABLE familiars (
  familiar_id INT PRIMARY KEY AUTO_INCREMENT,
  wizard_id INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  species ENUM('Owl','Cat','Toad','Dragonling','Raven','Fox','Sprite') NOT NULL,
  bond_level TINYINT NOT NULL,
  CONSTRAINT fk_familiars_wizard FOREIGN KEY (wizard_id) REFERENCES wizards(wizard_id),
  CONSTRAINT chk_bond_level CHECK (bond_level BETWEEN 1 AND 10)
);

CREATE TABLE spellbooks (
  spellbook_id INT PRIMARY KEY AUTO_INCREMENT,
  wizard_id INT NOT NULL,
  title VARCHAR(100) NOT NULL,
  created_year INT NOT NULL,
  is_cursed BOOLEAN NOT NULL DEFAULT FALSE,
  CONSTRAINT fk_spellbooks_wizard FOREIGN KEY (wizard_id) REFERENCES wizards(wizard_id)
);

CREATE TABLE spells (
  spell_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(70) NOT NULL UNIQUE,
  school ENUM('Elemental','Illusion','Transmutation','Necromancy','Healing','Divination','Dark Arts') NOT NULL,
  base_mana_cost INT NOT NULL,
  rarity ENUM('Common','Uncommon','Rare','Legendary') NOT NULL DEFAULT 'Common',
  CONSTRAINT chk_spell_cost CHECK (base_mana_cost > 0)
);

CREATE TABLE spellbook_spells (
  spellbook_id INT NOT NULL,
  spell_id INT NOT NULL,
  learned_on DATE NOT NULL,
  PRIMARY KEY (spellbook_id, spell_id),
  CONSTRAINT fk_sbs_spellbook FOREIGN KEY (spellbook_id) REFERENCES spellbooks(spellbook_id),
  CONSTRAINT fk_sbs_spell FOREIGN KEY (spell_id) REFERENCES spells(spell_id)
);

CREATE TABLE quests (
  quest_id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(120) NOT NULL,
  danger_level ENUM('Low','Medium','High','Fatal') NOT NULL,
  reward_gold INT NOT NULL,
  posted_by_guild_id INT NULL,
  CONSTRAINT fk_quests_guild FOREIGN KEY (posted_by_guild_id) REFERENCES guilds(guild_id),
  CONSTRAINT chk_reward_gold CHECK (reward_gold >= 0)
);

CREATE TABLE quest_assignments (
  quest_id INT NOT NULL,
  wizard_id INT NOT NULL,
  status ENUM('Assigned','Completed','Failed') NOT NULL DEFAULT 'Assigned',
  assigned_on DATE NOT NULL,
  completed_on DATE NULL,
  PRIMARY KEY (quest_id, wizard_id),
  CONSTRAINT fk_qa_quest FOREIGN KEY (quest_id) REFERENCES quests(quest_id),
  CONSTRAINT fk_qa_wizard FOREIGN KEY (wizard_id) REFERENCES wizards(wizard_id),
  CONSTRAINT chk_completed_on CHECK (completed_on IS NULL OR completed_on >= assigned_on)
);

CREATE TABLE duels (
  duel_id INT PRIMARY KEY AUTO_INCREMENT,
  challenger_id INT NOT NULL,
  defender_id INT NOT NULL,
  location VARCHAR(80) NOT NULL,
  duel_date DATE NOT NULL,
  winner_id INT NULL,
  CONSTRAINT fk_duels_challenger FOREIGN KEY (challenger_id) REFERENCES wizards(wizard_id),
  CONSTRAINT fk_duels_defender FOREIGN KEY (defender_id) REFERENCES wizards(wizard_id),
  CONSTRAINT fk_duels_winner FOREIGN KEY (winner_id) REFERENCES wizards(wizard_id),
  CONSTRAINT chk_duel_not_self CHECK (challenger_id <> defender_id)
);

CREATE TABLE spell_casts (
  cast_id INT PRIMARY KEY AUTO_INCREMENT,
  duel_id INT NOT NULL,
  caster_id INT NOT NULL,
  spell_id INT NOT NULL,
  mana_spent INT NOT NULL,
  was_critical BOOLEAN NOT NULL DEFAULT FALSE,
  cast_order INT NOT NULL,
  CONSTRAINT fk_casts_duel FOREIGN KEY (duel_id) REFERENCES duels(duel_id),
  CONSTRAINT fk_casts_caster FOREIGN KEY (caster_id) REFERENCES wizards(wizard_id),
  CONSTRAINT fk_casts_spell FOREIGN KEY (spell_id) REFERENCES spells(spell_id),
  CONSTRAINT chk_mana_spent CHECK (mana_spent > 0),
  CONSTRAINT chk_cast_order CHECK (cast_order > 0)
);

-- Helpful indexes (not required, but realistic)
CREATE INDEX idx_wizards_house ON wizards(house_id);
CREATE INDEX idx_wizards_guild ON wizards(guild_id);
CREATE INDEX idx_spell_casts_duel ON spell_casts(duel_id);
CREATE INDEX idx_spell_casts_spell ON spell_casts(spell_id);
CREATE INDEX idx_qa_status ON quest_assignments(status);