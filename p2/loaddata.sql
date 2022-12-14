-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!

-- This is only an example of how you add INSERT statements to this file.
--   You may remove it.

INSERT INTO Categories (name, priority) VALUES
('healthcare workers', 1),
('elderly (>= 65)', 1),
('immunodeficiency', 1),
('teacher', 2),
('children (< 10)', 2),
('close to 1st priority', 2),
('essential workers', 3),
('close to 2nd priority', 3),
('everybody else', 4);

INSERT INTO People (hinsurnum, name, phone, city, streetaddr, postalcode, dateofbirth, gender, regdate, cname) VALUES
('043769670722', 'Jane Doe', NULL, NULL, NULL, NULL, '5/6/1990', 'male', '3/21/2020', 'healthcare workers'),
('457612324611', 'Minette Glowacz', '9363188842', 'Montreal', '5110 Scoville Park', NULL, '10/5/1995', 'female', '2/20/2021', 'elderly (>= 65)'),
('998497091433', 'Carey Brierton', NULL, NULL, NULL, NULL, '12/23/1999', 'female', '8/12/2020', 'immunodeficiency'),
('695931762244', 'Kendall Elsbury', '8999398501', 'Montreal', '1337 Kipling Park', NULL, '12/27/2015', 'male', '12/30/2020', 'teacher'),
('394663004955', 'Dennis Roadnight', NULL, NULL, NULL, NULL, '01/16/2007', 'other', '4/9/2020', 'children (< 10)'),
('848473011566', 'Florie Tourne', '2612023891', 'Quebec City', '390 Ludington Street', 'H2S93D', '4/22/1970', 'male', '11/4/2020', 'close to 1st priority'),
('104887837677', 'Amelina Lake', '9564813738', 'Quebec City', '68669 Lillian Avenue', 'DW3V43', '10/2/1956', 'male', '4/8/2020', 'essential workers'),
('006147016388', 'Niki Jaques', '2829065744', 'Laval', '03692 Maple Crossing', NULL, '8/4/1982', 'female', '3/27/2020', 'close to 2nd priority'),
('115225470799', 'Alanson Gherarducci', '4473233549', 'Paris', '07, 6 Basil Parkway', '34VR3F', '7/20/1943', 'other', '5/14/2020', 'everybody else'),
('411568426700', 'Minny Baum', '2857114159', 'Sherbrooke', '697 Stang Lane', '34FGID', '2/16/1999', 'female', '10/4/2020', 'everybody else'),
('511568426700', 'Mikey Baum', '2857114159', 'Sherbrooke', '697 Stang Lane', '34FGID', '2/16/1999', 'male', '10/4/2020', 'everybody else'),
('611568426700', 'Mony Baum', '2857114159', 'Sherbrooke', '697 Stang Lane', '34FGID', '2/16/1999', 'male', '10/4/2020', 'everybody else');

INSERT INTO Locations (name, streetaddr, city, postalcode) VALUES
('Ye Olde Druge Store', '19 Forest Run Trail', 'Montreal', 'S0WJ4N'),
('Apothecaries', '473 Baker Street', NULL, 'QWEFIJ'),
('Pharmaprix', '7 Chinook Parkway', 'Quebec City', '12EF34'),
('Witch Potions', '31 Warbler Place', 'Laval', 'W9VHJ4'),
('Jean Coutu', '4385 Blackbird Center', 'Montreal', 'S0WJ4N'),
('Uniprix', '0262 Schmedeman Center', 'Montreal', '2039D3'),
('McGill Neurological Institute', '31 Warbler Place', 'Montreal', 'W9VHJ4'),
('Laval Maladies', '4385 Rock Center', 'Laval', '43FRE0'),
('Jewish General', '3755 Chemin de la C??te-Sainte-Catherine', 'Montreal', '3HJDEE'),
('Montgomery Hospital', '0262 Nynan Street', 'Frontenac', '11JD32'),
('YIAY', 'Universal Studios', 'Montreal', 'H0H0H0');

INSERT INTO Hospitals (name) VALUES
('McGill Neurological Institute'),
('Laval Maladies'),
('Jewish General'),
('Montgomery Hospital'),
('YIAY');

