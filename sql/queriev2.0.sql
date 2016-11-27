-- Executing query:

	Select row_number
	from questions
	group by _title
	having count(1) > 1
ERROR:  column "questions.row_number" must appear in the GROUP BY clause or be used in an aggregate function
LINE 2:  Select row_number
                ^

********** Error **********

ERROR: column "questions.row_number" must appear in the GROUP BY clause or be used in an aggregate function
SQL state: 42803
Character: 10

-- Executing query:

	Select _title
	from questions
	group by _title
	having count(1) > 1
Total query runtime: 15339 ms.
18 rows retrieved.

-- Executing query:
CREATE TABLE temp1 as 
	Select _title
	from questions
	group by _title
	having count(1) > 1;
Query returned successfully: 18 rows affected, 2779 ms execution time.

-- Executing query:
Select * from temp1;
Total query runtime: 24 ms.
18 rows retrieved.

-- Executing query:
Select * from questions where _title in (Select * from temp1)
Total query runtime: 1580 ms.
38 rows retrieved.

-- Executing query:
Create table temp2 as 
Select * from questions where _title in (Select * from temp1)
Query returned successfully: 38 rows affected, 692 ms execution time.

-- Executing query:
drop table temp1
Query returned successfully with no result in 65 ms.

-- Executing query:
Select * from temp2
Total query runtime: 54 ms.
38 rows retrieved.

-- Executing query:
Select min(_reputation) from temp2
group by _title;
Total query runtime: 25 ms.
18 rows retrieved.

-- Executing query:
Select _title, min(_reputation) from temp2
group by _title;
Total query runtime: 20 ms.
18 rows retrieved.

-- Executing query:
Create table temp1 as Select _title, min(_reputation) from temp2
group by _title;
Query returned successfully: 18 rows affected, 109 ms execution time.

-- Executing query:
drop table temp2
Query returned successfully with no result in 15 ms.

-- Executing query:
Select * from questions as q, temp1 as t where q._title = t._title and q._reputation = t._reputation;
ERROR:  column t._reputation does not exist
LINE 1: ...s t where q._title = t._title and q._reputation = t._reputat...
                                                             ^
HINT:  Perhaps you meant to reference the column "q._reputation".

********** Error **********

ERROR: column t._reputation does not exist
SQL state: 42703
Hint: Perhaps you meant to reference the column "q._reputation".
Character: 88

-- Executing query:
select * form temp1
ERROR:  syntax error at or near "form"
LINE 1: select * form temp1
                 ^


********** Error **********

ERROR: syntax error at or near "form"
SQL state: 42601
Character: 10

-- Executing query:
select * from temp1
Total query runtime: 13 ms.
18 rows retrieved.

-- Executing query:
Select * from questions as q, temp1 as t where q._title = t._title and q._reputation = t.min;
Total query runtime: 451 ms.
18 rows retrieved.

-- Executing query:
delete from questions as q, temp1 as t where q._title = t._title and q._reputation = t.min;
ERROR:  syntax error at or near ","
LINE 1: delete from questions as q, temp1 as t where q._title = t._t...
                                  ^


********** Error **********

ERROR: syntax error at or near ","
SQL state: 42601
Character: 27

-- Executing query:
Select row_number from questions as q, temp1 as t where q._title = t._title and q._reputation = t.min;
Total query runtime: 698 ms.
18 rows retrieved.

