-- Introduction
-- This is a Database Back-End Functionality of a "Medical Billing System"
-- The Database stores data about Pregnant Patients, Doctors, Hospitals, Pharmacy Prescription, Room Accomodation
-- The Database also stores data about Insurance Plans for Patients
-- The Database has Stored Procedure to Calculate the Insurance Quotation for Patients
-------------------------------------------------------------------------------
--Creation of Tables
-------------------------------------------------------------------------------
-- Creation of the PregnantPatient Table with its Primary & Foreign Keys
CREATE TABLE PregnantPatient 
( 
  PatientID             NUMBER NOT NULL, 
  PatientName           VARCHAR(50) NOT NULL,
  PatientAddress        VARCHAR(100) NOT NULL,
  PatientPhone          NUMBER NOT NULL,
  PatientEmail          VARCHAR(50) NOT NULL,
  PatientAge            NUMBER NOT NULL,  
CONSTRAINT PK_PregnantPatient 
  PRIMARY KEY (PatientID)
) 
/ 
-- Creation of the Hospital Table with its Primary & Foreign Keys
CREATE TABLE Hospital 
( 
  HospitalID             NUMBER NOT NULL, 
  HospitalName           VARCHAR(50) NOT NULL,
  HospitalAddress        VARCHAR(100) NOT NULL,
  HospitalPhone          NUMBER NOT NULL,
CONSTRAINT PK_Hospital 
  PRIMARY KEY (HospitalID)
) 
/ 
-- Creation of the Doctor Table with its Primary & Foreign Keys
CREATE TABLE Doctor 
( 
  DoctorID             NUMBER NOT NULL, 
  DoctorName           VARCHAR(50) NOT NULL,
  DoctorPhone          NUMBER NOT NULL,
  DoctorEmail          VARCHAR(50) NOT NULL,
  HospitalID           NUMBER NOT NULL,  
CONSTRAINT PK_Doctor 
  PRIMARY KEY (DoctorID),
CONSTRAINT FK_Doctor_Hospital 
  FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID)
) 
/ 
-- Creation of the BirthProcess Table with its Primary & Foreign Keys
CREATE TABLE BirthProcess 
( 
  BirthProcessID        NUMBER NOT NULL, 
  PatientID             NUMBER NOT NULL, 
  DoctorID              NUMBER NOT NULL, 
  BirthProcessDate      TIMESTAMP NOT NULL,
  BirthProcessStatus    CHAR(3) NOT NULL,
  BirthProcessCost      NUMBER NOT NULL,
CONSTRAINT PK_BirthProcess
  PRIMARY KEY (BirthProcessID),
CONSTRAINT FK_BirthProcess_Patient
  FOREIGN KEY (PatientID) REFERENCES PregnantPatient(PatientID),
CONSTRAINT FK_BirthProcess_Doctor
  FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
) 
/ 
-- Creation of the RoomAccomodation Table with its Primary & Foreign Keys
CREATE TABLE RoomAccomodation 
( 
  RoomAccomodationID            NUMBER NOT NULL, 
  HospitalID                    NUMBER NOT NULL, 
  PatientID                     NUMBER NOT NULL, 
  RoomAccomodationStartDate     TIMESTAMP NOT NULL,
  RoomAccomodationEndDate       TIMESTAMP NOT NULL,
  RoomPricePerNight             NUMBER NOT NULL,
CONSTRAINT PK_RoomAccomodation
  PRIMARY KEY (RoomAccomodationID),
CONSTRAINT FK_Accomodation_Hospital
  FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID),
