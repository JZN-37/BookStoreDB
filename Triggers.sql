use BookStoreApp

	-----------Trigger on Ratings------------

create trigger trgAIRatings
on Ratings
with encryption
after insert, update
as
begin
declare @id int
declare @catid int
declare @numrat int
declare @numpos int
declare @sum float
declare @catsum float
declare @bpos float
declare @cpos float

select @id=BId from inserted
select @numrat=count(@id) from Ratings where BId=@id
select @sum=sum(UserRating) from Ratings where BId=@id
select @bpos=@sum/(@numrat*5)
update Book set BPosition=@bpos where BId=@id

select @catid=BCatId from Book where BId=@id
select @numpos=count(@catid) from Book where BCatId=@catid
select @catsum=sum(BPosition) from Book where BCatId=@catid
select @cpos=@catsum/@numpos
update Category set CatPosition=@cpos where CatId=@catid
end

--------Triggers on Creation and Deletion of Books----------


create trigger trgAInsrtBk
on Book
with encryption
after insert
as
begin
declare @catid int
declare @status bit

select @catid=BCatId from inserted
select @status=BStatus from inserted

if(@status=1)
begin
update Category set CatCount=CatCount+1 where CatId=@catid
end

end

--------

create proc usp_IDelBk(@catid int , @status bit)
with encryption
as
begin
declare @numpos int
declare @catsum float
declare @cpos float

if(@status=1)
begin
update Category set CatCount=CatCount-1 where CatId=@catid
end
select @numpos=count(@catid) from Book where BCatId=@catid
select @catsum=sum(BPosition) from Book where BCatId=@catid
select @cpos=@catsum/@numpos
if(@numpos=0)
begin
update Category set CatPosition=0 where CatId=@catid
end
else
begin
update Category set CatPosition= @cpos where CatId=@catid
end
end

---------

create trigger trgIUpdtBk	
on Book
with encryption 
instead of update
as
begin
declare @btitle nvarchar(50)
declare @bisbn nvarchar(50)
declare @byear date
declare @bprice float
declare @bdesc nvarchar(500)
declare @bpos float
declare @bcount int
declare @img nvarchar(150)
declare @norders int
select @btitle=BTitle from inserted
select @bisbn=BISBN from inserted
select @byear=BYear from inserted
select @bprice=BPrice from inserted
select @bdesc=BDesc from inserted
select @bpos=BPosition from inserted
select @bcount=BCount from inserted
select @img=BImgPath from inserted
select @norders=Norders from inserted

declare @bid int
declare @catid int
declare @futstatus bit
declare @nowstatus bit
select @bid=BId from inserted
select @catid=BCatId from inserted
select @futstatus=BStatus from inserted
select @nowstatus=BStatus from Book where BId=@bid
if(@futstatus!=@nowstatus)
begin
if(@futstatus=1)
begin
update Category set CatCount=CatCount+1 where CatId=@catid
end
else
begin
update Category set CatCount=CatCount-1 where CatId=@catid
end
end
update Book 
set 
BCatId=@catid,
BTitle=@btitle,
BISBN=@bisbn,
BYear=@byear,
BPrice=@bprice,
BDesc=@bdesc,
BPosition=@bpos,
BCount=@bcount,
BStatus=@futstatus, 
BImgPath=@img,
Norders=@norders
where 
BId=@bid
end


-------------------

--Procedure on Orders--

create proc usp_InsrtOrders(@userid int, @bookid int, @bookqty int) 
with encryption
as
begin
--declare @userid int
declare @orderid int
--declare @bookid int
--declare @bookqty int
declare @orderdate datetime
declare @booktitle nvarchar(50)
declare @bookISBN nvarchar(50)
declare @bookCatName nvarchar(50)
declare @bookYear nvarchar(10)
declare @bookPrice float
declare @bookImgPath nvarchar(50)

--select @userid=UserId from inserted
--select @bookid=BookId from inserted
--select @bookqty=BookQty from inserted
set @orderdate=GETDATE()

set @orderid = (select UOrderNo from Users where Id=@userid)
set @booktitle = (select BTitle from Book where BId=@bookid)
set @bookISBN = (select BISBN from Book where BId=@bookid)
set @bookCatName = (select CatName from Category c , Book b where b.BId=@bookid and b.BCatId=c.CatId)
set @bookYear = (SELECT YEAR(BYear) FROM Book where BId=@bookid)
set @bookPrice = (select BPrice from Book where BId = @bookid)
set @bookImgPath = (select BImgPath from Book where BId = @bookid)

insert into Orders values(@userid, @orderid, @booktitle, @bookCatName, @bookISBN, @bookYear, @bookPrice, @bookImgPath, @bookqty, @orderdate)

--Reducing the book stock by @bookqty
update Book set BCount = BCount - @bookqty where BId = @bookid

--Incrementing the Norders of Book 
update Book set Norders = Norders + @bookqty where BId = @bookid

end


-------------------






