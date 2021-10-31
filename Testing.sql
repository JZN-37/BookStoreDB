--viewing table--

select * from Category
select * from Book
select * from Ratings
select * from Users
select * from Orders


--Creating User--
insert into Users values('shone', 'shone@123',7573092365, 'shonesaji11@gmail.com', 1,0)
insert into Users values('sam', 'sam@123',9786128496, 'sam@gmail.com', 1,0)
insert into Users values('john', 'john@123',9047834655, 'john@gmail.com', 1,0)

insert into Category values('Comedy', 'Comedy Description' , '~/Image/Comedy/ComedyCat.jpg' , 0, 1, 0, '01/02/2021')
insert into Category values('Crime', 'Crime Description' , '~/Image/Crime/CrimeCat.jpg' , 0, 1, 0, '01/03/2021')
insert into Category values('Horror', 'Horror Description' , '~/Image/Horror/HorrorCat.jpg' , 0, 1, 0, '09/08/2021')
insert into Category values('SciFi', 'Science Fiction Description' , '~/SciFi/Comedy/SciFiCat.jpg' , 0, 1, 0, '11/01/2021')


--Query to get popular books given Category--
select * from Book where Book.BCatId = 1 order by BPosition desc


--Book--
--Checking trgAInsrtBk trigger--
insert into Book values(2,'Born a Crime',978389667,'2020', 14.99, 'Author : Trevor Noah ', 0, 5, 1,'~/Images/Comedy/BornACrime.jpg' , 0)
insert into Book values(1,'Before and After Laughter',978152941,'2019', 8.99, 'Author : Jimmy Carr ', 0, 2, 1,'~/Images/Comedy/BefnAftLftr.jpg' , 0)
insert into Book values(2, 'A Place of Execution' ,978497131, '2021' , 18.99,  'Author : Val Mc Dermid ' , 0, 10, 1,'~/Images/Comedy/APlaceOfExec.jpg' , 0)
insert into Book values(3, 'Dracula' ,756139713 , '2021' , 13.99,  'Author : Bram Stoker ' , 0, 5, 1,'~/Images/Comedy/Dracula.jpg' , 0)
insert into Book values(4, 'The Martian' ,978497141,  '2017' , 18.99,  'Author : Andy Weir ' , 0, 2, 1,'~/Images/Comedy/TheMartian.jpg' , 0)

--Checking trgADelBk trigger--
--Run exec usp_IDelBk to update CatCount and CatPosition

delete from Book where BTitle = 'Dracula'
exec usp_IDelBk 3 , 1

--We have to set ON DELETE CASCADE for BId in Book table in order for below query to work 
delete from Category where CatName = 'Crime'


delete from Book where BCatId = 5

--Getting only year part of book 
SELECT YEAR(BYear) FROM Book


--Checking trgIUpdtBk trigger--
Update Category set CatCount=0 where CatId=1


--Adding Ratings--
--Checked trgAIRatings trigger--
insert into Ratings values(1 , 8, 4)
insert into Ratings values(2 , 8, 5)
insert into Ratings values(3 , 9, 5)
insert into Ratings values(3 , 9, 5)
insert into Ratings values(1 , 3, 0)
insert into Ratings values(3 , 2, 3)
insert into Ratings values(1,6,1)
insert into Ratings values(1,7,4)




--Testing Orders--
--First use the procedure usp_BeforeInsrtToOrders @userId to increment UOrderNo
--TO insert into the Orders table use the procedure trgIInsrtOrders @userId, @bookId, @bookQty
exec usp_BeforeInsrtToOrders 1
exec usp_InsrtOrders 1 , 2,2


--Query to select orders made by a given user
select * from Orders where UserId = 1