CONSTRAINT FK_Accomodation_Patient
  FOREIGN KEY (PatientID) REFERENCES PregnantPatient(PatientID)
) 
/
-- Creation of the PharmacyPrescription Table with its Primary & Foreign Keys
CREATE TABLE PharmacyPrescription
( 
  PrescriptionID             NUMBER NOT NULL, 
  PatientID                  NUMBER NOT NULL, 
  PrescriptionMedicine       VARCHAR(100) NOT NULL,
  PrescriptionAmount         NUMBER NOT NULL, 
CONSTRAINT PK_PharmacyPrescription 
  PRIMARY KEY (PrescriptionID),
CONSTRAINT FK_PharmacyPresc_Patient 
  FOREIGN KEY (PatientID) REFERENCES PregnantPatient(PatientID)
) 
/ 
-- Creation of the InsurancePlan Table with its Primary & Foreign Keys
CREATE TABLE InsurancePlanPerPatient
( 
  InsurancePlanID         NUMBER NOT NULL, 
  PatientID               NUMBER NOT NULL, 
  PlanType                NUMBER NOT NULL, 
  InsuranceProvider       VARCHAR(100) NOT NULL,
  DeductibleAmountInUSD   NUMBER NOT NULL, 
  MonthlyFees             NUMBER NOT NULL, 
CONSTRAINT PK_InsurancePlan 
  PRIMARY KEY (InsurancePlanID),
CONSTRAINT FK_InsurancePlan_Patient 
  FOREIGN KEY (PatientID) REFERENCES PregnantPatient(PatientID)
) 
/ 
-------------------------------------------------------------------------------
-- Creating a Look-up Table to indicate the Birth Status of Each Birth Process
CREATE TABLE BirthStatus_LookUp(
  StatusAcronym     CHAR(3) NOT NULL,
  StatusDescription CHAR(50) NOT NULL,
CONSTRAINT PK_BirthLookUpTable
  PRIMARY KEY (StatusAcronym)
);
/
--Altering the BirthProcess Table to add foreign key constraint to the status column to import values from Status Lookup table
ALTER TABLE BirthProcess ADD FOREIGN KEY (BirthProcessStatus) REFERENCES BirthStatus_LookUp(StatusAcronym);
/
-------------------------------------------------------------------------------
-- Creating a Look-up Table to indicate the Type of Each Insurance Plan
CREATE TABLE InsurancePlanType_LookUp(
  PlanTypeID          NUMBER NOT NULL,
  PlanTypeDescription VARCHAR(100) NOT NULL,
CONSTRAINT PK_InsurancePlanType
  PRIMARY KEY (PlanTypeID)
);
/
--Altering the InsurancePlanPerPatient Table to add foreign key constraint to the PlanType column to import values from PlanType Lookup table
ALTER TABLE InsurancePlanPerPatient ADD FOREIGN KEY (PlanType) REFERENCES InsurancePlanType_LookUp(PlanTypeID);
/
-------------------------------------------------------------------------------
-- Population of Data into Table (Insertion of Values)
-------------------------------------------------------------------------------
-- Population of Data In the PregnantPatient Table
BEGIN
INSERT INTO PregnantPatient(PatientID, PatientName, PatientAddress, PatientPhone, PatienteMail, PatientAge) 
VALUES      (10001, 'Maria Osorio', '15-625, Barton Street, Florida', 6543674321, 'mosorio@gmail.com', 35);
INSERT INTO PregnantPatient(PatientID, PatientName, PatientAddress, PatientPhone, PatienteMail, PatientAge) 
VALUES      (10002, 'Carla Maden', '17-342, Wonder Avenue, California', 5432341265, 'cmaden@yahoo.com', 24);
INSERT INTO PregnantPatient(PatientID, PatientName, PatientAddress, PatientPhone, PatienteMail, PatientAge) 
VALUES      (10003, 'Marja Salazar', '20-542, Fruitland Road, Chicago', 6547865435, 'msalazar@hotmail.com', 40);
INSERT INTO PregnantPatient(PatientID, PatientName, PatientAddress, PatientPhone, PatienteMail, PatientAge) 
VALUES      (10004, 'Martha Miguel', '19-354, Farah Street, Newyork', 9863457474, 'mmiguel@yahoo.com', 30);
INSERT INTO PregnantPatient(PatientID, PatientName, PatientAddress, PatientPhone, PatienteMail, PatientAge) 
VALUES      (10005, 'Sophia Alvarez', '45-762, Limasol Road, Tampa', 6583409898, 'salvarez@gmail.com', 45);
INSERT INTO PregnantPatient(PatientID, PatientName, PatientAddress, PatientPhone, PatienteMail, PatientAge) 
VALUES      (10006, 'Tala Hudson', '35-414, WhiteOak Street, Utah', 3753674334, 'thudson@gmail.com', 36);
INSERT INTO PregnantPatient(PatientID, PatientName, PatientAddress, PatientPhone, PatienteMail, PatientAge) 
VALUES      (10007, 'Jomana Rady', '99-765, Orchard Avenue, Kentucky', 4322341299, 'jrady@yahoo.com', 28);
INSERT INTO PregnantPatient(PatientID, PatientName, PatientAddress, PatientPhone, PatienteMail, PatientAge) 
VALUES      (10008, 'Christina Wigs', '54-832, SouthWestern Road, New Mexico', 6137865486, 'cwigs@hotmail.com', 40);
INSERT INTO PregnantPatient(PatientID, PatientName, PatientAddress, PatientPhone, PatienteMail, PatientAge) 
VALUES      (10009, 'Scarlet John', '75-200, Queens Street, Los Angelos', 5423457477, 'sjohn@yahoo.com', 35);
INSERT INTO PregnantPatient(PatientID, PatientName, PatientAddress, PatientPhone, PatienteMail, PatientAge) 
VALUES      (10010, 'Gigi Jenner', '92-105, Dundas Road, Virginia', 4323409878, 'gjenner@gmail.com', 20);
INSERT INTO PregnantPatient(PatientID, PatientName, PatientAddress, PatientPhone, PatienteMail, PatientAge) 
VALUES      (10011, 'Stella Maria', '72-905, Remas Ave, Utah', 6169809657, 'stmaria@hotmail.com', 50);
INSERT INTO PregnantPatient(PatientID, PatientName, PatientAddress, PatientPhone, PatienteMail, PatientAge) 
VALUES      (10012, 'Pinna Auriema', '82-789, Warwick Road, Arizona', 4357658097, 'puriema@hotmail.com', 34);
COMMIT;
END;
/
-- Population of Data In the Hospital Table
BEGIN
INSERT INTO Hospital(HospitalID, HospitalName, HospitalAddress, HospitalPhone) 
VALUES      (20001, 'Goseph Brant Hospital', 'Tampa, USA', 6547869898);
INSERT INTO Hospital(HospitalID, HospitalName, HospitalAddress, HospitalPhone) 
VALUES      (20002, 'Victoria Hospital', 'Florida, USA', 7039898654);
INSERT INTO Hospital(HospitalID, HospitalName, HospitalAddress, HospitalPhone) 
VALUES      (20003, 'General District Hospital', 'New Jersey, USA', 6908989725);
INSERT INTO Hospital(HospitalID, HospitalName, HospitalAddress, HospitalPhone) 
VALUES      (20004, 'Mother Teresa Hospital', 'Mitchigan, USA', 8769393765);
INSERT INTO Hospital(HospitalID, HospitalName, HospitalAddress, HospitalPhone) 
VALUES      (20005, 'Mount Sinai Hospital', 'Arizona, USA', 6357878903);
INSERT INTO Hospital(HospitalID, HospitalName, HospitalAddress, HospitalPhone) 
VALUES      (20006, 'Graham Bell Hospital', 'Virginia, USA', 3147869895);
INSERT INTO Hospital(HospitalID, HospitalName, HospitalAddress, HospitalPhone) 
VALUES      (20007, 'Saint Helena Hospital', 'Iowa, USA', 2549898623);
INSERT INTO Hospital(HospitalID, HospitalName, HospitalAddress, HospitalPhone) 
VALUES      (20008, 'Saint Martina Hospital', 'Tucson, USA', 6238989711);
INSERT INTO Hospital(HospitalID, HospitalName, HospitalAddress, HospitalPhone) 
VALUES      (20009, 'Sir. Isaac Brook Hospital', 'Kentucky, USA', 9679393786);
INSERT INTO Hospital(HospitalID, HospitalName, HospitalAddress, HospitalPhone) 
VALUES      (20010, 'Lady of Peace Hospital', 'Utah, USA', 9067878977);
INSERT INTO Hospital(HospitalID, HospitalName, HospitalAddress, HospitalPhone) 
VALUES      (20011, 'Healing of God Hospital', 'New York, USA', 9679393786);
INSERT INTO Hospital(HospitalID, HospitalName, HospitalAddress, HospitalPhone) 
VALUES      (20012, 'Notre Dam Hospital', 'Las Vegas, USA', 3247878943);
INSERT INTO Hospital(HospitalID, HospitalName, HospitalAddress, HospitalPhone) 
VALUES      (20013, 'Sick Kids Hospital', 'Bavaria, USA', 2899528747);
INSERT INTO Hospital(HospitalID, HospitalName, HospitalAddress, HospitalPhone) 
VALUES      (20014, 'Beaverly Heights Hospital', 'California, USA', 4326478987);
COMMIT;
END;
/
-- Population of Data In the Doctor Table
BEGIN
INSERT INTO Doctor(DoctorID, DoctorName, DoctorPhone, DoctorEmail, HospitalID) 
VALUES      (40001, 'Hany Shaker', 7658980945, 'hshaker@gmail.com', 20004);
INSERT INTO Doctor(DoctorID, DoctorName, DoctorPhone, DoctorEmail, HospitalID) 
VALUES      (40002, 'John Smith', 6530008675, 'jsmith@gmail.com', 20001);
INSERT INTO Doctor(DoctorID, DoctorName, DoctorPhone, DoctorEmail, HospitalID) 
VALUES      (40003, 'Maria Tiskova', 3097867098, 'mtiskova@gmail.com', 20003);
INSERT INTO Doctor(DoctorID, DoctorName, DoctorPhone, DoctorEmail, HospitalID) 
VALUES      (40004, 'Nikolas Martin', 4209876060, 'nmartin@gmail.com', 20005);
INSERT INTO Doctor(DoctorID, DoctorName, DoctorPhone, DoctorEmail, HospitalID) 
VALUES      (40005, 'Maggy Pineda', 3247865454, 'mpineda@gmail.com', 20003);
INSERT INTO Doctor(DoctorID, DoctorName, DoctorPhone, DoctorEmail, HospitalID) 
VALUES      (40006, 'Amir Tadrous', 4328980966, 'atadrous@gmail.com', 20004);
INSERT INTO Doctor(DoctorID, DoctorName, DoctorPhone, DoctorEmail, HospitalID) 
VALUES      (40007, 'Andree John', 4350008645, 'ajohn@gmail.com', 20009);
INSERT INTO Doctor(DoctorID, DoctorName, DoctorPhone, DoctorEmail, HospitalID) 
VALUES      (40008, 'Mario Bildly', 3247867055, 'mbikdy@gmail.com', 20008);
INSERT INTO Doctor(DoctorID, DoctorName, DoctorPhone, DoctorEmail, HospitalID) 
VALUES      (40009, 'Jean Beuchamp', 3549876090, 'jbeuchamp@gmail.com', 20007);
INSERT INTO Doctor(DoctorID, DoctorName, DoctorPhone, DoctorEmail, HospitalID) 
VALUES      (40010, 'Vinay Ilia', 6547865433, 'vilia@gmail.com', 20006);
INSERT INTO Doctor(DoctorID, DoctorName, DoctorPhone, DoctorEmail, HospitalID) 
VALUES      (40011, 'Mady Peter', 5646789856, 'mpeter@gmail.com', 20012);
INSERT INTO Doctor(DoctorID, DoctorName, DoctorPhone, DoctorEmail, HospitalID) 
VALUES      (40012, 'Tom George', 6534234532, 'tgeorge@gmail.com', 20011);
COMMIT;
END;
/
-- Population of Data In the Birth Process Status LookUp Table
BEGIN
INSERT INTO BirthStatus_LookUp(StatusAcronym, StatusDescription) 
VALUES      ('EM', 'Early Misscarriage');
INSERT INTO BirthStatus_LookUp(StatusAcronym, StatusDescription) 
VALUES      ('FA', 'Forcefull Abortion');
INSERT INTO BirthStatus_LookUp(StatusAcronym, StatusDescription) 
VALUES      ('NA', 'Natural Abortion');
INSERT INTO BirthStatus_LookUp(StatusAcronym, StatusDescription) 
VALUES      ('ND', 'Natural Delivery');
INSERT INTO BirthStatus_LookUp(StatusAcronym, StatusDescription) 
VALUES      ('CD', 'Caesarean Delivery');
INSERT INTO BirthStatus_LookUp(StatusAcronym, StatusDescription) 
VALUES      ('ITD', 'Induced To Deliver');
INSERT INTO BirthStatus_LookUp(StatusAcronym, StatusDescription) 
VALUES      ('DWE', 'Delivery With Epidural');
COMMIT;
END;
/
-- Population of Data In the BirthProcess Table
BEGIN
INSERT INTO BirthProcess(BirthProcessID, PatientID, DoctorID, BirthProcessDate, BirthProcessStatus, BirthProcessCost) 
VALUES      (50001, 10003, 40005, '2012-03-22 08:54:00.882000000', 'ND', 8500);
INSERT INTO BirthProcess(BirthProcessID, PatientID, DoctorID, BirthProcessDate, BirthProcessStatus, BirthProcessCost)
VALUES      (50002, 10004, 40003, '2016-08-16 02:14:00.782000000', 'FA', 11500);
INSERT INTO BirthProcess(BirthProcessID, PatientID, DoctorID, BirthProcessDate, BirthProcessStatus, BirthProcessCost)
VALUES      (50003, 10002, 40001, '2017-09-19 07:55:00.132000000', 'ITD', 7649);
INSERT INTO BirthProcess(BirthProcessID, PatientID, DoctorID, BirthProcessDate, BirthProcessStatus, BirthProcessCost)
VALUES      (50004, 10005, 40002, '2019-11-08 05:32:00.574000000', 'CD', 9000);
INSERT INTO BirthProcess(BirthProcessID, PatientID, DoctorID, BirthProcessDate, BirthProcessStatus, BirthProcessCost)
VALUES      (50005, 10001, 40004, '2020-05-01 03:14:00.236000000', 'EM', 15000);
INSERT INTO BirthProcess(BirthProcessID, PatientID, DoctorID, BirthProcessDate, BirthProcessStatus, BirthProcessCost)
VALUES      (50006, 10008, 40004, '2012-05-12 10:34:00.882000000', 'ND', 20000);
INSERT INTO BirthProcess(BirthProcessID, PatientID, DoctorID, BirthProcessDate, BirthProcessStatus, BirthProcessCost)
VALUES      (50007, 10010, 40003, '2018-09-08 01:14:00.782000000', 'FA', 7300);
INSERT INTO BirthProcess(BirthProcessID, PatientID, DoctorID, BirthProcessDate, BirthProcessStatus, BirthProcessCost)
VALUES      (50008, 10006, 40009, '2017-01-17 03:25:00.132000000', 'ITD', 9600);
INSERT INTO BirthProcess(BirthProcessID, PatientID, DoctorID, BirthProcessDate, BirthProcessStatus, BirthProcessCost)
VALUES      (50009, 10007, 40008, '2020-11-06 08:32:00.544000000', 'CD', 4500);
INSERT INTO BirthProcess(BirthProcessID, PatientID, DoctorID, BirthProcessDate, BirthProcessStatus, BirthProcessCost)
VALUES      (50010, 10009, 40010, '2019-12-20 07:14:00.116000000', 'EM', 10000);
INSERT INTO BirthProcess(BirthProcessID, PatientID, DoctorID, BirthProcessDate, BirthProcessStatus, BirthProcessCost)
VALUES      (50011, 10011, 40012, '2011-05-06 02:42:00.444000000', 'DWE', 6500);
INSERT INTO BirthProcess(BirthProcessID, PatientID, DoctorID, BirthProcessDate, BirthProcessStatus, BirthProcessCost)
VALUES      (50012, 10012, 40011, '2011-11-03 04:34:00.216000000', 'DWE', 8300);
COMMIT;
END;
/
-- Population of Data In the RoomAccomodation Table
BEGIN
INSERT INTO RoomAccomodation(RoomAccomodationID, HospitalID, PatientID, RoomAccomodationStartDate, RoomAccomodationEndDate, RoomPricePerNight) 
VALUES      (60001, 20005, 10001, '2020-05-01 01:10:00.122000000', '2020-05-05 01:10:00.122000000', 150);
INSERT INTO RoomAccomodation(RoomAccomodationID, HospitalID, PatientID, RoomAccomodationStartDate, RoomAccomodationEndDate, RoomPricePerNight) 
VALUES      (60002, 20004, 10002, '2017-09-18 07:55:00.132000000', '2017-09-25 07:55:00.132000000', 230);
INSERT INTO RoomAccomodation(RoomAccomodationID, HospitalID, PatientID, RoomAccomodationStartDate, RoomAccomodationEndDate, RoomPricePerNight) 
VALUES      (60003, 20003, 10003, '2012-03-20 08:54:00.882000000', '2012-03-26 08:54:00.882000000', 410);
INSERT INTO RoomAccomodation(RoomAccomodationID, HospitalID, PatientID, RoomAccomodationStartDate, RoomAccomodationEndDate, RoomPricePerNight) 
VALUES      (60004, 20003, 10004, '2016-08-15 02:14:00.782000000', '2016-08-21 02:14:00.782000000', 100);
INSERT INTO RoomAccomodation(RoomAccomodationID, HospitalID, PatientID, RoomAccomodationStartDate, RoomAccomodationEndDate, RoomPricePerNight) 
VALUES      (60005, 20001, 10005, '2019-11-05 05:32:00.574000000', '2019-11-10 05:32:00.574000000', 280);
INSERT INTO RoomAccomodation(RoomAccomodationID, HospitalID, PatientID, RoomAccomodationStartDate, RoomAccomodationEndDate, RoomPricePerNight) 
VALUES      (60006, 20007, 10006, '2017-01-15 03:25:00.132000000', '2017-01-20 03:25:00.132000000', 140);
INSERT INTO RoomAccomodation(RoomAccomodationID, HospitalID, PatientID, RoomAccomodationStartDate, RoomAccomodationEndDate, RoomPricePerNight) 
VALUES      (60007, 20008, 10007, '2020-11-05 08:32:00.544000000', '2020-11-11 08:32:00.544000000', 260);
INSERT INTO RoomAccomodation(RoomAccomodationID, HospitalID, PatientID, RoomAccomodationStartDate, RoomAccomodationEndDate, RoomPricePerNight) 
VALUES      (60008, 20005, 10008, '2012-05-10 10:34:00.882000000', '2012-05-16 10:34:00.882000000', 310);
INSERT INTO RoomAccomodation(RoomAccomodationID, HospitalID, PatientID, RoomAccomodationStartDate, RoomAccomodationEndDate, RoomPricePerNight) 
VALUES      (60009, 20006, 10009, '2019-12-19 07:14:00.116000000', '2019-12-23 07:14:00.116000000', 150);
INSERT INTO RoomAccomodation(RoomAccomodationID, HospitalID, PatientID, RoomAccomodationStartDate, RoomAccomodationEndDate, RoomPricePerNight) 
VALUES      (60010, 20003, 10010, '2018-09-07 01:14:00.782000000', '2018-09-11 01:14:00.782000000', 230);
INSERT INTO RoomAccomodation(RoomAccomodationID, HospitalID, PatientID, RoomAccomodationStartDate, RoomAccomodationEndDate, RoomPricePerNight) 
VALUES      (60011, 20012, 10011, '2011-05-05 02:42:00.444000000', '2011-05-10 02:42:00.444000000', 100);
INSERT INTO RoomAccomodation(RoomAccomodationID, HospitalID, PatientID, RoomAccomodationStartDate, RoomAccomodationEndDate, RoomPricePerNight) 
VALUES      (60012, 20011, 10012, '2011-11-01 04:34:00.216000000', '2011-11-15 04:34:00.216000000', 330);
COMMIT;
END;
/
-- Population of Data In the PharmacyPrescription Table
BEGIN
INSERT INTO PharmacyPrescription(PrescriptionID, PatientID, PrescriptionMedicine, PrescriptionAmount) 
VALUES      (70001, 10001, 'Senokot', 39);
INSERT INTO PharmacyPrescription(PrescriptionID, PatientID, PrescriptionMedicine, PrescriptionAmount) 
VALUES      (70002, 10002, 'Panadol', 26);
INSERT INTO PharmacyPrescription(PrescriptionID, PatientID, PrescriptionMedicine, PrescriptionAmount) 
VALUES      (70003, 10002, 'IbuProfen', 33);
INSERT INTO PharmacyPrescription(PrescriptionID, PatientID, PrescriptionMedicine, PrescriptionAmount) 
VALUES      (70004, 10003, 'Paracetamol', 18);
INSERT INTO PharmacyPrescription(PrescriptionID, PatientID, PrescriptionMedicine, PrescriptionAmount) 
VALUES      (70005, 10005, 'Fucidin', 14);
INSERT INTO PharmacyPrescription(PrescriptionID, PatientID, PrescriptionMedicine, PrescriptionAmount) 
VALUES      (70006, 10006, 'Advil', 27);
INSERT INTO PharmacyPrescription(PrescriptionID, PatientID, PrescriptionMedicine, PrescriptionAmount) 
VALUES      (70007, 10007, 'Tylenol', 30);
INSERT INTO PharmacyPrescription(PrescriptionID, PatientID, PrescriptionMedicine, PrescriptionAmount) 
VALUES      (70008, 10007, 'Multivitamins', 45);
INSERT INTO PharmacyPrescription(PrescriptionID, PatientID, PrescriptionMedicine, PrescriptionAmount) 
VALUES      (70009, 10007, 'Folic Acid', 16);
INSERT INTO PharmacyPrescription(PrescriptionID, PatientID, PrescriptionMedicine, PrescriptionAmount) 
VALUES      (70010, 10009, 'Iron Pills', 20);
INSERT INTO PharmacyPrescription(PrescriptionID, PatientID, PrescriptionMedicine, PrescriptionAmount) 
VALUES      (70011, 10012, 'Paracetamol', 18);
INSERT INTO PharmacyPrescription(PrescriptionID, PatientID, PrescriptionMedicine, PrescriptionAmount) 
VALUES      (70012, 10011, '⁮Vitamin D', 26);
COMMIT;
END;
/
-- Population of Data In the InsurancePlanType_LookUp Table
BEGIN
INSERT INTO InsurancePlanType_LookUp(PlanTypeID, PlanTypeDescription) 
VALUES      (1, 'Basic Plan');
INSERT INTO InsurancePlanType_LookUp(PlanTypeID, PlanTypeDescription) 
VALUES      (2, 'Premium Plan');
INSERT INTO InsurancePlanType_LookUp(PlanTypeID, PlanTypeDescription) 
VALUES      (3, 'Optimum Plan');
INSERT INTO InsurancePlanType_LookUp(PlanTypeID, PlanTypeDescription) 
VALUES      (4, 'VIP Plan');
INSERT INTO InsurancePlanType_LookUp(PlanTypeID, PlanTypeDescription) 
VALUES      (5, 'Executive Plan');
COMMIT;
END;
/
-- Population of Data In the InsurancePlan Table
BEGIN
INSERT INTO InsurancePlanPerPatient(InsurancePlanID, PatientID, PlanType, InsuranceProvider, DeductibleAmountInUSD, MonthlyFees) 
VALUES      (80001, 10001, 2, 'TD Bank', 400, 50);
INSERT INTO InsurancePlanPerPatient(InsurancePlanID, PatientID, PlanType, InsuranceProvider, DeductibleAmountInUSD, MonthlyFees) 
VALUES      (80002, 10002, 1, 'Allianz', 500, 50);
INSERT INTO InsurancePlanPerPatient(InsurancePlanID, PatientID, PlanType, InsuranceProvider, DeductibleAmountInUSD, MonthlyFees) 
VALUES      (80003, 10003, 5, 'West Life', 200, 50);
INSERT INTO InsurancePlanPerPatient(InsurancePlanID, PatientID, PlanType, InsuranceProvider, DeductibleAmountInUSD, MonthlyFees) 
VALUES      (80004, 10004, 4, 'Intact Insurance', 150, 50);
INSERT INTO InsurancePlanPerPatient(InsurancePlanID, PatientID, PlanType, InsuranceProvider, DeductibleAmountInUSD, MonthlyFees) 
VALUES      (80005, 10005, 2, 'Ace Life', 450, 50);
INSERT INTO InsurancePlanPerPatient(InsurancePlanID, PatientID, PlanType, InsuranceProvider, DeductibleAmountInUSD, MonthlyFees) 
VALUES      (80006, 10006, 5, 'Sun Life', 200, 75);
INSERT INTO InsurancePlanPerPatient(InsurancePlanID, PatientID, PlanType, InsuranceProvider, DeductibleAmountInUSD, MonthlyFees) 
VALUES      (80007, 10007, 1, 'CIBC Bank', 600, 50);
INSERT INTO InsurancePlanPerPatient(InsurancePlanID, PatientID, PlanType, InsuranceProvider, DeductibleAmountInUSD, MonthlyFees) 
VALUES      (80008, 10008, 3, 'Sun Life', 250, 50);
INSERT INTO InsurancePlanPerPatient(InsurancePlanID, PatientID, PlanType, InsuranceProvider, DeductibleAmountInUSD, MonthlyFees) 
VALUES      (80009, 10009, 3, 'BMO Bank', 200, 50);
INSERT INTO InsurancePlanPerPatient(InsurancePlanID, PatientID, PlanType, InsuranceProvider, DeductibleAmountInUSD, MonthlyFees) 
VALUES      (80010, 10010, 2, 'RBC Bank', 350, 50);
INSERT INTO InsurancePlanPerPatient(InsurancePlanID, PatientID, PlanType, InsuranceProvider, DeductibleAmountInUSD, MonthlyFees) 
VALUES      (80011, 10011, 4, 'Allianz', 400, 75);
INSERT INTO InsurancePlanPerPatient(InsurancePlanID, PatientID, PlanType, InsuranceProvider, DeductibleAmountInUSD, MonthlyFees) 
VALUES      (80012, 10012, 2, 'Ace Life', 350, 100);
COMMIT;
END;
/
-------------------------------------------------------------------------------
-- Sequence No.1
-------------------------------------------------------------------------------
-- Creating a Sequence to Enter a New Pregnant Patient
CREATE SEQUENCE PregnantPatientID_SEQ      
    START WITH 10013  
    INCREMENT BY 1      
    NOCACHE 
    NOCYCLE;
