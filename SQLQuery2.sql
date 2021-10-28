--Assignment2
--Jianyu Yu
--#1. What is Result Table
-- The resulting tables from a written query 

--#2 What is the difference between Union and Union All?
-- Union will combine the tables but removes duplicates, Union all keeps the duplicates even if thye do not meet the condition 

--#3 What are the other Set Operators SQL Server has?
-- Intersect and minus

--$4 What is the difference between Union and Join?
-- Join combines data from tables based on a matched condition; Union combines data from two result sets

--#5 What is the difference between INNER JOIN and FULL JOIN?
-- inner join will join entries that match a condition while full join joins all data regardless if they meet the condition

--#6 What is difference between left join and outer join
-- left join brings together the data from the left table that meets the condition while outer join will always put the data from the outer table if if the condition is not met

--#7 What is cross join?
-- cross join retrun all of the combinations of the two tables 

--#8 What is the difference between WHERE clause and HAVING clause?
-- where goes before aggregations, having goes after aggregations, where can be used with SELECT and UPDATE

--#9 Can there be multiple group by columns?
-- yes 

--SQL QUERIES
USE AdventureWorks2019
GO

--1.
SELECT COUNT(ProductID) AS [Number Of Products]
FROM Production.Product

--2
SELECT COUNT(ProductID) AS [Number Of Products]
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL

--3
SELECT psc.ProductSubcategoryID AS ProductSubCategoryID, COUNT(ProductID) AS CountedProducts
FROM Production.ProductSubCategory psc JOIN Production.Product p ON psc.ProductSubcategoryID = p.ProductSubcategoryID
GROUP BY psc.ProductSubcategoryID
ORDER BY CountedProducts DESC

--4
SELECT COUNT(ProductID) AS [Number Of Products]
FROM Production.Product
WHERE ProductSubcategoryID IS NULL 

--5
SELECT SUM(Quantity) AS [Total Product]
FROM Production.ProductInventory

--6
SELECT ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) < 100

--7
SELECT Shelf, ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY Shelf, ProductID
HAVING SUM(Quantity) < 100

--8
SELECT AVG(Quantity) AS AverageQuantity
FROM Production.ProductInventory
WHERE LocationID = 10

--9
SELECT ProductID, Shelf, AVG(Quantity) AS AVGShelfQuantity
FROM Production.ProductInventory
GROUP BY ProductID, Shelf

--10
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
WHERE Shelf IS NOT NULL
GROUP BY ProductID, Shelf

--11
SELECT Color, Class, Count(ProductID), AVG(ListPrice)
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class

--12
SELECT pcr.Name, psp.Name
FROM Person.CountryRegion pcr JOIN Person.StateProvince psp ON pcr.CountryRegionCode = psp.CountryRegionCode
ORDER BY pcr.name DESC

--13
SELECT pcr.Name, psp.Name
FROM Person.CountryRegion pcr JOIN Person.StateProvince psp ON pcr.CountryRegionCode = psp.CountryRegionCode
WHERE pcr.Name != 'Germany' AND pcr.Name != 'France'
ORDER BY pcr.name DESC

--Northwind Queries
USE Northwind
GO
--14
SELECT od.ProductID, o.OrderDate
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) > '1996'

--15
SELECT TOP 5 o.ShipPostalCode, (od.UnitPrice * od.Quantity) AS TotalSold
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID
ORDER BY TotalSold DESC

--16
SELECT TOP 5 o.ShipPostalCode, (od.UnitPrice * od.Quantity) AS TotalSold
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) > '1996'
ORDER BY TotalSold DESC

--17
SELECT c1.City, COUNT(c2.CustomerID) AS [Number Of Customers]
FROM Customers c1 JOIN Customers c2 ON c1.CustomerID = c2.CustomerID
GROUP BY c1.City

--18
SELECT c1.City, COUNT(c2.CustomerID) AS [Number Of Customers]
FROM Customers c1 JOIN Customers c2 ON c1.CustomerID = c2.CustomerID
GROUP BY c1.City
HAVING COUNT(c2.CustomerID) > 2

--19
SELECT c.ContactName, o.OrderDate
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate > '1/1/1998'

--20
SELECT c.ContactName, MAX(o.OrderDate)
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.ContactName

--21
SELECT c.ContactName, COUNT(o.OrderID) AS [Number Of Orders]
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.ContactName

--22
SELECT c.CustomerID, COUNT(o.OrderID) AS [Number Of Orders]
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID
HAVING COUNT(o.OrderID) > 100

--23
SELECT su.CompanyName AS [Supplier Company Name], sh.CompanyName AS [Shipping Company Name]
FROM Orders o JOIN Shippers sh ON o.ShipVia = sh.ShipperID JOIN Suppliers su ON su.City = o.ShipCity

--24
SELECT o.OrderDate, p.ProductName
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderDate ASC
--25
SELECT e1.FirstName + e1.LastName AS [Employee 1 Name], e2.FirstName + e2.LastName AS [Employee 2 Name], e1.Title
FROM Employees e1 JOIN Employees e2 ON e1.Title = e2.Title
--26
SELECT e1.FirstName, e1.LastName, e1.Title, COUNT(e2.ReportsTo) AS Subordinates
FROM Employees e1 JOIN Employees e2 ON e1.EmployeeID = e2.ReportsTo
WHERE (e2.ReportsTo = e1.EmployeeID)
GROUP BY e1.LastName, e1.FirstName, e1.Title

--27
SELECT c.City, c.ContactName AS Name, s.ContactName
FROM Customers c FULL JOIN Suppliers s ON c.City = s.City


