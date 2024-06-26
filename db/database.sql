create database if not exists toyskingdomdata;

drop database toyskingdomdata;

use toyskingdomdata;



create table users
(
    id_user      int auto_increment primary key,
    email        varchar(50) unique     not null,
    password     nvarchar(200)          not null,
    full_name    nvarchar(50)           not null,
    phone_number varchar(20),
    address      nvarchar(200),
    birthday     date,
    role         ENUM ('USER', 'ADMIN') not null default 'USER',
    active       bit                             default 1
) AUTO_INCREMENT = 100000;

CREATE TABLE categories
(
    id_category   varchar(10) PRIMARY KEY,
    category_name NVARCHAR(50) NOT NULL,
    description   TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
);



create table products
(
    id_product   int auto_increment primary key,
    id_category  varchar(10),
    product_name nvarchar(50) not null,
    des          TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    image        nvarchar(100)  default 'product.png',
    price        decimal(14, 2) default 0,
    unit         nvarchar(20)   default 'Cái',
    quantity     decimal(10, 2) default 0,
    active       bit            default 1,
    foreign key (id_category) references categories (id_category)
) AUTO_INCREMENT = 1000;


create table discounts
(
    id_discount      int auto_increment primary key,
    id_prduct        int,
    discount_percent decimal(5, 2) not null,
    start_day        datetime      not null,
    end_day          datetime      not null,
    active           bit default 1,
    foreign key (id_prduct) references products (id_product)
) AUTO_INCREMENT = 2000;

create table orders
(
    id_order   int auto_increment primary key,
    id_user    int,
    order_date datetime                              default current_timestamp,
    total      decimal(15, 2),
    status     ENUM ('PENDING', 'PAID', 'CANCELLED') default 'PENDING',
    foreign key (id_user) references users (id_user)
) AUTO_INCREMENT = 300000;

create table order_items
(
    id_order_item  int auto_increment primary key,
    id_order       int,
    id_product     int,
    order_quantity int          default 1,
    price          decimal(13, 2) not null,
    unit           nvarchar(20) default 'Cái',
    foreign key (id_order) references orders (id_order),
    foreign key (id_product) references products (id_product)
) AUTO_INCREMENT = 100000;

# INSERT Dữ liệu
INSERT INTO users (email, password, full_name, phone_number, address, birthday, role, active)
VALUES ('huynhbaomts2004@gmail.com', '123123', 'Bảo', '0388319013', 'Gò vấp, Hồ Chí Minh', '2000-01-01', 'ADMIN', 1),
       ('kiet@gmail.com', '123123', 'Đình Kiệt', '0388319013', 'Gò vấp, Hồ Chí Minh', '2000-01-01', 'ADMIN', 1),
       ('giabao@gmail.com', '123123', 'Gia Bảo', '0388319013', 'Gò vấp, Hồ Chí Minh', '2000-01-01', 'ADMIN', 1),
       ('lynguyenhoa102@gmail.com', '123123', 'Hoà', '0338997477', 'Gò vấp, Hồ Chí Minh', '2004-05-08', 'ADMIN', 1),
       ('superherovhv@gmail.com', '123123', 'Zinh', '0338997477', 'Gò vấp, Hồ Chí Minh', '2004-05-08', 'ADMIN', 1),
       ('han@gmail.com', '123123', 'Hữu Hàn', '0388319013', 'Gò vấp, Hồ Chí Minh', '2000-06-24', 'ADMIN', 1);

insert into categories(id_category, category_name, description)
values ('RB', 'Robot', 'robot, siêu anh hùng'),
       ('BB', 'Búp bê', 'Búp bê baby biết múa biết bay');



