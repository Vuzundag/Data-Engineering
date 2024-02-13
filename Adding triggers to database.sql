-- I will create and implemented MySQL triggers to automatically update a supplier_audit table whenever changes occur in the t_sup_supplier table. 
-- By that way, any modifications to supplier records are tracked to capture the sup_id and the date of the change (last_modified). 

-- before beginning, set safe_updates = 1 to be able to perform update and delete operations
SET SQL_SAFE_UPDATES = 0;


-- create an audit table to store changes
CREATE TABLE supplier_audit (
	sup_id INT PRIMARY KEY,
    last_modified DATE
);

-- first, 'after insert' trigger
DELIMITER $$
CREATE TRIGGER supplier_after_insert
AFTER INSERT ON t_sup_supplier
FOR EACH ROW
BEGIN
	-- insert record into audit table with current date as the last modified
    INSERT INTO supplier_audit (sup_id, last_modified)
    VALUES (NEW.sup_id, CURDATE());
END$$

DELIMITER ;


-- then, 'after update' trigger
DELIMITER $$
CREATE TRIGGER supplier_after_update
AFTER UPDATE ON t_sup_supplier
FOR EACH ROW
BEGIN
	-- update last_modified in hostory table or insert if not exists
    INSERT INTO supplier_audit (sup_id, last_modified)
    VALUES (NEW.sup_id, CURDATE())
    ON DUPLICATE KEY UPDATE last_modified = CURDATE();
END$$
DELIMITER ;


-- finally, 'after delete' trigger
DELIMITER $$
CREATE TRIGGER supplier_after_delete
AFTER DELETE ON supplier_audit
FOR EACH ROW
BEGIN
	-- insert or update audit table to store deletion date
    INSERT INTO supplier_audit (sup_id, last_modified)
    VALUES (OLD.sup_id, CURDATE())
    ON DUPLICATE KEY UPDATE last_modified = CURDATE();
END$$

DELIMITER ;

-- check if the triggers work
INSERT INTO t_sup_supplier (sup_id)
VALUES (2904474);

UPDATE t_sup_supplier
SET status_code = 'ini'
WHERE sup_id = 2904473;


-- final version of supplier_audit table
SELECT * FROM supplier_audit;


-- finally, turn safe_updates = 1 to keep the database secure
SET SQL_SAFE_UPDATES = 1;