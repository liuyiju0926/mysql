-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 
-- 伺服器版本： 10.3.16-MariaDB
-- PHP 版本： 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `iii`
--
CREATE DATABASE IF NOT EXISTS `iii` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `iii`;

DELIMITER $$
--
-- 程序
--
DROP PROCEDURE IF EXISTS `addCustomers`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addCustomers` (`newcustomerName` VARCHAR(20), `newphone` VARCHAR(20), `newemail` VARCHAR(100), `newaddress` VARCHAR(200))  begin
    insert into Customers (customerName, phone, email, address) values (newcustomerName, newphone, newemail, newaddress);
      
end$$

DROP PROCEDURE IF EXISTS `addOrderDetails`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addOrderDetails` (`newonumber` VARCHAR(20), `newpnumber` VARCHAR(20), `newunitprice` INT, `quantity` INT)  begin
    insert into `Order Details` (onumber, pnumber, unitprice, quantity) values (newonumber, newpnumber, newunitprice, quantity);
      
end$$

DROP PROCEDURE IF EXISTS `addOrders`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addOrders` (`newonumber` VARCHAR(20), `newphone` VARCHAR(20))  begin
    insert into Orders (onumber, phone) values (newonumber, newphone);
      
end$$

DROP PROCEDURE IF EXISTS `addProducts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addProducts` (`newproductName` VARCHAR(20), `newpnumber` VARCHAR(20), `newrePrice` INT, `newphone` VARCHAR(20))  begin
    insert into Products (productName, pnumber, rePrice, phone) values (newproductName, newpnumber, newrePrice, newphone);
      
end$$

DROP PROCEDURE IF EXISTS `addSuppliers`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addSuppliers` (`newsupplierName` VARCHAR(20), `newphone` VARCHAR(20), `newaddress` VARCHAR(200))  begin
    insert into Suppliers (supplierName, phone, address) values (newsupplierName, newphone, newaddress);
      
end$$

DROP PROCEDURE IF EXISTS `delCustomers`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delCustomers` (`oldcustomerID` INT)  begin
    delete from Customers where customerID = oldcustomerID;
      
end$$

DROP PROCEDURE IF EXISTS `delOrderDetails`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delOrderDetails` (`oldorderID` INT)  begin
    delete from `Order Details` where orderID = oldorderID;
      
end$$

DROP PROCEDURE IF EXISTS `delOrders`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delOrders` (`oldorderID` INT)  begin
    delete from Orders where orderID = oldorderID;
      
end$$

DROP PROCEDURE IF EXISTS `delProducts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delProducts` (`oldproductID` INT)  begin
    delete from Products where productID = oldproductID;
      
end$$

DROP PROCEDURE IF EXISTS `delSuppliers`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delSuppliers` (`oldsupplierID` INT)  begin
    delete from Suppliers where supplierID = oldsupplierID;
      
end$$

DROP PROCEDURE IF EXISTS `selCustomerName`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selCustomerName` (`kw` VARCHAR(20))  begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    set @query = 'select * from customers where customerName like ?';

    prepare stmt from @query;
    execute stmt using @key;    
end$$

DROP PROCEDURE IF EXISTS `selcustomerorder`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selcustomerorder` (`kw` VARCHAR(20))  begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci;
    set @query = 'select c.customername, o.onumber, od.pnumber, od.unitprice, od.quantity from orders o 
    join customers c on (o.phone = c.phone)
    join `order details` od on (o.onumber = od.onumber)
    where c.customername like ?' ;

    prepare stmt from @query;
    execute stmt using @key; 
       
end$$

DROP PROCEDURE IF EXISTS `selcustomerorder1`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selcustomerorder1` (`kw` VARCHAR(20))  begin
    select c.customername, o.onumber from orders o 
    join customers c on (o.phone = c.phone)
    where c.customername like '%kw%';
      
end$$

DROP PROCEDURE IF EXISTS `selcustomerorder2`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selcustomerorder2` (`kw` VARCHAR(20))  begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci;
    set @query = 'select c.customername, o.onumber from orders o 
    join customers c on (o.phone = c.phone)
    where c.customername like ?';

    prepare stmt from @query;
    execute stmt using @key; 
    
      
end$$

