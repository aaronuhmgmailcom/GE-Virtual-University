-- �޸���[LearningRecordCSv].[Item]

EXEC sp_rename '[LearningRecordCsv].[Item]','CourseName','COLUMN' 
GO

-- �޸���[LearningRecordCsv].[User ID]
EXEC sp_rename '[LearningRecordCsv].[User ID]','SSO','COLUMN' 
GO

-- �޸���[LearningRecordCsv].[User Name]
EXEC sp_rename '[LearningRecordCsv].[User Name]','UserName','COLUMN' 
GO

-- �޸���[LearningRecordCsv].[Completion Date]
EXEC sp_rename '[LearningRecordCsv].[Completion Date]','CompletedDate','COLUMN' 
GO

-- �����[LearningRecordCsv].[ID]
alter table LearningRecordCsv
add [ID] int identity(1,1) primary key
go

-- ����� [LearningRecordCsv].[CreatedDate]
alter table LearningRecordCsv
add [CreatedDate] datetime null default getdate()
go
