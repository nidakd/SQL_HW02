--Invoice tablosunda column isimlerini öğrenmek için bu sorguyu çalıştırıyorum
SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'invoice';


--1. soru Invoice tablosunda, 
--tüm değerleri NULL olan kayıtların sayısını bulmam isteniyor.
select * from invoice 
where invoice_date is null 
or billing_address is null 
or billing_city is null 
or billing_state is null 
or billing_country is null 
or billingpostal_code is null 
or total is null;
--row sayısı 209

--2. soru:
--Koordinasyondaki kişiler, Total değerlerinde bir hata olduğunu belirtiyorlar.
--Bu değerlerin iki katını görmek ve eski versiyonlarıyla birlikte karşılaştırmak için bir sorgu yazmanız isteniyor.
--Ayrıca, verilerin daha rahat takip edilebilmesi için, tablonun yeni versiyonuna ait kolona göre büyükten küçüğe sıralama yapılması isteniyor.
SELECT 
    invoice_id,
    customer_id,
    invoice_date,
    total AS old_total,               -- Eski Total değeri
    total * 2 AS new_total,           -- Yeni Total değeri (iki katı)
    billing_city,
    billing_state,
    billing_country,
    billingpostal_code,
    billing_address
FROM Invoice
ORDER BY new_total DESC;   
--ACIKLAMA
--old_total: Eski total değerini gösteriyor
--new_total: Total değerinin iki katı olan yeni değeri gösteriyor
--sıralama: Yeni total değerine göre sıralanmış sonuçları gösteriyor

--3.soru: Adres kolonundaki verileri, soldan 3 karakter ve sağdan 4 karakter alarak birleştirmeniz
--ve "Açık Adres" olarak yazmanız isteniyor.
--Ayrıca, bu yeni açık adresi 2013 yılı ve 8. ay’a göre filtrelemeniz gerekiyor.
SELECT 
    invoice_id,
    customer_id,
    invoice_date,
    CONCAT(LEFT(billing_address, 3), RIGHT(billing_address, 4)) AS "Açık Adres"
FROM Invoice
WHERE EXTRACT(YEAR FROM invoice_date) = 2013  -- 2013 yılı
  AND EXTRACT(MONTH FROM invoice_date) = 8    -- 8. ay
ORDER BY invoice_date;
--ACIKLAMA
--LEFT(billing_address, 3): Adresin solundaki ilk 3 karakteri alıyor
--RIGHT(billing_address, 4): Adresin sağındaki son 4 karakteri alıyor
--CONCAT(): Bu iki kısmı birleştiriyor ve "Açık Adres" olarak adlandırıyor
--EXTRACT(YEAR FROM invoice_date): invoice_date kolonundan yıl bilgisini alıyor ve 2013 yılına göre filtreleme yapıyor
--EXTRACT(MONTH FROM invoice_date): invoice_date kolonundan ay bilgisini alıyor ve 8. ay için filtreleme yapıyor

