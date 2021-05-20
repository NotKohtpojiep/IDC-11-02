
alter function GetSummaryCoefficientForStreet (@street_id int)  
returns int
as
begin
	IF (EXISTS (SELECT ���������� FROM ��������_���� inner join ���� ON ��������_����.id_���� = ����.id WHERE id_����� = @street_id))
	BEGIN
		RETURN (SELECT SUM(����������) 
			FROM ��������_���� inner join ���� ON ��������_����.id_���� = ����.id
			WHERE id_����� = @street_id)
	END
		RETURN 0
end
go

Create function GetDifferenceFromStreets (@street_from_id int, @street_to_id int)  
returns decimal(18,15)
as
begin
	 DECLARE @position_sum_from decimal(18,15)
	 SELECT @position_sum_from = (SELECT ������ + ������� FROM ����� WHERE id = @street_from_id)

	 DECLARE @position_sum_to decimal(18,15)
	 SELECT @position_sum_to = (SELECT ������ + ������� FROM ����� WHERE id = @street_to_id)

	 RETURN ABS(@position_sum_from - @position_sum_to)
end
go

Create function GetTariffPrice (@order_id int)  
returns decimal(8,2)
as
begin
	 RETURN (SELECT �����.��������� FROM ����� INNER JOIN ����� ON �����.id = �����.id_����������_������ WHERE �����.id = @order_id)
end
go

ALTER FUNCTION GetPriceForTime(@tarifPrice decimal(8,2), @time time(6))
returns @results table (��������� decimal(10,2)) as 
begin
  if ((SELECT DATEPART(HOUR, @time)) >= 23 OR (SELECT DATEPART(HOUR, @time)) < 6)
	 BEGIN
		insert @results (���������) select(@tarifPrice * 1.15)
	 END

	 if ((SELECT DATEPART(HOUR, @time)) >= 6 AND (SELECT DATEPART(HOUR, @time)) < 12)
	 BEGIN
		insert @results (���������) select (@tarifPrice * 1.65)
	 END

	 if ((SELECT DATEPART(HOUR, @time)) >= 12 AND (SELECT DATEPART(HOUR, @time)) < 17)
	 BEGIN
		insert @results (���������) select (@tarifPrice)
	 END

	 if ((SELECT DATEPART(HOUR, @time)) >= 17 AND (SELECT DATEPART(HOUR, @time)) < 23)
	 BEGIN
		insert @results (���������) select (@tarifPrice * 1.5)
	 END
RETURN 
END
go

ALTER TRIGGER FormirovanieZakaza ON dbo.����������_������
AFTER INSERT
AS
UPDATE
	�����
SET
	���������_������� = 
		(SELECT ��������� FROM dbo.GetPriceForTime(dbo.GetTariffPrice(Result.id), Result.�����_������))
FROM
	(SELECT �����.id,�����_������
	FROM inserted 
		INNER JOIN ����� ON �����.id = inserted.id) as Result
WHERE �����.id = Result.id
GO;

INSERT ����������_������ VALUES (1,1,1,2,2,NULL,NULL)


-- ������� 2

Create function GetMostPopularAt (@hour int)  
returns @t table (�����_������ nvarchar(50))
as
begin
	Insert @t
	SELECT �����_������.��������
	FROM
	(Select �����.id_�����������_������
	 FROM ����� INNER JOIN ������ 
		ON �����.id_�����������_������ = ������.id
	 Where DATEPART(HOUR, �����.�����_������) = @hour) t1 INNER JOIN
	 �����_������ ON t1.id_�����������_������ = �����_������.id
	 GROUP BY (�����_������.��������)
	 ORDER BY COUNT(*) DESC
	return
end
go

SELECT * FROM GetMostPopularAt(2)