INSERT INTO products (product_name, id_category, des, image, price, unit, quantity, active)
VALUES ('Xe Đạp Trẻ Em', 'RB', 'Xe đạp 3 bánh cho trẻ em, màu xanh lá', 'OIP.jpg', 850000.00, 'Cái', 15, 1),
       ('Búp Bê Barbie', 'BB', 'Búp bê Barbie phiên bản công chúa', 'bup-be.jpg', 550000.00, 'Cái', 30, 1),
       ('Lego Classic', 'BB', 'Bộ xếp hình Lego Classic với 500 mảnh', 'lego.jpg', 1200000.00, 'Hộp', 20, 1),
       ('Đồ Chơi Nhà Bếp', 'BB', 'Bộ đồ chơi nhà bếp mini', 'dochoibep.jpg', 300000.00, 'Bộ', 50, 1),
       ('Ô Tô Điều Khiển Từ Xa', 'BB', 'Ô tô điều khiển từ xa màu đỏ', 'xe.jpg', 650000.00, 'Cái', 25, 1),
       ('Gấu Bông Teddy', 'RB', 'Gấu bông Teddy cỡ lớn, cao 1m', 'gauteddy.jpg', 450000.00, 'Cái', 40, 1),
       ('Bảng Vẽ Thông Minh', 'RB', 'Bảng vẽ thông minh cho bé', 'bangve.jpg', 200000.00, 'Cái', 35, 1),
       ('Bộ Đồ Chơi Lắp Ráp', 'RB', 'Bộ đồ chơi lắp ráp mô hình ô tô', 'dolaprap.jpg', 350000.00, 'Bộ', 45, 1),
       ('Bộ Xếp Hình 3D', 'RB', 'Bộ xếp hình 3D sáng tạo', 'lego3d.jpg', 500000.00, 'Bộ', 20, 1),
       ('Đàn Piano Điện Tử', 'RB', 'Đàn piano điện tử mini cho bé', 'dan.jpg', 1500000.00, 'Cái', 10, 1);


# Bảng phụ

CREATE VIEW product_feature AS
SELECT p.id_product,
       p.id_category,
       p.product_name,
       p.des,
       p.image,
       p.price,
       COALESCE(d.discount_percent, 0) AS discount_percent,
       p.active
FROM products p
         LEFT JOIN
     discounts d
     ON
         p.id_product = d.id_prduct
             AND p.active = 1
             AND d.active = 1
             AND NOW() BETWEEN d.start_day AND d.end_day
WHERE p.active = 1;


# PROCEDURE pờ rô si trơ ------------------------------------------------------------------

CREATE PROCEDURE get_Quantity_Product(IN start INT, IN quantity INT)
BEGIN
    SELECT id_product,
           id_category,
           product_name,
           des,
           image,
           price,
           discount_percent
    FROM product_feature
    LIMIT start, quantity;
END;

DELIMITER //

CREATE PROCEDURE delete_order_items_with_zero_quantity(IN order_id INT)
BEGIN
    DELETE
    FROM order_items
    WHERE id_order = order_id
      AND order_quantity <= 0;
END //

DELIMITER ;


# TRIGER ------------------------------------------------


DELIMITER //

CREATE TRIGGER update_order_total_after_insert
    AFTER INSERT
    ON order_items
    FOR EACH ROW
BEGIN
    DECLARE order_total DECIMAL(15, 2);

    SELECT SUM(price * order_quantity)
    INTO order_total
    FROM order_items
    WHERE id_order = NEW.id_order;

    UPDATE orders
    SET total = IFNULL(order_total, 0.00)
    WHERE id_order = NEW.id_order;
END //

CREATE TRIGGER update_order_total_after_update
    AFTER UPDATE
    ON order_items
    FOR EACH ROW
BEGIN
    DECLARE order_total DECIMAL(15, 2);

    SELECT SUM(price * order_quantity)
    INTO order_total
    FROM order_items
    WHERE id_order = NEW.id_order;

    UPDATE orders
    SET total = IFNULL(order_total, 0.00)
    WHERE id_order = NEW.id_order;
END //

CREATE TRIGGER update_order_total_after_delete
    AFTER DELETE
    ON order_items
    FOR EACH ROW
BEGIN
    DECLARE order_total DECIMAL(15, 2);

    SELECT SUM(price * order_quantity)
    INTO order_total
    FROM order_items
    WHERE id_order = OLD.id_order;

    UPDATE orders
    SET total = IFNULL(order_total, 0.00)
    WHERE id_order = OLD.id_order;
END //

DELIMITER ;


select *
from order_items