-- Executing query:
Delete questions where row_number in (Select row_number from questions as q, temp1 as t where q._title = t._title and q._reputation = t.min);
ERROR:  syntax error at or near "questions"
LINE 1: Delete questions where row_number in (Select row_number from...
               ^

********** Error **********

ERROR: syntax error at or near "questions"
SQL state: 42601
Character: 8

-- Executing query:
Delete from questions where row_number in (Select row_number from questions as q, temp1 as t where q._title = t._title and q._reputation = t.min);
Query returned successfully: 18 rows affected, 748 ms execution time.

-- Executing query:
select count(1) from where questions, answers where questions._title = answers._title;
ERROR:  syntax error at or near "where"
LINE 1: select count(1) from where questions, answers where question...
                             ^

********** Error **********

ERROR: syntax error at or near "where"
SQL state: 42601
Character: 22

-- Executing query:
select count(1) from questions, answers where questions._title = answers._title;
Total query runtime: 6559 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers
Total query runtime: 278 ms.
1 row retrieved.

-- Executing query:
select count(1) from questions, answers where questions._title = answers._title;
Total query runtime: 948 ms.
1 row retrieved.

-- Executing query:
select count(distinct(_title)) from questions, answers where questions._title = answers._title;
ERROR:  column reference "_title" is ambiguous
LINE 1: select count(distinct(_title)) from questions, answers where...
                              ^

********** Error **********

ERROR: column reference "_title" is ambiguous
SQL state: 42702
Character: 23

-- Executing query:
select distinct(_title) from questions, answers where questions._title = answers._title;
ERROR:  column reference "_title" is ambiguous
LINE 1: select distinct(_title) from questions, answers where questi...
                        ^

********** Error **********

ERROR: column reference "_title" is ambiguous
SQL state: 42702
Character: 17

-- Executing query:
select distinct(answers._title) from questions, answers where questions._title = answers._title;
Total query runtime: 3718 ms.
112834 rows retrieved.

-- Executing query:
select answers._title from questions, answers where questions._title = answers._title;
Total query runtime: 2694 ms.
183480 rows retrieved.

-- Executing query:
Select count(1) from answers
Total query runtime: 206 ms.
1 row retrieved.

-- Executing query:
update answers set answers.fk_row_num = (
	select row_number
	from questions
	where qustions._title = answers_title);
ERROR:  missing FROM-clause entry for table "qustions"
LINE 4:  where qustions._title = answers_title);
               ^


********** Error **********

ERROR: missing FROM-clause entry for table "qustions"
SQL state: 42P01
Character: 85

-- Executing query:
update answers set answers.fk_row_num = (
	select row_number
	from questions
	where questions._title = answers_title);


Select row_number() over (), questions.row_number fk_row_num, datasets.*
where 
datasets._type = 'answers'
datasets._title =  questions._title;
ERROR:  syntax error at or near "datasets"
LINE 10: datasets._title =  questions._title;
         ^

********** Error **********

ERROR: syntax error at or near "datasets"
SQL state: 42601
Character: 229

-- Executing query:
update answers set answers.fk_row_num = (
	select row_number
	from questions
	where questions._title = answers_title);


Select row_number() over (), questions.row_number fk_row_num, datasets.*
from datasets, questions
where 
datasets._type = 'answers'
datasets._title =  questions._title;
ERROR:  syntax error at or near "datasets"
LINE 11: datasets._title =  questions._title;
         ^


********** Error **********

ERROR: syntax error at or near "datasets"
SQL state: 42601
Character: 254

-- Executing query:
update answers set answers.fk_row_num = (
	select row_number
	from questions
	where questions._title = answers_title);


Select row_number() over (), questions.row_number fk_row_num, datasets.*
from datasets, questions
where 
datasets._type = 'answers' and
datasets._title =  questions._title;
ERROR:  column "answers_title" does not exist
LINE 4:  where questions._title = answers_title);
                                  ^

********** Error **********

ERROR: column "answers_title" does not exist
SQL state: 42703
Character: 104

-- Executing query:
Select row_number() over (), questions.row_number fk_row_num, datasets.*
from datasets, questions
where 
datasets._type = 'answers' and
datasets._title =  questions._title;
ERROR:  canceling statement due to user request

********** Error **********

ERROR: canceling statement due to user request
SQL state: 57014

-- Executing query:
Create table answers1
as
Select row_number() over (), questions.row_number fk_row_num, datasets.*
from datasets, questions
where 
datasets._type = 'answers' and
datasets._title =  questions._title;
Query returned successfully: 0 rows affected, 4519 ms execution time.

-- Executing query:
Select * from answers1
Total query runtime: 14 ms.
0 rows retrieved.

-- Executing query:
select * from datasets;
ERROR:  canceling statement due to user request

********** Error **********

ERROR: canceling statement due to user request
SQL state: 57014

-- Executing query:
select * from datasets limit 10;
Total query runtime: 16 ms.
10 rows retrieved.

-- Executing query:
drop table answers1
Query returned successfully with no result in 62 ms.

-- Executing query:
Create table answers1
as
Select row_number() over (), questions.row_number fk_row_num, datasets.*
from datasets, questions
where 
datasets._type = 'answer' and
datasets._title =  questions._title;
Query returned successfully: 183480 rows affected, 82883 ms execution time.

-- Executing query:
Select count(1) from answers
Total query runtime: 663 ms.
1 row retrieved.

