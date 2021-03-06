/*
## (C) Copyright IBM Corporation 2015.
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
## http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.

# Each SQL statement in this file should terminate with a semicolon (;)
# Lines starting with the pound character (#) are considered as comments
*/

DROP TABLE HOLDINGEJB cascade;
DROP TABLE ACCOUNTPROFILEEJB cascade;
DROP TABLE QUOTEEJB cascade;
DROP TABLE KEYGENEJB cascade;
DROP TABLE ACCOUNTEJB cascade;
DROP TABLE ORDEREJB cascade;

CREATE OR REPLACE TABLE HOLDINGEJB
  (PURCHASEPRICE DECIMAL(14, 2) DEFAULT NULL,
   HOLDINGID INTEGER NOT NULL,
   QUANTITY DOUBLE NOT NULL,
   PURCHASEDATE DATE DEFAULT NULL,
   ACCOUNT_ACCOUNTID INTEGER DEFAULT NULL,
   QUOTE_SYMBOL VARCHAR(250) DEFAULT NULL);

ALTER TABLE HOLDINGEJB
  ADD CONSTRAINT PK_HOLDINGEJB PRIMARY KEY (HOLDINGID);

CREATE OR REPLACE TABLE ACCOUNTPROFILEEJB
  (ADDRESS VARCHAR(250) DEFAULT NULL,
   PASSWD VARCHAR(250) DEFAULT NULL,
   USERID VARCHAR(250) NOT NULL,
   EMAIL VARCHAR(250) DEFAULT NULL,
   CREDITCARD VARCHAR(250) DEFAULT NULL,
   FULLNAME VARCHAR(250) DEFAULT NULL);

ALTER TABLE ACCOUNTPROFILEEJB
  ADD CONSTRAINT PK_ACCOUNTPROFILEEJB PRIMARY KEY (USERID);

CREATE OR REPLACE TABLE QUOTEEJB
  (LOW DECIMAL(14, 2) DEFAULT NULL,
   OPEN1 DECIMAL(14, 2) DEFAULT NULL,
   VOLUME DOUBLE NOT NULL,
   PRICE DECIMAL(14, 2) DEFAULT NULL,
   HIGH DECIMAL(14, 2) DEFAULT NULL,
   COMPANYNAME VARCHAR(250) DEFAULT NULL,
   SYMBOL VARCHAR(250) NOT NULL,
   CHANGE1 DOUBLE NOT NULL);

ALTER TABLE QUOTEEJB
  ADD CONSTRAINT PK_QUOTEEJB PRIMARY KEY (SYMBOL);

CREATE TABLE KEYGENEJB
  (KEYVAL INTEGER NOT NULL,
   KEYNAME VARCHAR(250) NOT NULL);

ALTER TABLE KEYGENEJB
  ADD CONSTRAINT PK_KEYGENEJB PRIMARY KEY (KEYNAME);

INSERT INTO KEYGENEJB (KEYNAME,KEYVAL) VALUES ('account', 0);
INSERT INTO KEYGENEJB (KEYNAME,KEYVAL) VALUES ('holding', 0);
INSERT INTO KEYGENEJB (KEYNAME,KEYVAL) VALUES ('order', 0);
  
CREATE TABLE ACCOUNTEJB
  (CREATIONDATE DATE DEFAULT NULL,
   OPENBALANCE DECIMAL(14, 2) DEFAULT NULL,
   LOGOUTCOUNT INTEGER NOT NULL,
   BALANCE DECIMAL(14, 2) DEFAULT NULL,
   ACCOUNTID INTEGER NOT NULL,
   LASTLOGIN DATE DEFAULT NULL,
   LOGINCOUNT INTEGER NOT NULL,
   PROFILE_USERID VARCHAR(250) DEFAULT NULL);

ALTER TABLE ACCOUNTEJB
  ADD CONSTRAINT PK_ACCOUNTEJB PRIMARY KEY (ACCOUNTID);

CREATE TABLE ORDEREJB
  (ORDERFEE DECIMAL(14, 2) DEFAULT NULL,
   COMPLETIONDATE DATE DEFAULT NULL,
   ORDERTYPE VARCHAR(250) DEFAULT NULL,
   ORDERSTATUS VARCHAR(250) DEFAULT NULL,
   PRICE DECIMAL(14, 2) DEFAULT NULL,
   QUANTITY DOUBLE NOT NULL,
   OPENDATE DATE DEFAULT NULL,
   ORDERID INTEGER NOT NULL,
   ACCOUNT_ACCOUNTID INTEGER DEFAULT NULL,
   QUOTE_SYMBOL VARCHAR(250) DEFAULT NULL,
   HOLDING_HOLDINGID INTEGER DEFAULT NULL);

ALTER TABLE ORDEREJB
  ADD CONSTRAINT PK_ORDEREJB PRIMARY KEY (ORDERID);

CREATE INDEX ACCOUNT_USERID ON ACCOUNTEJB(PROFILE_USERID);
CREATE INDEX HOLDING_ACCOUNTID ON HOLDINGEJB(ACCOUNT_ACCOUNTID);
CREATE INDEX ORDER_ACCOUNTID ON ORDEREJB(ACCOUNT_ACCOUNTID);
CREATE INDEX ORDER_HOLDINGID ON ORDEREJB(HOLDING_HOLDINGID);
CREATE INDEX CLOSED_ORDERS ON ORDEREJB(ACCOUNT_ACCOUNTID,ORDERSTATUS);