/
-- Using the PregnantPatientID_SEQ sequence to insert a new row in the Pregnant Patient table
DECLARE
   Pregnant_Patient_new_row  PregnantPatient%ROWTYPE;    
BEGIN
   Pregnant_Patient_new_row.PatientID := PregnantPatientID_SEQ.NEXTVAL;
   Pregnant_Patient_new_row.PatientName := 'Roma Henrique' ;
   Pregnant_Patient_new_row.PatientAddress := '56-987 Rymal Street, Tuscon, USA';
   Pregnant_Patient_new_row.PatientPhone := 6578778908;
   Pregnant_Patient_new_row.PatientEmail := 'rhenrique@gmail.com';
   Pregnant_Patient_new_row.PatientAge := 43;
INSERT    INTO PregnantPatient    VALUES Pregnant_Patient_new_row;
COMMIT;
END;
/
-------------------------------------------------------------------------------
-- Sequence No.2
-------------------------------------------------------------------------------
-- Creating a Sequence to Enter a New Pharmacy Prescription
CREATE SEQUENCE PharmacyPrescriptionID_SEQ      
    START WITH 70013  
    INCREMENT BY 1      
    NOCACHE 
    NOCYCLE;
/
-- Using the PharmacyPrescription_SEQ sequence to insert a new row in the Pharmacy Prescription table
DECLARE
   Pharmacy_Prescription_new_row  PharmacyPrescription%ROWTYPE;    
