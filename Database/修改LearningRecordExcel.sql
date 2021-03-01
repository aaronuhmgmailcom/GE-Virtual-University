use learningjf
go

--------------------------------------------------------------------------------------------------------------
-- ɾ����[LearningRecordExcel].[NO#]

Alter table  LearningRecordExcel
drop column [NO#]
GO

-- ɾ����[LearningRecordExcel].[F10]
Alter table  LearningRecordExcel
drop column [F10]
GO


-- ɾ����[LearningRecordExcel].[F11]

Alter table  LearningRecordExcel
drop column [F11]
GO

-- ɾ����[LearningRecordExcel].[F12]
Alter table  LearningRecordExcel
drop column [F12]
GO

-- �����[LearningRecordExcel].[ID]

alter table LearningRecordExcel
add [ID] int identity(1,1) primary key
go

-- ����� [LearningRecordExcel].[CreatedDate]
alter table LearningRecordExcel
add [CreatedDate] datetime null default getdate()
go

-- �޸���[LearningRecordExcel].[Course]

EXEC sp_rename '[LearningRecordExcel].[Course]','CourseName','COLUMN' 
GO

-- �޸���[LearningRecordExcel].[SSO#]

EXEC sp_rename '[LearningRecordExcel].[SSO#]','SSO','COLUMN' 
GO

-- �޸���[LearningRecordExcel].[Name]

EXEC sp_rename '[LearningRecordExcel].[Name]','UserName','COLUMN' 
GO

-- �޸���[LearningRecordExcel].[Start Date]
EXEC sp_rename '[LearningRecordExcel].[Start Date]','StartDate','COLUMN' 
GO

-- �޸���[LearningRecordExcel].[Completed Date]
EXEC sp_rename '[LearningRecordExcel].[Completed Date]','CompletedDate','COLUMN' 
GO

------------------------------------------------------------------------------------------------------------------------------------

