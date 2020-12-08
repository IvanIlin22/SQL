CREATE TABLE resume
(
	resume_id		serial primary key,
	candidate_name	text	not null,
	vacancy_name	text	not null,
	contact_data	text	not null,
	education		text,
	last_work		text
);

CREATE TABLE employer
(
	employer_id			serial primary key,
	employer_name		text	not null,
	area_id				integer not null
);

CREATE TABLE vacancy
(
	vacancy_id					serial primary key,
	employer_id					integer	not null references employer (employer_id),        
	position_name				text	not null,
	compensation_from			integer,
	compensation_to				integer,
	compensation_gross			boolean	not null,
	date_creation				date	not null
);

CREATE TABLE response
(
	response_id		serial primary key,
	vacancy_id		integer	not null references vacancy(vacancy_id),
	resume_id		integer	not null references resume(resume_id),
	date_response	date	not null
);

	INSERT INTO resume(candidate_name, vacancy_name, contact_data, education, last_work)
	VALUES	('Петров Илья Алексеевич', 'Разработчик', '+79263549874', 'MSU',  'MSU'),
		('Иванов Александр Алексеевич', 'Аналитик', '+79263549841', 'HSE',  'Mail'),
		('Михайлова Ольга Ивановна', 'Бухгалтер', '+79263544368', 'RGRU',  'Иванов и Ко'),
		('Иванова Мария Анатольевна', 'Разработчик', '+79263549874', 'MSU',  'MSU'),
		('Пикалов Владислав Алексеевич', 'Разработчик', '+79263549880', 'MPEI', 'null'),
		('Петров Илья Алексеевич', 'Охранник', '+79263549874', 'MSU',  'MSU'),
		('Петров Андрей Андреевич', 'Уборщик', '+79033549874', 'null', 'null'),
		('Фрольцов Илья Алексеевич', 'Тестировщик', '+79263229874', 'MPEI',  'Яндекс'),
		('Сергеев Илья Ильич', 'Аналитик', '+79263549874', 'MSU',  'Сбер'),
		('Петров Сергей Андреевич', 'Разработчик', '+79263549874', 'MSU',  'Тинькоф'),
		('Андрей Илья Сергеевич', 'Тестировщик', '+79263549874', 'MSU',  'Ozon');

INSERT INTO employer(employer_name, area_id)
VALUES	('hh.ru', 1),
		('Яндекс', 1),
		('Mail', 1),
		('Сбер', 1),
		('Тинькофф', 1),	
		('Рога и Копыта', 2),
		('Google', 2),
		('Иванов и Ко', 3),
		('Amazon', 4),
		('Badoo', 5),
		('Ozon', 5),
		('Avito', 5),
		('Telegram', 6),
		('VTB', 6);

INSERT INTO vacancy (employer_id, position_name, compensation_from, compensation_to, compensation_gross, date_creation)
VALUES	(1,'Разработчик', 20000, 30000, true,  '2019-03-21'),
		(1, 'Тестировщик', 10000, 20000, true, '2019-03-22'),
		(1, 'Аналитик', null, null, false, '2019-04-13'),
		(2, 'Разработчик', 25000, 27000, false, '2019-04-28'),
		(3, 'Разработчик', 15000, 17000, false, '2019-05-23'),
		(4, 'Аналитик', 20000, 24000, false, '2019-04-13'),
		(5, 'Тестировщик', null, 17000, true, '2019-05-10'),
		(6, 'Аналитик', 25000, 35000, false, '2019-06-01'),
		(7, 'Уборщик', 25000, 27000, true, '2019-03-03'),
		(7, 'Охранник', 14000, 15000, true, '2019-03-11'),
		(8, 'Бухгалтер', 18000, null, false, '2019-08-23');
		
INSERT INTO response(vacancy_id, resume_id, date_response)
VALUES	(1, 1, '2019-03-22'),
		(1, 2, '2019-04-22'),
		(2, 3, '2019-05-01'),
		(3, 4, '2019-06-22'),
		(4, 5, '2019-07-25'),
		(4, 6, '2019-07-28'),
		(5, 7, '2019-08-03'),
		(6, 8, '2019-08-13'),
		(7, 9, '2019-09-14'),
		(8, 10, '2019-12-02'),
		(8, 11, '2020-01-12');
		