BEGIN
   Pharmacy_Prescription_new_row.PrescriptionID := PharmacyPrescriptionID_SEQ.NEXTVAL;
   Pharmacy_Prescription_new_row.PatientID := '10010' ;
   Pharmacy_Prescription_new_row.PrescriptionMedicine := 'Restorlax';
   Pharmacy_Prescription_new_row.PrescriptionAmount := 42;
INSERT    INTO PharmacyPrescription    VALUES Pharmacy_Prescription_new_row;
COMMIT;
END;
/
-------------------------------------------------------------------------------
-- Index No.1
-------------------------------------------------------------------------------
-- Create Index for the heavily searched RoomAccomodation Table (Price Per Night Column)
CREATE INDEX Room_Price_Per_Night ON RoomAccomodation (RoomPricePerNight);
/
-------------------------------------------------------------------------------
-- Index No.2
-------------------------------------------------------------------------------
-- Create Index for (Primary Key or InsurancePLanID & Monthly Fees) of the heavily searched table Insurance Plan Per Patient 
CREATE UNIQUE INDEX InsurancePlan_ID_Index
ON InsurancePlanPerpatient (InsurancePlanID, MonthlyFees)
COMPUTE STATISTICS;
-- Create an Execution Plan for the Select Statement  
EXPLAIN PLAN FOR
SELECT PatientID, InsurancePlanID, MonthlyFees
FROM InsurancePlanPerpatient
WHERE MonthlyFees > 75
ORDER BY MonthlyFees;
-- Display Execution Plan from the PLAN_TABLE to detect benefit of index for search   
SELECT * FROM TABLE(dbms_xplan.display);
/
-------------------------------------------------------------------------------
-- Index No.3
-------------------------------------------------------------------------------
-- Creation of an Index for The Birth Process Table (The Birth Process Date)
CREATE INDEX Birth_Process_Date_Index
ON BirthProcess (TRUNC(BirthProcessDate))
COMPUTE STATISTICS;  
/ 
-- Select statement that uses the index
SELECT * FROM BirthProcess
WHERE TRUNC(BirthProcessDate) BETWEEN to_date('01/01/2016','dd/mm/yyyy') AND SYSDATE;   
-- Create an Execution Plan for the Select Statement  
EXPLAIN PLAN FOR   
   SELECT * FROM BirthProcess
   WHERE TRUNC(BirthProcessDate) BETWEEN to_date('01/01/2016','dd/mm/yyyy') AND SYSDATE;   
