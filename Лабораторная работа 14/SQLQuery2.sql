ALTER TABLE dbo.Car_brands
	ADD CONSTRAINT AK_Car_brands_Name_UQ UNIQUE(Name)
GO
ALTER TABLE dbo.Car_categories
	ADD CONSTRAINT AK_Car_categories_Name_UQ UNIQUE(Name)
GO

ALTER TABLE dbo.Car_colours
	ADD CONSTRAINT AK_Car_colours_Name_UQ UNIQUE(Name)
GO

ALTER TABLE dbo.Car_sales
	ADD CONSTRAINT CHK_Car_sales_Sale_date_Correct_date CHECK (Sale_date BETWEEN '01.01.1900' AND '01.01.2100');
ALTER TABLE dbo.Car_sales
	ADD CONSTRAINT DF_Car_sales_Sale_date DEFAULT GETDATE() FOR Sale_date;
GO

ALTER TABLE dbo.Cars
	ADD CONSTRAINT AK_Car_Attributes UNIQUE(Name, Car_brand_id, Category_id, Manufacture_year);
ALTER TABLE dbo.Cars
	ADD CONSTRAINT CHK_Car_Manufacture_year CHECK (Manufacture_year BETWEEN 1900 AND 2100);
ALTER TABLE dbo.Cars
	ADD CONSTRAINT CHK_Car_Masses_corrects CHECK (Max_mass BETWEEN 0 AND Mass);
GO

ALTER TABLE dbo.Cars_Range
	ADD CONSTRAINT AK_Cars_Range_Attributes UNIQUE(Car_id, Colour_id);
ALTER TABLE dbo.Cars_Range
	ADD CONSTRAINT CHK_Cars_Range_Manufacture_year CHECK (Manufacture_year BETWEEN 1900 AND 2100);
GO

ALTER TABLE dbo.Cities
	ADD CONSTRAINT AK_Cities_Name_UQ UNIQUE(Name)
GO

ALTER TABLE dbo.Countries
	ADD CONSTRAINT AK_Countries_Name_UQ UNIQUE(Name)
GO

ALTER TABLE dbo.Customers
	ADD CONSTRAINT CHK_Customers_Passport_serial CHECK (Passport_serial LIKE '[0-9][0-9][0-9][0-9]' );
ALTER TABLE dbo.Customers
	ADD CONSTRAINT CHK_Customers_Passport_number CHECK (Passport_number LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]' );
ALTER TABLE dbo.Customers
	ADD CONSTRAINT AK_Customers_Passport_serial_Passport_number_UQ UNIQUE(Passport_serial, Passport_number)
ALTER TABLE dbo.Customers
	ADD CONSTRAINT CHK_Customers_Home_number CHECK (Home_number >= 0);
GO

ALTER TABLE dbo.Employees
	ADD CONSTRAINT CHK_Employees_Salary CHECK (Salary >= 0);
ALTER TABLE dbo.Employees
	ADD CONSTRAINT CHK_Employees_Work_expirience CHECK (Work_expirience >= 0 AND Work_expirience <= 100);
ALTER TABLE dbo.Employees
	ADD CONSTRAINT CHK_Employees_Gender CHECK (Gender IN ('M','F'));
ALTER TABLE dbo.Employees
	ADD CONSTRAINT CHK_Employees_Salary_with_WorkExp CHECK (
	(Salary <= 10000 AND Work_expirience < 10) OR
	((Salary BETWEEN 10000 AND 15000) AND (Work_expirience BETWEEN 10 AND 15)) OR 
	(Salary >= 15000 AND Work_expirience >= 15));
GO

ALTER TABLE dbo.Factory_manufacturers
	ADD CONSTRAINT CHK_Factory_manufacturers_Home_number CHECK (Home_number >= 0);
GO