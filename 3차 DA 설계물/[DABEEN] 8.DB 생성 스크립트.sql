/*데이터베이스 오브젝트 생성 [테이블, 제약조건(인덱스)]*/

CREATE TABLE `admin`
(
    `admin_num`    CHAR(10) NOT NULL
 COMMENT '관리자번호',
    `admin_name`    VARCHAR(30) NOT NULL
 COMMENT '관리자명',
    `address`    VARCHAR(300) NOT NULL
 COMMENT '주소',
    `phone_num`    VARCHAR(13) NOT NULL
 COMMENT '전화번호',
    `id`    VARCHAR(15) NOT NULL
 COMMENT '아이디',
    `pwd`    VARCHAR(15) NOT NULL
 COMMENT '비밀번호',
    `email`    VARCHAR(30) NOT NULL
 COMMENT '이메일'
)
 COMMENT = '관리자';

ALTER TABLE `admin`
 ADD CONSTRAINT `관리자_PK` PRIMARY KEY ( `admin_num` );

CREATE UNIQUE INDEX `관리자_PK` ON `admin`
( `admin_num` );

CREATE UNIQUE INDEX `관리자_UK` ON `admin`
( `id` );

CREATE TABLE `bskt`
(
    `bskt_num`    CHAR(10) NOT NULL
 COMMENT '장바구니번호',
    `bskt_user_num`    CHAR(10) NOT NULL
 COMMENT '장바구니사용자번호',
    `total_price`    DECIMAL(14,4) NOT NULL
 COMMENT '합계금액',
    `milege_use_whet`    CHAR(1) NOT NULL
 COMMENT '마일리지사용여부'
)
 COMMENT = '장바구니';

ALTER TABLE `bskt`
 ADD CONSTRAINT `bskt_PK` PRIMARY KEY ( `bskt_num` );

CREATE UNIQUE INDEX `bskt_PK` ON `bskt`
( `bskt_num` );

CREATE INDEX `bskt_FK_IX` ON `bskt`
( `bskt_user_num` );


CREATE TABLE `bskt_comp`
(
    `bskt_num`    CHAR(10) NOT NULL
 COMMENT '장바구니번호',
    `help_num`    CHAR(10) NOT NULL
 COMMENT '도움번호',
    `suppl_num`    CHAR(10) NOT NULL
 COMMENT '공급자번호',
    `indv_help_price`    DECIMAL(14,4) NOT NULL
 COMMENT '개별도움금액'
)
 COMMENT = '장바구니구성';

ALTER TABLE `bskt_comp`
 ADD CONSTRAINT `bskt_comp_PK` PRIMARY KEY ( `bskt_num`,`help_num`,`suppl_num` );

CREATE UNIQUE INDEX `bskt_comp_PK` ON `bskt_comp`
( `bskt_num`,`help_num`,`suppl_num` );

CREATE INDEX `bskt_comp_FK2_IX` ON `bskt_comp`
( `help_num`,`suppl_num` );


CREATE TABLE `category`
(
    `cat_num`    CHAR(4) NOT NULL
 COMMENT '카테고리번호',
    `cat_name`    VARCHAR(30) NOT NULL
 COMMENT '카테고리명',
    `cat_desc`    VARCHAR(300) NOT NULL
 COMMENT '카테고리설명',
    `high_cat_num`    CHAR(4)
 COMMENT '상위카테고리번호'
)
 COMMENT = '카테고리';

ALTER TABLE `category`
 ADD CONSTRAINT `category_PK` PRIMARY KEY ( `cat_num` );

CREATE UNIQUE INDEX `category_PK` ON `category`
( `cat_num` );

CREATE INDEX `category_FK_IX` ON `category`
( `high_cat_num` );


