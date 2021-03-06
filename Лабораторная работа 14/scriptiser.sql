USE [Car_Dealership]
GO

CREATE TABLE [dbo].[Car_brands] (
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](65) NOT NULL,
	[Origin_country_id] [int] NULL,
	[Factory_manufacturer_id] [int] NOT NULL,
 CONSTRAINT [PK_Car_brands] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_Car_brands_Name_UQ] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Car_categories] (
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Car_categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_Car_categories_Name_UQ] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Car_colours](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](65) NOT NULL,
 CONSTRAINT [PK_Car_colours] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_Car_colours_Name_UQ] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Car_sales](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Customer_id] [int] NOT NULL,
	[Employee_id] [int] NOT NULL,
	[Car_range_id] [int] NOT NULL,
	[Sale_date] [date] NOT NULL,
 CONSTRAINT [PK_Car_sales] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Cars](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Car_brand_id] [int] NOT NULL,
	[Category_id] [int] NOT NULL,
	[Release_year] [smallint] NULL,
 CONSTRAINT [PK_Cars] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Cars_range](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Car_id] [int] NOT NULL,
	[Colour_id] [int] NOT NULL,
	[Manufacture_year] [smallint] NOT NULL,
 CONSTRAINT [PK_Cars_range] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Cities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](65) NOT NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_Cities_Name_UQ] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Countries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_Countries_Name_UQ] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firstname] [nvarchar](65) NOT NULL,
	[Lastname] [nvarchar](65) NOT NULL,
	[Middlename] [nvarchar](65) NULL,
	[Passport_serial] [char](4) NOT NULL,
	[Passport_number] [char](6) NOT NULL,
	[Country_id] [int] NOT NULL,
	[City_id] [int] NOT NULL,
	[Street_name] [nvarchar](120) NOT NULL,
	[Home_number] [smallint] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_Customers_Passport_serial_Passport_number_UQ] UNIQUE NONCLUSTERED 
