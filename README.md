# mysql
Homework
0. 庫名: iii
1. 客戶資料表：id(int primary,autoincrement),姓名,電話(uni),email,address
2. 供應商: id(...),名稱,電話(uni),地址
3. 商品表: id(...),編號(uni),名稱,建議售價,供應商(f)
4. 訂單: id(...),編號(uni),客戶(f)
5. 訂單細項: id(...),編號(f),商品(f),實際單價,數量
功能
6. 客戶: 新增,刪除,修改
    查詢: 電話, 姓名 => 關鍵字, 若無 => 全部 
7. 供應商: 新增,刪除,修改
    查詢: 名稱,電話 => 關鍵字, 若無 => 全部
8. 商品: 新增,刪除,修改 
    查詢: 名稱 => 關鍵字, 若無 => 全部
9. 訂單: 新增,刪除 => 包含訂單細項的處理
10.訂單明細: 新增,刪除,修改(只能修改數量及實際單價)
11. 綜合查詢:
    a. 指定客戶查詢訂單,含訂單明細
    b. 指定客戶查詢訂單總金額
    c. 指定商品查詢訂單中的客戶, 例如: 商品P001的客戶有哪些,買幾個
    d. 指定供應商查詢訂單中的商品清單
