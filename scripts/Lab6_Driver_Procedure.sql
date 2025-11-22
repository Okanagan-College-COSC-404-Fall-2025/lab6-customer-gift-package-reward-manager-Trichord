SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE SHOW_GIFTS AS
v_i NUMBER := 1;
v_max_rows NUMBER := 5;
BEGIN
    CUSTOMER_MANAGER.ASSIGN_GIFTS_TO_ALL;

    FOR r in (SELECT * FROM CUSTOMER_REWARDS
            LEFT JOIN GIFT_CATALOG USING(GIFT_ID)
            ORDER BY REWARD_ID) LOOP
            DBMS_OUTPUT.PUT('Reward ID: ' || r.REWARD_ID || ', Customer email: ' || r.CUSTOMER_EMAIL || ', Reward Date: ' || r.REWARD_DATE || ', Gift ID: ' || r.GIFT_ID || ', ');
              
                IF r.GIFT_ID IS NOT NULL THEN
                    FOR i IN 1 .. r.GIFTS.COUNT - 1 LOOP
                        DBMS_OUTPUT.PUT('Gift: ' || r.GIFTS(i) || ', ');
                    END LOOP;
                    DBMS_OUTPUT.PUT_LINE('Gift: ' || r.GIFTS(r.GIFTS.COUNT));
                ELSE
                    DBMS_OUTPUT.PUT_LINE('No Gifts');
                END IF;

            v_i := v_i + 1;
            EXIT WHEN v_i > v_max_rows;
    END LOOP;
END SHOW_GIFTS;
/

BEGIN
    SHOW_GIFTS;
END;
/