-- Executing query:
Select * from answers1
except
select * from answers
ERROR:  EXCEPT types bigint and text cannot be matched
LINE 3: select * from answers
               ^

********** Error **********

ERROR: EXCEPT types bigint and text cannot be matched
SQL state: 42804
Character: 38

-- Executing query:
Create table acceptedAnswers1
as
Select row_number() over (), questions.row_number fk_row_num, datasets.*
from datasets, questions
where 
datasets._type = 'accepted_answer' and
datasets._title =  questions._title;
Query returned successfully: 0 rows affected, 1103 ms execution time.

-- Executing query:
select * from datasets limit 10
Total query runtime: 16 ms.
10 rows retrieved.

-- Executing query:
Create table acceptedAnswers1
as
Select row_number() over (), questions.row_number fk_row_num, datasets.*
from datasets, questions
where 
datasets._type = 'accepted-answer' and
datasets._title =  questions._title;
ERROR:  relation "acceptedanswers1" already exists

********** Error **********

ERROR: relation "acceptedanswers1" already exists
SQL state: 42P07

-- Executing query:
drop table acceptedanswers1
Query returned successfully with no result in 139 ms.

-- Executing query:
Create table acceptedAnswers
as
Select row_number() over (), questions.row_number fk_row_num, datasets.*
from datasets, questions
where 
datasets._type = 'accepted-answer' and
datasets._title =  questions._title;
Query returned successfully: 95618 rows affected, 54764 ms execution time.

-- Executing query:
Select count(1) from answers1
Total query runtime: 2341 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions
Total query runtime: 383 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions
Total query runtime: 352 ms.
1 row retrieved.

-- Executing query:
Select count(1) from datasets
Total query runtime: 863 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions where row_number not in
(Select fk_row_num from answers);
ERROR:  canceling statement due to user request

********** Error **********

ERROR: canceling statement due to user request
SQL state: 57014

-- Executing query:
Select count(1) from questions where row_number in
(Select fk_row_num from answers);
Total query runtime: 707 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions where row_number in
(Select fk_row_num from answers
union
Select fk_row_num from accepted_answers);
ERROR:  relation "accepted_answers" does not exist
LINE 4: Select fk_row_num from accepted_answers);
                               ^

********** Error **********

ERROR: relation "accepted_answers" does not exist
SQL state: 42P01
Character: 113

-- Executing query:
Select count(1) from questions where row_number in
(Select fk_row_num from answers
union
Select fk_row_num from acceptedanswers);
Total query runtime: 1974 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions where row_number not in
(Select fk_row_num from answers
union
Select fk_row_num from acceptedanswers);
ERROR:  canceling statement due to user request

********** Error **********

ERROR: canceling statement due to user request
SQL state: 57014

-- Executing query:
Select * from questions where row_number in
(Select fk_row_num from answers
union
Select fk_row_num from acceptedanswers);
ERROR:  canceling statement due to user request

********** Error **********

ERROR: canceling statement due to user request
SQL state: 57014

-- Executing query:
Create table questions_with_answers
Select * from questions where row_number in
(Select fk_row_num from answers
union
Select fk_row_num from acceptedanswers);
ERROR:  syntax error at or near "Select"
LINE 2: Select * from questions where row_number in
        ^

********** Error **********

ERROR: syntax error at or near "Select"
SQL state: 42601
Character: 37

-- Executing query:
Create table questions_with_answers
as
Select * from questions where row_number in
(Select fk_row_num from answers
union
Select fk_row_num from acceptedanswers);
Query returned successfully: 165180 rows affected, 101799 ms execution time.

-- Executing query:
Select * from questions_with_answers q, answers a
where q._title = a._title
ERROR:  canceling statement due to user request

********** Error **********

ERROR: canceling statement due to user request
SQL state: 57014

-- Executing query:
Select count(1) from questions_with_answers q, answers a
where q._title = a._title
Total query runtime: 1078 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers q, acceptedanswers a
where q._title = a._title
Total query runtime: 646 ms.
1 row retrieved.

-- Executing query:
Select min(_reputations) from answers
ERROR:  column "_reputations" does not exist
LINE 1: Select min(_reputations) from answers
                   ^
HINT:  Perhaps you meant to reference the column "answers._reputation".


********** Error **********

ERROR: column "_reputations" does not exist
SQL state: 42703
Hint: Perhaps you meant to reference the column "answers._reputation".
Character: 12

