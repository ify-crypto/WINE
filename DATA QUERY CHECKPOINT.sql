

CREATE TABLE PRODUCTS(
ProductID VARCHAR(6) Primary Key  NOT NULL,
ProductName varchar(15) not null,
ProductType varchar(15) not null,
Price Float
);

DROP TABLE PRODUCTS

CREATE TABLE CUSTOMERS(
CUSTOMERID VARCHAR(6) PRIMARY KEY NOT NULL,
CUSTOMER_NAME VARCHAR(15) NOT NULL,
EMAIL VARCHAR(30) NOT NULL,
PHONE VARCHAR (17) NOT NULL,
);



CREATE TABLE ORDERS(
ORDERID VARCHAR (10) PRIMARY KEY NOT NULL,
ORDER_DATE DATE NOT NULL,
CUSTOMERID VARCHAR(6)FOREIGN KEY REFERENCES CUSTOMERS(CUSTOMERID)
);


CREATE TABLE ORDERDETAILS(
ORDERDETAILID VARCHAR (10)PRIMARY KEY NOT NULL,
QUANTITY INT NOT NULL,
ORDERID VARCHAR (10) FOREIGN KEY REFERENCES ORDERS(ORDERID),
ProductID VARCHAR(6) FOREIGN KEY REFERENCES PRODUCTS(ProductID)
);

DROP TABLE ORDERDETAILS



CREATE TABLE PRODUCTTYPES(
PRODUCT_TYPE_ID VARCHAR(7) PRIMARY KEY NOT NULL,
PRODUCT_TYPE_NAME VARCHAR(10) NOT NULL
);


INSERT INTO Products values
('P1','WIDGET A','WIDGET',10.00),
('P2','WIDGET B','WIDGET',15.00),
('P3','GADGET X','GADGET',20.00),
('P4','GADGET Y','GADGET',25.00),
('P5','DOOHICKEY Z','DOOHICKEY',30.00);



INSERT INTO CUSTOMERS VALUES
('C1','JOHN SMITH','john@example.com','123-456-7890'),
('C2','JANE DOE','jane.doe@example.com','987-654-3210'),
('C3','ALICE BROWN','alice.brown@example.com','456-789-0123');



INSERT INTO ORDERS VALUES
('OD101','2024-05-01','C1'),
('OD102','2024-05-02','C2'),
('OD103','2024-05-01','C3');


INSERT INTO ORDERDETAILS VALUES
('ORD101',2,'OD101','P1'),
('ORD102',1,'OD101','P3'),
('ORD103',3,'OD102','P2'),
('ORD104',2,'OD102','P4'),
('ORD105',1,'OD103','P5');



INSERT INTO PRODUCTTYPES VALUES
('PT101','WIDGET'),
('PT102','GADGET'),
('PT103','DOOHICKEY');

--Retrieve all products.
select*from[dbo].[PRODUCTS]

--Retrieve all customers.
select*from[dbo].[CUSTOMERS]

--Retrieve all orders.
select*from[dbo].[ORDERS]

--Retrieve all order details.
select*from[dbo].[ORDERDETAILS] 

--Retrieve all product types.
select*from[dbo].[PRODUCTTYPES]



--Retrieve the names of the products that have been ordered by at least one customer, 
--along with the total quantity of each product ordered.


SELECT*FROM[dbo].[ORDERDETAILS]
SELECT*FROM[dbo].[PRODUCTS]
SELECT*FROM[dbo].[ORDERS]



SELECT P.ProductName,OD.CUSTOMERID,SUM(ORD.QUANTITY) AS TOTAL_QUANTITY
FROM[dbo].[PRODUCTS]P
LEFT JOIN [dbo].[ORDERDETAILS]ORD
ON P.ProductID = ORD.ProductID
LEFT JOIN [dbo].[ORDERS]OD
ON ORD.ORDERID = OD.ORDERID
WHERE ORD.QUANTITY >= 1
GROUP BY P.ProductName,OD.CUSTOMERID



--Retrieve the names of the customers who have placed an order on every day of the week,
--along with the total number of orders placed by each customer.

SELECT*FROM[dbo].[CUSTOMERS]  
SELECT*FROM[dbo].[ORDERS]
SELECT*FROM[dbo].[ORDER_DETAILS]

SELECT C.CUSTOMER_NAME,OD.ORDER_DATE,SUM(ORD.QUANTITY) AS TOTAL_ORD
FROM[dbo].[CUSTOMERS]C
LEFT JOIN [dbo].[ORDERS] OD
ON C.CUSTOMERID = OD.CUSTOMERID
LEFT JOIN [dbo].[ORDERDETAILS]ORD 
ON  ORD.ORDERID = OD.ORDERID
WHERE DATEPART(WEEKDAY,OD.ORDER_DATE) IN ('01','02')
GROUP BY C.CUSTOMER_NAME,OD.ORDER_DATE


--Retrieve the names of the customers who have placed the most orders,
--along with the total number of orders placed by each customer.

SELECT  C.CUSTOMER_NAME,COUNT(ORD.QUANTITY) AS NO_ORD,SUM(ORD.QUANTITY) AS TOTAL_ORD
FROM[dbo].[CUSTOMERS]C
LEFT JOIN [dbo].[ORDERS] OD
ON C.CUSTOMERID = OD.CUSTOMERID
LEFT JOIN [dbo].[ORDERDETAILS]ORD 
ON  ORD.ORDERID = OD.ORDERID
GROUP BY C.CUSTOMER_NAME
ORDER BY COUNT(ORD.QUANTITY),SUM(ORD.QUANTITY)desc


