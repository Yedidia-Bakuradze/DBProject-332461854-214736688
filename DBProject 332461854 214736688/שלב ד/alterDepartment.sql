-- Drop not null
Alter Table Department_1 modify DepartId NUMBER(5) NULL;
Alter Table Department_1 modify DepartName VARCHAR2(35) NULL;


-- add new columns
alter table Department_1 Add budget      INTEGER null;
alter table Department_1 Add maxcapacity INTEGER null;
alter table Department_1 Add currentsize INTEGER null;
