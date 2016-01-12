CREATE TABLE favorite_artists (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  musician_id INTEGER,

  FOREIGN KEY(musician_id) REFERENCES musician(id)
);

CREATE TABLE musicians (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL,
  group_id INTEGER,

  FOREIGN KEY(group_id) REFERENCES music_group(id)
);

CREATE TABLE music_groups (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

INSERT INTO
  music_groups (id, name)
VALUES
  (1, "Galantis"), (2, "Nero");

INSERT INTO
  musicians (id, fname, lname, group_id)
VALUES
  (1, "Christian", "Karlsson", 1),
  (2, "Linus", "Eklöw", 1),
  (3, "Stephen", "Thompson", 2),
  (4, "Justin", "Bieber", NULL);

INSERT INTO
  favorite_artists (id, name, musician_id)
VALUES
  (1, "Chris Brown", 1),
  (2, "Ashanti", 2),
  (3, "Death Cab For Cutie", 3),
  (4, "Chance the Rapper", 3),
  (5, "Vic Mensa", NULL);