-- Display Execution Plan from the PLAN_TABLE   
SELECT * FROM TABLE(dbms_xplan.display);
-------------------------------------------------------------------------------
-- Index No.4
-------------------------------------------------------------------------------
-- Create Index for the heavily searched InsurancePlanPerPatient Table (The Deductible Amount)
CREATE INDEX Insurance_deductible_amount ON InsurancePlanPerPatient (DeductibleAmountInUSD);
/
-------------------------------------------------------------------------------
-- Trigger No.1
-------------------------------------------------------------------------------
-- A Trigger to always automatically set Insurance Plan Type to 4 for Any New Plan Inserted
-- Plan Type 4 is the VIP Plan
-- Then the Patient may ask to upgrade or downgrade his/her plan type 
CREATE OR REPLACE TRIGGER Plan_Type_To_4
BEFORE INSERT OR UPDATE ON InsurancePlanPerPatient
FOR EACH ROW
BEGIN
    :NEW.PlanType := 4;
END;
/
-- Block to test the above Trigger
SET SERVEROUTPUT ON;
BEGIN
INSERT INTO InsurancePlanPerPatient VALUES (80015, 10009, 1, 'Intact Insurance', 250, 60);
COMMIT;
DBMS_OUTPUT.PUT_LINE('New Plan is inserted successfully, plan type is set to 4, patient can ask to upgrade or downgrade');
END;
/
-------------------------------------------------------------------------------
-- Trigger No.2
-------------------------------------------------------------------------------
--Trigger to Display Specific Message based on Each Transaction on the Pharmacy Prescription Table
CREATE OR REPLACE TRIGGER Pharmacy_Transactions
  BEFORE
    INSERT OR 
    UPDATE OF PrescriptionMedicine, PrescriptionAmount OR
    DELETE
    ON PharmacyPrescription