--Retrieve the names of the products that have been ordered the most, 
 --along with the total quantity of each product ordered.
  
  SELECT*FROM[dbo].[PRODUCTS]
  SELECT*FROM[dbo].[ORDERDETAILS]


SELECT P.ProductName,SUM(ORD.QUANTITY) as  Total_quantity
FROM[dbo].[PRODUCTS] P
LEFT JOIN [dbo].[ORDERDETAILS] ORD
ON P.ProductID = ORD.ProductID
group by P.ProductName
order by SUM(ORD.QUANTITY) desc 



--Retrieve the names of customers who have placed an order for at least one widget.

select* from[dbo].[CUSTOMERS]
select* from[dbo].[ORDERS]
SELECT * FROM [dbo].[ORDERDETAILS]
SELECT* FROM[dbo].[PRODUCTS]

SELECT C.CUSTOMER_NAME,P.ProductType
from[dbo].[CUSTOMERS]C
 LEFT JOIN [dbo].[ORDERS]OD
ON C.CUSTOMERID = OD.CUSTOMERID
 LEFT JOIN [dbo].[ORDERDETAILS]ORD
ON OD.ORDERID = ORD.ORDERID
 LEFT JOIN [dbo].[PRODUCTS]P
ON ORD.ProductID = P.ProductID
where ProductType =' WIDGET' AND
ORD.QUANTITY >=1


--Retrieve the names of the customers who have placed an order for at least one widget and at least one gadget, 
--along with the total cost of the widgets and gadgets ordered by each customer.


SELECT C.CUSTOMER_NAME,P.ProductType,SUM(P.Price)as Total_price
from[dbo].[CUSTOMERS]C
 LEFT JOIN [dbo].[ORDERS]OD
ON C.CUSTOMERID = OD.CUSTOMERID
 LEFT JOIN [dbo].[ORDERDETAILS]ORD
ON OD.ORDERID = ORD.ORDERID
 LEFT JOIN [dbo].[PRODUCTS]P
ON ORD.ProductID = P.ProductID
where P. ProductType  IN (' WIDGET' , 'GADGET') 
and ORD.QUANTITY   >1
group by C.CUSTOMER_NAME,P.ProductType


--Retrieve the names of the customers who have placed an order for at least one gadget,
--along with the total cost of the gadgets ordered by each customer.

select* from[dbo].[CUSTOMERS]
select* from[dbo].[ORDERS]
SELECT * FROM [dbo].[ORDERDETAILS]
SELECT* FROM[dbo].[PRODUCTS]

SELECT C.CUSTOMER_NAME,P.ProductType,SUM(P.Price)as Total_price
from[dbo].[CUSTOMERS]C
  JOIN [dbo].[ORDERS]OD
ON C.CUSTOMERID = OD.CUSTOMERID
  JOIN [dbo].[ORDERDETAILS]ORD
ON OD.ORDERID = ORD.ORDERID
  JOIN [dbo].[PRODUCTS]P
ON ORD.ProductID = P.ProductID
where ProductType =' GADGET' AND
ORD.QUANTITY >=1
group by C.CUSTOMER_NAME,P.ProductType


--Retrieve the names of the customers who have placed an order for at least one doohickey, 
--along with the total cost of the doohickeys ordered by each customer.

SELECT C.CUSTOMER_NAME,P.ProductType,SUM(P.Price)as Total_price
from[dbo].[CUSTOMERS]C
  JOIN [dbo].[ORDERS]OD
ON C.CUSTOMERID = OD.CUSTOMERID
  JOIN [dbo].[ORDERDETAILS]ORD
ON OD.ORDERID = ORD.ORDERID
  JOIN [dbo].[PRODUCTS]P
ON ORD.ProductID = P.ProductID
where ProductType =' DOOHICKEY' AND
ORD.QUANTITY <=1
group by C.CUSTOMER_NAME,P.ProductType

-- Retrieve the names of the customers who have placed an order every day of the week, 
-- along with the total number of orders placed by each customer.

SELECT C.CUSTOMER_NAME,OD.ORDER_DATE,SUM(ORD.QUANTITY) AS TOTAL_ORD
FROM[dbo].[CUSTOMERS]C
LEFT JOIN [dbo].[ORDERS] OD
ON C.CUSTOMERID = OD.CUSTOMERID
LEFT JOIN [dbo].[ORDERDETAILS]ORD 
ON  ORD.ORDERID = OD.ORDERID
WHERE DATEPART(WEEKDAY,OD.ORDER_DATE) IN ('01','02')
GROUP BY C.CUSTOMER_NAME,OD.ORDER_DATE


--Retrieve the total number of widgets and gadgets ordered by each customer,
 --along with the total cost of the orders.--
SELECT* FROM[dbo].[PRODUCTS]
SELECT* FROM[dbo].[ORDERDETAILS]
select* from[dbo].[ORDERS]

SELECT OD.CUSTOMERID,count(ORD.QUANTITY) AS TOTAL_NO_OF_PR,SUM(P.Price) as Total_price
from[dbo].[PRODUCTS]P
LEFT JOIN [dbo].[ORDERDETAILS] ORD
ON P.ProductID = ORD.ProductID
RIGHT JOIN[dbo].[ORDERS]OD
ON ORD.ORDERID = OD.ORDERID
GROUP BY OD.CUSTOMERID

