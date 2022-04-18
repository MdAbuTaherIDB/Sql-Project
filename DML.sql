USE CarRental
GO
--Insert data in manufacturers using procedure spInsertManufacturer
DECLARE @id INT
EXEC spInsertManufacturer'Audi', 'Made in Germany', @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertManufacturer'Marcedes', 'Made in Germany', @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertManufacturer'BMW', 'Made in Germany', @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertManufacturer'Range Rover', 'Owning this company Jaguar Land', @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertManufacturer'Toyota', 'Made in Japan', @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertManufacturer'Hyundai', 'Made in South Korea', @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertManufacturer'Ford', 'Made in USA', @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertManufacturer'tesla', 'Made in USA', @id OUTPUT
SELECT @id as 'inserted with id'
GO
SELECT * FROM manufacturers
GO
--Update Data in manufacturer with  Procedure
EXEC spUpdateManufacturer @manufacturer_id=1, @manufacturer_name = 'Bentley'
EXEC spUpdateManufacturer @manufacturer_id=4, @manufacturer_name = 'Volvo'
EXEC spUpdateManufacturer @manufacturer_id=5, @manufacturer_name = 'Mclaren'
GO
SELECT * FROM manufacturers
GO
--Insert models data
DECLARE @id INT
EXEC spInsertModels 'AX1 ', 1, @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertModels 'MDS-01',2, @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertModels 'b-01', 3, @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertModels 'RV-1', 4, @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertModels 'TT-01',5, @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertModels 'H-06',6, @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertModels 'Ford-1', 7, @id OUTPUT
SELECT @id as 'inserted with id'
EXEC spInsertModels 'T-S1', 8, @id OUTPUT
SELECT @id as 'inserted with id'
GO
SELECT * FROM models
GO
EXEC spInsertCustomers	
								@customer_name ='C1' ,
								@customer_email ='c1@mm.com',
								@customer_phone ='01710111111',
								@customer_address ='gazipur'
EXEC spInsertCustomers	
								@customer_name ='C2' ,
								@customer_email ='c2@mm.com',
								@customer_phone ='01810111111',
								@customer_address ='dhaka'
EXEC spInsertCustomers	
								@customer_name ='C3' ,
								@customer_email ='c3@mm.com',
								@customer_phone ='01610111111',
								@customer_address ='dhaka'
EXEC spInsertCustomers	
								@customer_name ='C4' ,
								@customer_email ='c4@mm.com',
								@customer_phone ='01910111111',
								@customer_address ='dhaka'
GO
select * from customers
go
DECLARE @id INT
exec spInsertBookingstatus 'available',@id  OUTPUT
SELECT @id as 'inserted with id'
exec spInsertBookingstatus 'hired',@id  OUTPUT
SELECT @id as 'inserted with id'
exec spInsertBookingstatus 'not available',@id  OUTPUT
SELECT @id as 'inserted with id'
go
select * from bookingstatus
GO
exec spInsertVrhicleCategories	'Luxary'
exec spInsertVrhicleCategories	'Regular'
exec spInsertVrhicleCategories	'Microbus'
exec spInsertVrhicleCategories	'Family car'
go
select * from vehicle_categories
GO
DECLARE @id INT
exec spInsertVehicles 27000, 3000.00, 2100, 2, 1, @id output
exec spInsertVehicles 21000, 2700.00, 2100, 2, 1, @id output
exec spInsertVehicles 27000, 3000.00, 4500, 1, 2, @id output
exec spInsertVehicles 1500, 8000.00, 2100, 1, 1, @id output
go
select * from vehicles
go
exec spInsertBookings	
								@date_from ='2021-07-07' ,
								@date_to ='2021-07-10',
								@payment_recieved_on ='2021-07-09',
								@customer_id =1,
								@vehicle_id =1
--will fail for trigger
--vehicle with id=1 is booked from 2021-07-10 to 2021-07-10
exec spInsertBookings	
								@date_from ='2021-07-09' ,
								@date_to ='2021-07-13',
								@payment_recieved_on ='2021-07-09',
								@customer_id =2,
								@vehicle_id =1
--ok
exec spInsertBookings	
								@date_from ='2021-07-09' ,
								@date_to ='2021-07-13',
								@payment_recieved_on ='2021-07-09',
								@customer_id =2,
								@vehicle_id =2
--ok
--views

select * from vehiclelist
go
select * from vBookingCurrentMonth
go
select * from bookingofvehcle_date_range(1, '2021-07-01', '2021-07-30')
GO