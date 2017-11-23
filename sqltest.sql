create database sqltest;
CREATE TABLE student (
    sno VARCHAR(3) NOT NULL,
    sname VARCHAR(4) NOT NULL,
    ssex VARCHAR(2) NOT NULL,
    sbirthday DATETIME,
    class VARCHAR(5)
);

CREATE TABLE course (
    cno VARCHAR(5) NOT NULL,
    cname VARCHAR(10) NOT NULL,
    tno VARCHAR(10) NOT NULL
);

CREATE TABLE score (
    sno VARCHAR(3) NOT NULL,
    cno VARCHAR(5) NOT NULL,
    degree NUMERIC(10 , 1 ) NOT NULL
);

CREATE TABLE teacher (
    tno VARCHAR(3) NOT NULL,
    tname VARCHAR(4) NOT NULL,
    tsex VARCHAR(2) NOT NULL,
    tbirthday DATETIME NOT NULL,
    prof VARCHAR(6),
    depart VARCHAR(10) NOT NULL
);

INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (108 ,'曾华' 
,'男' ,'1977-09-01',95033);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (105 ,'匡明' 
,'男' ,'1975-10-02',95031);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (107 ,'王丽' 
,'女' ,'1976-01-23',95033);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (101 ,'李军' 
,'男' ,'1976-02-20',95033);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (109 ,'王芳' 
,'女' ,'1975-02-10',95031);
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES (103 ,'陆君' 
,'男' ,'1974-06-03',95031);


INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('3-105' ,'计算机导论',825);
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('3-245' ,'操作系统' ,804);
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('6-166' ,'数据电路' ,856);
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('9-888' ,'高等数学' ,100);

INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (103,'3-245',86);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (105,'3-245',75);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (109,'3-245',68);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (103,'3-105',92);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (105,'3-105',88);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (109,'3-105',76);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (101,'3-105',64);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (107,'3-105',91);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (108,'3-105',78);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (101,'6-166',85);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (107,'6-106',79);
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES (108,'6-166',81);

INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART) 
VALUES (804,'李诚','男','1958-12-02','副教授','计算机系');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART) 
VALUES (856,'张旭','男','1969-03-12','讲师','电子工程系');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART)
VALUES (825,'王萍','女','1972-05-05','助教','计算机系');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART) 
VALUES (831,'刘冰','女','1977-08-14','助教','电子工程系');

-- ##链接地址：http://blog.csdn.net/qaz13177_58_/article/details/5575711/

-- 题目：
-- 1、 查询Student表中的所有记录的Sname、Ssex和Class列。
select sname,ssex ,class from student;
-- 2、 查询教师所有的单位即不重复的Depart列。
select distinct depart from teacher;
-- 3、 查询Student表的所有记录。
select * from student;
-- 4、 查询Score表中成绩在60到80之间的所有记录。
select * from score where degree between 60 and 80;
-- 5、 查询Score表中成绩为85，86或88的记录。
select * from score where degree in (85,86,88);
-- 6、 查询Student表中“95031”班或性别为“女”的同学记录。
select * from student where class='95031' or ssex ='女';
-- 7、 以Class降序查询Student表的所有记录。
select * from student order by class desc;
-- 8、 以Cno升序、Degree降序查询Score表的所有记录。
select * from score order by cno asc, degree desc;
-- 9、 查询“95031”班的学生人数。
select count(*) '95031班总人数' from student where class='95031';
-- 10、查询Score表中的最高分的学生学号和课程号。
select sno ,cno from score where degree =(select max(degree) from score);
select sno ,cno from score where degree>=all(select degree from score);
select sno,cno from score order by degree desc limit 1;
-- 11、查询‘3-105’号课程的平均分。
select avg(degree) from score where cno='3-105';
-- 12、查询Score表中至少有5名学生选修的并以3开头的课程的平均分数。
select cno,avg(degree) from score where cno like '3%' group by cno having count(*)>=5;
-- 13、查询最低分大于70，最高分小于90的Sno列。
select distinct sno from score where degree  between 70 and 90;-- 错，最低高分针对个人而言