CREATE TABLE `chat`
(
    `chat_num`    CHAR(10) NOT NULL
 COMMENT '채팅번호',
    `chat_gen_dttm`    DATETIME NOT NULL
 COMMENT '채팅생성일시',
    `chat_end_dttm`    DATETIME NOT NULL DEFAULT '9999-12-31 23:59:59'
 COMMENT '채팅종료일시',
    `help_num`    CHAR(10) NOT NULL
 COMMENT '도움번호',
    `cnsr_num`    CHAR(10) NOT NULL
 COMMENT '수요자번호',
    `suppl_num`    CHAR(10) NOT NULL
 COMMENT '공급자번호'
)
 COMMENT = '채팅';

ALTER TABLE `chat`
 ADD CONSTRAINT `chat_PK` PRIMARY KEY ( `chat_num` );

CREATE UNIQUE INDEX `chat_PK` ON `chat`
( `chat_num` );

CREATE INDEX `chat_FK1_IX` ON `chat`
( `help_num` );

CREATE INDEX `chat_FK2_IX` ON `chat`
( `cnsr_num` );

CREATE INDEX `chat_FK3_IX` ON `chat`
( `suppl_num` );


CREATE TABLE `fqa`
(
    `fqa_num`    CHAR(10) NOT NULL
 COMMENT '자주묻는질문번호',
    `quest_pstn_dttm`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
 COMMENT '질문게시일시',
    `title`    VARCHAR(60) NOT NULL
 COMMENT '제목',
    `rply_cont`    VARCHAR(1500) NOT NULL
 COMMENT '답변내용',
    `fqa_rgistrant_num`    CHAR(10) NOT NULL
 COMMENT '자주묻는질문등록자번호'
)
 COMMENT = '자주묻는질문';

ALTER TABLE `fqa`
 ADD CONSTRAINT `자주묻는질문_PK` PRIMARY KEY ( `fqa_num` );

CREATE UNIQUE INDEX `자주묻는질문_PK` ON `fqa`
( `fqa_num` );

CREATE INDEX `fqa_FK_IX` ON `fqa`
( `fqa_rgistrant_num` );


CREATE TABLE `help`
(
    `help_num`    CHAR(10) NOT NULL
 COMMENT '도움번호',
    `help_pstn_dttm`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
 COMMENT '도움게시일시',
    `cat_num`    CHAR(4) NOT NULL
 COMMENT '카테고리번호',
    `cnsr_num`    CHAR(10) NOT NULL
 COMMENT '수요자번호',
    `title`    VARCHAR(60) NOT NULL
 COMMENT '제목',
    `exec_loc`    VARCHAR(300) NOT NULL
 COMMENT '이행위치',
    `price`    DECIMAL(14,4) NOT NULL
 COMMENT '금액',
    `pref_suppl_num`    DECIMAL(2) NOT NULL
 COMMENT '희망공급자수',
    `pref_help_exec_dttm`    DATETIME NOT NULL
 COMMENT '희망도움이행일시',
    `help_aply_cls_dttm`    DATETIME NOT NULL
 COMMENT '도움신청마감일시',
    `cont`    VARCHAR(3000) NOT NULL
 COMMENT '내용',
    `help_aprv_whet`    CHAR(1) NOT NULL
 COMMENT '도움승인여부',
    `exec_sgg_name`    VARCHAR(30) NOT NULL
 COMMENT '이행시군구명'
)
 COMMENT = '도움';

ALTER TABLE `help`
 ADD CONSTRAINT `help_PK` PRIMARY KEY ( `help_num` );

CREATE UNIQUE INDEX `help_PK` ON `help`
( `help_num` );

CREATE INDEX `help_FK1_IX` ON `help`
( `cat_num` );

CREATE INDEX `help_FK2_IX` ON `help`
( `cnsr_num` );


CREATE TABLE `help_pic`
(
    `help_num`    CHAR(10) NOT NULL
 COMMENT '도움번호',
    `pic_ornu`    DECIMAL(2) NOT NULL
 COMMENT '사진순번',
    `path`    VARCHAR(300) NOT NULL
 COMMENT '경로명'
)
 COMMENT = '도움사진';

