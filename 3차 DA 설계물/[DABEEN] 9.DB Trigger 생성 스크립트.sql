/*USER - own_mileage[SUBSTRACTION]*/

-- CREATE TRIGGER mileage_use_hist_IS_TR (마일리지 사용이력 발생시 사용자의 마일리지 소유액을 차감하는 트리거)
DELIMITER $$
CREATE TRIGGER mileage_use_hist_IS_TR AFTER INSERT ON dabeen.mileage_use_hist
FOR EACH ROW
BEGIN
DECLARE old_mileage DECIMAL(14,4);
DECLARE old_price DECIMAL(14,4);
SELECT own_mileage,user_price INTO old_mileage,old_price FROM (SELECT * FROM user u WHERE u.user_num = new.user_num) a, mileage_use_hist mh WHERE a.user_num = mh.user_num;
UPDATE user SET own_mileage = old_mileage-old_price WHERE user.user_num = new.user_num;
END $$

-- CREATE TRIGGER mileage_use_hist_UP_TR (마일리지 사용이력 발생시 사용자의 마일리지 소유액을 차감하는 트리거)
DELIMITER $$
CREATE TRIGGER mileage_use_hist_UP_TR AFTER UPDATE ON dabeen.mileage_use_hist
FOR EACH ROW
BEGIN
DECLARE old_mileage DECIMAL(14,4);
DECLARE old_price DECIMAL(14,4);
SELECT own_mileage,user_price INTO old_mileage,old_price FROM (SELECT * FROM user u WHERE u.user_num = new.user_num) a, mileage_use_hist mh WHERE a.user_num = mh.user_num;
UPDATE user SET own_mileage = old_mileage-old_price WHERE user.user_num = new.user_num;
END $$

/*USER - own_mileage[ADD]*/

-- CREATE TRIGGER bskt_comp_mileage_IS_TR (장바구니 구성에 INSERT 발생 시, 장바구니 구성에 존재하는 공급자의 마일리지 잔액을 더해주는 트리거)
DELIMITER $$
CREATE TRIGGER bskt_comp_mileage_IS_TR AFTER INSERT ON dabeen.bskt_comp
FOR EACH ROW
BEGIN
	DECLARE new_indv_help_price DECIMAL(14,4);
    DECLARE old_mileage DECIMAL(14,4);
    SET new_indv_help_price = new.indv_help_price;
    SELECT own_mileage INTO old_mileage FROM (SELECT * FROM bskt_comp bc WHERE bc.bskt_num = new.bskt_num AND bc.help_num = new.help_num AND bc.suppl_num = new.suppl_num) a, user b WHERE a.suppl_num = b.user_num;
    UPDATE USER u SET own_mileage = old_mileage + new_indv_help_price WHERE user_num = new.suppl_num;  
END $$


-- CREATE TRIGGER bskt_comp_mileage_UP_TR (장바구니 구성에 UPDATE 발생 시, 장바구니 구성에 존재하는 공급자의 마일리지 잔액을 더해주는 트리거)
DELIMITER $$
CREATE TRIGGER bskt_comp_mileage_UP_TR AFTER UPDATE ON dabeen.bskt_comp
FOR EACH ROW
BEGIN
	DECLARE new_indv_help_price DECIMAL(14,4);
    DECLARE old_mileage DECIMAL(14,4);
    SET new_indv_help_price = new.indv_help_price;
    SELECT own_mileage INTO old_mileage FROM (SELECT * FROM bskt_comp bc WHERE bc.bskt_num = new.bskt_num AND bc.help_num = new.help_num AND bc.suppl_num = new.suppl_num) a, user b WHERE a.suppl_num = b.user_num;
    UPDATE USER u SET own_mileage = old_mileage + new_indv_help_price WHERE user_num = new.suppl_num;  
END $$

/*USER - avg_rate*/

-- CREATE TRIGGER help_suppl_comp_rate_IS_TR (도움 공급자 구성에서 평점이 매겨질 때 공급자의 평균 평점을 갱신하는 트리거)
-- TRIGGER에 반응한 row의 rate 값이 0보다 큰 경우에만 평균평점 변경을 반영합니다.
DELIMITER $$
CREATE TRIGGER help_suppl_comp_rate_IS_TR AFTER INSERT ON dabeen.help_suppl_comp
FOR EACH ROW
BEGIN
	DECLARE new_avg_rate DECIMAL(3,2);
	IF new.rate > 0
	THEN 
	SELECT ROUND(AVG(rate),2) INTO new_avg_rate FROM (SELECT * FROM user u WHERE u.user_num = new.suppl_num) a, help_suppl_comp sp WHERE a.user_num = sp.suppl_num;
	UPDATE user SET avg_rate = new_avg_rate WHERE user.user_num = new.suppl_num;
	END IF;
