use learningjf
go

--------------------------------------------------------------------------------------------------------------
-- ɾ����[LearningRecordExcel].[NO#]
select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[NO#]'
if @@ROWCOUNT > 0
begin
Alter table  LearningRecordExcel
drop column NO#
end
GO

-- ɾ����[LearningRecordExcel].[F10]
select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[F10]'
if @@ROWCOUNT > 0
begin
Alter table  LearningRecordExcel
drop column [F10]
end
GO


-- ɾ����[LearningRecordExcel].[F11]
select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[F11]'
if @@ROWCOUNT > 0
begin
Alter table  LearningRecordExcel
drop column [F11]
end
GO

-- ɾ����[LearningRecordExcel].[F12]
select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[F12]'
if @@ROWCOUNT > 0
begin
Alter table  LearningRecordExcel
drop column [F12]
end
GO

-- �����[LearningRecordExcel].[ID]
select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[ID]'
if @@ROWCOUNT = 0
begin
alter table LearningRecordExcel
add [ID] int identity(1,1) primary key
end
go

-- ����� [LearningRecordExcel].[CreatedDate]
select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[CreatedDate]'
if @@ROWCOUNT = 0
begin
alter table LearningRecordExcel
add [CreatedDate] datetime null default getdate()
end
go

-- �޸���[LearningRecordExcel].[Course]
select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[Course]'
if @@ROWCOUNT > 0
begin
EXEC sp_rename '[LearningRecordExcel].[Course]','CourseName','COLUMN' 
end
GO

-- �޸���[LearningRecordExcel].[SSO#]
select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[SSO#]'
if @@ROWCOUNT > 0
begin
EXEC sp_rename '[LearningRecordExcel].[SSO#]','SSO','COLUMN' 
end
GO

-- �޸���[LearningRecordExcel].[Name]
select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[Name]'
if @@ROWCOUNT > 0
begin
EXEC sp_rename '[LearningRecordExcel].[Name]','UserName','COLUMN' 
end
GO

-- �޸���[LearningRecordExcel].[Start Date]
select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[Start Date]'
if @@ROWCOUNT > 0
begin
EXEC sp_rename '[LearningRecordExcel].[Start Date]','StartDate','COLUMN' 
end
GO

-- �޸���[LearningRecordExcel].[Completed Date]
select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[Completed Date]'
if @@ROWCOUNT > 0
begin
EXEC sp_rename '[LearningRecordExcel].[Completed Date]','CompletedDate','COLUMN' 
end
GO

-- �޸���[LearningRecordExcel].[courseid]
select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[courseid]'
if @@ROWCOUNT > 0
begin
EXEC sp_rename '[LearningRecordExcel].[courseid]','CourseId','COLUMN' 
end
GO

------------------------------------------------------------------------------------------------------------------------------------
