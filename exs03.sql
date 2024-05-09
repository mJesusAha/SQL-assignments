--                     Структура базы данных 
-- Была одна небольшая сложность, мне не удалось подключить базу данных oracle у себя, но надеюсь мне это не oчень помешало
-- Я решила создать отдельно таблицу адресс, дом всего один, для того что бы постоянно не вписывать адрес.
-- Cтруктура базы данных состоит из 4-x cвязанных таблиц:
-- "house" - дом
-- "apartments" - квартиры
-- "registered_people" - зарегистрированные люди
-- "people" - люди (жильцы дома)
-- таблица "registered_people" заполняется автоматически, при добавлении или удалении жильцов,
-- в ней храниться номер квартиры и количество жильцов
-- Таблица квартиры содержит информацию о квартирах
-- Так как количество квартир не может менятся, cтолбец "apartment" PRIMARY KEY
-- В полях "apartment", "flooretrance", "floore" выставлены ограничения на ввод в соответствии с заданием
CREATE TABLE "house" (
  "address_id" number(1) PRIMARY KEY,
  "address" varchar2(25) NOT NULL
);

CREATE TABLE "apartments" (
  "id_address" number(1) NOT NULL,
  "apartment" number(4) NOT NULL PRIMARY KEY CHECK ("apartment" <= 1471
and "apartment" > 0 ),
  "flooretrance" number(1) NOT NULL CHECK ("flooretrance" <= 7
and "flooretrance">0),
  "floore" number(2) NOT NULL CHECK ("floore" <= 17
and "floore" > 0),
  "area_apartments" number(4,
2) NOT NULL,
  foreign key ("id_address") REFERENCES "house"("address_id")
);

CREATE TABLE "registered_people"(
"apartment" number(4) NOT NULL PRIMARY KEY CHECK ("apartment" <= 1471
and "apartment" > 0 ),
"registered" number(4)
);

CREATE TABLE "people" (
  "id" number PRIMARY KEY,
  "apartment" number(4) NOT NULL CHECK ("apartment" <= 1471
and "apartment" > 0 ),
  "sirname" varchar2(25) NOT NULL,
  "firstname" varchar2(25) NOT NULL,
  "secondname" varchar2(25),
  "owner" varchar2(25) DEFAULT('yes') CHECK ("owner" IN ('yes', 'no')),
  foreign key ("apartment") REFERENCES "apartments"("apartment"),
  foreign key ("apartment") REFERENCES "registered_people"("apartment")
);

CREATE TRIGGER "insert_people_registred_trg"
AFTER
INSERT
	ON
	"people" 
FOR EACH ROW
BEGIN
		delete
from
	"registered_people";

insert
	into
	"registered_people" 
  select
	"apartment",
	count(*) as "registered"
from
	people
group by
	"apartment";
end;

CREATE TRIGGER "delete_people_registred_trg"
AFTER
DELETE
	ON
	"people" 
FOR EACH ROW
BEGIN
		delete
from
	"registered_people";

insert
	into
	"registered_people" 
  select
	"apartment",
	count(*) as "registered"
from
	people
group by
	"apartment";
end;
-- *************************************************** --
-- Для тестирования ------------------------------------

INSERT
	into
	house
values (1,
"Omskaia Obl, Omskiy r-n Tenistaia 4");

INSERT
	into
	apartments
values ( 1,
1470,
6,
1,
134);

INSERT
	into
	apartments
values (1,
15,
6,
1,
134);

INSERT
	into
	people
values (1,
1471,
"Petrova",
"Olesya",
NULL,
'yes');

INSERT
	into
	people
values (2,
1471,
"Petrov",
"Oleg",
NULL,
'yes');

INSERT
	into
	people
values (3,
26,
"Ivanova",
"Ivana",
NULL,
'yes');

INSERT
	into
	people
values (4,
27,
"Ivanov",
"Ivan",
NULL,
'yes');

select
	*
from
	"registered_people";
