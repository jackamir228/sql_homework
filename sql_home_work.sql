create schema university
--Этап №1 Создание схемы. 
--Определить самостоятельно типы данных для каждого поля(колонки). 
--Самостоятельно определить что является primary key и foreign key.


--1. Создать таблицу с факультетами: id, имя факультета, стоимость обучения
	CREATE TABLE university.faculty(id int primary key, name varchar(100), price numeric(9,2))
	select *
	from university.faculty

	DROP SCHEMA public

--2. Создать таблицу с курсами: id, номер курса, id факультета
CREATE TABLE university.course(id int primary key, course_number int,
					faculty_id int REFERENCES university.faculty(id))

	select *
	from university.course

--3. Создать таблицу с учениками: id, имя, фамилия, отчество, бюджетник/частник, id курса
CREATE TABLE university.student(id int primary key, name varchar(100), surname varchar(100), 
							patronymic varchar(100), state_private boolean, 
							course_id int REFERENCES university.course(id))
			select *
	from university.student

--Этап №2 Заполнение данными:
--1. Создать два факультета: Инженерный (30 000 за курс) , Экономический (49 000 за курс)
INSERT INTO university.faculty values(1, 'Инженерный', 30000);
INSERT INTO university.faculty values(2, 'Экономический', 49000);

--2. Создать 1 курс на Инженерном факультете: 1 курс
INSERT INTO university.course values(1, 1, 1);
--3. Создать 2 курса на экономическом факультете: 1, 4 курс
INSERT INTO university.course values(2, 1, 2);
INSERT INTO university.course values(3, 4, 2);

--4. Создать 5 учеников:
--Петров Петр Петрович, 1 курс инженерного факультета, бюджетник
INSERT INTO university.student values(1, 'Петр', 'Петров', 'Петрович', true, 1)
Иванов Иван Иваныч, 1 курс инженерного факультета, частник
INSERT INTO university.student values(2, 'Иван', 'Иваныч', 'Иванов', false, 1)
Михно Сергей Иваныч, 4 курс экономического факультета, бюджетник
INSERT INTO university.student values(3, 'Михно', 'Сергей', 'Петрович', true, 3)
--обновление отчества у Михно
UPDATE university.student st set patronymic = 'Иваныч'
where st.id = 3
Стоцкая Ирина Юрьевна, 4 курс экономического факультета, частник
INSERT INTO university.student values(4, 'Ирина', 'Стоцкая', 'Юрьевна', false, 3)
Младич Настасья (без отчества), 1 курс экономического факультета, частник
INSERT INTO university.student values (5, 'Настасья', 'Младич', null, false, 2)

--Этап №3 Выборка данных. Необходимо написать sql запросы :
--1. Вывести всех студентов, кто платит больше 30_000.
select st.name, st.surname, st.patronymic, st.state_private, co.id, fa.price
from university.student st 
right JOIN university.course co on st.course_id = co.id
right JOIN university.faculty fa on co.faculty_id = fa.id
where fa.price > 30000

--2. Перевести всех студентов Петровых на 1 курс экономического факультета.
UPDATE university.student st SET course_id = 2
where st.surname LIKE 'Петров'

--3. Вывести всех студентов без отчества или фамилии.
select * 
from university.student st
where st.patronymic is null or st.surname is null

--4. Вывести всех студентов содержащих в фамилии или в имени или в отчестве "ван".
select * 
from university.student st
where st.surname LIKE '%ван%' or st.name LIKE '%ван%' or st.patronymic LIKE '%ван%' 
--5. Удалить все записи из всех таблиц.
drop table university.course, university.faculty