END $$

-- CREATE TRIGGER help_suppl_comp_rate_UP_TR (도움 공급자 구성에서 평점이 매겨질 때 공급자의 평균 평점을 갱신하는 트리거)
-- TRIGGER에 반응한 row의 rate 값이 0보다 큰 경우에만 평균평점 변경을 반영합니다.
DELIMITER $$
CREATE TRIGGER help_suppl_comp_rate_UP_TR AFTER UPDATE ON dabeen.help_suppl_comp
FOR EACH ROW
BEGIN
	DECLARE new_avg_rate DECIMAL(3,2);
	IF new.rate > 0
	THEN 
	SELECT ROUND(AVG(rate),2) INTO new_avg_rate FROM (SELECT * FROM user u WHERE u.user_num = new.suppl_num) a, help_suppl_comp sp WHERE a.user_num = sp.suppl_num;
	UPDATE user SET avg_rate = new_avg_rate WHERE user.user_num = new.suppl_num;
	END IF;
END $$


/*HELP- help_aprv_whet*/

-- CREATE TRIGGER help_suppl_comp_aprv_IS_TR (도음 공급자 구성에서 임의의 도움이 완료된 경우 상위 도움 엔터티에 마감되었음을 반영하는 트리거)
DELIMITER $$
CREATE TRIGGER help_suppl_comp_aprv_IS_TR AFTER INSERT ON dabeen.help_suppl_comp
FOR EACH ROW
BEGIN
	IF new.help_aprv_whet = 'y'
	THEN 
	UPDATE help h SET help_aprv_whet = 'y' WHERE h.help_num = new.help_num;
	END IF;
END $$

-- CREATE TRIGGER help_suppl_comp_aprv_UP_TR (도음 공급자 구성에서 임의의 도움이 완료된 경우 상위 도움 엔터티에 마감되었음을 반영하는 트리거)
DELIMITER $$
CREATE TRIGGER help_suppl_comp_aprv_UP_TR AFTER UPDATE ON dabeen.help_suppl_comp
FOR EACH ROW
BEGIN
	IF new.help_aprv_whet = 'y'
	THEN 
	UPDATE help h SET help_aprv_whet = 'y' WHERE h.help_num = new.help_num;
	END IF;
END $$

/*BSKT - total_price*/

-- CREATE TRIGGER bskt_comp_price_IS_TR (장바구니 구성에 INSERT 발생 시, 장바구니 구성에 존재하는 특정 장바구니의 개별 도움가격의 합계를 계산하는 트리거)
DELIMITER $$
CREATE TRIGGER bskt_comp_price_IS_TR AFTER INSERT ON dabeen.bskt_comp
FOR EACH ROW
BEGIN
	DECLARE new_total_price DECIMAL(14,4);
	SELECT ROUND(SUM(indv_help_price),4) INTO new_total_price FROM (SELECT * FROM bskt_comp bc WHERE bc.bskt_num = new.bskt_num) a;
	UPDATE bskt SET total_price = new_total_price WHERE bskt_num = new.bskt_num;
END $$

-- CREATE TRIGGER bskt_comp_price_UP_TR (장바구니 구성에 INSERT 발생 시, 장바구니 구성에 존재하는 특정 장바구니의 개별 도움가격의 합계를 계산하는 트리거)
DELIMITER $$
CREATE TRIGGER bskt_comp_price_UP_TR AFTER UPDATE ON dabeen.bskt_comp
FOR EACH ROW
BEGIN
	DECLARE new_total_price DECIMAL(14,4);
	SELECT ROUND(SUM(indv_help_price),4) INTO new_total_price FROM (SELECT * FROM bskt_comp bc WHERE bc.bskt_num = new.bskt_num) a;
	UPDATE bskt SET total_price = new_total_price WHERE bskt_num = new.bskt_num;
END $$

-- CREATE TRIGGER help_aprv_whet_IS_TR (도움에 INSERT 발생 시, 도움 승인 여부를 N으로 자동 삽입하는 트리거)
DELIMITER $$
CREATE TRIGGER help_aprv_whet_IS_TR AFTER INSERT ON dabeen.help
FOR EACH ROW
BEGIN
	UPDATE help SET help_aprv_whet = 'n' WHERE help_num = new.help_num;
END $$


