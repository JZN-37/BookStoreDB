create database BookStoreApp
use BookStoreApp

create table Admin
(
AId int primary key identity,
AName nvarchar(50),
APwd nvarchar(50)
)

create table Discount
(
DId int primary key identity,
DCouponCode nvarchar(50),
DDiscountValue float,
DStatus bit
)

create table Orders
(
Id int primary key identity,
UserId int foreign key references Users(Id) not null,
OrderId int,
BookTitle nvarchar(50),
BookCatName nvarchar(50),
BookISBN nvarchar(50),
BookYear date,
BookPrice float,
BImagePath nvarchar(50),
BookQty int,
OrderDate datetime
)

create proc usp_BeforeInsrtToOrders(@userId int)
with encryption
as
begin
update Users set UOrderNo=UOrderNo+1 where Id= @userId
end

