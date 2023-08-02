CREATE USER 'order_user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON order_service_db.* TO 'order_user'@'%';