DROP PROCEDURE IF EXISTS `selCustomerPhone`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selCustomerPhone` (`kw` VARCHAR(20))  begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    set @query = 'select * from customers where Phone like ?';

    prepare stmt from @query;
    execute stmt using @key;       
end$$

DROP PROCEDURE IF EXISTS `selordercustomer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selordercustomer` (`kw` VARCHAR(20))  begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci;
    set @query = 'select p.productName, p.pnumber, c.customerName, od.quantity from `order details` od
    join products p on (od.pnumber = p.pnumber)
    join orders o on (od.onumber = o.onumber)
    join customers c on (o.phone = c.phone)
    where p.productName like ?' ;

    prepare stmt from @query;
    execute stmt using @key; 
       
end$$

DROP PROCEDURE IF EXISTS `selorderprice`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selorderprice` (`kw` VARCHAR(20))  begin
    set @key = concat(kw) COLLATE utf8_unicode_ci;
    set @query = 'select c.customername, sum(od.unitprice * od.quantity) total from orders o 
    join customers c on (o.phone = c.phone)
    join `order details` od on (o.onumber = od.onumber)
    where c.customername like ?' ;

    prepare stmt from @query;
    execute stmt using @key; 
       
end$$

DROP PROCEDURE IF EXISTS `selorderproduct`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selorderproduct` (`kw` VARCHAR(20))  begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci;
    set @query = 'select s.supplierName, o.onumber, p.productName, p.pnumber, p.reprice from `order details` od
    join orders o on (od.onumber = o.onumber)
    join products p on (od.pnumber = p.pnumber)
    join suppliers s on (p.phone = s.phone)
    where s.supplierName like ?' ;

    prepare stmt from @query;
    execute stmt using @key; 
       
end$$

DROP PROCEDURE IF EXISTS `selProductName`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selProductName` (`kw` VARCHAR(20))  begin
     set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
     set @query = 'select * from products where productName like ?';

    prepare stmt from @query;
    execute stmt using @key; 
        
end$$

DROP PROCEDURE IF EXISTS `selsupplierName`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selsupplierName` (`kw` VARCHAR(20))  begin
      set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    set @query = 'select * from suppliers where supplierName like ?';

    prepare stmt from @query;
    execute stmt using @key;  
        
end$$

DROP PROCEDURE IF EXISTS `selsupplierPhone`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selsupplierPhone` (`kw` VARCHAR(20))  begin
      set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    set @query = 'select * from suppliers where phone like ?';

    prepare stmt from @query;
    execute stmt using @key;  
        
end$$

DROP PROCEDURE IF EXISTS `updCustomers`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updCustomers` (`oldcustomerID` INT, `oldcustomerName` VARCHAR(20), `oldphone` VARCHAR(20), `oldemail` VARCHAR(100), `oldaddress` VARCHAR(200))  begin
    update Customers set customerName = oldcustomerName, phone = oldphone, email = oldemail, address =  oldaddress 
    where customerID = oldcustomerID;
      
end$$

DROP PROCEDURE IF EXISTS `updOrderDetails`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updOrderDetails` (`oldorderID` INT, `oldunitprice` INT, `oldquantity` INT)  begin
    update `Order Details` set unitprice = oldunitprice, quantity = oldquantity
    where orderID = oldorderID;
      
end$$

DROP PROCEDURE IF EXISTS `updProducts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updProducts` (`oldproductID` INT, `oldproductName` VARCHAR(20), `oldpnumber` VARCHAR(20), `oldrePrice` INT, `oldphone` VARCHAR(20))  begin
    update  Products set productName = oldcustomerName, pnumber = oldpnumber, rePrice = oldrePrice, phone =  oldphone 
    where productID = oldproductID;
      
end$$

DROP PROCEDURE IF EXISTS `updSuppliers`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updSuppliers` (`oldsupplierID` INT, `oldsupplierName` VARCHAR(20), `oldphone` VARCHAR(20), `oldaddress` VARCHAR(200))  begin
    update Suppliers set supplierName = oldsupplierName, phone = oldphone, address =  oldaddress 
    where supplierID = oldsupplierID;
      
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 資料表結構 `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `customerID` int(11) NOT NULL,
  `customerName` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的關聯 `customers`:
--

--
-- 傾印資料表的資料 `customers`
--

INSERT INTO `customers` (`customerID`, `customerName`, `phone`, `email`, `address`) VALUES
(1, 'Liu', '0911111111', 'liu@gmail.com', 'Taipei'),
(2, 'Wu', '0922222222', 'wu@gmail.com', 'NewTaipei'),
(3, 'Lin', '0933333333', 'lin@gmail.com', 'Taoyuan'),
(4, 'Chun', '0944444444', 'chun@gmail.com', 'Taichung');