-- Executing query:
Select min(_reputation) from answers
Total query runtime: 352 ms.
1 row retrieved.

-- Executing query:
Select max(_reputation) from answers
Total query runtime: 353 ms.
1 row retrieved.

-- Executing query:
Select * from answers limit 10
Total query runtime: 13 ms.
10 rows retrieved.

-- Executing query:
Select * from acceptedanswers limit 10
Total query runtime: 42 ms.
10 rows retrieved.

-- Executing query:
Select * from answers limit 10
Total query runtime: 19 ms.
10 rows retrieved.

-- Executing query:
Select max(_accept_rate) from answers limit 10
Total query runtime: 374 ms.
1 row retrieved.

-- Executing query:
Select min(_accept_rate) from answers limit 10
Total query runtime: 531 ms.
1 row retrieved.

-- Executing query:
Select min(_accept_rate) from questions limit 10
Total query runtime: 540 ms.
1 row retrieved.

-- Executing query:
Select max(_accept_rate) from questions limit 10
Total query runtime: 413 ms.
1 row retrieved.

-- Executing query:
Select max(_reputation) from questions limit 10
Total query runtime: 444 ms.
1 row retrieved.

-- Executing query:
Select min(_reputation) from questions limit 10
Total query runtime: 403 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation < 250;
ERROR:  operator does not exist: text < integer
LINE 1: Select count(1) from answers where _reputation < 250;
                                                       ^
HINT:  No operator matches the given name and argument type(s). You might need to add explicit type casts.

********** Error **********

ERROR: operator does not exist: text < integer
SQL state: 42883
Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts.
Character: 48

-- Executing query:
Select count(1) from answers where _reputation < '250';
Total query runtime: 428 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation >= '250';
Total query runtime: 349 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation >= '300';
Total query runtime: 439 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation < '300';
Total query runtime: 349 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions where _reputation < '250';
Total query runtime: 527 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions where _reputation >= '250';
Total query runtime: 648 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions where _reputation >= '200';
Total query runtime: 426 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions where _reputation >= '250';
Total query runtime: 518 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers where _reputation >= '250';
Total query runtime: 390 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers where _reputation < '250';
Total query runtime: 435 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers where _reputation >= '250';
Total query runtime: 369 ms.
1 row retrieved.

-- Executing query:
create table questions_with_reputation
Select * from questions_with_answers where _reputation >= '250';
ERROR:  syntax error at or near "Select"
LINE 2: Select * from questions_with_answers where _reputation >= '2...
        ^

********** Error **********

ERROR: syntax error at or near "Select"
SQL state: 42601
Character: 40

-- Executing query:
create table questions_with_reputation
as
Select * from questions_with_answers where _reputation >= '250';
Query returned successfully: 94562 rows affected, 23980 ms execution time.

-- Executing query:
Select count(1) from questions_with_reputation q, answers a
where q._title = a._title;
Total query runtime: 801 ms.
1 row retrieved.

-- Executing query:
create table answers_with_reputation
Select answers.* from questions_with_reputation q, answers a
where q._title = a._title;
ERROR:  syntax error at or near "Select"
LINE 2: Select answers.* from questions_with_reputation q, answers a
        ^


********** Error **********

ERROR: syntax error at or near "Select"
SQL state: 42601
Character: 38

-- Executing query:
create table answers_with_reputation
as
Select answers.* from questions_with_reputation q, answers a
where q._title = a._title;
ERROR:  invalid reference to FROM-clause entry for table "answers"
LINE 3: Select answers.* from questions_with_reputation q, answers a
               ^
HINT:  Perhaps you meant to reference the table alias "a".


********** Error **********

ERROR: invalid reference to FROM-clause entry for table "answers"
SQL state: 42P01
Hint: Perhaps you meant to reference the table alias "a".
Character: 48

-- Executing query:
create table answers_with_reputation
as
Select a.* from questions_with_reputation q, answers a
where q._title = a._title;
Query returned successfully: 102007 rows affected, 10868 ms execution time.

-- Executing query:
create table acceptedanswers_with_reputation
as
Select a.* from questions_with_reputation q, answers a
where q._title = a._title;
Query returned successfully: 102007 rows affected, 8493 ms execution time.

-- Executing query:
drop table acceptedanswers_with_reputation
Query returned successfully with no result in 107 ms.