(
	[Passport_serial] ASC,
	[Passport_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Firstname] [nvarchar](65) NOT NULL,
	[Lastname] [nvarchar](65) NOT NULL,
	[Middlename] [nvarchar](65) NULL,
	[Work_expirience] [tinyint] NOT NULL,
	[Salary] [decimal](13, 2) NOT NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Factory_manufacturers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
	[Country_id] [int] NOT NULL,
	[City_id] [int] NOT NULL,
	[Street_name] [nvarchar](120) NOT NULL,
	[Home_number] [smallint] NULL,
 CONSTRAINT [PK_Factory_manufacturers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Car_sales] ADD  CONSTRAINT [DF_Car_sales_Sale_date]  DEFAULT (getdate()) FOR [Sale_date]
GO
ALTER TABLE [dbo].[Car_brands]  WITH CHECK ADD  CONSTRAINT [FK_Car_brands_Countries] FOREIGN KEY([Origin_country_id])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Car_brands] CHECK CONSTRAINT [FK_Car_brands_Countries]
GO
ALTER TABLE [dbo].[Car_brands]  WITH CHECK ADD  CONSTRAINT [FK_Car_brands_Factory_manufacturers] FOREIGN KEY([Factory_manufacturer_id])
REFERENCES [dbo].[Factory_manufacturers] ([Id])
GO
ALTER TABLE [dbo].[Car_brands] CHECK CONSTRAINT [FK_Car_brands_Factory_manufacturers]
GO
ALTER TABLE [dbo].[Car_sales]  WITH CHECK ADD  CONSTRAINT [FK_Car_sales_Cars_range] FOREIGN KEY([Car_range_id])
REFERENCES [dbo].[Cars_range] ([Id])
GO
ALTER TABLE [dbo].[Car_sales] CHECK CONSTRAINT [FK_Car_sales_Cars_range]
GO
ALTER TABLE [dbo].[Car_sales]  WITH CHECK ADD  CONSTRAINT [FK_Car_sales_Customers] FOREIGN KEY([Customer_id])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Car_sales] CHECK CONSTRAINT [FK_Car_sales_Customers]
GO
ALTER TABLE [dbo].[Car_sales]  WITH CHECK ADD  CONSTRAINT [FK_Car_sales_Employees] FOREIGN KEY([Employee_id])
REFERENCES [dbo].[Employees] ([Id])
GO
ALTER TABLE [dbo].[Car_sales] CHECK CONSTRAINT [FK_Car_sales_Employees]
GO
ALTER TABLE [dbo].[Cars]  WITH CHECK ADD  CONSTRAINT [FK_Cars_Car_brands] FOREIGN KEY([Car_brand_id])
REFERENCES [dbo].[Car_brands] ([Id])
GO
ALTER TABLE [dbo].[Cars] CHECK CONSTRAINT [FK_Cars_Car_brands]
GO
ALTER TABLE [dbo].[Cars]  WITH CHECK ADD  CONSTRAINT [FK_Cars_Car_categories] FOREIGN KEY([Category_id])
REFERENCES [dbo].[Car_categories] ([Id])
GO
ALTER TABLE [dbo].[Cars] CHECK CONSTRAINT [FK_Cars_Car_categories]
GO
ALTER TABLE [dbo].[Cars_range]  WITH CHECK ADD  CONSTRAINT [FK_Cars_range_Car_colours] FOREIGN KEY([Colour_id])
REFERENCES [dbo].[Car_colours] ([Id])
GO
ALTER TABLE [dbo].[Cars_range] CHECK CONSTRAINT [FK_Cars_range_Car_colours]
GO
ALTER TABLE [dbo].[Cars_range]  WITH CHECK ADD  CONSTRAINT [FK_Cars_range_Cars] FOREIGN KEY([Car_id])
REFERENCES [dbo].[Cars] ([Id])
GO
ALTER TABLE [dbo].[Cars_range] CHECK CONSTRAINT [FK_Cars_range_Cars]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Cities] FOREIGN KEY([City_id])
REFERENCES [dbo].[Cities] ([Id])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Cities]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Countries] FOREIGN KEY([Country_id])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Countries]
GO
ALTER TABLE [dbo].[Factory_manufacturers]  WITH CHECK ADD  CONSTRAINT [FK_Factory_manufacturers_Cities] FOREIGN KEY([City_id])
REFERENCES [dbo].[Cities] ([Id])
GO
ALTER TABLE [dbo].[Factory_manufacturers] CHECK CONSTRAINT [FK_Factory_manufacturers_Cities]
GO
ALTER TABLE [dbo].[Factory_manufacturers]  WITH CHECK ADD  CONSTRAINT [FK_Factory_manufacturers_Countries] FOREIGN KEY([Country_id])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Factory_manufacturers] CHECK CONSTRAINT [FK_Factory_manufacturers_Countries]
GO
ALTER TABLE [dbo].[Car_sales]  WITH CHECK ADD  CONSTRAINT [CHK_Car_sales_Sale_date_Correct_date] CHECK  (([Sale_date]>='01.01.1900' AND [Sale_date]<='01.01.2100'))
GO
ALTER TABLE [dbo].[Car_sales] CHECK CONSTRAINT [CHK_Car_sales_Sale_date_Correct_date]
GO
ALTER TABLE [dbo].[Car_sales]  WITH CHECK ADD  CONSTRAINT [CHK_Sale_date_Correct_date] CHECK  (([Sale_date]>='01.01.1900' AND [Sale_date]<='01.01.2100'))
GO
ALTER TABLE [dbo].[Car_sales] CHECK CONSTRAINT [CHK_Sale_date_Correct_date]
GO
ALTER TABLE [dbo].[Cars_range]  WITH CHECK ADD  CONSTRAINT [CHK_Cars_Range_Manufacture_year] CHECK  (([Manufacture_year]>=(1900) AND [Manufacture_year]<=(2100)))
GO
ALTER TABLE [dbo].[Cars_range] CHECK CONSTRAINT [CHK_Cars_Range_Manufacture_year]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [CHK_Customers_Home_number] CHECK  (([Home_number]>=(0)))
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [CHK_Customers_Home_number]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [CHK_Customers_Passport_number] CHECK  (([Passport_number] like '[0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [CHK_Customers_Passport_number]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [CHK_Customers_Passport_serial] CHECK  (([Passport_serial] like '[0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [CHK_Customers_Passport_serial]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [CHK_Employees_Salary] CHECK  (([Salary]>=(0)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [CHK_Employees_Salary]
GO
ALTER TABLE [dbo].[Factory_manufacturers]  WITH CHECK ADD  CONSTRAINT [CHK_Factory_manufacturers_Home_number] CHECK  (([Home_number]>=(0)))
GO
ALTER TABLE [dbo].[Factory_manufacturers] CHECK CONSTRAINT [CHK_Factory_manufacturers_Home_number]
GO
