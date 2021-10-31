use BookStoreApp


create table Users
(
Id int primary key identity,
UName nvarchar(20),   --concat FName and Lname from UI--
UPwd nvarchar(20),
UMobile nvarchar(10) unique,
UEmail nvarchar(50) unique,
UStatus bit,                    --activated or deactivated--
UOrderNo int default 0
)

create table UserAddress
(
UserAddrId int primary key identity,
UserId int foreign key references Users(Id),
UAddrLine1 nvarchar(50),
UAddrLine2 nvarchar(50),
UAddrCity nvarchar(50),
UAddrCountry nvarchar(50),
UAddrPincode nvarchar(10),
)

create table UserBankDetails
(
UserBankDetailsId int primary key identity,
UserId int foreign key references Users(Id),
UserCard nvarchar(16),
CardExpiry nvarchar(5)
)

Create table Wishlist
(
WId int unique identity,
UserId int foreign key references Users(Id),
BId int foreign key references Book(BId) ON DELETE CASCADE,
Constraint pkUsrBookWish primary key(UserId,BId)
)