-- Executing query:
create table acceptedanswers_with_reputation
as
Select a.* from questions_with_reputation q, acceptedanswers a
where q._title = a._title;
Query returned successfully: 58230 rows affected, 10455 ms execution time.

-- Executing query:
select count(1) from acceptedanswers_with_reputation
Total query runtime: 1268 ms.
1 row retrieved.

-- Executing query:
select count(1) from acceptedanswers_with_reputation where _reputation < 250
ERROR:  operator does not exist: text < integer
LINE 1: ...from acceptedanswers_with_reputation where _reputation < 250
                                                                  ^
HINT:  No operator matches the given name and argument type(s). You might need to add explicit type casts.

********** Error **********

ERROR: operator does not exist: text < integer
SQL state: 42883
Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts.
Character: 72

-- Executing query:
select count(1) from acceptedanswers_with_reputation where _reputation < '250'
Total query runtime: 159 ms.
1 row retrieved.

-- Executing query:
select count(1) from acceptedanswers_with_reputation where _reputation >= '250'
Total query runtime: 244 ms.
1 row retrieved.

-- Executing query:
select count(1) from answers_with_reputation where _reputation >= '250'
Total query runtime: 588 ms.
1 row retrieved.

-- Executing query:
select count(1) from answers_with_reputation where _reputation < '250'
Total query runtime: 329 ms.
1 row retrieved.

-- Executing query:
select count(1) from answers_with_reputation where _reputation < '100'
Total query runtime: 182 ms.
1 row retrieved.

-- Executing query:
select count(1) from answers_with_reputation where _reputation < '200'
Total query runtime: 317 ms.
1 row retrieved.

-- Executing query:
select count(1) from answers_with_reputation where _reputation >= '200'
Total query runtime: 254 ms.
1 row retrieved.

-- Executing query:
select count(1) from answers_with_reputation where _reputation >= '100'
Total query runtime: 291 ms.
1 row retrieved.

-- Executing query:
select count(1) from answers_with_reputation where _reputation >= '0'
Total query runtime: 273 ms.
1 row retrieved.

-- Executing query:
select count(1) from answers_with_reputation where _reputation >= '100'
Total query runtime: 317 ms.
1 row retrieved.

-- Executing query:
delete from answers_with_reputation where _reputation >= '100'
Query returned successfully: 99472 rows affected, 11438 ms execution time.

-- Executing query:
rollback
WARNING:  there is no transaction in progress


Query returned successfully with no result in 18 ms.

-- Executing query:
drop table acceptedanswers_with_reputation
Query returned successfully with no result in 96 ms.

-- Executing query:
create table answers_with_reputation
as
Select a.* from questions_with_reputation q, answers a
where q._title = a._title;
Query returned successfully: 102007 rows affected, 10868 ms execution time.

ERROR:  syntax error at or near "Query"
LINE 5: Query returned successfully: 102007 rows affected, 10868 ms ...
        ^

********** Error **********

ERROR: syntax error at or near "Query"
SQL state: 42601
Character: 123

-- Executing query:
create table answers_with_reputation
as
Select a.* from questions_with_reputation q, answers a
where q._title = a._title;
ERROR:  relation "answers_with_reputation" already exists

********** Error **********

ERROR: relation "answers_with_reputation" already exists
SQL state: 42P07

-- Executing query:
drop table answers_with_reputation
Query returned successfully with no result in 162 ms.

-- Executing query:
create table answers_with_reputation
as
Select a.* from questions_with_reputation q, answers a
where q._title = a._title;
Query returned successfully: 102007 rows affected, 6932 ms execution time.

-- Executing query:
create table acceptedanswers_with_reputation
as
Select a.* from questions_with_reputation q, acceptedanswers a
where q._title = a._title;
Query returned successfully: 58230 rows affected, 6228 ms execution time.

-- Executing query:
delete from answers_with_reputation where _reputation < '100'

Query returned successfully: 2535 rows affected, 2884 ms execution time.

-- Executing query:
select count(1) from answers_with_reputation

Total query runtime: 737 ms.
1 row retrieved.

-- Executing query:
select count(1) from answers_with_reputation where _reputation < '200'

Total query runtime: 261 ms.
1 row retrieved.

-- Executing query:
select count(1) from answers_with_reputation where _reputation > '200'

Total query runtime: 254 ms.
1 row retrieved.

-- Executing query:
select count(1) from answers_with_reputation where _reputation < '150'