BEGIN
  CASE
    WHEN INSERTING THEN
      DBMS_OUTPUT.PUT_LINE('Inserting a New Pharmacy Prescription Order');
    WHEN UPDATING('PrescriptionMedicine') THEN
      DBMS_OUTPUT.PUT_LINE('Updating Prescription Medicine');
    WHEN UPDATING('PrescriptionAmount') THEN
      DBMS_OUTPUT.PUT_LINE('Updating Prescription Amount');
    WHEN DELETING THEN
      DBMS_OUTPUT.PUT_LINE('Deleting a Pharmacy Prescription Order');
  END CASE;
END;
/
--Sample to test the trigger upon update of Prescription Amount
SET SERVEROUTPUT ON;
BEGIN
UPDATE PharmacyPrescription
SET PrescriptionAmount = 150
WHERE PrescriptionMedicine= 'Panadol';
END;
/
-------------------------------------------------------------------------------
-- Trigger No.3 (Instead Of) Type
-------------------------------------------------------------------------------
--Create View to Test if the (Instead Of) Trigger can handle the complex UPDATE statement
--This View displays data about Patient, related doctor, related hospital,
--and related birth process cost that is greater than 9000 USD
CREATE OR REPLACE VIEW Patient_Doctor_Hospital_Cost AS
SELECT PP.PatientID, PP.PatientName, DOCT.DoctorID, DOCT.DoctorName, 
BP.BirthProcessStatus, LKUP.StatusDescription, BP.BirthProcessCost
FROM PregnantPatient PP
INNER JOIN BirthProcess BP ON PP.PatientID = BP.PatientID
INNER JOIN Doctor DOCT ON DOCT.DoctorID = BP.DoctorID
INNER JOIN BirthStatus_LookUp LKUP ON LKUP.StatusAcronym = BP.BirthProcessStatus
WHERE BP.BirthProcessCost > 9000;
/
-- Create Trigger of The Type "Instead Of"
CREATE OR REPLACE TRIGGER modify_view_trigger
INSTEAD OF UPDATE
ON Patient_Doctor_Hospital_Cost
FOR EACH ROW
BEGIN
UPDATE BirthProcess
SET BirthProcessCost=:NEW.BirthProcessCost
WHERE BirthProcessStatus=:OLD.BirthProcessStatus;
END;
/
-- Update Block after the trigger is created 
-- It decreases the birth cost by 1000 USD for Process with 'FA' Status
-- 'FA' Status is Forced Abortion
-- It does not create an error because the instead of trigger is activated
BEGIN
UPDATE Patient_Doctor_Hospital_Cost
SET BirthProcessCost = BirthProcessCost - 1000
WHERE BirthProcessStatus= 'FA';
END;
/
-------------------------------------------------------------------------------
-- Procedures
-------------------------------------------------------------------------------
-- First Procedure Updates an Audit/Log Table
-------------------------------------------------------------------------------
--Creating an Audit/Log Table to store information abot audit attempts of the tables
CREATE TABLE Audit_Log_Main_Table
(
TableName         VARCHAR(100) NOT NULL,
ModificationDate  TIMESTAMP NOT NULL,
ColumnName        VARCHAR(100) NOT NULL,
OldFieldValue     NUMBER NOT NULL,
NewFieldValue     NUMBER NOT NULL,
ModifiedBy        VARCHAR(100) NOT NULL
)
/
-------------------------------------------------------------------------------
-- Procedure No.1
-------------------------------------------------------------------------------
--Creating a Procedure to Increase the deductible amount of the Insurance Plan of a Certain Patient
--Inputs of the procedure are the "Increment Value" or "Added Value" and the "Patient ID"
CREATE OR REPLACE PROCEDURE increase_deductible_amount
(selected_Patient_ID               IN    InsurancePlanPerPatient.PatientID%TYPE,
 amount_to_add                     IN    NUMBER,
 display_patient_ID                OUT   InsurancePlanPerPatient.PatientID%TYPE,
 display_plan_type                 OUT   InsurancePlanPerPatient.PlanType%TYPE,
 display_deductible_amount         OUT   InsurancePlanPerPatient.DeductibleAmountInUSD%TYPE,
 old_amount                        OUT   NUMBER)  