INSERT INTO Nurses (licenseno, name, hospname) VALUES
('2197556479', 'Nessie Simukov', 'Laval Maladies'),
('3825033384', 'Marty Doherty', 'Laval Maladies'),
('8617596554', 'Calla Hubbuck', 'Laval Maladies'),
('8382973256', 'Algernon Kimmings', 'Laval Maladies'),
('6640090600', 'Francklyn Scrivens', 'Jewish General'),
('7109768511', 'Libbi Calendar', 'Jewish General'),
('9453922722', 'Zita Hanhart', 'Jewish General'),
('8448783727', 'Fraze Fullicks', 'Jewish General'),
('0744604915', 'Goldina Streatley', 'Montgomery Hospital'),
('8142951371', 'Clare Olorenshaw', 'Montgomery Hospital'),
('3143095814', 'Jack Douglass', 'YIAY'),
('2345243854', 'Erin Douglass', 'YIAY');

INSERT INTO WorkingDays (locname, date) VALUES
('Laval Maladies', '7/27/2021'),
('Laval Maladies', '8/9/2020'),
('Laval Maladies', '8/9/2022'),
('Laval Maladies', '5/25/2021'),
('Laval Maladies', '12/24/2022'),
('Laval Maladies', '12/27/2021'),
('Laval Maladies', '7/4/2021'),
('Laval Maladies', '02/06/2021'),
('Jewish General', '3/20/2021'),
('Jewish General', '4/23/2022'),
('Jewish General', '1/31/2021'),
('Jewish General', '1/05/2021'),
('Jewish General', '2/1/2021'),
('Jewish General', '02/06/2021'),
('Jewish General', '12/17/2022'),
('Pharmaprix', '5/5/2020'),
('Pharmaprix', '8/5/2020'),
('Pharmaprix', '3/20/2021'),
('McGill Neurological Institute', '10/21/2022'),
('McGill Neurological Institute', '4/6/2021'),
('Montgomery Hospital', '11/2/2023'),
('Montgomery Hospital', '7/8/2019'),
('Witch Potions', '4/11/2021');

INSERT INTO Vaccines (name, numdoses, waitingperiod) VALUES
('Pfizer-BioNTech', 2, 10),
('Moderna', 5, 3),
('Sinovac', 1, 1),
('Astrozeneca', 4, 20),
('Mystery', 10, 10);

INSERT INTO Batches (name, batchnum, manufacdate, expirydate, numvials, locname) VALUES
('Sinovac', 1, '2/11/2021', '10/14/2021', 39, 'Jewish General'),
('Pfizer-BioNTech', 0, '4/9/2020', '7/20/2023', 10, 'Pharmaprix'),
('Pfizer-BioNTech', 1, '1/8/2020', '11/29/2021', 158, 'Jewish General'),
('Pfizer-BioNTech', 3, '1/16/2020', '4/13/2023', 100, 'Jewish General'),
('Pfizer-BioNTech', 4, '3/6/2021', '4/14/2021', 69, 'Laval Maladies'),
('Pfizer-BioNTech', 5, '12/21/2020', '10/9/2021', 180, 'Jewish General'),
('Moderna', 1, '7/13/2020', '3/15/2023', 63, 'Jewish General'),
('Pfizer-BioNTech', 6, '9/28/2020', '9/7/2021', 109, 'Jewish General'),
('Sinovac', 2, '5/6/2020', '9/24/2021', 180, 'Pharmaprix'),
('Pfizer-BioNTech', 7, '7/23/2020', '5/12/2021', 19, 'Laval Maladies'),
('Moderna', 2, '7/13/2020', '3/15/2023', 4, 'McGill Neurological Institute');

INSERT INTO Vials (name, batchnum, num) VALUES
('Moderna', 1, 0),
('Moderna', 1, 1),
('Moderna', 1, 2),
('Moderna', 1, 3),
('Moderna', 1, 4),
('Moderna', 1, 5),
('Moderna', 2, 10),
('Moderna', 2, 11),
('Moderna', 2, 12),
('Pfizer-BioNTech', 0, 1),
('Pfizer-BioNTech', 0, 2),
('Pfizer-BioNTech', 0, 3),
('Pfizer-BioNTech', 0, 4),
('Pfizer-BioNTech', 3, 1),
('Pfizer-BioNTech', 3, 2),
('Pfizer-BioNTech', 3, 3),
('Pfizer-BioNTech', 3, 4),
('Pfizer-BioNTech', 3, 5),
('Pfizer-BioNTech', 6, 21),
('Pfizer-BioNTech', 6, 22),
('Pfizer-BioNTech', 6, 23),
('Pfizer-BioNTech', 6, 24),
('Pfizer-BioNTech', 7, 2),
('Pfizer-BioNTech', 7, 4),
('Pfizer-BioNTech', 7, 5);