Total query runtime: 204 ms.
1 row retrieved.

-- Executing query:
select count(1) from answers_with_reputation where _reputation >= '150'

Total query runtime: 356 ms.
1 row retrieved.

-- Executing query:
delete from answers_with_reputation where _reputation < '150'

Query returned successfully: 19377 rows affected, 10177 ms execution time.

-- Executing query:
select count(1) from acceptedanswers_with_reputation where _reputation < '150'

Total query runtime: 186 ms.
1 row retrieved.

-- Executing query:
select count(1) from acceptedanswers_with_reputation where _reputation >= '150'

Total query runtime: 258 ms.
1 row retrieved.

-- Executing query:
select count(1) from acceptedanswers_with_reputation where _reputation >= '100'

Total query runtime: 202 ms.
1 row retrieved.

-- Executing query:
select count(1) from acceptedanswers_with_reputation where _reputation < '100'

Total query runtime: 216 ms.
1 row retrieved.

-- Executing query:
select count(1) from acceptedanswers_with_reputation where _reputation < '150'

Total query runtime: 172 ms.
1 row retrieved.

-- Executing query:
select count(1) from acceptedanswers_with_reputation where _reputation < '1250'

Total query runtime: 224 ms.
1 row retrieved.

-- Executing query:
select count(1) from acceptedanswers_with_reputation where _reputation < '125'

Total query runtime: 299 ms.
1 row retrieved.

-- Executing query:
select count(1) from acceptedanswers_with_reputation where _reputation < '1250'

Total query runtime: 248 ms.
1 row retrieved.

-- Executing query:
select count(1) from acceptedanswers_with_reputation where _reputation < '1250'

Total query runtime: 210 ms.
1 row retrieved.

-- Executing query:
select _reputation from acceptedanswers_with_reputation where _reputation < '125'

Total query runtime: 277 ms.
6200 rows retrieved.

-- Executing query:
alter table datasets alter column _reputation type numeric(10,0) using _reputation::numeric;
Query returned successfully with no result in 101382 ms.

-- Executing query:
alter table datasets
alter column _vote type numeric(10,0) using _vote::numeric
alter column _accept_rate type numeric(10,0) using _accept_rate::numeric
;
ERROR:  syntax error at or near "alter"
LINE 3: alter column _accept_rate type numeric(10,0) using _accept_r...
        ^


********** Error **********

ERROR: syntax error at or near "alter"
SQL state: 42601
Character: 82

-- Executing query:
alter table datasets
alter column _vote type numeric(10,0) using _vote::numeric
,column _accept_rate type numeric(10,0) using _accept_rate::numeric
;
ERROR:  syntax error at or near "column"
LINE 3: ,column _accept_rate type numeric(10,0) using _accept_rate::...
         ^


********** Error **********

ERROR: syntax error at or near "column"
SQL state: 42601
Character: 83

-- Executing query:
alter table datasets
alter column _vote type numeric(10,0), _accept_rate type numeric(10,0) using _vote::numeric, _accept_rate::numeric
;
ERROR:  syntax error at or near "_accept_rate"
LINE 2: alter column _vote type numeric(10,0), _accept_rate type num...
                                               ^


********** Error **********

ERROR: syntax error at or near "_accept_rate"
SQL state: 42601
Character: 62

-- Executing query:
alter table datasets
alter column _vote type numeric(10,0) using _vote::numeric;
Query returned successfully with no result in 126952 ms.

-- Executing query:
alter table questions
alter column _reputation type numeric(10,0) using _reputation::numeric;
Query returned successfully with no result in 25894 ms.

-- Executing query:
alter table answers
alter column _reputation type numeric(10,0) using _reputation::numeric;
Query returned successfully with no result in 12558 ms.

-- Executing query:
alter table acceptedanswers
alter column _reputation type numeric(10,0) using _reputation::numeric;
Query returned successfully with no result in 16350 ms.

-- Executing query:
Create table questions_with_answers
as
Select * from questions where row_number in
(Select fk_row_num from answers
union
Select fk_row_num from acceptedanswers);
ERROR:  relation "questions_with_answers" already exists

********** Error **********

ERROR: relation "questions_with_answers" already exists
SQL state: 42P07

-- Executing query:
Select * from questions_with_answers where _reputation >= 250;

ERROR:  operator does not exist: text >= integer
LINE 1: ...lect * from questions_with_answers where _reputation >= 250;
                                                                ^
