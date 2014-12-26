CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Pat', 'Lo'),
  ('Nick', 'Arora'),
  ('Barack', 'Obama'),
  ('Ronda', 'Rousey'),
  ('Steph', 'Curry');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Length', 'How long is the program?',
    (SELECT id FROM users WHERE fname = 'Pat' AND lname = 'Lo')),
  ('Jobs', 'Will we ever get a job?',
    (SELECT id FROM users WHERE fname = 'Nick' AND lname = 'Arora')),
  ('Living Situation', 'What is it like to live at AA?',
    (SELECT id FROM users WHERE fname = 'Steph' AND lname = 'Curry')),
  ('Curriculum', 'What do they teach at AA?',
    (SELECT id FROM users WHERE fname = 'Steph' AND lname = 'Curry'));


INSERT INTO
  question_followers(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Barack' AND lname = 'Obama'),
    (SELECT id FROM questions WHERE title = 'Length')),
  ((SELECT id FROM users WHERE fname = 'Ronda' AND lname = 'Rousey'),
    (SELECT id FROM questions WHERE title = 'Jobs')),
  ((SELECT id FROM users WHERE fname = 'Ronda' AND lname = 'Rousey'),
    (SELECT id FROM questions WHERE title = 'Living Situation')),
  ((SELECT id FROM users WHERE fname = 'Pat' AND lname = 'Lo'),
    (SELECT id FROM questions WHERE title = 'Living Situation')),
  ((SELECT id FROM users WHERE fname = 'Nick' AND lname = 'Arora'),
    (SELECT id FROM questions WHERE title = 'Living Situation')),
  ((SELECT id FROM users WHERE fname = 'Barack' AND lname = 'Obama'),
    (SELECT id FROM questions WHERE title = 'Living Situation')),
  ((SELECT id FROM users WHERE fname = 'Steph' AND lname = 'Curry'),
    (SELECT id FROM questions WHERE title = 'Living Situation'));

INSERT INTO
  replies(question_id, parent_reply_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'Length'), NULL,
    (SELECT id FROM users WHERE fname = 'Steph' AND lname = 'Curry'),
    'Twelve Weeks I think'),
  ((SELECT id FROM questions WHERE title = 'Jobs'), NULL,
    (SELECT id FROM users WHERE fname = 'Steph' AND lname = 'Curry'),
    'You should join the NBA');

INSERT INTO
  replies(question_id, parent_reply_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'Length'),
    (SELECT id FROM replies WHERE body = 'Twelve Weeks I think'),
    (SELECT id FROM users WHERE fname = 'Barack' AND lname = 'Obama'),
    'Work on your shot Curry');

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Barack' AND lname = 'Obama'),
    (SELECT id FROM questions WHERE title = 'Length')),
  ((SELECT id FROM users WHERE fname = 'Steph' AND lname = 'Curry'),
    (SELECT id FROM questions WHERE title = 'Length')),
  ((SELECT id FROM users WHERE fname = 'Ronda' AND lname = 'Rousey'),
    (SELECT id FROM questions WHERE title = 'Jobs')),
  ((SELECT id FROM users WHERE fname = 'Ronda' AND lname = 'Rousey'),
    (SELECT id FROM questions WHERE title = 'Living Situation')),
  ((SELECT id FROM users WHERE fname = 'Pat' AND lname = 'Lo'),
    (SELECT id FROM questions WHERE title = 'Living Situation')),
  ((SELECT id FROM users WHERE fname = 'Nick' AND lname = 'Arora'),
    (SELECT id FROM questions WHERE title = 'Living Situation')),
  ((SELECT id FROM users WHERE fname = 'Barack' AND lname = 'Obama'),
    (SELECT id FROM questions WHERE title = 'Living Situation')),
  ((SELECT id FROM users WHERE fname = 'Steph' AND lname = 'Curry'),
    (SELECT id FROM questions WHERE title = 'Living Situation'));
