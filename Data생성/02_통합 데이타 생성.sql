ALTER TABLE Cert DISABLE PRIMARY KEY CASCADE;
ALTER TABLE Reply DISABLE PRIMARY KEY CASCADE;
ALTER TABLE Join DISABLE PRIMARY KEY CASCADE;
ALTER TABLE Together DISABLE PRIMARY KEY CASCADE;
ALTER TABLE Member DISABLE PRIMARY KEY CASCADE;

TRUNCATE TABLE Cert;
TRUNCATE TABLE Reply;
TRUNCATE TABLE Join;
TRUNCATE TABLE Together;
TRUNCATE TABLE Member;
TRUNCATE TABLE OperInfo;

--------------------------------------------------------
--  [강성민] 파일이 생성됨 - 금요일-3월-29-2019   33
--------------------------------------------------------
REM INSERTING into Cert
SET DEFINE OFF;
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190305',233,'gowith','img/ksm_manbo20190305.jpg');
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190306',233,'gowith','img/ksm_manbo20190306.jpg');
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190307',233,'gowith','img/ksm_manbo20190307.jpg');
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190309',233,'gowith','img/ksm_manbo20190309.jpg');
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190310',233,'gowith','img/ksm_manbo20190310.jpg');
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190311',233,'gowith','img/ksm_manbo20190311.jpg');
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190312',233,'gowith','img/ksm_manbo20190312.jpg');
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190313',233,'gowith','img/ksm_manbo20190313.jpg');
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190315',233,'gowith','img/ksm_manbo20190315.jpg');
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190317',233,'gowith','img/ksm_manbo20190317.jpg');
REM INSERTING into Reply
SET DEFINE OFF;
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,201,'이런건 꼭 참여해야함.','ggyo','20190210');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,201,'무조건 강추','gozila','20190210');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (3,201,'안하면 손해 아님?','gazua','20190211');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,204,'좀 이상한데? ','gowith','20190304');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,204,'나 열심히 잘 할거임','gazua','20190305');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (3,204,'좋아좋아요','ggyo','20190306');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,222,'고고곸ㅋㅋ','ggyo','20181225');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,222,'막 땡기는 투게더 인듯?','gozila','20181226');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (3,222,'우--------------------아------------ㅋㅋㅋ','gowith','20181227');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,233,'개이득, 도전 성공할 수 있음','gazua','20180314');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,233,'누가 이런걸 만들었나요?','gowith','20180314');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (3,233,'이런건 식은 죽 먹기 아닙니까?','gozila','20180315');
REM INSERTING into Join
SET DEFINE OFF;
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (201,'gazua','20190210',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (204,'gozila','20190305',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (222,'ggyo','20191224',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (233,'gowith','20190303',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (201,'ggyo','20190210',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (204,'gazua','20190305',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (222,'gowith','20191224',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (233,'gozila','20190303',0);
REM INSERTING into Member
SET DEFINE OFF;
Insert into Member (ID,name,password,tel,email,point,createDate) values ('gowith','김성학','19442','010-2322-9912','gowith@gmail.com',19230,'20160302');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('ggyo','강현우','12355','010-2443-2211','ggyo19@naver.com',1233,'20170706');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('gazua','김현정','123116','010-5643-9811','gazua@gmail.com',0,'20110202');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('gozila','박상현','1251156','010-2411-2991','goinggo@gmail.com',1233500,'20110603');
REM INSERTING into Together
SET DEFINE OFF;
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (233,'만보걷기','만보걷고 건강챙기자','img/ksm_manbo.jpg',500,'20190305','20190318',1,50,2,0,'gowith','20190301',3);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (222,'하루열잔','하루 물 열잔 마시기','img/ksm_water.jpg',1000,'20190101','20190402',10,100,2,0,'ggyo','20181220',1);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (201,'하루한끼','소식하여 장수하자','img/ksm_onemeal.jpg',700,'20190215','20190415',5,30,2,0,'gazua','20190208',1);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (204,'아침챙겨','아침먹고 하루힘내','img/ksm_breakfast.jpg',900,'20190308','20190318',2,50,2,0,'gozila','20190302',1);

--------------------------------------------------------
-- [박성인] 파일이 생성됨 - 금요일-3월-29-2019   
--------------------------------------------------------
Insert into OPERINFO (LASTPROCDATE,OPERDATE) values ('20100101',to_date('19/04/16','RR/MM/DD'));

REM INSERTING into Cert
SET DEFINE OFF;
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190106',700,'zebra',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190107',700,'xylitol',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190107',700,'young',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190107',700,'zebra',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190108',700,'xylitol',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190109',700,'young',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190109',700,'zebra',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190110',700,'xylitol',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190112',700,'young',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190113',700,'zebra',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190114',700,'xylitol',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190114',700,'young',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190114',700,'zebra',null);
REM INSERTING into Reply
SET DEFINE OFF;
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,700,'물 마시는 거 정말 중요하죠. 열심히 한번 해 보겠습니다.','zebra','20190101');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,700,'2리터가 가능할까요? 흑흑','zebra','20190105');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (3,700,'저는 하마예용~ 잘 할 수 있을 듯...','xylitol','20190115');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (4,700,'물 먹는 거 우습게 생각했는데, 보통 일이 아니었음.','young','20190116');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,701,'착한 사람 한 번 되어 볼까요?','zebra','20190101');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,701,'정말 좋은 생각인 거 같아요. 고맙다는 말 세번 한다는 거...','zebra','20190203');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (3,701,'고맙다는 말을... 입이 안떨어져요. 돈 생각하면서 한번 도전! 말','xylitol','20190202');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (4,701,'고맙다라... 이게 하면 좋은데 왜 폭파 되었을까요? 다시 진행하면 한번 해 볼까 봐요.','young','20190329');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,702,'걸으면 오래 산다는데. 만보는 넘사벽. 오늘부터 계단으로 한번 다녀볼까요?','zebra','20190305');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,702,'반성합니다. 맨날 엘레베이터만 타고 다녔는데 만보 채우려면 얼마나 걸어야 할까요? 만보기부터 사야 할 듯.','zebra','20190329');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (3,702,'도전! 저는 잘 할 수 있을 듯요. 만보는 우습죠. ㅋ','xylitol','20190401');
REM INSERTING into Join
SET DEFINE OFF;
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (702,'zebra','20190320',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (702,'xylitol','20190311',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (702,'young','20190303',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (701,'zebra','20190207',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (701,'xylitol','20190207',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (701,'young','20190208',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (700,'zebra','20190101',2000);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (700,'xylitol','20190102',1000);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (700,'young','20190103',1000);
REM INSERTING into Member
SET DEFINE OFF;
Insert into Member (ID,name,password,tel,email,point,createDate) values ('xylitol','자일리톤','xylitol','010-3923-9820','saintp@naver.com',89234,'20190102');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('young','류현진','young','010-2345-9201','young@daum.net',238909,'20170101');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('zebra','얼룩말','zebra','016-9029-2298','zebra@hotmail.com',43927,'20150323');
REM INSERTING into Together
SET DEFINE OFF;
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (700,'하루에 물 2리터 마시기','물마시기 힘드시죠? 물을 많이 마셔야 건강헹 좋아요.','img/saintpWater.png',10000,'20190105','20190114',2,1000,3,0,'zebra','20190101',3);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (701,'매일 고맙단말 세번하기','매일 고맙다는 말을 꼭 3번은 하기로 해요. 이게 의외로 어렵단 거. 
하지만 해 보면 듣는 사람도 기뻐하고, 나도 행복해 져요. ^^
','img/saintpThanks.jpg',30000,'20190210','20190310',3,2000,2,0,'zebra','20190201',0);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (702,'매일 만보 걷기','매일만보걷기라니깐요.','img/saintpManbo.png',20000,'20190430','20191231',10,50,3,0,'xylitol','20190301',1);

--------------------------------------------------------
-- [서인준] 파일이 생성됨 - 금요일-3월-29-2019   
--------------------------------------------------------
REM INSERTING into Cert
SET DEFINE OFF;
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190422',601,'seoinjun',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190423',601,'seomoon',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190425',601,'seomoon',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190230',602,'seosungjun',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190228',602,'seomoon',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190301',602,'seomoon',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190311',602,'seomoon',null);
REM INSERTING into Reply
SET DEFINE OFF;
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,601,'열심히 해봐요!!','seoinjun','20190420');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,601,'어떤 책으로 하나요?','seomoon','20190401');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,602,'재밌을까요?','seomoon','20190219');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,603,'저도 하고싶은데!','seosungjun','20190327');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,604,'안경 낀 사람도 참여할 수 있나요?','seoinjun','20190327');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,604,'Can I do it? ','seostar','20190401');
REM INSERTING into Join
SET DEFINE OFF;
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (601,'seoinjun','20190420',6666);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (602,'seosungjun','20190219',1666);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (602,'seomoon','20190219',4998);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (601,'seomoon','20190420',13332);
REM INSERTING into Member
SET DEFINE OFF;
Insert into Member (ID,name,password,tel,email,point,createDate) values ('seoinjun','서인준','seoinjun','010-1234-1234','seo@naver.com',50000,'20190329');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('seomoon','서문','seomoon','010-1234-6789','moon@navr.com',70000,'20190311');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('seosungjun','서성준','seosungjun','010-6789-1234','shseo@gmail.com',30000,'20190314');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('seostar','서별','seostar','010-1234-4311','star@daum.net',0,'20190328');
REM INSERTING into Together
SET DEFINE OFF;
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (601,'하루 책1시간읽기','하루에 책 1시간 읽는 모임입니다.
재미있겠지요?
책을 읽지 않고 마음대로 생각하다보면 개소리나 하게 됩니다.
책 선정은 다음과 같습니다.
1. 대한민국 헌법
2. 하이에크의 자유헌정론
3. ','img/seo_601_book.jpg',100000,'20190420','20190720',2,30,2,0,'seoinjun','20190329',2);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (602,'아침6시기상','매일 6시에 일어나서 인증사진을 올리는 모임입니다. 
화이팅!!','img/seo_602_wakeUp01.jpg',100000,'20190219','20190419',10,40,2,0,'seoinjun','20190204',2);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (603,'매일 영어 영작모임','매일 영어로 영작을 하는 모임입니다. A4용지 기준 표준 양식, 폰트 사이즈 11이하로 1장 이상의 글을 매일 쓰고, 인증하는 모임입니다. 문법 오류도 서로 지적해주면 좋을 것 같습니다','img/seo_603_writing01.jpg',25000,'20190407','20190609',7,15,1,0,'seomoon','20190320',1);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (604,'30일동안PullUp 매일하기','매일 PullUp을 하는 모임입니다. 30일 동안 진행합니다. 사진으로 인증합니다. ','img/seo_604_pullUp.jpg',30000,'20190414','20190514',10,60,2,0,'seomoon','20190401',1);

--------------------------------------------------------
-- [차연지] 파일이 생성됨 - 금요일-3월-29-2019   
--------------------------------------------------------
REM INSERTING into Cert
SET DEFINE OFF;
Insert into Cert (createDate,toNo,memberID,filepath) values ('20180325',500,'qty5252',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20180326',500,'pickle52',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20180327',500,'pjyun11',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20180328',500,'qulity77',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20180329',500,'rrrrap777',null);
REM INSERTING into Reply
SET DEFINE OFF;
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,500,' 끝났네요!!','qty5252','20180315');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,500,' 힘들었어요ㅠㅠ','qty5252','20180315');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,510,'다들 힘내봅시다!','pjyun11','20190311');
REM INSERTING into Join
SET DEFINE OFF;
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (500,'pickle52','20180320',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (500,'pjyun11','20180316',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (500,'qulity77','20180317',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (500,'qty5252','20180315',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (500,'rrrrap777','20180320',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (510,'pjyun11','20190311',0);
REM INSERTING into Member
SET DEFINE OFF;
Insert into Member (ID,name,password,tel,email,point,createDate) values ('phk0987','박현경','phk0987','010-5648-8963','phk0987@naver.com',80000,'20180708');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('pickle52','박오이','pickle01','010-1298-7659','pickle01@daum.net',45000,'20170630');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('pjyun11','박정윤','pjyun11','010-9966-7756','pjyun11@nate.com',76000,'20160821');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('queen99','김지윤','queen99','010-9631-7852','queen99@apple.com',142000,'20180511');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('qulity77','이기대','qulity77','010-7564-1359','qulity77@sal.co.kr',16000,'20170425');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('qty5252','조윤희','qty5252','010-2233-4593','qty5252@naver.com',18000,'20161209');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('rabbit03','윤나비','rabbit03','010-7896-6528','rabbit03@naver.com',74000,'20181104');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('redy1004','이창현','redy1004','010-7832-1116','redy1004@daum.net',32000,'20170329');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('rrrrap777','조원영','rrrrap777','010-878-1952','rrrrap777@yahoo.co.kr',24000,'20160918');
REM INSERTING into Together
SET DEFINE OFF;
Insert into Together 
(toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (500,'일주일에 책 1권읽기','매주 한 권씩 책을 읽으면서 마음의 양식 쌓기','img/ynvly_book.jpg',10000,'20180401','20180428',5,30,5,0,'qty5252','20180315',3);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (510,'매일 일기쓰기','하루를 마무리하며 오늘 있었던 일을 정리해보아요. 후에는 멋진 추억이 될 거 에요!','img/ynvly_diary.jpg',5000,'20190325','20190425',3,20,1,5000,'pjyun11','20190311',2);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (520,'저녁을 샐러드로 바꿔먹기!',' 하루 한끼 저녁을 샐러드로 바꿔서 건강과 다이어트 두마리토끼를 잡아봅시다!','img/ynvly_salad.jpg',10000,'20190501','20190507',10,50,0,0,'rabbit03','20190401',1);

--------------------------------------------------------
-- [이성용] 파일이 생성됨 - 금요일-3월-29-2019   
--------------------------------------------------------
REM INSERTING into Cert
SET DEFINE OFF;
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190312',2,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190312',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190313',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190314',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190315',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190316',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190317',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190318',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190319',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190320',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190321',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190322',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190323',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190324',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190325',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190326',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190315',2,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190316',2,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190317',2,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190318',2,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190319',2,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190320',2,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190322',2,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190325',2,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190328',2,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190327',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190328',2,'a0101',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190108',1,'a0201',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190109',1,'a0201',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190110',1,'a0201',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190108',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190109',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190110',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190111',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190112',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190113',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190114',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190115',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190116',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190117',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190118',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190119',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190120',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190121',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190122',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190123',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190124',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190125',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190126',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190127',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190128',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190129',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190130',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190131',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190201',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190202',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190203',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190204',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190205',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190206',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190207',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190208',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190209',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190210',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190211',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190212',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190213',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190214',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190215',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190216',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190217',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190218',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190219',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190220',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190221',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190222',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190223',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190224',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190225',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190226',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190227',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190228',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190301',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190302',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190303',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190304',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190305',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190306',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190307',1,'a0508',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190308',1,'a0508',null);

REM INSERTING into Reply
SET DEFINE OFF;
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,1,'작심 3일각','a0201','20190110');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,1,'작심 3일 실화네..','a0201','20190309');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,2,'하..','a0508','20190325');

REM INSERTING into Join
SET DEFINE OFF;
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (2,'a0101','20190310',17000);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (3,'a0201','20190327',15000);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (1,'a0201','20190105',300);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (2,'a0508','20190311',10000);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (1,'a0508','20190101',34600);

REM INSERTING into Member
SET DEFINE OFF;
Insert into Member (ID,name,password,tel,email,point,createDate) values ('a0508','이성용','a0508','01011110000','a0508@a.com',5000000,'20180508');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('a0101','류준열','a0101','01001010101','a0101@a.com',128000,'20190118');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('a0201','조던필','a0201','01002010201','a0101@a.com',128000,'20190327');

REM INSERTING into Together
SET DEFINE OFF;
INSERT INTO TOGETHER (TONO,TITLE,DESCRIPTION,THUMPATH,JOINPOINT,STARTDATE,ENDDATE,MINPERSON,MAXPERSON,JOINPERSON,REMAINPOINT,CREATORID,CREATEDATE,STATUS) VALUES (1,'헬스장가기','새해엔 운동 시작','img/syGymGo.jpg',5900,'20190108','20190308',10,100,98,0,'a0508','20190101',3);
INSERT INTO TOGETHER (TONO,TITLE,DESCRIPTION,THUMPATH,JOINPOINT,STARTDATE,ENDDATE,MINPERSON,MAXPERSON,JOINPERSON,REMAINPOINT,CREATORID,CREATEDATE,STATUS) VALUES (2,'하루 한번 자격증 기출문제 풀기','하루 한번 자격증 기출문제 풀기','img/syLicenseStudy.jpg',31000,'20190312','20190412',5,100,76,0,'a0101','20190310',2);
INSERT INTO TOGETHER (TONO,TITLE,DESCRIPTION,THUMPATH,JOINPOINT,STARTDATE,ENDDATE,MINPERSON,MAXPERSON,JOINPERSON,REMAINPOINT,CREATORID,CREATEDATE,STATUS) VALUES (3,'아침 8시전에 일어나기','아침형인간','img/syMorningHuman.jpg',30000,'20190402','20190502',2,100,60,0,'a0201','20190327',1);
--------------------------------------------------------
-- [허미희] 파일이 생성됨 - 금요일-3월-29-2019   
--------------------------------------------------------
REM INSERTING into Cert
SET DEFINE OFF;
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190227',403,'noise',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190228',403,'noise',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190301',403,'noise',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190302',403,'noise',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190320',403,'noise',null);
REM INSERTING into Reply
SET DEFINE OFF;
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,401,'아.. 인원 모집이 안되서 아쉽네요ㅜ','moon','20180725');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,401,'아 자식 서울대 갔으면 좋겠는데','noon','20180721');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,402,'꾹행님처럼 튼튼한 근육을 만들어보아유','ninano','20190228');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,402,'아.. 계단..,. 천국의 계단이야..','mongdal','20190301');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (3,402,'.. 우리 집은 롯*시그니아........................','monkey','20190324');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,403,'와우 꾸준히 챙겨먹고 돈도 벌고 키키','narara','20190402');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,403,'쉬운 목표닷','murmur','20190407');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (3,403,'기다리기 지겹당','ncis','20190408');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (4,403,'안뇽 여러분 !','most','20190409');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (5,403,'밥 좀 줭','noise','21090409');
REM INSERTING into Join
SET DEFINE OFF;
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (401,'moon','20180720',null);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (401,'noon','20180723',null);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (402,'ninano','20190405',null);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (401,'mongdal','20180724',null);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (402,'monkey','20190408',null);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (403,'narara','20190224',null);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (402,'murmur','20190402',null);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (402,'ncis','20190409',null);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (403,'most','20190223',null);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (403,'noise','20190226',null);
REM INSERTING into Member
SET DEFINE OFF;
Insert into Member (ID,name,password,tel,email,point,createDate) values ('moon','강백호','moon','010-2456-5896','moon@naver.com',37500,'20181119');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('noon','서태웅','noon','010-6521-4256','noon@daum.net',200000,'20190101');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('ninano','채소연','ninano','019-156-2458','ninano@empas.com',16000,'20181229');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('mongdal','채치수','mongdal','010-3216-1154','mongdal@empas.com',130000,'20190305');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('monkey','김수겸','monkey','010-8563-4698','monkey@yahoo.co.kr',6000,'20190314');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('narara','정대만','narara','010-4785-1256','narara@daum.net',20000,'20190328');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('murmur','윤대협','murmur','010-9365-1235','murmur@naver.com
',1000,'20181023');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('ncis','송태섭','ncis','010-7632-6521','ncis@daum.net',80000,'20181204');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('most','이명헌','most','010-9514-7532','most@naver.com',63000,'20190101');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('noise','이정환','noise','010-5214-2653','noise@naver.com',50000,'20190201');
REM INSERTING into Together
SET DEFINE OFF;
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values  (401,'수능 100일 기도합시다.','영험한 팔공산 갓바위에서 100일 동안 자녀 수능 100일 기도 하실 분 모집합니다.','img/mh_pray.jpg',100000,'20180725','20181101',7,10,6,0,'moon','20180720',0);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (402,'하루 두 번, 프로바이오틱스&프리바이오틱스 챙겨 먹기','아침: 프로바이오틱스 1알(포), 저녁: 프리바이오틱스 1알(포)
*참조*
프로바이오틱스가 변비를 일으키는 유해균의 증식을 억제하고 장의 연동운동도 활발해지며 역으로 장내유해균과 부패균의 증식억제와 장관면역의 활성화로 병원성 바이러스나 병원균이 배제돼 장관운동의 정상화에 따른 설사 증상에도 도움을 준다고 밝혔습니다.
프리바이오틱스 장점은 프로바이오틱스 생존을 향상,효과 지속, 살아남은 미생물로부터의 도움을 받을 수 있습니다','img/mh_biotics.jpg',10000,'20190410','20190419',50,100,null,0,'murmur','20190402',2);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (403,'1일 계단 10층 오르기','*계단 오르기 운동 효과*
1. 허리둘레 감소
2. 중성지방 수치 감소
3. 혈압 및 혈당 수치 감소
4. 심폐기능 강화
5. 하체 근력 향상

*바른 자세
1. 척추를 바로 세우고, 발 모양은 11자, 얄발 사이 보간은 주먹 하나 정도, 계단 디딜 때 1/2정도 올려 주며, 양팔은 가볍게 앞뒤로 흔들며 엉덩이를 밀어 주는 느낌으로 오르며, 약간 숨이 차고 땀이 나는 정도를 유지.
** 다리나 무릎 관절에 문제가 있다면 피할 것.','img/mh_stair.jpg',60000,'20190227','20190328',30,50,40,0,'noise','20190222',3);



--------------------------------------------------------
--  [조용철] 파일이 생성됨 - 월요일-4월-01-2019   
--------------------------------------------------------
REM INSERTING into Cert
SET DEFINE OFF;
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190301',300,'jwony04',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190101',301,'keunb95',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190201',302,'lchaey00',null);
REM INSERTING into Reply
SET DEFINE OFF;
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,300,'토마토 주스 좋아~!','jwony04','20190302');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,301,'달려가~~~~!!','keunb95','20190102');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,302,'손가락에 불이 난다.','lchaey00','20190202');
REM INSERTING into Join
SET DEFINE OFF;
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (300,'jwony04','20190415',2333);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (301,'keunb95','20181225',1546);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (302,'lchaey00','20190125',12808);
REM INSERTING into Member
SET DEFINE OFF;
Insert into Member (ID,name,password,tel,email,point,createDate) values ('jwony04','장원영','jwony04','010-8859-1195','won04@gmail.com',200000,'20190101');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('keunb95','권은비','keunb95','010-2759-4058','eun95@gmail.com',500000,'20180301');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('lchaey00','이채연','lchaey00','010-1004-8702','chae00@gmail.com',400000,'20180305');
REM INSERTING into Together
SET DEFINE OFF;
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (300,'매일아침 토마토 주스 한잔씩 먹기','아침마다 토마토 주스(구입 or 직접제작)를 마십니다.','img/Jyc_tomato.jpg',5000,'20190301','20190501',3,30,3,15000,'jwony04','20190220',2);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (301,'하루 1시간 운동하기','유산소 or 근력운동 등 하고싶은 활동적인 운동을 합니다.','img/Jyc_running.jpg',10000,'20190101','20190630',3,15,3,30000,'keunb95','20181215',2);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (302,'하루 10분 영어타자 연습하기','글로벌 시대에 맞게 영어타자 연습을 통해 외국문화와 원활한 소통을 해봅시다.','img/Jyc_typing.jpg',20000,'20190201','20190430',3,50,3,60000,'lchaey00','20190115',2);