AS
BEGIN
UPDATE InsurancePlanPerPatient
SET DeductibleAmountInUSD = DeductibleAmountInUSD + amount_to_add
WHERE PatientID = selected_Patient_ID ;
dbms_output.put_line('Update Process has been performed Successfully');
SELECT DeductibleAmountInUSD INTO display_deductible_amount FROM INsurancePlanPerPatient WHERE PatientID = selected_Patient_ID ;
INSERT INTO Audit_Log_Main_Table (TableName, ModificationDate, ColumnName, OldFieldValue, NewFieldValue, ModifiedBy)        
VALUES ('InsurancePlanPerPatient', SYSDATE, 'DeductibleAmountInUSD', (display_deductible_amount-amount_to_add), display_deductible_amount, USER );
old_amount  := display_deductible_amount-amount_to_add;
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line( SQLERRM );
END;
/
--Anonymous Block that Calls the above procedure and outputs the result
SET SERVEROUTPUT ON;
DECLARE
 selected_Patient_ID               InsurancePlanPerPatient.PatientID%TYPE;
 amount_to_add                     NUMBER;
 display_patient_ID                InsurancePlanPerPatient.PatientID%TYPE;
 display_plan_type                 InsurancePlanPerPatient.PlanType%TYPE;
 display_deductible_amount         InsurancePlanPerPatient.DeductibleAmountInUSD%TYPE;
 old_amount                        NUMBER;
BEGIN
increase_deductible_amount(10001, 20, display_patient_ID, display_plan_type, display_deductible_amount, old_amount);
dbms_output.put_line('Old Deductible Amount is : ' || old_amount );
dbms_output.put_line('New Deductible Amount is : ' || display_deductible_amount);
END;
/
-------------------------------------------------------------------------------
-- Procedure No.2
-------------------------------------------------------------------------------
-- Creating a Procedure to Calculate an insurance quotation for a chosen paient
CREATE OR REPLACE PROCEDURE insurance_quotation_calculator
(selected_Patient_ID                    IN    InsurancePlanPerPatient.PatientID%TYPE,
 display_Patient_ID                     OUT    InsurancePlanPerPatient.PatientID%TYPE,
 display_patient_name                   OUT   PregnantPatient.PatientName%TYPE,
 display_birth_cost                     OUT   BirthProcess.BirthProcessCost%TYPE,
 display_pharmacy_amount                OUT   PharmacyPrescription.PrescriptionAmount%TYPE,
 display_accomd_start_date        OUT  NUMBER,
 display_accomd_end_date          OUT   NUMBER,
 display_nights_count       OUT NUMBER,
 display_price_per_night                OUT   NUMBER,
 display_total_accomodation OUT NUMBER,
 display_deductible_amount              OUT   NUMBER,
 total_insurance_quotation              OUT   NUMBER)  
