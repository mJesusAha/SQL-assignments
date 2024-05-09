-- Так как множество в отличие от мультимножества не подразумевает повторяющихся элементов,
--  я использовала EXCEPT и UNION
-- Ecли бы это было мультимножество, выбором было бы EXCEPT ALL и UNION ALL
(SELECT * FROM A
    EXCEPT
SELECT * FROM B)
    UNION
(SELECT * FROM B
    EXCEPT
SELECT * FROM A)