--------------------------------------------------------
--  [형석] 파일이 생성됨 - 월요일-4월-01-2019   
--------------------------------------------------------
REM INSERTING into Cert
SET DEFINE OFF;
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190329',101,'deadNinja',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190329',102,'eternalLight',null);
Insert into Cert (createDate,toNo,memberID,filepath) values ('20190329',103,'fireLazer',null);
REM INSERTING into Reply
SET DEFINE OFF;
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (1,101,'같이 허쉴?','deadNinja','20190329');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (2,102,'사람이 너무 없네요ㅠ','eternalLight','20190329');
Insert into Reply (seq,toNo,Reply,creatorID,createDate) values (3,103,'Let it be','fireLazer','20190329');
REM INSERTING into Join
SET DEFINE OFF;
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (101,'deadNinja','20190329',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (102,'eternalLight','20190329',0);
Insert into Join (toNo,memberID,joinDate,rewardPoint) values (103,'fireLazer','20190329',0);
REM INSERTING into Member
SET DEFINE OFF;
Insert into Member (ID,name,password,tel,email,point,createDate) values ('deadNinja','제드','deadNinja','02-333-1111','deadNinja@gmail.com',100000,'20190218');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('eternalLight','럭스','eternalLight','02-332-1111','eternalLight@gmail.com',200000,'20190301');
Insert into Member (ID,name,password,tel,email,point,createDate) values ('fireLazer','빅토르','fireLazer','02-331-1111','fireLazer@gmail.com',300000,'20190325');
REM INSERTING into Together
SET DEFINE OFF;
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (101,'그림자 분신술','그림자 분신술 수행','img/yhs_shadowZED.png',10000,'20190329','20190501',5,20,3,30000,'deadNinja','20190319',1);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (102,'빛으로 강타해요!','빛으로 가루만들기','img/yhs_elementalLUX.jpg',15000,'20190329','20190501',5,20,3,45000,'eternalLight','20190319',1);
Insert into Together (toNo,title,description,thumPath,joinPoint,startDate,endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,Status) values (103,'영광스런 진화에 동참하라!','레이저로 즐거운 과학실험
','img/yhs_lazerVICTOR.PNG',20000,'20190329','20190501',5,20,3,60000,'fireLazer','20190319',1);




ALTER TABLE Member ENABLE VALIDATE PRIMARY KEY;
ALTER TABLE Cert ENABLE VALIDATE PRIMARY KEY;
ALTER TABLE Reply ENABLE VALIDATE PRIMARY KEY;
ALTER TABLE Join ENABLE VALIDATE PRIMARY KEY; 
ALTER TABLE Together ENABLE VALIDATE PRIMARY KEY;



ALTER TABLE Cert ENABLE VALIDATE CONSTRAINT FK_Join_TO_Cert_1;
ALTER TABLE Reply ENABLE VALIDATE CONSTRAINT FK_Together_TO_Reply_1;
ALTER TABLE Reply ENABLE VALIDATE CONSTRAINT FK_Member_TO_Reply_1;
ALTER TABLE Join ENABLE VALIDATE CONSTRAINT FK_Together_TO_Join_1 ;
ALTER TABLE Join ENABLE VALIDATE CONSTRAINT FK_Member_TO_Join_1 ;
ALTER TABLE Together ENABLE VALIDATE CONSTRAINT FK_Member_TO_Together_1 ;


UPDATE Member SET password='1';
DELETE FROM JOIN WHERE toNo IN ( SELECT toNo FROM Together WHERE status = 0);

COMMIT;