ALTER TABLE `help_pic`
 ADD CONSTRAINT `help_pic_PK` PRIMARY KEY ( `help_num`,`pic_ornu` );

CREATE UNIQUE INDEX `help_pic_PK` ON `help_pic`
( `help_num`,`pic_ornu` );


CREATE TABLE `help_suppl_comp`
(
    `help_num`    CHAR(10) NOT NULL
 COMMENT '도움번호',
    `suppl_num`    CHAR(10) NOT NULL
 COMMENT '공급자번호',
    `help_aprv_whet`    CHAR(1) NOT NULL
 COMMENT '도움승인여부',
    `aprv_dttm`    DATETIME
 COMMENT '승인일시',
    `ast_dttm`    DATETIME
 COMMENT '평가일시',
    `rate`    DECIMAL(3,2)
 COMMENT '평점',
    `ast_cont`    VARCHAR(1500)
 COMMENT '평가내용'
)
 COMMENT = '도움공급자구성';

ALTER TABLE `help_suppl_comp`
 ADD CONSTRAINT `help_suppl_comp_PK` PRIMARY KEY ( `help_num`,`suppl_num` );

CREATE UNIQUE INDEX `help_suppl_comp_PK` ON `help_suppl_comp`
( `help_num`,`suppl_num` );

CREATE INDEX `help_suppl_comp_FK2_IX` ON `help_suppl_comp`
( `suppl_num` );


CREATE TABLE `mileage_use_hist`
(
    `user_num`    CHAR(10) NOT NULL
 COMMENT '사용자번호',
    `milege_use_dttm`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
 COMMENT '마일리지사용일시',
    `use_type`    CHAR(1) NOT NULL
 COMMENT '사용구분',
    `use_price`    DECIMAL(14,4) NOT NULL
 COMMENT '사용금액',
    `bskt_num`    CHAR(10)
 COMMENT '장바구니번호',
    `wdrl_acct_num`    VARCHAR(30)
 COMMENT '인출계좌번호',
    `pymt_num`    CHAR(10)
 COMMENT '결제번호'
)
 COMMENT = '마일리지사용이력';

ALTER TABLE `mileage_use_hist`
 ADD CONSTRAINT `mileage_use_hist_PK` PRIMARY KEY ( `user_num`,`milege_use_dttm` );

CREATE UNIQUE INDEX `mileage_use_hist_PK` ON `mileage_use_hist`
( `user_num`,`milege_use_dttm` );

CREATE INDEX `mileage_use_hist_FK2_IX` ON `mileage_use_hist`
( `bskt_num` );

CREATE INDEX `mileage_use_hist_FK3_IX` ON `mileage_use_hist`
( `pymt_num` );


CREATE TABLE `msg`
(
    `chat_num`    CHAR(10) NOT NULL
 COMMENT '채팅번호',
    `msg_writer_num`    CHAR(10) NOT NULL
 COMMENT '메시지작성자번호',
    `msg_send_dttm`    DATETIME NOT NULL
 COMMENT '메시지전송일시',
    `cont`    VARCHAR(3000) NOT NULL
 COMMENT '내용'
)
 COMMENT = '메시지';

ALTER TABLE `msg`
 ADD CONSTRAINT `msg_PK` PRIMARY KEY ( `chat_num`,`msg_writer_num`,`msg_send_dttm` );

CREATE UNIQUE INDEX `msg_PK` ON `msg`
( `chat_num`,`msg_writer_num`,`msg_send_dttm` );


