CREATE DATABASE IF NOT EXISTS HumanFriends;
USE HumanFriends;

CREATE TABLE IF NOT EXISTS Pets (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255),
    Type VARCHAR(255),
    BirthDate DATE,
    Commands JSON
);

CREATE TABLE IF NOT EXISTS PackAnimals (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255),
    Type VARCHAR(255),
    BirthDate DATE,
    Commands JSON
);

INSERT INTO Pets (Name, Type, BirthDate, Commands) VALUES
('Fido', 'Dog', '2020-01-01', '["Sit", "Stay", "Fetch"]'),
('Whiskers', 'Cat', '2019-05-15', '["Sit", "Pounce"]'),
('Hammy', 'Hamster', '2021-03-10', '["Roll", "Hide"]'),
('Buddy', 'Dog', '2018-12-10', '["Sit", "Paw", "Bark"]'),
('Smudge', 'Cat', '2020-02-20', '["Sit", "Pounce", "Scratch"]'),
('Peanut', 'Hamster', '2021-08-01', '["Roll", "Spin"]'),
('Bella', 'Dog', '2019-11-11', '["Sit", "Stay", "Roll"]'),
('Oliver', 'Cat', '2020-06-30', '["Meow", "Scratch", "Jump"]');

INSERT INTO PackAnimals (Name, Type, BirthDate, Commands) VALUES
('Thunder', 'Horse', '2015-07-21', '["Trot", "Canter", "Gallop"]'),
('Sandy', 'Camel', '2016-11-03', '["Walk", "Carry Load"]'),
('Eeyore', 'Donkey', '2017-09-18', '["Walk", "Carry Load", "Bray"]'),
('Storm', 'Horse', '2014-05-05', '["Trot", "Canter"]'),
('Dune', 'Camel', '2018-12-12', '["Walk", "Sit"]'),
('Burro', 'Donkey', '2019-01-23', '["Walk", "Bray", "Kick"]'),
('Blaze', 'Horse', '2016-02-29', '["Trot", "Jump", "Gallop"]'),
('Sahara', 'Camel', '2015-08-14', '["Walk", "Run"]');

-- Создаем таблицу HorsesAndDonkeys
CREATE TABLE IF NOT EXISTS HorsesAndDonkeys AS
SELECT ID, Name, Type, BirthDate, Commands FROM PackAnimals WHERE Type IN ('Horse', 'Donkey');

-- Создаем таблицу YoungAnimals
CREATE TABLE IF NOT EXISTS YoungAnimals AS
SELECT ID, Name, Type, BirthDate, Commands, TIMESTAMPDIFF(MONTH, BirthDate, CURDATE()) AS AgeInMonths
FROM (
    SELECT ID, Name, Type, BirthDate, Commands FROM Pets
    UNION ALL
    SELECT ID, Name, Type, BirthDate, Commands FROM PackAnimals
) AS AllAnimals
WHERE TIMESTAMPDIFF(YEAR, BirthDate, CURDATE()) BETWEEN 1 AND 3;

-- Создаем таблицу AllAnimalsCombined
CREATE TABLE IF NOT EXISTS AllAnimalsCombined AS
SELECT ID, Name, Type, BirthDate, Commands, 'Pets' AS SourceTable FROM Pets
UNION ALL
SELECT ID, Name, Type, BirthDate, Commands, 'PackAnimals' AS SourceTable FROM PackAnimals
UNION ALL
SELECT ID, Name, Type, BirthDate, Commands, 'HorsesAndDonkeys' AS SourceTable FROM HorsesAndDonkeys
UNION ALL
SELECT ID, Name, Type, BirthDate, Commands, 'YoungAnimals' AS SourceTable FROM YoungAnimals;
