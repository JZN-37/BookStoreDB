use BookStoreApp

create table Category
(
CatId int primary key identity,
CatName nvarchar(50) unique,
CatDesc nvarchar(150),
CatImgPath nvarchar(150),
CatCount int,  
CatStatus bit, --if 0 make UI disabled--
CatPosition float default 0,
CatCreatedAt datetime
)

create table Book
(
BId int primary key identity,      
BCatId int foreign key references Category(CatId) ON DELETE CASCADE,
BTitle nvarchar(50) not null,
BISBN nvarchar(50) not null unique,
BYear date,   --Year--
BPrice float,
BDesc nvarchar(500), -- Place a limit of 500 characters in UI--
BPosition float default 0,
BCount int,
BStatus bit,
BImgPath nvarchar(150),
Norders int
)

create table Ratings
(
RatingId int unique identity,
UserId int foreign key references Users(Id),
BId int foreign key references Book(BId) ON DELETE CASCADE,
UserRating float, --make sure the upper limit is set in the UI TO 5--
Constraint pkUsrBk primary key(UserId,BId)
)

create table Cart
(
CartId int unique identity,
UserId int foreign key references Users(Id),
BId int foreign key references Book(BId) ON DELETE CASCADE,
BQty int
Constraint pkUsrBook primary key(UserId,BId)
)












--DELETING IN A ONE TO MANY RELATION TYPE TABLE - need to use ON DELETE CASCADE at the end of the foreign key reference
--ALTER TABLE Book
--   DROP CONSTRAINT FK__Book__BCatId__2D27B809   -- or whatever it's called

--ALTER TABLE Book
--   ADD CONSTRAINT FK__Book__BCatId__2D27B809_Cascade
--   FOREIGN KEY (BCatId) REFERENCES Category(CatId) ON DELETE CASCADE


--ALTER TABLE Ratings
--   DROP CONSTRAINT FK__Ratings__BId__32E0915F   -- or whatever it's called

--ALTER TABLE Ratings
--   ADD CONSTRAINT FK__Ratings__BId__32E0915F_Cascade
--   FOREIGN KEY (BId) REFERENCES Book(BId) ON DELETE CASCADE