SELECT SNO FROM SCORE GROUP BY SNO HAVING MIN(DEGREE)>70 AND MAX(DEGREE)<90;
-- 14、查询所有学生的Sname、Cno和Degree列。
select sname,score.cno ,degree from student,score,course where student.sno=score.sno and score.cno=course.cno;-- 不需要连接course表
-- 15、查询所有学生的Sno、Cname和Degree列。
select student.sno,course.cname ,degree from student,score,course where student.sno=score.sno and score.cno=course.cno;
-- 16、查询所有学生的Sname、Cname和Degree列。
select student.sname,course.cname ,degree from student,score,course where student.sno=score.sno and score.cno=course.cno;
-- 17、查询“95033”班所选课程的平均分。
select avg(degree) as '95033班所选课程的平均分' from score ,student where score.sno=student.sno and student.class='95033';
-- 18、假设使用如下命令建立了一个grade表：
-- create table grade(low   number(3,0),upp   number(3),rank   char(1));
-- insert into grade values(90,100,’A’);
-- insert into grade values(80,89,’B’);
-- insert into grade values(70,79,’C’);
-- insert into grade values(60,69,’D’);
-- insert into grade values(0,59,’E’);
-- commit;
-- 现查询所有同学的Sno、Cno和rank列。
create table grade(low   numeric(3,0),upp   numeric(3,0),rank   char(1));
insert into grade values(90,100,'A');
insert into grade values(80,89,'B');
insert into grade values(70,79,'C');
insert into grade values(60,69,'D');
insert into grade values(0,59,'E');
commit;

select sno,cno ,rank from score,grade where score.degree between grade.low and grade.upp;

-- 19、查询选修“3-105”课程的成绩高于“109”号同学成绩的所有同学的记录。
select * from score sc  where sc.cno='3-105' and sc.degree>(select degree from score where score.sno='109'and score.cno='3-105' );

SELECT A.* FROM SCORE A JOIN SCORE B WHERE A.CNO='3-105' AND A.DEGREE>B.DEGREE AND 

B.SNO='109' AND B.CNO='3-105';
-- 另一解法：
SELECT A.* FROM SCORE A  WHERE A.CNO='3-105' AND A.DEGREE>ALL(SELECT DEGREE FROM 

SCORE B WHERE B.SNO='109' AND B.CNO='3-105');