HINT:  No operator matches the given name and argument type(s). You might need to add explicit type casts.

********** Error **********

ERROR: operator does not exist: text >= integer
SQL state: 42883
Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts.
Character: 56

-- Executing query:
Select * from questions_with_answers where _reputation > 250;

ERROR:  operator does not exist: text > integer
LINE 1: ...elect * from questions_with_answers where _reputation > 250;
                                                                 ^
HINT:  No operator matches the given name and argument type(s). You might need to add explicit type casts.

********** Error **********

ERROR: operator does not exist: text > integer
SQL state: 42883
Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts.
Character: 56

-- Executing query:
alter table questions_with_answers
alter column _reputation type numeric(10,0) using _reputation::numeric;
Query returned successfully with no result in 31054 ms.

-- Executing query:
Select * from questions_with_answers where _reputation >= 250;

ERROR:  canceling statement due to user request

********** Error **********

ERROR: canceling statement due to user request
SQL state: 57014

-- Executing query:
Select count(1) from questions_with_answers where _reputation >= 250;

Total query runtime: 528 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers where _reputation >= 0;

Total query runtime: 320 ms.
1 row retrieved.

-- Executing query:
Select min(_reputation) from questions_with_answers where _reputation >= 0;

Total query runtime: 434 ms.
1 row retrieved.

-- Executing query:
Select max(_reputation) from questions_with_answers where _reputation >= 0;

Total query runtime: 505 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers where _reputation < 250;

Total query runtime: 407 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers where _reputation >= 250;

Total query runtime: 394 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers where _reputation < 150;

Total query runtime: 435 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers where _reputation >= 150;

Total query runtime: 264 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers where _reputation >= 100;

Total query runtime: 426 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers where _reputation >= 1250;

Total query runtime: 339 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers where _reputation >= 125;

Total query runtime: 361 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers where _reputation < 125;

Total query runtime: 318 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers where _reputation > 100;

Total query runtime: 322 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation > 100;

Total query runtime: 540 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation > 150;

Total query runtime: 372 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation < 150;

Total query runtime: 307 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation < 250;

Total query runtime: 287 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation >= 250;

Total query runtime: 288 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation < 250;

Total query runtime: 449 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation < 350;

Total query runtime: 352 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation >= 350;

Total query runtime: 308 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation < 350;

Total query runtime: 307 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation < 350;

Total query runtime: 339 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers where _reputation >= 350;

Total query runtime: 297 ms.
1 row retrieved.

-- Executing query:
Select _reputation from answers where _reputation < 350;

Total query runtime: 310 ms.
52416 rows retrieved.

-- Executing query:
create table answers_reputation
as
Select * from answers where _reputation >= 350;

Query returned successfully: 131064 rows affected, 13408 ms execution time.

-- Executing query:

Select * from acceptedanswers where _reputation >= 350;

ERROR:  canceling statement due to user request

********** Error **********

ERROR: canceling statement due to user request
SQL state: 57014

-- Executing query:

Select count(1) from acceptedanswers where _reputation >= 350;

Total query runtime: 275 ms.
1 row retrieved.

-- Executing query:

Select count(1) from acceptedanswers where _reputation < 350;

Total query runtime: 279 ms.
1 row retrieved.

-- Executing query:

Select count(1) from acceptedanswers where _reputation < 350;

Total query runtime: 326 ms.
1 row retrieved.

-- Executing query:
create table acceptedanswers_reputation
as
Select * from acceptedanswers where _reputation >= 350;

Query returned successfully: 78327 rows affected, 9338 ms execution time.

-- Executing query:
select count(1) from questions_with_reputation;
ERROR:  relation "questions_with_reputation" does not exist
LINE 1: select count(1) from questions_with_reputation;
                             ^

********** Error **********

ERROR: relation "questions_with_reputation" does not exist
SQL state: 42P01
Character: 22

-- Executing query:
select count(1) from questions_reputation;
ERROR:  relation "questions_reputation" does not exist
LINE 1: select count(1) from questions_reputation;
                             ^

********** Error **********

ERROR: relation "questions_reputation" does not exist
SQL state: 42P01
Character: 22

-- Executing query:

Select * from questions_with_answers;
ERROR:  canceling statement due to user request

********** Error **********

ERROR: canceling statement due to user request
SQL state: 57014

