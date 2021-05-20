create user customer@localhost identified by '12345';
create user manager@localhost identified by '12345';
create user reception@localhost identified by '12345';

grant select on airport.ticket_flight to customer@localhost;
grant select on airport.flight to customer@localhost;
grant select on airport.city to customer@localhost;
grant select on airport.airport to customer@localhost;

grant select, insert, update on airport.ticket_flight to reception@localhost;
grant select, insert, update on airport.passenger to reception@localhost;
grant select on airport.flight to customer@localhost;
grant select on airport.city to reception@localhost;
grant select on airport.airport to reception@localhost;
grant select on airport.aircraft to reception@localhost;

grant select, insert, update, delete on airport.ticket_flight to manager@localhost;
grant select, insert, update, delete on airport.passenger to manager@localhost;
grant select, insert, update on airport.flight to manager@localhost;
grant select on airport.city to manager@localhost;
grant select on airport.airport to manager@localhost;
grant select on airport.aircraft to manager@localhost;


INSERT INTO airport.city
( 
  `name`,
  `shortname`,
  `timezone`
 )
VALUES
('Moscow','MSC','3'),
('St.Peterburg','SPB','3'),
('Berlin','BRL','1'),
('Prague','PRG','2'),
('New York','NYR','12'),
('Washington','WSG','12'),
('Michi','MCH','11'),
('Tokyo','TKO','7'),
('Pekin','PKN','6'),
('Volgograd','VLG','4');

INSERT INTO airport.airport
(
  `name`,
  `city_id`,
  `longitute`,
  `latitude`
 )
VALUES
('Vadim Garaev','1','23','23'),
('Dfybi','1','45','99'),
('Zuec','2','33','12'),
('Drujec','2','33','32'),
('Vad','2','12','12'),
('Vladas','4','43','45'),
('Zmishenko Valeriy','5','12','11'),
('Leave me alone','3','20','7'),
('Coment','6','10','6'),
('Broken','7','90','4');

INSERT INTO airport.aircraft
( 
  `name`,
  `type`
 )
VALUES
('Boeng Bong 228','Letaet'),
('Boeng Bong 300','MnogoLetaet'),
('Bongs 10','Letaet'),
('Bongs 12','OpyatLetaet'),
('Net 1','Letaet'),
('Bang Nag 123','Letaet'),
('Kekeket 123','OpyatLetaet'),
('Echo 12','Letaet'),
('Boent 122','Letaet'),
('Kto to 12','Letaet');

INSERT INTO airport.flight
( 
  `departure_datetime`,
  `arrival_datetime`,
  `departure_airport`,
  `arrival_airport`,
  `status`,
  `aircraft_id`,
  `actual_departure`,
  `actual_arrival`
 )
VALUES
('2020-01-01 10:38:10','2020-01-02 7:38:10','1','2','Soon','1', null, null),
('2020-01-12 10:38:10','2020-01-12 21:10:00','3','1','Wait for','4', null, null),
('2020-01-01 10:38:10','2020-01-02 7:38:10','6','1','Ok','5', null, null),
('2020-01-01 10:38:10','2020-01-02 7:38:10','2','3','Done','3', '2020-01-01 10:32:00','2020-01-02 7:12:12'),
('2020-01-01 10:38:10','2020-01-02 7:38:10','7','2','Ok','4', null, null),
('2020-01-01 10:38:10','2020-01-02 7:38:10','2','3','Ok','1', null,'2020-01-02 7:12:12'),
('2020-01-01 10:38:10','2020-01-02 7:38:10','4','5','Near','1', null, null),
('2020-01-01 10:38:10','2020-01-02 7:38:10','5','4','Done','2', '2020-01-01 10:32:00', null),
('2020-01-01 10:38:10','2020-01-02 7:38:10','6','1','Done','2', null, null),
('2020-01-01 10:38:10','2020-01-02 7:38:10','2','6','Done','6', null,'2020-01-02 7:12:12');

INSERT INTO airport.passenger
( 
  `name`,
  `midlename`,
  `lastname`,
  `birthdate`
 )
VALUES
('Vadim','Albertovich','Garaev','2000-01-01'),
('Daen','Garajes','Macho','1998-04-20'),
('Diman','Ejasda','Haner','2000-01-01'),
('Darjan','Namefas','Nane','1998-04-20'),
('Krana','Nakratar','Han','2003-01-01'),
('Narma','Arlange','Garaev','1998-04-20'),
('Karma','Kartmen','Tem','2002-01-01'),
('Lama','Name','Jane','1998-04-20'),
('Nana','Lamema','Tane','1998-04-20'),
('Mama','Janae','Mane','2001-01-01');

INSERT INTO airport.ticket_flight
( 
  `flight_id`,
  `fare_conditions`,
  `amount`,
  `passenger_id`,
  `range`,
  `seat`
 )
VALUES
('1','Generic','400','1','2','5'),
('1','Main','200','3','3','3'),
('3','Cheaper','500','1','2','4'),
('4','Cheaper','300','6','2','2'),
('2','Sale','500','6','5','3'),
('1','Generic','1000','3','10','3'),
('2','Main','200','2','5','5'),
('4','Main','300','4','5','1'),
('5','Generic','500','6','5','2');