-- 20、查询score中选学一门以上课程的同学中分数为非最高分成绩的记录。
select sno,cno,degree from score outS where degree < (select max(innS.degree) from score innS where outS.cno=innS.cno);
select sno,cno,degree from score s where degree<(select max(degree) from score )group by sno having count(SNO)>1 order by degree;
select s.* from score as s, (select sno,max(DEGREE) as md from score group by sno having count(*)>1 ) as sc where s.DEGREE<sc.md and s.SNO=sc.SNO;
-- 21、查询成绩高于学号为“109”、课程号为“3-105”的成绩的所有记录。
select * from score  outS where outS.degree>(select degree from score where sno='109' and cno='3-105'); 
-- 22、查询和学号为108的同学同年出生的所有学生的Sno、Sname和Sbirthday列。
select /* s1.sno,s1.sname,s1.sbirthday */ * from student s1,student s2 where s2.sno='108' and year(s1.sbirthday) =year(s2.sbirthday) ;
-- 23、查询“张旭“教师任课的学生成绩。
select /*score.sno,score.cno,score.degree */ * from score,course,teacher where teacher.tname='张旭' and  teacher.tno=course.tno and course.cno=score.cno;
-- 24、查询选修某课程的同学人数多于5人的教师姓名。
select t.tname from teacher t where t.tno in (select c.tno from course c,score s where c.cno = s.cno group by tno having count(*)>5);
-- 或者：
select t.tname from teacher t, course c,score s where t.tno=c.tno and c.cno=s.cno group by t.tname having count(*) >5;
-- 25、查询95033班和95031班全体学生的记录。
select * from student s where s.class ='95033' or s.class='95031';
-- 26、查询存在有85分以上成绩的课程Cno.
select distinct s.cno from score s where s.degree>85;-- ？
SELECT CNO FROM SCORE GROUP BY CNO HAVING MAX(DEGREE)>85;
-- 27、查询出“计算机系“教师所教课程的成绩表。
select sc.sno,sc.cno,c.cname, sc.degree from score sc ,course c ,teacher t where sc.cno=c.cno and c.tno=t.tno and t.depart='计算机系';
-- 28、查询“计算机系”与“电子工程系“不同职称的教师的Tname和Prof。
select t.tname ,t.prof from teacher t where t.depart='计算机系' or t.depart='电子工程系';-- ????????????????
-- 29、查询选修编号为“3-105“课程且成绩至少高于选修编号为“3-245”的同学的Cno、Sno和Degree,并按Degree从高到低次序排序。
select score.cno,score.sno,score.degree from score where score.cno='3-105' and score.degree >=all(select degree from score s where s.cno='3-245') order by score.degree desc;
-- 30、查询选修编号为“3-105”且成绩高于选修编号为“3-245”课程的同学的Cno、Sno和Degree.
select s1.cno,s1.sno,s1.degree from score s1 where s1.cno='3-105' and s1.degree>=any(select s2.degree from score s2 where s2.cno='3-245');  ;
-- 31、查询所有教师和同学的name、sex和birthday.
select t.tname name,t.tsex sex ,t.tbirthday birthday  from teacher t union select s.sname name ,s.ssex sex ,s.sbirthday birthday from student s;
-- 32、查询所有“女”教师和“女”同学的name、sex和birthday.
select t.tname name,t.tsex sex ,t.tbirthday birthday  from teacher t where t.tsex='女' union select s.sname name ,s.ssex sex ,s.sbirthday birthday from student s where s.ssex='女';
-- 33、查询成绩比该课程平均成绩低的同学的成绩表。
select s.cno,s.sno,s.degree from score s where s.degree<(select avg(ins.degree) from score ins where ins.cno=s.cno );
-- 34、查询所有任课教师的Tname和Depart.
select t.tname,t.depart from teacher t where t.tno in (select distinct ic.tno from course ic );--- 也可以exists 或者连接teacher表和course表
-- 35  查询所有未讲课的教师的Tname和Depart. 
select t.tname,t.depart from teacher t where t.tno  not in (select distinct ic.tno from course ic );-- not in效率最差
-- 解法一：
SELECT TNAME,DEPART FROM TEACHER A LEFT JOIN COURSE B USING(TNO) WHERE ISNUL (B.tno);
-- 解法二：
select tname,depart from teacher a where not exists (select * from course b where a.tno=b.tno);
-- 36、查询至少有2名男生的班号。
select  s.class ,count(*) from student s  where s.ssex='男' group by s.class having count(*) >=2;
-- 37、查询Student表中不姓“王”的同学记录。
select s.sno,s.sname,s.ssex,s.sbirthday ,s.age from student s where s.sname not like '王%';
-- 38、查询Student表中每个学生的姓名和年龄。
select s.sname, (year(now())-year(s.sbirthday)) age from student s;
-- 39、查询Student表中最大和最小的Sbirthday日期值。
select max(sbirthday) birthday from student union select min(sbirthday) birthday from student;
-- 40、以班号和年龄从大到小的顺序查询Student表中的全部记录。
select  s.class ,(year(now())-year(s.sbirthday)) age ,s.sname,s.sno from student s order by class desc, sbirthday desc; 
-- 41、查询“男”教师及其所上的课程。
select t.*,c.* from teacher t,course c where t.tno =c.tno and t.tsex='男';
-- 42、查询最高分同学的Sno、Cno和Degree列。
select s1.sno, s1.cno,s1.degree from score s1 where degree=(select max(s2.degree) from score s2 /* where s2.cno=s1.cno*/ );
-- 43、查询和“李军”同性别的所有同学的Sname.
select s1.sname from student s1,student s2 where s1.ssex=s2.ssex and s2.sname='李军' /* and s1.sname !='李军'*/ ; 
-- 44、查询和“李军”同性别并同班的同学Sname.
select s1.sname from student s1 where s1.ssex=(select ssex from student where sname='李军') and s1.class=(select class from student where sname='李军') and s1.sname!='李军';
-- 45、查询所有选修“计算机导论”课程的“男”同学的成绩表
select s.* ,sc.* from student s,score sc,course c where s.sno=sc.sno and sc.cno=c.cno and c.cname='计算机导论' and s.ssex='男';
