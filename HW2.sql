/* 新增客戶資料 */
\d #
create procedure addCustomers(newcustomerName varchar(20), newphone varchar(20), newemail varchar(100), newaddress varchar(200)) 

begin
    insert into Customers (customerName, phone, email, address) values (newcustomerName, newphone, newemail, newaddress);
      
end #
\d ; 
--------------------------------
/* 刪除客戶資料 */
\d #
create procedure delCustomers(oldcustomerID int) 

begin
    delete from Customers where customerID = oldcustomerID;
      
end #
\d ;
--------------------------------
/* 修改客戶資料 */
\d #
create procedure updCustomers(oldcustomerID int, oldcustomerName varchar(20), oldphone varchar(20), oldemail varchar(100), oldaddress varchar(200)) 

begin
    update Customers set customerName = oldcustomerName, phone = oldphone, email = oldemail, address =  oldaddress 
    where customerID = oldcustomerID;
      
end #
\d ;
-------------------------------
/* 使用客戶名字查詢客戶資料 */
\d #
create procedure selCustomerName(kw varchar(20)) 

begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    set @query = 'select * from customers where customerName like ?';

    prepare stmt from @query;
    execute stmt using @key;    
end #
\d ;
-------------------------------
/* 使用客戶電話查詢客戶資料 */
\d #
create procedure selCustomerPhone(kw varchar(20)) 

begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    set @query = 'select * from customers where Phone like ?';

    prepare stmt from @query;
    execute stmt using @key;       
end #
\d ;
----------------------------------------------
/* 新增供應商資料 */
\d #
create procedure addSuppliers(newsupplierName varchar(20), newphone varchar(20), newaddress varchar(200)) 

begin
    insert into Suppliers (supplierName, phone, address) values (newsupplierName, newphone, newaddress);
      
end #
\d ; 
--------------------------------
/* 刪除供應商資料 */
\d #
create procedure delSuppliers(oldsupplierID int) 

begin
    delete from Suppliers where supplierID = oldsupplierID;
      
end #
\d ;
--------------------------------
/* 修改供應商資料 */
\d #
create procedure updSuppliers(oldsupplierID int, oldsupplierName varchar(20), oldphone varchar(20), oldaddress varchar(200)) 

begin
    update Suppliers set supplierName = oldsupplierName, phone = oldphone, address =  oldaddress 
    where supplierID = oldsupplierID;
      
end #
\d ;
-------------------------------
/* 使用供應商名字查詢供應商資料*/
\d #
create procedure selsupplierName(kw varchar(20)) 

begin
      set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    set @query = 'select * from suppliers where supplierName like ?';

    prepare stmt from @query;
    execute stmt using @key;  
        
end #
\d ;
-------------------------------
/* 使用供應商電話查詢供應商資料*/
\d #
create procedure selsupplierPhone(kw varchar(20)) 

begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
    set @query = 'select * from suppliers where phone like ?';

    prepare stmt from @query;
    execute stmt using @key;  
        
end #
\d ;
-------------------------------
/* 新增商品資料 */
\d #
create procedure addProducts(newproductName varchar(20), newpnumber varchar(20), newrePrice int, newphone varchar(20)) 

begin
    insert into Products (productName, pnumber, rePrice, phone) values (newproductName, newpnumber, newrePrice, newphone);
      
end #
\d ; 
--------------------------------
/* 刪除商品資料 */
\d #
create procedure delProducts(oldproductID int) 

begin
    delete from Products where productID = oldproductID;
      
end #
\d ;
--------------------------------
/* 修改商品資料 */
\d #
create procedure updProducts(oldproductID int, oldproductName varchar(20), oldpnumber varchar(20), oldrePrice int, oldphone varchar(20)) 

begin
    update  Products set productName = oldcustomerName, pnumber = oldpnumber, rePrice = oldrePrice, phone =  oldphone 
    where productID = oldproductID;
      
end #
\d ;
-------------------------------
/* 使用商品名稱查詢商品資料*/
\d #
create procedure selProductName(kw varchar(20)) 

begin
     set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci; 
     set @query = 'select * from products where productName like ?';

    prepare stmt from @query;
    execute stmt using @key; 
        
end #
\d ;
-------------------------------
/* 新增訂單資料 */
\d #
create procedure addOrders(newonumber varchar(20), newphone varchar(20)) 

begin
    insert into Orders (onumber, phone) values (newonumber, newphone);
      
end #
\d ; 
--------------------------------
/* 刪除訂單資料 */
\d #
create procedure delOrders(oldorderID int) 

begin
    delete from Orders where orderID = oldorderID;
      
end #
\d ;
--------------------------------
/* 新增訂單明細資料 */
\d #
create procedure addOrderDetails(newonumber varchar(20), newpnumber varchar(20), newunitprice int, quantity int) 

begin
    insert into `Order Details` (onumber, pnumber, unitprice, quantity) values (newonumber, newpnumber, newunitprice, quantity);
      
end #
\d ; 
--------------------------------
/* 刪除訂單明細資料 */
\d #
create procedure delOrderDetails(oldorderID int) 

begin
    delete from `Order Details` where orderID = oldorderID;
      
end #
\d ;
--------------------------------
/* 修改訂單明細資料，只能修改實際單價跟數量 */
\d #
create procedure updOrderDetails(oldorderID int, oldunitprice int, oldquantity int) 

begin
    update `Order Details` set unitprice = oldunitprice, quantity = oldquantity
    where orderID = oldorderID;
      
end #
\d ;
-------------------------------
/* 綜合查詢 */
/* a. 指定客戶查詢訂單,含訂單明細 */
\d #
create procedure selcustomerorder(kw varchar(20)) 

begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci;
    set @query = 'select c.customername, o.onumber, od.pnumber, od.unitprice, od.quantity from orders o 
    join customers c on (o.phone = c.phone)
    join `order details` od on (o.onumber = od.onumber)
    where c.customername like ?' ;

    prepare stmt from @query;
    execute stmt using @key; 
       
end #
\d ;
-------------------------------
 /* b. 指定客戶查詢訂單總金額 */
 \d #
create procedure selorderprice(kw varchar(20)) 

begin
    set @key = concat(kw) COLLATE utf8_unicode_ci;
    set @query = 'select c.customername, sum(od.unitprice * od.quantity) total from orders o 
    join customers c on (o.phone = c.phone)
    join `order details` od on (o.onumber = od.onumber)
    where c.customername like ?' ;

    prepare stmt from @query;
    execute stmt using @key; 
       
end #
\d ;
-------------------------------------
/* c. 指定商品查詢訂單中的客戶 */
\d #
create procedure selordercustomer(kw varchar(20)) 

begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci;
    set @query = 'select p.productName, p.pnumber, c.customerName, od.quantity from `order details` od
    join products p on (od.pnumber = p.pnumber)
    join orders o on (od.onumber = o.onumber)
    join customers c on (o.phone = c.phone)
    where p.productName like ?' ;

    prepare stmt from @query;
    execute stmt using @key; 
       
end #
\d ;
-------------------------------------
--  d. 指定供應商查詢訂單中的商品清單
\d #
create procedure selorderproduct(kw varchar(20)) 

begin
    set @key = concat('%', kw, '%') COLLATE utf8_unicode_ci;
    set @query = 'select s.supplierName, o.onumber, p.productName, p.pnumber, p.reprice from `order details` od
    join orders o on (od.onumber = o.onumber)
    join products p on (od.pnumber = p.pnumber)
    join suppliers s on (p.phone = s.phone)
    where s.supplierName like ?' ;

    prepare stmt from @query;
    execute stmt using @key; 
       
end #
\d ;