CREATE TABLE `post`
(
    `post_num`    CHAR(10) NOT NULL
 COMMENT '게시글번호',
    `post_type`    CHAR(1) NOT NULL
 COMMENT '게시글구분',
    `title`    VARCHAR(60) NOT NULL
 COMMENT '제목',
    `quest_pstn_dttm`    DATETIME DEFAULT CURRENT_TIMESTAMP
 COMMENT '질문게시일시',
    `quester_num`    CHAR(10)
 COMMENT '질문자번호',
    `rply_pstn_dttm`    DATETIME DEFAULT CURRENT_TIMESTAMP
 COMMENT '답변게시일시',
    `rplyer_num`    CHAR(10)
 COMMENT '답변자번호',
    `quest_post_num`    CHAR(10)
 COMMENT '질문게시글번호'
)
 COMMENT = '게시글';

ALTER TABLE `post`
 ADD CONSTRAINT `게시글_PK` PRIMARY KEY ( `post_num` );

CREATE UNIQUE INDEX `게시글_PK` ON `post`
( `post_num` );

CREATE INDEX `post_FK1_IX` ON `post`
( `quester_num` );

CREATE INDEX `post_FK2_IX` ON `post`
( `rplyer_num` );

CREATE INDEX `post_FK3_IX` ON `post`
( `quest_post_num` );


CREATE TABLE `pymt`
(
    `pymt_num`    CHAR(10) NOT NULL
 COMMENT '결제번호',
    `pymt_dttm`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
 COMMENT '결제일시',
    `pymt_mthd_type`    CHAR(1) NOT NULL
 COMMENT '결제수단구분',
    `pymt_price`    DECIMAL(14,4) NOT NULL
 COMMENT '결제금액',
    `refd_whet`    CHAR(1) NOT NULL
 COMMENT '환불여부',
    `refd_dttm`    DATETIME
 COMMENT '환불일시'
)
 COMMENT = '결제';

ALTER TABLE `pymt`
 ADD CONSTRAINT `pymt_PK` PRIMARY KEY ( `pymt_num` );

CREATE UNIQUE INDEX `pymt_PK` ON `pymt`
( `pymt_num` );


CREATE TABLE `user`
(
    `user_num`    CHAR(10) NOT NULL
 COMMENT '사용자번호',
    `user_name`    VARCHAR(30) NOT NULL
 COMMENT '사용자명',
    `birth_date`    CHAR(8) NOT NULL
 COMMENT '생년월일',
    `address`    VARCHAR(300) NOT NULL
 COMMENT '주소',
    `phone_num`    VARCHAR(13) NOT NULL
 COMMENT '전화번호',
    `id`    VARCHAR(15) NOT NULL
 COMMENT '아이디',
    `pwd`    VARCHAR(15) NOT NULL
 COMMENT '비밀번호',
    `email`    VARCHAR(30) NOT NULL
 COMMENT '이메일',
    `nickname`    VARCHAR(30) NOT NULL
 COMMENT '닉네임',
    `suppl_whet`    CHAR(1) NOT NULL
 COMMENT '공급자여부',
    `blon_sgg_name`    VARCHAR(30) NOT NULL
 COMMENT '소속시군구명',
    `pic_path`    VARCHAR(300)
 COMMENT '사진경로명',
    `rrn_rear`    CHAR(7)
 COMMENT '주민등록번호뒷자리',
    `avg_rate`    DECIMAL(3,2)
 COMMENT '평균평점',
    `own_milege`    DECIMAL(14,4)
 COMMENT '보유마일리지'
)
 COMMENT = '사용자';

ALTER TABLE `user`
 ADD CONSTRAINT `user_PK` PRIMARY KEY ( `user_num` );

CREATE UNIQUE INDEX `user_PK` ON `user`
( `user_num` );

CREATE UNIQUE INDEX `user_UK` ON `user`
( `id` );

/*데이터베이스 오브젝트 생성 [제약조건(외래키)]*/

ALTER TABLE `bskt`
 ADD CONSTRAINT `bskt_FK` FOREIGN KEY ( `bskt_user_num` )
 REFERENCES user (`user_num` );