INSERT INTO Slots (locname, date, time, tentnum, hinsurnum, allocdate, licenseno, vname, batchnum, num) VALUES
('Pharmaprix', '5/5/2020', '13:10', 1, NULL, NULL, NULL, NULL, NULL, NULL),
('Pharmaprix', '5/5/2020', '14:26', 1, NULL, NULL, '3825033384', 'Pfizer-BioNTech', 0, 1),
('Pharmaprix', '5/5/2020', '17:00', 1, '104887837677', '5/1/2020', '3825033384', 'Pfizer-BioNTech', 0, 2),
('Pharmaprix', '8/5/2020', '17:00', 1, '394663004955', '5/1/2020', '8617596554', 'Pfizer-BioNTech', 0, 3),
('Pharmaprix', '3/20/2021', '19:00', 0, NULL, NULL, NULL, 'Pfizer-BioNTech', 0, 4),
('Jewish General', '3/20/2021', '19:00', 0, NULL, NULL, '8448783727', NULL, NULL, NULL),
('Jewish General', '3/20/2021', '18:00', 0, NULL, NULL, NULL, NULL, NULL, NULL),
('Jewish General', '3/20/2021', '17:00', 0, '043769670722', '1/08/2021', NULL, NULL, NULL, NULL),
('Jewish General', '3/20/2021', '17:30', 1, '457612324611', '1/03/2021', '2197556479', 'Moderna', 1, 1),
('Jewish General', '3/20/2021', '17:45', 1, '695931762244', '10/10/2020', '8448783727', NULL, NULL, NULL),
('Jewish General', '02/06/2021', '1:00', 5, '043769670722', '2/05/2021', '2197556479', 'Pfizer-BioNTech', 3, 2),
('Jewish General', '02/06/2021', '1:00', 6, '115225470799', '2/02/2021', '2197556479', 'Pfizer-BioNTech', 6, 21),
('Jewish General', '01/31/2021', '1:00', 6, '115225470799', '1/02/2021', '2197556479', 'Pfizer-BioNTech', 6, 22),
('Jewish General', '01/05/2021', '1:00', 6, '511568426700', '1/02/2021', '2197556479', 'Pfizer-BioNTech', 6, 23),
('Jewish General', '01/31/2021', '1:20', 6, '511568426700', '1/02/2021', '2197556479', 'Pfizer-BioNTech', 6, 24),
('Jewish General', '12/17/2022', '21:45', 3, '695931762244', '10/04/2022', '0744604915', NULL, NULL, NULL),
('Laval Maladies', '8/9/2020', '1:00', 1, '848473011566', '2/02/2020', '6640090600', 'Pfizer-BioNTech', 7, 2),
('Laval Maladies', '7/27/2021', '1:00', 1, '848473011566', '1/31/2021', '6640090600', 'Pfizer-BioNTech', 7, 4),
('Laval Maladies', '02/06/2021', '1:00', 1, '006147016388', '1/31/2021', '2197556479', 'Pfizer-BioNTech', 7, 5),
('McGill Neurological Institute', '10/21/2022', '00:05', 2, '115225470799', '10/21/2021', NULL, 'Moderna', 2, 10),
('McGill Neurological Institute', '4/6/2021', '14:00', 3, NULL, NULL, NULL, 'Moderna', 2, 11);

INSERT INTO NurseDay (licenseno, locname, date) VALUES
('3825033384', 'Pharmaprix', '5/5/2020'),
('2197556479', 'Pharmaprix', '5/5/2020'),
('8617596554', 'Pharmaprix', '8/5/2020'),
('8617596554', 'Pharmaprix', '3/20/2021'),
('2197556479', 'Jewish General', '3/20/2021'),
('8448783727', 'Jewish General', '3/20/2021'),
('2197556479', 'Jewish General', '01/31/2021'),
('2197556479', 'Jewish General', '01/05/2021'),
('2197556479', 'Jewish General', '02/01/2021'),
('2197556479', 'Jewish General', '02/06/2021'),
('0744604915', 'Jewish General', '12/17/2022'),
('2197556479', 'Witch Potions', '4/11/2021'),
('0744604915', 'Laval Maladies', '8/9/2022'),
('0744604915', 'Montgomery Hospital', '7/8/2019'),
('6640090600', 'Laval Maladies', '8/9/2020'),
('6640090600', 'Laval Maladies', '7/27/2021'),
('2197556479', 'Laval Maladies', '02/06/2021'),
('8142951371', 'Montgomery Hospital', '11/2/2023');