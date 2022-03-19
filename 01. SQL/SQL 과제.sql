#1
SELECT country, COUNT(DISTINCT offices.officeCode) as officeCounts, COUNT(employeeNumber) as employeeCounts
FROM offices
LEFT JOIN employees
ON offices.officecode = employees.officecode
GROUP BY country;

#2
SELECT *
FROM customers
WHERE contactFirstName LIKE 'R%';

#3
SELECT orders.status, count(orderNumber) as orderCounts
FROM customers
LEFT JOIN orders on orders.customerNumber = customers.customerNumber
where country = "USA"
group by 1
Having status = 'Cancelled' or status = 'On Hold';

#4
SELECT table1.officeCode, table1.counts as 고객수
FROM (
	SELECT officeCode, COUNT(customerNumber) as counts
	FROM customers
	LEFT JOIN employees
	ON salesRepEmployeeNumber = employeeNumber
	WHERE salesRepEmployeeNumber is not null
	GROUP BY officeCode
	) table1
ORDER BY table1.counts desc
limit 1;

#5
SELECT *
FROM customers as C
JOIN (SELECT p.customerNumber, SUM(amount) as payAmounts
	FROM payments as p
	LEFT JOIN customers as c
	ON p.customerNumber = c.customerNumber
	WHERE paymentDate LIKE '2004-11%'
	GROUP BY p.customerNumber
	ORDER BY payAmounts desc
	limit 1) as A
ON C.customerNumber = A.customerNumber;

#6
SELECT MAX(datediff(shippedDate,orderDate)) as 최대소요기간, MIN(datediff(shippedDate,orderDate)) as 최소소요기간
FROM orders
WHERE orderDate LIKE '2005-01%';

#7
SELECT t2.customerNumber as purchasingKing, employees.*
FROM (
    SELECT customers.*, t1.amount
	FROM (
		SELECT customerNumber, SUM(amount) as amount
		FROM payments
		WHERE paymentDate LIKE '2004%'
		GROUP BY customerNumber
	) t1
	INNER JOIN customers ON t1.customerNumber = customers.customerNumber
    ORDER BY amount desc
    limit 1
    ) t2
INNER JOIN employees
ON employees.employeeNumber = t2.salesRepEmployeeNumber;