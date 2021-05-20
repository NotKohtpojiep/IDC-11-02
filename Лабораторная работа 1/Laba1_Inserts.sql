INSERT INTO education.faculty
( 
  `name`,
  `foundation_date`,
  `occupation`,
  `max_student`
 )
VALUES
('Технологии','2000-02-02','Строительство','45'),
('Гуманитарная','2010-01-01','Изучение языков','25'),
('Основы практики','2001-05-22','Набивание навыков','20'),
('Фундаментальные основы','2005-12-05','Усвоение навыков','40'),
('Программирование','2012-06-12','Написание алгоритмов','35'),
('Русский язык','2003-03-01','Чтение книг','25'),
('Творчествоведение','2014-01-07','Изучение искусства','20'),
('Рисование','2015-01-08','Использование кистей','50'),
('Английский язык','2008-01-10','Разговор с носителями','35'),
('Немецкий язык','2011-07-25','Разговор с носителями','23');
INSERT INTO education.department
( 
  `dep_code`,
  `fac_code`,
  `name`,
  `responsible`,
  `graduating_dep`,
  `site`,
  `mob_number`
 )
VALUES
('1','1','Создаю робота','Вадим Гараев','4','www.botowod.com','88005553535'),
('2','5','Пишу на бумаге','Ярик Привет','3','www.yarick.com', null),
('3','3','Практикуйтесь','Практикант Вова','4', null, null),
('4','7','Я точно не картина','Усач Петя','7', null, '88005553535'),
('5','4','Основаю основать','Владимир Гриб','4','www.grib.ru', null),
('6','3','Я практикую','Практикант Вова','2', null, null),
('7','10','Скажи мне девять','Интелли Коддд','1', null,'88005553535'),
('8','2','Голосуем голосом','Владислав Славения','10','www.ti_ne_golosuesh.com','88005553535'),
('9','1','Латех','Валерий Валентинович','3',null,null),
('10','6','Русифицирую','Переводчик Валера','5','www.howtorussian.com','88005553535');
