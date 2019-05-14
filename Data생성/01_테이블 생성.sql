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

COMMENT ON COLUMN OperInfo.lastProcDate IS '����ó���� �� ������.';

COMMENT ON COLUMN OperInfo.OperDate IS '�۾��� �� ��¥�� �ð�';CREATE SEQUENCE  SeqForPK  INCREMENT BY 1 START WITH 800 CACHE 20 NOCYCLE ;

CREATE TABLE Member (
	ID	VARCHAR2(20)		NOT NULL,
	name	VARCHAR2(50)		NULL,
	password	VARCHAR2(20)		NULL,
	tel	VARCHAR2(13)		NULL,
	email	VARCHAR2(30)		NULL,
	point	NUMBER	DEFAULT 0	NULL,
	createDate	VARCHAR2(8)		NULL
);

COMMENT ON COLUMN Member.tel IS '010-8787-9991���·� �Է�';

COMMENT ON COLUMN Member.point IS 'ȸ���� ���� ���� ����Ʈ ���̴�.';

COMMENT ON COLUMN Member.createDate IS '20190403 ����';



CREATE TABLE Join (
	toNo	NUMBER		NOT NULL,
	memberID	VARCHAR2(20)		NOT NULL,
	joinDate	VARCHAR2(20)		NULL,
	rewardPoint	NUMBER		NULL
);

COMMENT ON COLUMN Join.joinDate IS '20190402 ����';
COMMENT ON COLUMN Join.rewardPoint IS '��������Ʈ�� �����ڰ� �ش� ���Դ����� Ȯ���ϰ� �Ǵ�  �� ����Ʈ�� ���Դ��� ����� ������ ��� ������Ʈ�ȴ�.';



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

COMMENT ON COLUMN Together.toNo IS 'PK�� ���� ������ �ִ� ��ȣ';

COMMENT ON COLUMN Together.joinPoint IS '�δ� ��������Ʈ��. �� ����Ʈ�� ������� ��������Ʈ ����.';

COMMENT ON COLUMN Together.startDate IS '20190402 ���·� ����.';

COMMENT ON COLUMN Together.endDate IS '20190402���·� ����.';

COMMENT ON COLUMN Together.minPerson IS '�����ο��� �ּ��ο��� ��ġ�� ���ϸ� �� ���Դ��� ����.';

COMMENT ON COLUMN Together.maxPerson IS '�����ο��� �ִ��ο��� �ʰ��� �� ����.';

COMMENT ON COLUMN Together.joinPerson IS '���� ������ �ο���';

COMMENT ON COLUMN Together.remainPoint IS '�����ð��� �Ǹ� �� ���� �ٽ� ���Ǿ� Update.';

COMMENT ON COLUMN Together.createDate IS '20190402���·� ����.';

COMMENT ON COLUMN Together.status IS '0: ���ĵ�  1. ������  2: ������  3: ����';



CREATE TABLE Cert (
	toNo	NUMBER		NOT NULL,
	memberID	VARCHAR2(20)		NOT NULL,
	createDate	VARCHAR2(8)		NOT NULL,
	filePath	VARCHAR2(100)		NULL
);

COMMENT ON COLUMN Cert.createDate IS '����° PK';

COMMENT ON COLUMN Cert.toNo IS 'ù��° PK';

COMMENT ON COLUMN Cert.memberID IS '�ι�° PK';



CREATE TABLE Reply (
	ToNo	NUMBER		NOT NULL,
	seq	NUMBER		NOT NULL,
	Reply	VARCHAR2(500)		NULL,
	creatorID	VARCHAR2(20)		NOT NULL,
	createDate	VARCHAR2(20)		NULL
);

COMMENT ON COLUMN Reply.seq IS '�ι�° PK. ���Դ��� 1���� �����Ѵ�.';

COMMENT ON COLUMN Reply.ToNo IS 'ù��°PK';

COMMENT ON COLUMN Reply.createDate IS '20190402 ����';

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