-- Executing query:

Select count(1) from questions_with_answers
where row_number in
(
Select fk_row_num from answers_reputation
INTERSECT
Select fk_row_num from acceptedanswers_reputation
)
Total query runtime: 699 ms.
1 row retrieved.

-- Executing query:

Select count(1) from questions_with_answers
where row_number in
(
Select fk_row_num from answers_reputation
UNION
Select fk_row_num from acceptedanswers_reputation
)
Total query runtime: 738 ms.
1 row retrieved.

-- Executing query:

Select count(1) from questions_with_answers
where row_number in
(
Select fk_row_num from answers_reputation
)
Total query runtime: 510 ms.
1 row retrieved.

-- Executing query:

Select count(1) from questions_with_answers
where row_number in
(
Select fk_row_num from answers_reputation
UNION
Select fk_row_num from acceptedanswers_reputation
)
Total query runtime: 736 ms.
1 row retrieved.

-- Executing query:
create table questions_with_reputation
as
Select * from questions_with_answers
where row_number in
(
Select fk_row_num from answers_reputation
UNION
Select fk_row_num from acceptedanswers_reputation
)
Query returned successfully: 138179 rows affected, 29098 ms execution time.

-- Executing query:
create table questions_with_reputation
as
Select * from questions_with_answers
where row_number in
(
Select fk_row_num from answers_reputation
UNION
Select fk_row_num from acceptedanswers_reputation
)
ERROR:  relation "questions_with_reputation" already exists

********** Error **********

ERROR: relation "questions_with_reputation" already exists
SQL state: 42P07

-- Executing query:
Select count(1) from questions_with_answers
Total query runtime: 264 ms.
1 row retrieved.

-- Executing query:
Select count(1) from questions_with_answers a, answers b where a._title = b._title;
Total query runtime: 792 ms.
1 row retrieved.

-- Executing query:
Select count(1) from answers b ;
Total query runtime: 222 ms.
1 row retrieved.

-- Executing query:
drop table questions_with_reputation
Query returned successfully with no result in 151 ms.

-- Executing query:
create table questions_with_reputation
as
Select * from questions_with_answers
where row_number in
(
Select fk_row_num from answers_reputation
UNION
Select fk_row_num from acceptedanswers_reputation
)
Query returned successfully: 138179 rows affected, 21320 ms execution time.

-- Executing query:
create table fquestions
as
select * from questions_with_reputation
Query returned successfully: 138179 rows affected, 24286 ms execution time.

-- Executing query:
create table fanswers
as
select * from answers_reputation
Query returned successfully: 131064 rows affected, 11560 ms execution time.

-- Executing query:
create table facceptedanswers
as
select * from acceptedanswers_reputation
Query returned successfully: 78327 rows affected, 9928 ms execution time.

-- Executing query:
SELECT _tag FROM FQUESTIONS;
Total query runtime: 483 ms.
138179 rows retrieved.

-- Executing query:
CREATE TABLE TAGS (
tag text)

ERROR:  relation "tags" already exists

********** Error **********

ERROR: relation "tags" already exists
SQL state: 42P07

-- Executing query:
truncate table if exists tags
ERROR:  syntax error at or near "exists"
LINE 1: truncate table if exists tags
                          ^

********** Error **********

ERROR: syntax error at or near "exists"
SQL state: 42601
Character: 19

-- Executing query:
frop table if exists tags
ERROR:  syntax error at or near "frop"
LINE 1: frop table if exists tags
        ^

********** Error **********

ERROR: syntax error at or near "frop"
SQL state: 42601
Character: 1

-- Executing query:
drop table if exists tags
Query returned successfully with no result in 283 ms.

-- Executing query:
CREATE TABLE TAGS (
tag text)

Query returned successfully with no result in 180 ms.

-- Executing query:
select distinct tag from tags
Total query runtime: 166 ms.
10634 rows retrieved.

-- Executing query:
create table distinctTags
as
select distinct tag from tags
Query returned successfully: 10634 rows affected, 560 ms execution time.

-- Executing query:
SELECT tag, count(1) FROM TAGS GROUP BY tag ORDER BY 2 DESC
Total query runtime: 210 ms.
10634 rows retrieved.

-- Executing query:
create table tag_count
as
SELECT tag, count(1) FROM TAGS GROUP BY tag ORDER BY 2 DESC
Query returned successfully: 10634 rows affected, 460 ms execution time.