AS
BEGIN
SELECT PatientID, PatientName INTO display_Patient_ID, display_patient_name FROM PregnantPatient WHERE PatientID = selected_Patient_ID; 
SELECT BirthProcessCost INTO display_birth_cost FROM BirthProcess WHERE PatientID = selected_Patient_ID; 
SELECT PrescriptionAmount INTO display_pharmacy_amount FROM PharmacyPrescription WHERE PatientID = selected_Patient_ID;
SELECT TO_NUMBER(TO_CHAR(RoomAccomodationStartDate,'YYYYMMDD')), TO_NUMBER(TO_CHAR(RoomAccomodationEndDate,'YYYYMMDD')), RoomPricePerNight INTO display_accomd_start_date, display_accomd_end_date, display_price_per_night   FROM RoomAccomodation WHERE PatientID = selected_Patient_ID;
SELECT DeductibleAmountInUSD INTO display_deductible_amount FROM InsurancePlanPerPatient WHERE PatientID = selected_Patient_ID;
display_nights_count := (display_accomd_end_date - display_accomd_start_date);
display_total_accomodation := (display_price_per_night * display_nights_count);
total_insurance_quotation := display_birth_cost + display_pharmacy_amount + display_total_accomodation  - display_deductible_amount  ;
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line( SQLERRM );
END;
/
--Anonymous Block that Calls the above procedure and outputs the result
SET SERVEROUTPUT ON;
DECLARE
 selected_Patient_ID                   InsurancePlanPerPatient.PatientID%TYPE;
 display_Patient_ID                    InsurancePlanPerPatient.PatientID%TYPE;
 display_patient_name                  PregnantPatient.PatientName%TYPE;
 display_birth_cost                    BirthProcess.BirthProcessCost%TYPE;
 display_pharmacy_amount               PharmacyPrescription.PrescriptionAmount%TYPE;
 display_accomd_start_date             NUMBER;
 display_accomd_end_date               NUMBER;
 display_nights_count                  NUMBER;
 display_price_per_night               NUMBER;
 display_total_accomodation            NUMBER;
 display_deductible_amount             NUMBER;
 total_insurance_quotation             NUMBER; 
BEGIN
insurance_quotation_calculator(10001, display_Patient_ID,display_patient_name, display_birth_cost,
                              display_pharmacy_amount, display_accomd_start_date,
                              display_accomd_end_date, display_nights_count, display_price_per_night,              
                              display_total_accomodation, display_deductible_amount, total_insurance_quotation);      
dbms_output.put_line('Patient ID is: ' || display_Patient_ID);
dbms_output.put_line('Patient Name is: ' || display_patient_name);
dbms_output.put_line('Birth Process Cost In USD is: $' || display_birth_cost);
dbms_output.put_line('Pharmacy Medicines Cost In USD is : $' || display_pharmacy_amount);
dbms_output.put_line('Hospital Room Accomodation Start Date is: ' || TO_CHAR(TO_DATE(display_accomd_start_date, 'YYYYMMDD'), 'mm/dd/yyyy'));
dbms_output.put_line('Hospital Room Accomodation End Date is: ' || TO_CHAR(TO_DATE(display_accomd_end_date, 'YYYYMMDD'), 'mm/dd/yyyy'));
dbms_output.put_line('Number of Nights Stayed in Hospital is: ' || display_nights_count);
dbms_output.put_line('Price of Room Per Night is: $' || display_price_per_night);
dbms_output.put_line('Total Accomodation Cost is: ' || display_price_per_night || ' * ' || display_nights_count || ' = ' || display_total_accomodation);
dbms_output.put_line('Insurance Deductible Amount is: $ ' || display_deductible_amount );
dbms_output.put_line('Grand Insurance Quotation (Including Surgery Cost + Pharmacy Cost + Room Cost) is: $ ' || total_insurance_quotation );
END;
/
-------------------------------------------------------------------------------
-- Function No.1
-------------------------------------------------------------------------------
-- Creating a Function that Retrieves the Most Expensive Birth Process in a Certain Year
CREATE OR REPLACE FUNCTION most_expensive_birth_process(
    process_year NUMBER
) 
RETURN NUMBER
IS
    most_expensive_process NUMBER := 0;
BEGIN   
    SELECT MAX(BirthProcessCost)
    INTO most_expensive_process
    FROM (SELECT BirthProcessCost FROM BirthProcess WHERE EXTRACT(YEAR FROM BirthProcessDate) = process_year);
    RETURN most_expensive_process;   
END;
/
-- Anonymous Block that Calls the Above Function
DECLARE
    most_expensive_process NUMBER := 0;
BEGIN
    most_expensive_process := most_expensive_birth_process (2020);
    DBMS_OUTPUT.PUT_LINE('Most Expensive Birth Process in 2020 cost is: ' || most_expensive_process);
END;
/
-------------------------------------------------------------------------------
-- Function No.2
-------------------------------------------------------------------------------
-- Creating a Function that Retrieves the Location of a Hospital where a Doctor Works
CREATE OR REPLACE FUNCTION rerieve_hospital_by_doctor(
    doctor_id NUMBER
) 
RETURN VARCHAR2
IS
    hospital_address VARCHAR2(100) := null;
BEGIN   
    SELECT HospitalAddress
    INTO hospital_address
    FROM Hospital
    INNER JOIN Doctor ON Doctor.HospitalID = Hospital.HospitalID
    WHERE Doctor.DoctorID = doctor_id;
    RETURN hospital_address;   
END;
/
-- Anonymous Block that Calls the Above Function
DECLARE
    hospital_address VARCHAR2(100) := null;
BEGIN
    hospital_address := rerieve_hospital_by_doctor (40008);
    DBMS_OUTPUT.PUT_LINE('The Address of the Hospital Where Doctor Works is: ' || hospital_address);
END;
/
-------------------------------------------------------------------------------
-- End Of Medical Billing Back End Functionality Database
-------------------------------------------------------------------------------




