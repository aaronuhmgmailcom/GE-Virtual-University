-- �޸���[LearningRecordCSv].[Item]
IF EXISTS( select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[Item]' )
begin
EXEC sp_rename '[LearningRecordCsv].[courseid]','CourseName','COLUMN' 
end
GO

-- �޸���[LearningRecordCsv].[User ID]
IF EXISTS( select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[User ID]' )
begin
EXEC sp_rename '[LearningRecordCsv].[User ID]','SSO','COLUMN' 
end
GO

-- �޸���[LearningRecordCsv].[User Name]
IF EXISTS( select * from syscolumns where id=object_id('[LearningRecordCsv]') and name = '[User Name]' )
begin
EXEC sp_rename '[LearningRecordCsv].[User Name]','UserName','COLUMN' 
end
GO

-- �޸���[LearningRecordCsv].[Completion Date]
IF EXISTS( select * from syscolumns where id=object_id('[LearningRecordCsv]') and name = '[Completion Date]' )
begin
EXEC sp_rename '[LearningRecordCsv].[Completion Date]','CompletedDate','COLUMN' 
end
GO

-- �޸���[LearningRecordCsv].[courseid]
IF EXISTS( select * from syscolumns where id=object_id('[LearningRecordCsv]') and name = '[courseid]' )
begin
EXEC sp_rename '[LearningCsv].[courseid]','CourseId','COLUMN' 
end
GO

-- �����[LearningRecordCsv].[ID]
IF NOT EXISTS( select * from syscolumns where id=object_id('[LearningRecordCsv]') and name = '[ID]' )
begin
alter table LearningRecordCsv
add [ID] int identity(1,1) primary key
end
go

-- ����� [LearningRecordCsv].[CreatedDate]
IF NOT EXISTS( select * from syscolumns where id=object_id('[LearningRecordExcel]') and name = '[ID]' )
begin
alter table LearningRecordCsv
add [CreatedDate] datetime null default getdate()
end
go
