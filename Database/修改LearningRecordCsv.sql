-- 修改列[LearningRecordCSv].[Item]

EXEC sp_rename '[LearningRecordCsv].[Item]','CourseName','COLUMN' 
GO

-- 修改列[LearningRecordCsv].[User ID]
EXEC sp_rename '[LearningRecordCsv].[User ID]','SSO','COLUMN' 
GO

-- 修改列[LearningRecordCsv].[User Name]
EXEC sp_rename '[LearningRecordCsv].[User Name]','UserName','COLUMN' 
GO

-- 修改列[LearningRecordCsv].[Completion Date]
EXEC sp_rename '[LearningRecordCsv].[Completion Date]','CompletedDate','COLUMN' 
GO

-- 添加列[LearningRecordCsv].[ID]
alter table LearningRecordCsv
add [ID] int identity(1,1) primary key
go

-- 添加列 [LearningRecordCsv].[CreatedDate]
alter table LearningRecordCsv
add [CreatedDate] datetime null default getdate()
go
