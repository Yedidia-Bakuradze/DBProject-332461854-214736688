CREATE OR REPLACE NONEDITIONABLE PROCEDURE create_and_assign_shifts(p_num_shifts NUMBER, p_start_date DATE) IS
    v_employee_id NUMBER;
    v_shift_date DATE := p_start_date;
    v_shift_count NUMBER := 0;
BEGIN
    WHILE v_shift_count < p_num_shifts LOOP
        -- Morning shift.
        IF v_shift_count < p_num_shifts THEN
            BEGIN
                v_employee_id := get_employee_for_shift(v_shift_date + INTERVAL '9' HOUR);
                INSERT INTO Shift (Starttime, Endtime)
                VALUES (v_shift_date + INTERVAL '9' HOUR, v_shift_date + INTERVAL '17' HOUR);
                INSERT INTO employeeshift (empId, Starttime)
                VALUES (v_employee_id, v_shift_date + INTERVAL '9' HOUR);
                
                v_shift_count := v_shift_count + 1;
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('Error assigning morning shift on ' || v_shift_date );
            END;
        END IF;
        
        -- Evening shift.
        IF v_shift_count < p_num_shifts THEN
            BEGIN
                v_employee_id := get_employee_for_shift(v_shift_date + INTERVAL '17' HOUR);
                INSERT INTO Shift (Starttime, Endtime)
                VALUES (v_shift_date + INTERVAL '17' HOUR, v_shift_date + INTERVAL '25' HOUR);
                INSERT INTO employeeshift (empId, Starttime)
                VALUES (v_employee_id, v_shift_date + INTERVAL '17' HOUR);
                
                v_shift_count := v_shift_count + 1;
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('Error assigning evening shift on ' || v_shift_date);
            END;
        END IF;
        
        -- Move to the next day
        v_shift_date := v_shift_date + 1;
    END LOOP;
END;
/