ALTER TABLE `bskt_comp`
 ADD CONSTRAINT `bskt_comp_FK1` FOREIGN KEY ( `bskt_num` )
 REFERENCES bskt (`bskt_num` );

ALTER TABLE `bskt_comp`
 ADD CONSTRAINT `bskt_comp_FK2` FOREIGN KEY ( `suppl_num`,`help_num` )
 REFERENCES help_suppl_comp (`help_num`,`suppl_num` );


ALTER TABLE `category`
 ADD CONSTRAINT `category_FK` FOREIGN KEY ( `high_cat_num` )
 REFERENCES category (`cat_num` );


ALTER TABLE `chat`
 ADD CONSTRAINT `chat_FK1` FOREIGN KEY ( `help_num` )
 REFERENCES help (`help_num` );

ALTER TABLE `chat`
 ADD CONSTRAINT `chat_FK2` FOREIGN KEY ( `cnsr_num` )
 REFERENCES user (`user_num` );

ALTER TABLE `chat`
 ADD CONSTRAINT `chat_FK3` FOREIGN KEY ( `suppl_num` )
 REFERENCES user (`user_num` );



ALTER TABLE `fqa`
 ADD CONSTRAINT `fqa_FK` FOREIGN KEY ( `fqa_rgistrant_num` )
 REFERENCES admin (`admin_num` );



ALTER TABLE `help`
 ADD CONSTRAINT `help_FK2` FOREIGN KEY ( `cnsr_num` )
 REFERENCES user (`user_num` );

ALTER TABLE `help`
 ADD CONSTRAINT `help_FK1` FOREIGN KEY ( `cat_num` )
 REFERENCES category (`cat_num` );



ALTER TABLE `help_pic`
 ADD CONSTRAINT `help_pic_FK` FOREIGN KEY ( `help_num` )
 REFERENCES help (`help_num` );



ALTER TABLE `help_suppl_comp`
 ADD CONSTRAINT `help_suppl_comp_FK1` FOREIGN KEY ( `help_num` )
 REFERENCES help (`help_num` );

ALTER TABLE `help_suppl_comp`
 ADD CONSTRAINT `help_suppl_comp_FK2` FOREIGN KEY ( `suppl_num` )
 REFERENCES user (`user_num` );



ALTER TABLE `mileage_use_hist`
 ADD CONSTRAINT `mileage_use_hist_FK1` FOREIGN KEY ( `user_num` )
 REFERENCES user (`user_num` );

ALTER TABLE `mileage_use_hist`
 ADD CONSTRAINT `mileage_use_hist_FK2` FOREIGN KEY ( `bskt_num` )
 REFERENCES bskt (`bskt_num` );

ALTER TABLE `mileage_use_hist`
 ADD CONSTRAINT `mileage_use_hist_FK3` FOREIGN KEY ( `pymt_num` )
 REFERENCES pymt (`pymt_num` );



ALTER TABLE `msg`
 ADD CONSTRAINT `msg_FK1` FOREIGN KEY ( `chat_num` )
 REFERENCES chat (`chat_num` );

ALTER TABLE `msg`
 ADD CONSTRAINT `msg_FK2` FOREIGN KEY ( `msg_writer_num` )
 REFERENCES user (`user_num` );



ALTER TABLE `post`
 ADD CONSTRAINT `post_FK1` FOREIGN KEY ( `quester_num` )
 REFERENCES user (`user_num` );

ALTER TABLE `post`
 ADD CONSTRAINT `post_FK2` FOREIGN KEY ( `rplyer_num` )
 REFERENCES admin (`admin_num` );

ALTER TABLE `post`
 ADD CONSTRAINT `post_FK3` FOREIGN KEY ( `quest_post_num` )
 REFERENCES post (`post_num` );



ALTER TABLE `pymt`
 ADD CONSTRAINT `pymt_FK` FOREIGN KEY ( `pymt_num` )
 REFERENCES bskt (`bskt_num` );

