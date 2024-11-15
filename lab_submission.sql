-- (i) A Procedure called PROC_LAB5
DELIMITER$$
CREATE PROCEDURE PROC_LAB5(IN customerNumber INT)
BEGIN
SELECT
customers.customerNumber,
customers.customerName,
SUM(orders.amount) AS totalOrderAmount,
payments.paymentDate,
payments.amount AS paymentAmount
FROM
customers
JOIN
orders ON customers.customerNumber = orders.customerNumber
LEFT JOIN 
payment ON customers.customerNumber = payment.customerNumber
WHERE
customer.customerNumber = customerNumber
GROUP BY 
customer.customerNumber, payment.paymentDate;
END;
DELIMITER; 



-- (ii) A Function called FUNC_LAB5
DELIMITER//
CREATE FUNCTION FUNC_LAB5(customerNumber INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC 
BEGIN 
DECLARE total_payment DECIMAL (10, 2);
select sum (amount) INTO total_payment
FROM payments
WHERE customerNumber = customerNumber;
RETURN IFNULL(total_payment, 0);
END //
DELIMITER;


-- (iii) A View called VIEW_LAB5
CREATE VIEW 'VIEW_LAB5' AS 
SELECT
products.productCode AS 'Product Code',
products.productName AS 'Product Name',
productlines.productLine AS 'Product Line',
SUM(orderdetails.quantityOrdered) AS 'Total Quantity Ordered'
FROM
products
JOIN
productlines ON products.productLine = products.productLine
JOIN
orderdetails ON products.productCode = products.productCode
GROUP BY
products.productCode, products.productName, products.productLine
ORDER BY
'Total QuantityOrdered'DESC;