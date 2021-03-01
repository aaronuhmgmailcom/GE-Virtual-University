use learningjf
go

--------------------------------------------------------------------------------------------------------------
-- 删除列[LearningRecordExcel].[NO#]

Alter table  LearningRecordExcel
drop column [NO#]
GO

-- 删除列[LearningRecordExcel].[F10]
Alter table  LearningRecordExcel
drop column [F10]
GO


-- 删除列[LearningRecordExcel].[F11]

Alter table  LearningRecordExcel
drop column [F11]
GO

-- 删除列[LearningRecordExcel].[F12]
Alter table  LearningRecordExcel
drop column [F12]
GO

-- 添加列[LearningRecordExcel].[ID]

alter table LearningRecordExcel
add [ID] int identity(1,1) primary key
go

-- 添加列 [LearningRecordExcel].[CreatedDate]
alter table LearningRecordExcel
add [CreatedDate] datetime null default getdate()
go

-- 修改列[LearningRecordExcel].[Course]

EXEC sp_rename '[LearningRecordExcel].[Course]','CourseName','COLUMN' 
GO

-- 修改列[LearningRecordExcel].[SSO#]

EXEC sp_rename '[LearningRecordExcel].[SSO#]','SSO','COLUMN' 
GO

-- 修改列[LearningRecordExcel].[Name]

EXEC sp_rename '[LearningRecordExcel].[Name]','UserName','COLUMN' 
GO

-- 修改列[LearningRecordExcel].[Start Date]
EXEC sp_rename '[LearningRecordExcel].[Start Date]','StartDate','COLUMN' 
GO

-- 修改列[LearningRecordExcel].[Completed Date]
EXEC sp_rename '[LearningRecordExcel].[Completed Date]','CompletedDate','COLUMN' 
GO

------------------------------------------------------------------------------------------------------------------------------------

