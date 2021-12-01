 -- BASE
    -- Get all customers and their addresses.
        SELECT first_name, last_name, street, city, state, zip FROM 
        customers JOIN addresses ON customers.id=addresses.customer_id
        ORDER BY last_name ASC;
    -- Get all orders and their line items (orders, quantity and product).
        SELECT order_id, order_date, description, quantity, unit_price FROM
        orders JOIN line_items ON orders.id=line_items.order_id
        JOIN products ON line_items.product_id=products.id
        ORDER BY order_id ASC;
    -- Which warehouses have cheetos?
        SELECT warehouse, description, on_hand, unit_price FROM 
        warehouse JOIN warehouse_product ON warehouse.id=warehouse_product.warehouse_id
        JOIN products ON products.id=warehouse_product.product_id
        WHERE products.description='cheetos';
    -- Which warehouses have diet pepsi?
        SELECT warehouse, description, on_hand, unit_price FROM 
        warehouse JOIN warehouse_product ON warehouse.id=warehouse_product.warehouse_id
        JOIN products ON products.id=warehouse_product.product_id
        WHERE products.description='diet pepsi';
    -- Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
        SELECT
            f.first_name,
            f.last_name,
            COUNT(e.id) AS order_count
        FROM
            customers f
        JOIN addresses d ON d.customer_id=f.id
        LEFT JOIN orders e ON e.address_id=d.id
        GROUP BY
            f.first_name, f.last_name
        ORDER BY
            order_count DESC;
    -- How many customers do we have?
        SELECT COUNT(customers.id) AS customer_count
        FROM customers;
    -- How many products do we carry?
        SELECT COUNT(products.id) AS product_count
        FROM products;
    -- What is the total available on-hand quantity of diet pepsi?
        SELECT 
            description, SUM (on_hand) AS total_on_hand
        FROM 
            warehouse 
        JOIN 
            warehouse_product ON warehouse.id=warehouse_product.warehouse_id
        JOIN 
            products ON products.id=warehouse_product.product_id
        WHERE
            description='diet pepsi'
        GROUP BY
            description;

-- STRETCH
    -- How much was the total cost for each order?
    -- How much has each customer spent in total?
    -- How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).