-- --------------------------------------------------------

--
-- 資料表結構 `order details`
--

DROP TABLE IF EXISTS `order details`;
CREATE TABLE `order details` (
  `orderID` int(11) NOT NULL,
  `onumber` varchar(20) DEFAULT NULL,
  `pnumber` varchar(20) DEFAULT NULL,
  `unitprice` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的關聯 `order details`:
--   `onumber`
--       `orders` -> `onumber`
--   `pnumber`
--       `products` -> `pnumber`
--

--
-- 傾印資料表的資料 `order details`
--

INSERT INTO `order details` (`orderID`, `onumber`, `pnumber`, `unitprice`, `quantity`) VALUES
(1, 'o001', 'p001', 90, 20),
(2, 'o002', 'p002', 81, 30),
(3, 'o003', 'p003', 72, 40),
(4, 'o004', 'p004', 54, 40),
(5, 'o005', 'p005', 90, 50),
(6, 'o006', 'p006', 180, 70);

-- --------------------------------------------------------

--
-- 資料表結構 `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `onumber` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的關聯 `orders`:
--   `phone`
--       `customers` -> `phone`
--

--
-- 傾印資料表的資料 `orders`
--

INSERT INTO `orders` (`id`, `onumber`, `phone`) VALUES
(1, 'o001', '0911111111'),
(2, 'o002', '0911111111'),
(3, 'o003', '0922222222'),
(4, 'o004', '0933333333'),
(5, 'o005', '0944444444'),
(6, 'o006', '0944444444');

-- --------------------------------------------------------

--
-- 資料表結構 `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `productID` int(11) NOT NULL,
  `productName` varchar(20) DEFAULT NULL,
  `pnumber` varchar(20) DEFAULT NULL,
  `rePrice` int(11) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的關聯 `products`:
--   `phone`
--       `suppliers` -> `phone`
--

--
-- 傾印資料表的資料 `products`
--

INSERT INTO `products` (`productID`, `productName`, `pnumber`, `rePrice`, `phone`) VALUES
(1, 'clothes', 'p001', 100, '0921111111'),
(2, 'hat', 'p002', 90, '0921111111'),
(3, 'pants', 'p003', 80, '0921222222'),
(4, 'sock', 'p004', 60, '0931111111'),
(5, 'shoes', 'p005', 100, '0931111111'),
(6, 'coat', 'p006', 200, '0941111111');

-- --------------------------------------------------------

--
-- 資料表結構 `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers` (
  `supplierID` int(11) NOT NULL,
  `supplierName` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的關聯 `suppliers`:
--

--
-- 傾印資料表的資料 `suppliers`
--

INSERT INTO `suppliers` (`supplierID`, `supplierName`, `phone`, `address`) VALUES
(1, 'Liu1', '0921111111', 'Taipei'),
(2, 'Wu1', '0921222222', 'Miaoli'),
(3, 'Chun', '0931111111', 'Pingtung'),
(4, 'Lin1', '0941111111', 'Changhua');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customerID`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- 資料表索引 `order details`
--
ALTER TABLE `order details`
  ADD PRIMARY KEY (`orderID`),
  ADD KEY `number` (`onumber`),
  ADD KEY `pnumber` (`pnumber`);

--
-- 資料表索引 `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `number` (`onumber`),
  ADD KEY `phone` (`phone`);

--
-- 資料表索引 `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productID`),
  ADD UNIQUE KEY `number` (`pnumber`),
  ADD KEY `phone` (`phone`);

--
-- 資料表索引 `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplierID`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `customers`
--
ALTER TABLE `customers`
  MODIFY `customerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `order details`
--
ALTER TABLE `order details`
  MODIFY `orderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `products`
--
ALTER TABLE `products`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplierID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `order details`
--
ALTER TABLE `order details`
  ADD CONSTRAINT `order details_ibfk_1` FOREIGN KEY (`onumber`) REFERENCES `orders` (`onumber`),
  ADD CONSTRAINT `order details_ibfk_2` FOREIGN KEY (`pnumber`) REFERENCES `products` (`pnumber`);

--
-- 資料表的限制式 `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`phone`) REFERENCES `customers` (`phone`);

--
-- 資料表的限制式 `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`phone`) REFERENCES `suppliers` (`phone`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
