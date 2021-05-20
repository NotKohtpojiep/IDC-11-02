
alter function GetSummaryCoefficientForStreet (@street_id int)  
returns int
as
begin
	IF (EXISTS (SELECT Коэффицент FROM Тарифная_зона inner join Зона ON Тарифная_зона.id_зоны = Зона.id WHERE id_улицы = @street_id))
	BEGIN
		RETURN (SELECT SUM(Коэффицент) 
			FROM Тарифная_зона inner join Зона ON Тарифная_зона.id_зоны = Зона.id
			WHERE id_улицы = @street_id)
	END
		RETURN 0
end
go

Create function GetDifferenceFromStreets (@street_from_id int, @street_to_id int)  
returns decimal(18,15)
as
begin
	 DECLARE @position_sum_from decimal(18,15)
	 SELECT @position_sum_from = (SELECT Широта + Долгота FROM Улица WHERE id = @street_from_id)

	 DECLARE @position_sum_to decimal(18,15)
	 SELECT @position_sum_to = (SELECT Широта + Долгота FROM Улица WHERE id = @street_to_id)

	 RETURN ABS(@position_sum_from - @position_sum_to)
end
go

Create function GetTariffPrice (@order_id int)  
returns decimal(8,2)
as
begin
	 RETURN (SELECT Тариф.Стоимость FROM Заказ INNER JOIN Тариф ON Тариф.id = Заказ.id_выбранного_тарифа WHERE Заказ.id = @order_id)
end
go

ALTER FUNCTION GetPriceForTime(@tarifPrice decimal(8,2), @time time(6))
returns @results table (Стоимость decimal(10,2)) as 
begin
  if ((SELECT DATEPART(HOUR, @time)) >= 23 OR (SELECT DATEPART(HOUR, @time)) < 6)
	 BEGIN
		insert @results (Стоимость) select(@tarifPrice * 1.15)
	 END

	 if ((SELECT DATEPART(HOUR, @time)) >= 6 AND (SELECT DATEPART(HOUR, @time)) < 12)
	 BEGIN
		insert @results (Стоимость) select (@tarifPrice * 1.65)
	 END

	 if ((SELECT DATEPART(HOUR, @time)) >= 12 AND (SELECT DATEPART(HOUR, @time)) < 17)
	 BEGIN
		insert @results (Стоимость) select (@tarifPrice)
	 END

	 if ((SELECT DATEPART(HOUR, @time)) >= 17 AND (SELECT DATEPART(HOUR, @time)) < 23)
	 BEGIN
		insert @results (Стоимость) select (@tarifPrice * 1.5)
	 END
RETURN 
END
go

ALTER TRIGGER FormirovanieZakaza ON dbo.Информация_заказа
AFTER INSERT
AS
UPDATE
	Заказ
SET
	Стоимость_поездки = 
		(SELECT Стоимость FROM dbo.GetPriceForTime(dbo.GetTariffPrice(Result.id), Result.Время_заказа))
FROM
	(SELECT Заказ.id,Время_заказа
	FROM inserted 
		INNER JOIN Заказ ON Заказ.id = inserted.id) as Result
WHERE Заказ.id = Result.id
GO;

INSERT Информация_заказа VALUES (1,1,1,2,2,NULL,NULL)


-- Задание 2

Create function GetMostPopularAt (@hour int)  
returns @t table (Класс_машины nvarchar(50))
as
begin
	Insert @t
	SELECT Класс_машины.Название
	FROM
	(Select Заказ.id_перевозимой_машины
	 FROM Заказ INNER JOIN Машина 
		ON Заказ.id_перевозимой_машины = Машина.id
	 Where DATEPART(HOUR, Заказ.Время_заказа) = @hour) t1 INNER JOIN
	 Класс_машины ON t1.id_перевозимой_машины = Класс_машины.id
	 GROUP BY (Класс_машины.Название)
	 ORDER BY COUNT(*) DESC
	return
end
go

SELECT * FROM GetMostPopularAt(2)