DROP TABLE Cert;
DROP TABLE Join;
DROP TABLE Reply;
DROP TABLE Together;
DROP TABLE Member;
DROP SEQUENCE  SeqForPK;
DROP TABLE OperInfo;

CREATE TABLE OperInfo (
	lastProcDate	VARCHAR2(8)		NOT NULL,
	OperDate		VARCHAR2(8)		NOT NULL
);

COMMENT ON COLUMN OperInfo.lastProcDate IS '인증처리를 한 최종일.';

COMMENT ON COLUMN OperInfo.OperDate IS '작업을 한 날짜와 시간';CREATE SEQUENCE  SeqForPK  INCREMENT BY 1 START WITH 800 CACHE 20 NOCYCLE ;

CREATE TABLE Member (
	ID	VARCHAR2(20)		NOT NULL,
	name	VARCHAR2(50)		NULL,
	password	VARCHAR2(20)		NULL,
	tel	VARCHAR2(13)		NULL,
	email	VARCHAR2(30)		NULL,
	point	NUMBER	DEFAULT 0	NULL,
	createDate	VARCHAR2(8)		NULL
);

COMMENT ON COLUMN Member.tel IS '010-8787-9991형태로 입력';

COMMENT ON COLUMN Member.point IS '회원의 현재 보유 포인트 값이다.';

COMMENT ON COLUMN Member.createDate IS '20190403 형태';



CREATE TABLE Join (
	toNo	NUMBER		NOT NULL,
	memberID	VARCHAR2(20)		NOT NULL,
	joinDate	VARCHAR2(20)		NULL,
	rewardPoint	NUMBER		NULL
);

COMMENT ON COLUMN Join.joinDate IS '20190402 형태';
COMMENT ON COLUMN Join.rewardPoint IS '보상포인트는 참여자가 해당 투게더에서 확보하게 되는  총 포인트로 투게더가 종료될 때까지 계속 업데이트된다.';



CREATE TABLE Together (
	toNo	NUMBER		NOT NULL,
	title	VARCHAR2(100)		NULL,
	description	VARCHAR2(2000)		NULL,
	thumPath	VARCHAR2(100)		NULL,
	joinPoint	NUMBER	DEFAULT 0	NULL,
	startDate	VARCHAR2(8)		NULL,
	endDate	VARCHAR2(8)		NULL,
	minPerson	NUMBER		NULL,
	maxPerson	NUMBER		NULL,
	joinPerson	NUMBER		NULL,
	remainPoint	NUMBER	DEFAULT 0	NULL,
	creatorID	VARCHAR2(20)		NOT NULL,
	createDate	VARCHAR2(8)		NULL,
	status	NUMBER		NULL
);

COMMENT ON COLUMN Together.toNo IS 'PK를 위해 생성해 주는 번호';

COMMENT ON COLUMN Together.joinPoint IS '인당 참여포인트임. 이 포인트를 재원으로 보상포인트 지급.';

COMMENT ON COLUMN Together.startDate IS '20190402 형태로 저장.';

COMMENT ON COLUMN Together.endDate IS '20190402형태로 저장.';

COMMENT ON COLUMN Together.minPerson IS '참여인원이 최소인원에 미치지 못하면 이 투게더는 폭파.';

COMMENT ON COLUMN Together.maxPerson IS '참여인원이 최대인원을 초과할 수 없다.';

COMMENT ON COLUMN Together.joinPerson IS '실제 참여한 인원수';

COMMENT ON COLUMN Together.remainPoint IS '인증시간이 되면 이 값이 다시 계산되어 Update.';

COMMENT ON COLUMN Together.createDate IS '20190402형태로 저장.';

COMMENT ON COLUMN Together.status IS '0: 폭파됨  1. 모집중  2: 진행중  3: 종료';



CREATE TABLE Cert (
	toNo	NUMBER		NOT NULL,
	memberID	VARCHAR2(20)		NOT NULL,
	createDate	VARCHAR2(8)		NOT NULL,
	filePath	VARCHAR2(100)		NULL
);

COMMENT ON COLUMN Cert.createDate IS '세번째 PK';

COMMENT ON COLUMN Cert.toNo IS '첫번째 PK';

COMMENT ON COLUMN Cert.memberID IS '두번째 PK';



CREATE TABLE Reply (
	ToNo	NUMBER		NOT NULL,
	seq	NUMBER		NOT NULL,
	Reply	VARCHAR2(500)		NULL,
	creatorID	VARCHAR2(20)		NOT NULL,
	createDate	VARCHAR2(20)		NULL
);

COMMENT ON COLUMN Reply.seq IS '두번째 PK. 투게더별 1부터 시작한다.';

COMMENT ON COLUMN Reply.ToNo IS '첫번째PK';

COMMENT ON COLUMN Reply.createDate IS '20190402 형태';

ALTER TABLE Member ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
	ID
);

ALTER TABLE Join ADD CONSTRAINT PK_JOIN PRIMARY KEY (
	toNo,
	memberID
);

ALTER TABLE Together ADD CONSTRAINT PK_TOGETHER PRIMARY KEY (
	toNo
);

ALTER TABLE Cert ADD CONSTRAINT PK_CERT PRIMARY KEY (
	toNo,
	memberID, 
  createDate
);

ALTER TABLE Reply ADD CONSTRAINT PK_REPLY PRIMARY KEY (
	ToNo,
	seq
);

ALTER TABLE Join ADD CONSTRAINT FK_Together_TO_Join_1 FOREIGN KEY (
	toNo
)
REFERENCES Together (
	toNo
);

ALTER TABLE Join ADD CONSTRAINT FK_Member_TO_Join_1 FOREIGN KEY (
	memberID
)
REFERENCES Member (
	ID
);

ALTER TABLE Together ADD CONSTRAINT FK_Member_TO_Together_1 FOREIGN KEY (
	creatorID
)
REFERENCES Member (
	ID
);

ALTER TABLE Cert ADD CONSTRAINT FK_Join_TO_Cert_1 FOREIGN KEY (
	toNo,
  memberID
)
REFERENCES Join (
	toNo,
  memberID
);

ALTER TABLE Reply ADD CONSTRAINT FK_Together_TO_REPLY_1 FOREIGN KEY (
	ToNo
)
REFERENCES Together (
	toNo
);

ALTER TABLE Reply ADD CONSTRAINT FK_Member_TO_REPLY_1 FOREIGN KEY (
	creatorID
)
REFERENCES Member (
	ID
);

