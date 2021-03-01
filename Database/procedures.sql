
USE [learningjf]
GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.CallRoles_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.CallRoles_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.CallRoles_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the CallRoles table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.CallRoles_Get_List

AS


				
				SELECT
					[CallRoleID],
					[CallUserID],
					[TocallUserID],
					[CreateTime],
					[Status]
				FROM
					[dbo].[CallRoles]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.CallRoles_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.CallRoles_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.CallRoles_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the CallRoles table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.CallRoles_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [CallRoleID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([CallRoleID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [CallRoleID]'
				SET @SQL = @SQL + ' FROM [dbo].[CallRoles]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[CallRoleID], O.[CallUserID], O.[TocallUserID], O.[CreateTime], O.[Status]
				FROM
				    [dbo].[CallRoles] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[CallRoleID] = PageIndex.[CallRoleID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[CallRoles]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.CallRoles_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.CallRoles_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.CallRoles_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the CallRoles table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.CallRoles_Insert
(

	@CallRoleId int    OUTPUT,

	@CallUserId varchar (20)  ,

	@TocallUserId varchar (20)  ,

	@CreateTime datetime   ,

	@Status int   
)
AS


				
				INSERT INTO [dbo].[CallRoles]
					(
					[CallUserID]
					,[TocallUserID]
					,[CreateTime]
					,[Status]
					)
				VALUES
					(
					@CallUserId
					,@TocallUserId
					,@CreateTime
					,@Status
					)
				
				-- Get the identity value
				SET @CallRoleId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.CallRoles_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.CallRoles_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.CallRoles_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the CallRoles table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.CallRoles_Update
(

	@CallRoleId int   ,

	@CallUserId varchar (20)  ,

	@TocallUserId varchar (20)  ,

	@CreateTime datetime   ,

	@Status int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[CallRoles]
				SET
					[CallUserID] = @CallUserId
					,[TocallUserID] = @TocallUserId
					,[CreateTime] = @CreateTime
					,[Status] = @Status
				WHERE
[CallRoleID] = @CallRoleId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.CallRoles_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.CallRoles_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.CallRoles_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the CallRoles table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.CallRoles_Delete
(

	@CallRoleId int   
)
AS


				DELETE FROM [dbo].[CallRoles] WITH (ROWLOCK) 
				WHERE
					[CallRoleID] = @CallRoleId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.CallRoles_GetByCallRoleId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.CallRoles_GetByCallRoleId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.CallRoles_GetByCallRoleId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the CallRoles table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.CallRoles_GetByCallRoleId
(

	@CallRoleId int   
)
AS


				SELECT
					[CallRoleID],
					[CallUserID],
					[TocallUserID],
					[CreateTime],
					[Status]
				FROM
					[dbo].[CallRoles]
				WHERE
					[CallRoleID] = @CallRoleId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.CallRoles_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.CallRoles_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.CallRoles_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the CallRoles table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.CallRoles_Find
(

	@SearchUsingOR bit   = null ,

	@CallRoleId int   = null ,

	@CallUserId varchar (20)  = null ,

	@TocallUserId varchar (20)  = null ,

	@CreateTime datetime   = null ,

	@Status int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [CallRoleID]
	, [CallUserID]
	, [TocallUserID]
	, [CreateTime]
	, [Status]
    FROM
	[dbo].[CallRoles]
    WHERE 
	 ([CallRoleID] = @CallRoleId OR @CallRoleId IS NULL)
	AND ([CallUserID] = @CallUserId OR @CallUserId IS NULL)
	AND ([TocallUserID] = @TocallUserId OR @TocallUserId IS NULL)
	AND ([CreateTime] = @CreateTime OR @CreateTime IS NULL)
	AND ([Status] = @Status OR @Status IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [CallRoleID]
	, [CallUserID]
	, [TocallUserID]
	, [CreateTime]
	, [Status]
    FROM
	[dbo].[CallRoles]
    WHERE 
	 ([CallRoleID] = @CallRoleId AND @CallRoleId is not null)
	OR ([CallUserID] = @CallUserId AND @CallUserId is not null)
	OR ([TocallUserID] = @TocallUserId AND @TocallUserId is not null)
	OR ([CreateTime] = @CreateTime AND @CreateTime is not null)
	OR ([Status] = @Status AND @Status is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.TrainingLog_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.TrainingLog_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.TrainingLog_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the TrainingLog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.TrainingLog_Get_List

AS


				
				SELECT
					[TrainingLogID],
					[LogBeginTime],
					[LogEndTime],
					[TrainingTime],
					[MachineIP],
					[TrainUserID],
					[SessionID],
					[CourseWareID],
					[CourseID]
				FROM
					[dbo].[TrainingLog]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.TrainingLog_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.TrainingLog_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.TrainingLog_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the TrainingLog table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.TrainingLog_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [TrainingLogID] bigint 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([TrainingLogID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [TrainingLogID]'
				SET @SQL = @SQL + ' FROM [dbo].[TrainingLog]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[TrainingLogID], O.[LogBeginTime], O.[LogEndTime], O.[TrainingTime], O.[MachineIP], O.[TrainUserID], O.[SessionID], O.[CourseWareID], O.[CourseID]
				FROM
				    [dbo].[TrainingLog] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[TrainingLogID] = PageIndex.[TrainingLogID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[TrainingLog]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.TrainingLog_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.TrainingLog_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.TrainingLog_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the TrainingLog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.TrainingLog_Insert
(

	@TrainingLogId bigint    OUTPUT,

	@LogBeginTime datetime   ,

	@LogEndTime datetime   ,

	@TrainingTime int   ,

	@MachineIp varchar (20)  ,

	@TrainUserId int   ,

	@SessionId varchar (20)  ,

	@CourseWareId varchar (20)  ,

	@CourseId varchar (20)  
)
AS


				
				INSERT INTO [dbo].[TrainingLog]
					(
					[LogBeginTime]
					,[LogEndTime]
					,[TrainingTime]
					,[MachineIP]
					,[TrainUserID]
					,[SessionID]
					,[CourseWareID]
					,[CourseID]
					)
				VALUES
					(
					@LogBeginTime
					,@LogEndTime
					,@TrainingTime
					,@MachineIp
					,@TrainUserId
					,@SessionId
					,@CourseWareId
					,@CourseId
					)
				
				-- Get the identity value
				SET @TrainingLogId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.TrainingLog_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.TrainingLog_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.TrainingLog_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the TrainingLog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.TrainingLog_Update
(

	@TrainingLogId bigint   ,

	@LogBeginTime datetime   ,

	@LogEndTime datetime   ,

	@TrainingTime int   ,

	@MachineIp varchar (20)  ,

	@TrainUserId int   ,

	@SessionId varchar (20)  ,

	@CourseWareId varchar (20)  ,

	@CourseId varchar (20)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[TrainingLog]
				SET
					[LogBeginTime] = @LogBeginTime
					,[LogEndTime] = @LogEndTime
					,[TrainingTime] = @TrainingTime
					,[MachineIP] = @MachineIp
					,[TrainUserID] = @TrainUserId
					,[SessionID] = @SessionId
					,[CourseWareID] = @CourseWareId
					,[CourseID] = @CourseId
				WHERE
[TrainingLogID] = @TrainingLogId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.TrainingLog_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.TrainingLog_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.TrainingLog_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the TrainingLog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.TrainingLog_Delete
(

	@TrainingLogId bigint   
)
AS


				DELETE FROM [dbo].[TrainingLog] WITH (ROWLOCK) 
				WHERE
					[TrainingLogID] = @TrainingLogId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.TrainingLog_GetByTrainingLogId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.TrainingLog_GetByTrainingLogId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.TrainingLog_GetByTrainingLogId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the TrainingLog table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.TrainingLog_GetByTrainingLogId
(

	@TrainingLogId bigint   
)
AS


				SELECT
					[TrainingLogID],
					[LogBeginTime],
					[LogEndTime],
					[TrainingTime],
					[MachineIP],
					[TrainUserID],
					[SessionID],
					[CourseWareID],
					[CourseID]
				FROM
					[dbo].[TrainingLog]
				WHERE
					[TrainingLogID] = @TrainingLogId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.TrainingLog_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.TrainingLog_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.TrainingLog_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the TrainingLog table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.TrainingLog_Find
(

	@SearchUsingOR bit   = null ,

	@TrainingLogId bigint   = null ,

	@LogBeginTime datetime   = null ,

	@LogEndTime datetime   = null ,

	@TrainingTime int   = null ,

	@MachineIp varchar (20)  = null ,

	@TrainUserId int   = null ,

	@SessionId varchar (20)  = null ,

	@CourseWareId varchar (20)  = null ,

	@CourseId varchar (20)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [TrainingLogID]
	, [LogBeginTime]
	, [LogEndTime]
	, [TrainingTime]
	, [MachineIP]
	, [TrainUserID]
	, [SessionID]
	, [CourseWareID]
	, [CourseID]
    FROM
	[dbo].[TrainingLog]
    WHERE 
	 ([TrainingLogID] = @TrainingLogId OR @TrainingLogId IS NULL)
	AND ([LogBeginTime] = @LogBeginTime OR @LogBeginTime IS NULL)
	AND ([LogEndTime] = @LogEndTime OR @LogEndTime IS NULL)
	AND ([TrainingTime] = @TrainingTime OR @TrainingTime IS NULL)
	AND ([MachineIP] = @MachineIp OR @MachineIp IS NULL)
	AND ([TrainUserID] = @TrainUserId OR @TrainUserId IS NULL)
	AND ([SessionID] = @SessionId OR @SessionId IS NULL)
	AND ([CourseWareID] = @CourseWareId OR @CourseWareId IS NULL)
	AND ([CourseID] = @CourseId OR @CourseId IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [TrainingLogID]
	, [LogBeginTime]
	, [LogEndTime]
	, [TrainingTime]
	, [MachineIP]
	, [TrainUserID]
	, [SessionID]
	, [CourseWareID]
	, [CourseID]
    FROM
	[dbo].[TrainingLog]
    WHERE 
	 ([TrainingLogID] = @TrainingLogId AND @TrainingLogId is not null)
	OR ([LogBeginTime] = @LogBeginTime AND @LogBeginTime is not null)
	OR ([LogEndTime] = @LogEndTime AND @LogEndTime is not null)
	OR ([TrainingTime] = @TrainingTime AND @TrainingTime is not null)
	OR ([MachineIP] = @MachineIp AND @MachineIp is not null)
	OR ([TrainUserID] = @TrainUserId AND @TrainUserId is not null)
	OR ([SessionID] = @SessionId AND @SessionId is not null)
	OR ([CourseWareID] = @CourseWareId AND @CourseWareId is not null)
	OR ([CourseID] = @CourseId AND @CourseId is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.TrainingUser_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.TrainingUser_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.TrainingUser_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the TrainingUser table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.TrainingUser_Get_List

AS


				
				SELECT
					[TrainUserID],
					[UserID],
					[GroupID],
					[TrainingUserType],
					[TrainUserStatus],
					[TrainAuditingStatus],
					[TrainAuditingMan],
					[TrainAuditingDate],
					[CreateTime],
					[CourseID],
					[TrainAuditingDescription],
					[TrainingFinishTime],
					[TestFinishTime],
					[InvestigationFinishTime],
					[StudyFinishTime],
					[TrainTimeUseCredit],
					[TrainTimeAddPoint]
				FROM
					[dbo].[TrainingUser]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.TrainingUser_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.TrainingUser_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.TrainingUser_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the TrainingUser table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.TrainingUser_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [TrainUserID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([TrainUserID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [TrainUserID]'
				SET @SQL = @SQL + ' FROM [dbo].[TrainingUser]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[TrainUserID], O.[UserID], O.[GroupID], O.[TrainingUserType], O.[TrainUserStatus], O.[TrainAuditingStatus], O.[TrainAuditingMan], O.[TrainAuditingDate], O.[CreateTime], O.[CourseID], O.[TrainAuditingDescription], O.[TrainingFinishTime], O.[TestFinishTime], O.[InvestigationFinishTime], O.[StudyFinishTime], O.[TrainTimeUseCredit], O.[TrainTimeAddPoint]
				FROM
				    [dbo].[TrainingUser] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[TrainUserID] = PageIndex.[TrainUserID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[TrainingUser]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.TrainingUser_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.TrainingUser_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.TrainingUser_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the TrainingUser table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.TrainingUser_Insert
(

	@TrainUserId int    OUTPUT,

	@UserId varchar (20)  ,

	@GroupId varchar (20)  ,

	@TrainingUserType int   ,

	@TrainUserStatus int   ,

	@TrainAuditingStatus int   ,

	@TrainAuditingMan varchar (20)  ,

	@TrainAuditingDate datetime   ,

	@CreateTime datetime   ,

	@CourseId varchar (20)  ,

	@TrainAuditingDescription varchar (500)  ,

	@TrainingFinishTime smalldatetime   ,

	@TestFinishTime smalldatetime   ,

	@InvestigationFinishTime smalldatetime   ,

	@StudyFinishTime smalldatetime   ,

	@TrainTimeUseCredit int   ,

	@TrainTimeAddPoint int   
)
AS


				
				INSERT INTO [dbo].[TrainingUser]
					(
					[UserID]
					,[GroupID]
					,[TrainingUserType]
					,[TrainUserStatus]
					,[TrainAuditingStatus]
					,[TrainAuditingMan]
					,[TrainAuditingDate]
					,[CreateTime]
					,[CourseID]
					,[TrainAuditingDescription]
					,[TrainingFinishTime]
					,[TestFinishTime]
					,[InvestigationFinishTime]
					,[StudyFinishTime]
					,[TrainTimeUseCredit]
					,[TrainTimeAddPoint]
					)
				VALUES
					(
					@UserId
					,@GroupId
					,@TrainingUserType
					,@TrainUserStatus
					,@TrainAuditingStatus
					,@TrainAuditingMan
					,@TrainAuditingDate
					,@CreateTime
					,@CourseId
					,@TrainAuditingDescription
					,@TrainingFinishTime
					,@TestFinishTime
					,@InvestigationFinishTime
					,@StudyFinishTime
					,@TrainTimeUseCredit
					,@TrainTimeAddPoint
					)
				
				-- Get the identity value
				SET @TrainUserId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.TrainingUser_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.TrainingUser_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.TrainingUser_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the TrainingUser table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.TrainingUser_Update
(

	@TrainUserId int   ,

	@UserId varchar (20)  ,

	@GroupId varchar (20)  ,

	@TrainingUserType int   ,

	@TrainUserStatus int   ,

	@TrainAuditingStatus int   ,

	@TrainAuditingMan varchar (20)  ,

	@TrainAuditingDate datetime   ,

	@CreateTime datetime   ,

	@CourseId varchar (20)  ,

	@TrainAuditingDescription varchar (500)  ,

	@TrainingFinishTime smalldatetime   ,

	@TestFinishTime smalldatetime   ,

	@InvestigationFinishTime smalldatetime   ,

	@StudyFinishTime smalldatetime   ,

	@TrainTimeUseCredit int   ,

	@TrainTimeAddPoint int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[TrainingUser]
				SET
					[UserID] = @UserId
					,[GroupID] = @GroupId
					,[TrainingUserType] = @TrainingUserType
					,[TrainUserStatus] = @TrainUserStatus
					,[TrainAuditingStatus] = @TrainAuditingStatus
					,[TrainAuditingMan] = @TrainAuditingMan
					,[TrainAuditingDate] = @TrainAuditingDate
					,[CreateTime] = @CreateTime
					,[CourseID] = @CourseId
					,[TrainAuditingDescription] = @TrainAuditingDescription
					,[TrainingFinishTime] = @TrainingFinishTime
					,[TestFinishTime] = @TestFinishTime
					,[InvestigationFinishTime] = @InvestigationFinishTime
					,[StudyFinishTime] = @StudyFinishTime
					,[TrainTimeUseCredit] = @TrainTimeUseCredit
					,[TrainTimeAddPoint] = @TrainTimeAddPoint
				WHERE
[TrainUserID] = @TrainUserId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.TrainingUser_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.TrainingUser_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.TrainingUser_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the TrainingUser table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.TrainingUser_Delete
(

	@TrainUserId int   
)
AS


				DELETE FROM [dbo].[TrainingUser] WITH (ROWLOCK) 
				WHERE
					[TrainUserID] = @TrainUserId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.TrainingUser_GetByTrainUserId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.TrainingUser_GetByTrainUserId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.TrainingUser_GetByTrainUserId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the TrainingUser table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.TrainingUser_GetByTrainUserId
(

	@TrainUserId int   
)
AS


				SELECT
					[TrainUserID],
					[UserID],
					[GroupID],
					[TrainingUserType],
					[TrainUserStatus],
					[TrainAuditingStatus],
					[TrainAuditingMan],
					[TrainAuditingDate],
					[CreateTime],
					[CourseID],
					[TrainAuditingDescription],
					[TrainingFinishTime],
					[TestFinishTime],
					[InvestigationFinishTime],
					[StudyFinishTime],
					[TrainTimeUseCredit],
					[TrainTimeAddPoint]
				FROM
					[dbo].[TrainingUser]
				WHERE
					[TrainUserID] = @TrainUserId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.TrainingUser_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.TrainingUser_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.TrainingUser_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the TrainingUser table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.TrainingUser_Find
(

	@SearchUsingOR bit   = null ,

	@TrainUserId int   = null ,

	@UserId varchar (20)  = null ,

	@GroupId varchar (20)  = null ,

	@TrainingUserType int   = null ,

	@TrainUserStatus int   = null ,

	@TrainAuditingStatus int   = null ,

	@TrainAuditingMan varchar (20)  = null ,

	@TrainAuditingDate datetime   = null ,

	@CreateTime datetime   = null ,

	@CourseId varchar (20)  = null ,

	@TrainAuditingDescription varchar (500)  = null ,

	@TrainingFinishTime smalldatetime   = null ,

	@TestFinishTime smalldatetime   = null ,

	@InvestigationFinishTime smalldatetime   = null ,

	@StudyFinishTime smalldatetime   = null ,

	@TrainTimeUseCredit int   = null ,

	@TrainTimeAddPoint int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [TrainUserID]
	, [UserID]
	, [GroupID]
	, [TrainingUserType]
	, [TrainUserStatus]
	, [TrainAuditingStatus]
	, [TrainAuditingMan]
	, [TrainAuditingDate]
	, [CreateTime]
	, [CourseID]
	, [TrainAuditingDescription]
	, [TrainingFinishTime]
	, [TestFinishTime]
	, [InvestigationFinishTime]
	, [StudyFinishTime]
	, [TrainTimeUseCredit]
	, [TrainTimeAddPoint]
    FROM
	[dbo].[TrainingUser]
    WHERE 
	 ([TrainUserID] = @TrainUserId OR @TrainUserId IS NULL)
	AND ([UserID] = @UserId OR @UserId IS NULL)
	AND ([GroupID] = @GroupId OR @GroupId IS NULL)
	AND ([TrainingUserType] = @TrainingUserType OR @TrainingUserType IS NULL)
	AND ([TrainUserStatus] = @TrainUserStatus OR @TrainUserStatus IS NULL)
	AND ([TrainAuditingStatus] = @TrainAuditingStatus OR @TrainAuditingStatus IS NULL)
	AND ([TrainAuditingMan] = @TrainAuditingMan OR @TrainAuditingMan IS NULL)
	AND ([TrainAuditingDate] = @TrainAuditingDate OR @TrainAuditingDate IS NULL)
	AND ([CreateTime] = @CreateTime OR @CreateTime IS NULL)
	AND ([CourseID] = @CourseId OR @CourseId IS NULL)
	AND ([TrainAuditingDescription] = @TrainAuditingDescription OR @TrainAuditingDescription IS NULL)
	AND ([TrainingFinishTime] = @TrainingFinishTime OR @TrainingFinishTime IS NULL)
	AND ([TestFinishTime] = @TestFinishTime OR @TestFinishTime IS NULL)
	AND ([InvestigationFinishTime] = @InvestigationFinishTime OR @InvestigationFinishTime IS NULL)
	AND ([StudyFinishTime] = @StudyFinishTime OR @StudyFinishTime IS NULL)
	AND ([TrainTimeUseCredit] = @TrainTimeUseCredit OR @TrainTimeUseCredit IS NULL)
	AND ([TrainTimeAddPoint] = @TrainTimeAddPoint OR @TrainTimeAddPoint IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [TrainUserID]
	, [UserID]
	, [GroupID]
	, [TrainingUserType]
	, [TrainUserStatus]
	, [TrainAuditingStatus]
	, [TrainAuditingMan]
	, [TrainAuditingDate]
	, [CreateTime]
	, [CourseID]
	, [TrainAuditingDescription]
	, [TrainingFinishTime]
	, [TestFinishTime]
	, [InvestigationFinishTime]
	, [StudyFinishTime]
	, [TrainTimeUseCredit]
	, [TrainTimeAddPoint]
    FROM
	[dbo].[TrainingUser]
    WHERE 
	 ([TrainUserID] = @TrainUserId AND @TrainUserId is not null)
	OR ([UserID] = @UserId AND @UserId is not null)
	OR ([GroupID] = @GroupId AND @GroupId is not null)
	OR ([TrainingUserType] = @TrainingUserType AND @TrainingUserType is not null)
	OR ([TrainUserStatus] = @TrainUserStatus AND @TrainUserStatus is not null)
	OR ([TrainAuditingStatus] = @TrainAuditingStatus AND @TrainAuditingStatus is not null)
	OR ([TrainAuditingMan] = @TrainAuditingMan AND @TrainAuditingMan is not null)
	OR ([TrainAuditingDate] = @TrainAuditingDate AND @TrainAuditingDate is not null)
	OR ([CreateTime] = @CreateTime AND @CreateTime is not null)
	OR ([CourseID] = @CourseId AND @CourseId is not null)
	OR ([TrainAuditingDescription] = @TrainAuditingDescription AND @TrainAuditingDescription is not null)
	OR ([TrainingFinishTime] = @TrainingFinishTime AND @TrainingFinishTime is not null)
	OR ([TestFinishTime] = @TestFinishTime AND @TestFinishTime is not null)
	OR ([InvestigationFinishTime] = @InvestigationFinishTime AND @InvestigationFinishTime is not null)
	OR ([StudyFinishTime] = @StudyFinishTime AND @StudyFinishTime is not null)
	OR ([TrainTimeUseCredit] = @TrainTimeUseCredit AND @TrainTimeUseCredit is not null)
	OR ([TrainTimeAddPoint] = @TrainTimeAddPoint AND @TrainTimeAddPoint is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserGroup_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserGroup_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserGroup_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the UserGroup table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserGroup_Get_List

AS


				
				SELECT
					[GroupID],
					[UserID],
					[AutoID]
				FROM
					[dbo].[UserGroup]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserGroup_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserGroup_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserGroup_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the UserGroup table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserGroup_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [AutoID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([AutoID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [AutoID]'
				SET @SQL = @SQL + ' FROM [dbo].[UserGroup]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[GroupID], O.[UserID], O.[AutoID]
				FROM
				    [dbo].[UserGroup] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[AutoID] = PageIndex.[AutoID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[UserGroup]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserGroup_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserGroup_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserGroup_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the UserGroup table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserGroup_Insert
(

	@GroupId varchar (20)  ,

	@UserId varchar (20)  ,

	@AutoId int    OUTPUT
)
AS


				
				INSERT INTO [dbo].[UserGroup]
					(
					[GroupID]
					,[UserID]
					)
				VALUES
					(
					@GroupId
					,@UserId
					)
				
				-- Get the identity value
				SET @AutoId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserGroup_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserGroup_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserGroup_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the UserGroup table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserGroup_Update
(

	@GroupId varchar (20)  ,

	@UserId varchar (20)  ,

	@AutoId int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[UserGroup]
				SET
					[GroupID] = @GroupId
					,[UserID] = @UserId
				WHERE
[AutoID] = @AutoId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserGroup_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserGroup_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserGroup_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the UserGroup table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserGroup_Delete
(

	@AutoId int   
)
AS


				DELETE FROM [dbo].[UserGroup] WITH (ROWLOCK) 
				WHERE
					[AutoID] = @AutoId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserGroup_GetByAutoId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserGroup_GetByAutoId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserGroup_GetByAutoId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the UserGroup table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserGroup_GetByAutoId
(

	@AutoId int   
)
AS


				SELECT
					[GroupID],
					[UserID],
					[AutoID]
				FROM
					[dbo].[UserGroup]
				WHERE
					[AutoID] = @AutoId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserGroup_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserGroup_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserGroup_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the UserGroup table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserGroup_Find
(

	@SearchUsingOR bit   = null ,

	@GroupId varchar (20)  = null ,

	@UserId varchar (20)  = null ,

	@AutoId int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [GroupID]
	, [UserID]
	, [AutoID]
    FROM
	[dbo].[UserGroup]
    WHERE 
	 ([GroupID] = @GroupId OR @GroupId IS NULL)
	AND ([UserID] = @UserId OR @UserId IS NULL)
	AND ([AutoID] = @AutoId OR @AutoId IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [GroupID]
	, [UserID]
	, [AutoID]
    FROM
	[dbo].[UserGroup]
    WHERE 
	 ([GroupID] = @GroupId AND @GroupId is not null)
	OR ([UserID] = @UserId AND @UserId is not null)
	OR ([AutoID] = @AutoId AND @AutoId is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserInfo_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserInfo_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserInfo_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the UserInfo table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserInfo_Get_List

AS


				
				SELECT
					[UserID],
					[UserName],
					[UserCNName],
					[Password],
					[Telephone],
					[Email],
					[UserStatus],
					[CreateTime],
					[FEBadgeID],
					[Mobile],
					[UserType],
					[UserCredit],
					[department],
					[OHR_Solid_Line_Mgr_ID],
					[OHR_HR_Rep]
				FROM
					[dbo].[UserInfo]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserInfo_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserInfo_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserInfo_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the UserInfo table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserInfo_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [UserID] varchar(20) COLLATE database_default  
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([UserID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [UserID]'
				SET @SQL = @SQL + ' FROM [dbo].[UserInfo]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[UserID], O.[UserName], O.[UserCNName], O.[Password], O.[Telephone], O.[Email], O.[UserStatus], O.[CreateTime], O.[FEBadgeID], O.[Mobile], O.[UserType], O.[UserCredit], O.[department], O.[OHR_Solid_Line_Mgr_ID], O.[OHR_HR_Rep]
				FROM
				    [dbo].[UserInfo] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[UserID] = PageIndex.[UserID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[UserInfo]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserInfo_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserInfo_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserInfo_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the UserInfo table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserInfo_Insert
(

	@UserId varchar (20)  ,

	@UserName varchar (20)  ,

	@UserCnName varchar (20)  ,

	@Password varchar (50)  ,

	@Telephone varchar (50)  ,

	@Email varchar (50)  ,

	@UserStatus int   ,

	@CreateTime datetime   ,

	@FeBadgeId varchar (20)  ,

	@Mobile varchar (50)  ,

	@UserType int   ,

	@UserCredit int   ,

	@Department varchar (150)  ,

	@OhrSolidLineMgrId nvarchar (250)  ,

	@OhrHrRep nvarchar (250)  
)
AS


				
				INSERT INTO [dbo].[UserInfo]
					(
					[UserID]
					,[UserName]
					,[UserCNName]
					,[Password]
					,[Telephone]
					,[Email]
					,[UserStatus]
					,[CreateTime]
					,[FEBadgeID]
					,[Mobile]
					,[UserType]
					,[UserCredit]
					,[department]
					,[OHR_Solid_Line_Mgr_ID]
					,[OHR_HR_Rep]
					)
				VALUES
					(
					@UserId
					,@UserName
					,@UserCnName
					,@Password
					,@Telephone
					,@Email
					,@UserStatus
					,@CreateTime
					,@FeBadgeId
					,@Mobile
					,@UserType
					,@UserCredit
					,@Department
					,@OhrSolidLineMgrId
					,@OhrHrRep
					)
				
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserInfo_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserInfo_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserInfo_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the UserInfo table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserInfo_Update
(

	@UserId varchar (20)  ,

	@OriginalUserId varchar (20)  ,

	@UserName varchar (20)  ,

	@UserCnName varchar (20)  ,

	@Password varchar (50)  ,

	@Telephone varchar (50)  ,

	@Email varchar (50)  ,

	@UserStatus int   ,

	@CreateTime datetime   ,

	@FeBadgeId varchar (20)  ,

	@Mobile varchar (50)  ,

	@UserType int   ,

	@UserCredit int   ,

	@Department varchar (150)  ,

	@OhrSolidLineMgrId nvarchar (250)  ,

	@OhrHrRep nvarchar (250)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[UserInfo]
				SET
					[UserID] = @UserId
					,[UserName] = @UserName
					,[UserCNName] = @UserCnName
					,[Password] = @Password
					,[Telephone] = @Telephone
					,[Email] = @Email
					,[UserStatus] = @UserStatus
					,[CreateTime] = @CreateTime
					,[FEBadgeID] = @FeBadgeId
					,[Mobile] = @Mobile
					,[UserType] = @UserType
					,[UserCredit] = @UserCredit
					,[department] = @Department
					,[OHR_Solid_Line_Mgr_ID] = @OhrSolidLineMgrId
					,[OHR_HR_Rep] = @OhrHrRep
				WHERE
[UserID] = @OriginalUserId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserInfo_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserInfo_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserInfo_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the UserInfo table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserInfo_Delete
(

	@UserId varchar (20)  
)
AS


				DELETE FROM [dbo].[UserInfo] WITH (ROWLOCK) 
				WHERE
					[UserID] = @UserId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserInfo_GetByUserId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserInfo_GetByUserId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserInfo_GetByUserId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the UserInfo table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserInfo_GetByUserId
(

	@UserId varchar (20)  
)
AS


				SELECT
					[UserID],
					[UserName],
					[UserCNName],
					[Password],
					[Telephone],
					[Email],
					[UserStatus],
					[CreateTime],
					[FEBadgeID],
					[Mobile],
					[UserType],
					[UserCredit],
					[department],
					[OHR_Solid_Line_Mgr_ID],
					[OHR_HR_Rep]
				FROM
					[dbo].[UserInfo]
				WHERE
					[UserID] = @UserId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserInfo_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserInfo_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserInfo_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the UserInfo table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserInfo_Find
(

	@SearchUsingOR bit   = null ,

	@UserId varchar (20)  = null ,

	@UserName varchar (20)  = null ,

	@UserCnName varchar (20)  = null ,

	@Password varchar (50)  = null ,

	@Telephone varchar (50)  = null ,

	@Email varchar (50)  = null ,

	@UserStatus int   = null ,

	@CreateTime datetime   = null ,

	@FeBadgeId varchar (20)  = null ,

	@Mobile varchar (50)  = null ,

	@UserType int   = null ,

	@UserCredit int   = null ,

	@Department varchar (150)  = null ,

	@OhrSolidLineMgrId nvarchar (250)  = null ,

	@OhrHrRep nvarchar (250)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [UserID]
	, [UserName]
	, [UserCNName]
	, [Password]
	, [Telephone]
	, [Email]
	, [UserStatus]
	, [CreateTime]
	, [FEBadgeID]
	, [Mobile]
	, [UserType]
	, [UserCredit]
	, [department]
	, [OHR_Solid_Line_Mgr_ID]
	, [OHR_HR_Rep]
    FROM
	[dbo].[UserInfo]
    WHERE 
	 ([UserID] = @UserId OR @UserId IS NULL)
	AND ([UserName] = @UserName OR @UserName IS NULL)
	AND ([UserCNName] = @UserCnName OR @UserCnName IS NULL)
	AND ([Password] = @Password OR @Password IS NULL)
	AND ([Telephone] = @Telephone OR @Telephone IS NULL)
	AND ([Email] = @Email OR @Email IS NULL)
	AND ([UserStatus] = @UserStatus OR @UserStatus IS NULL)
	AND ([CreateTime] = @CreateTime OR @CreateTime IS NULL)
	AND ([FEBadgeID] = @FeBadgeId OR @FeBadgeId IS NULL)
	AND ([Mobile] = @Mobile OR @Mobile IS NULL)
	AND ([UserType] = @UserType OR @UserType IS NULL)
	AND ([UserCredit] = @UserCredit OR @UserCredit IS NULL)
	AND ([department] = @Department OR @Department IS NULL)
	AND ([OHR_Solid_Line_Mgr_ID] = @OhrSolidLineMgrId OR @OhrSolidLineMgrId IS NULL)
	AND ([OHR_HR_Rep] = @OhrHrRep OR @OhrHrRep IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [UserID]
	, [UserName]
	, [UserCNName]
	, [Password]
	, [Telephone]
	, [Email]
	, [UserStatus]
	, [CreateTime]
	, [FEBadgeID]
	, [Mobile]
	, [UserType]
	, [UserCredit]
	, [department]
	, [OHR_Solid_Line_Mgr_ID]
	, [OHR_HR_Rep]
    FROM
	[dbo].[UserInfo]
    WHERE 
	 ([UserID] = @UserId AND @UserId is not null)
	OR ([UserName] = @UserName AND @UserName is not null)
	OR ([UserCNName] = @UserCnName AND @UserCnName is not null)
	OR ([Password] = @Password AND @Password is not null)
	OR ([Telephone] = @Telephone AND @Telephone is not null)
	OR ([Email] = @Email AND @Email is not null)
	OR ([UserStatus] = @UserStatus AND @UserStatus is not null)
	OR ([CreateTime] = @CreateTime AND @CreateTime is not null)
	OR ([FEBadgeID] = @FeBadgeId AND @FeBadgeId is not null)
	OR ([Mobile] = @Mobile AND @Mobile is not null)
	OR ([UserType] = @UserType AND @UserType is not null)
	OR ([UserCredit] = @UserCredit AND @UserCredit is not null)
	OR ([department] = @Department AND @Department is not null)
	OR ([OHR_Solid_Line_Mgr_ID] = @OhrSolidLineMgrId AND @OhrSolidLineMgrId is not null)
	OR ([OHR_HR_Rep] = @OhrHrRep AND @OhrHrRep is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.SysLog_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.SysLog_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.SysLog_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the SysLog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.SysLog_Get_List

AS


				
				SELECT
					[LogId],
					[LogClass],
					[LogDescribe],
					[UserID],
					[LogDate]
				FROM
					[dbo].[SysLog]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.SysLog_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.SysLog_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.SysLog_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the SysLog table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.SysLog_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [LogId] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([LogId])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [LogId]'
				SET @SQL = @SQL + ' FROM [dbo].[SysLog]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[LogId], O.[LogClass], O.[LogDescribe], O.[UserID], O.[LogDate]
				FROM
				    [dbo].[SysLog] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[LogId] = PageIndex.[LogId]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[SysLog]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.SysLog_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.SysLog_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.SysLog_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the SysLog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.SysLog_Insert
(

	@LogId int    OUTPUT,

	@LogClass varchar (20)  ,

	@LogDescribe varchar (500)  ,

	@UserId varchar (50)  ,

	@LogDate datetime   
)
AS


				
				INSERT INTO [dbo].[SysLog]
					(
					[LogClass]
					,[LogDescribe]
					,[UserID]
					,[LogDate]
					)
				VALUES
					(
					@LogClass
					,@LogDescribe
					,@UserId
					,@LogDate
					)
				
				-- Get the identity value
				SET @LogId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.SysLog_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.SysLog_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.SysLog_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the SysLog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.SysLog_Update
(

	@LogId int   ,

	@LogClass varchar (20)  ,

	@LogDescribe varchar (500)  ,

	@UserId varchar (50)  ,

	@LogDate datetime   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[SysLog]
				SET
					[LogClass] = @LogClass
					,[LogDescribe] = @LogDescribe
					,[UserID] = @UserId
					,[LogDate] = @LogDate
				WHERE
[LogId] = @LogId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.SysLog_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.SysLog_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.SysLog_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the SysLog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.SysLog_Delete
(

	@LogId int   
)
AS


				DELETE FROM [dbo].[SysLog] WITH (ROWLOCK) 
				WHERE
					[LogId] = @LogId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.SysLog_GetByLogId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.SysLog_GetByLogId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.SysLog_GetByLogId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the SysLog table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.SysLog_GetByLogId
(

	@LogId int   
)
AS


				SELECT
					[LogId],
					[LogClass],
					[LogDescribe],
					[UserID],
					[LogDate]
				FROM
					[dbo].[SysLog]
				WHERE
					[LogId] = @LogId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.SysLog_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.SysLog_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.SysLog_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the SysLog table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.SysLog_Find
(

	@SearchUsingOR bit   = null ,

	@LogId int   = null ,

	@LogClass varchar (20)  = null ,

	@LogDescribe varchar (500)  = null ,

	@UserId varchar (50)  = null ,

	@LogDate datetime   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [LogId]
	, [LogClass]
	, [LogDescribe]
	, [UserID]
	, [LogDate]
    FROM
	[dbo].[SysLog]
    WHERE 
	 ([LogId] = @LogId OR @LogId IS NULL)
	AND ([LogClass] = @LogClass OR @LogClass IS NULL)
	AND ([LogDescribe] = @LogDescribe OR @LogDescribe IS NULL)
	AND ([UserID] = @UserId OR @UserId IS NULL)
	AND ([LogDate] = @LogDate OR @LogDate IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [LogId]
	, [LogClass]
	, [LogDescribe]
	, [UserID]
	, [LogDate]
    FROM
	[dbo].[SysLog]
    WHERE 
	 ([LogId] = @LogId AND @LogId is not null)
	OR ([LogClass] = @LogClass AND @LogClass is not null)
	OR ([LogDescribe] = @LogDescribe AND @LogDescribe is not null)
	OR ([UserID] = @UserId AND @UserId is not null)
	OR ([LogDate] = @LogDate AND @LogDate is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Students_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Students_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Students_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the Students table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Students_Get_List

AS


				
				SELECT
					[StudentID],
					[UserID],
					[CreateTime],
					[Status],
					[DegreeID],
					[Notes],
					[studies],
					[ApplyDate],
					[ApprovalofHuman],
					[ApproveofDate]
				FROM
					[dbo].[Students]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Students_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Students_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Students_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the Students table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Students_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [StudentID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([StudentID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [StudentID]'
				SET @SQL = @SQL + ' FROM [dbo].[Students]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[StudentID], O.[UserID], O.[CreateTime], O.[Status], O.[DegreeID], O.[Notes], O.[studies], O.[ApplyDate], O.[ApprovalofHuman], O.[ApproveofDate]
				FROM
				    [dbo].[Students] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[StudentID] = PageIndex.[StudentID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[Students]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Students_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Students_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Students_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the Students table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Students_Insert
(

	@StudentId int    OUTPUT,

	@UserId varchar (20)  ,

	@CreateTime datetime   ,

	@Status int   ,

	@DegreeId int   ,

	@Notes varchar (500)  ,

	@Studies int   ,

	@ApplyDate datetime   ,

	@ApprovalofHuman varchar (20)  ,

	@ApproveofDate datetime   
)
AS


				
				INSERT INTO [dbo].[Students]
					(
					[UserID]
					,[CreateTime]
					,[Status]
					,[DegreeID]
					,[Notes]
					,[studies]
					,[ApplyDate]
					,[ApprovalofHuman]
					,[ApproveofDate]
					)
				VALUES
					(
					@UserId
					,@CreateTime
					,@Status
					,@DegreeId
					,@Notes
					,@Studies
					,@ApplyDate
					,@ApprovalofHuman
					,@ApproveofDate
					)
				
				-- Get the identity value
				SET @StudentId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Students_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Students_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Students_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the Students table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Students_Update
(

	@StudentId int   ,

	@UserId varchar (20)  ,

	@CreateTime datetime   ,

	@Status int   ,

	@DegreeId int   ,

	@Notes varchar (500)  ,

	@Studies int   ,

	@ApplyDate datetime   ,

	@ApprovalofHuman varchar (20)  ,

	@ApproveofDate datetime   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[Students]
				SET
					[UserID] = @UserId
					,[CreateTime] = @CreateTime
					,[Status] = @Status
					,[DegreeID] = @DegreeId
					,[Notes] = @Notes
					,[studies] = @Studies
					,[ApplyDate] = @ApplyDate
					,[ApprovalofHuman] = @ApprovalofHuman
					,[ApproveofDate] = @ApproveofDate
				WHERE
[StudentID] = @StudentId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Students_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Students_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Students_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the Students table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Students_Delete
(

	@StudentId int   
)
AS


				DELETE FROM [dbo].[Students] WITH (ROWLOCK) 
				WHERE
					[StudentID] = @StudentId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Students_GetByStudentId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Students_GetByStudentId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Students_GetByStudentId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the Students table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Students_GetByStudentId
(

	@StudentId int   
)
AS


				SELECT
					[StudentID],
					[UserID],
					[CreateTime],
					[Status],
					[DegreeID],
					[Notes],
					[studies],
					[ApplyDate],
					[ApprovalofHuman],
					[ApproveofDate]
				FROM
					[dbo].[Students]
				WHERE
					[StudentID] = @StudentId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Students_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Students_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Students_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the Students table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Students_Find
(

	@SearchUsingOR bit   = null ,

	@StudentId int   = null ,

	@UserId varchar (20)  = null ,

	@CreateTime datetime   = null ,

	@Status int   = null ,

	@DegreeId int   = null ,

	@Notes varchar (500)  = null ,

	@Studies int   = null ,

	@ApplyDate datetime   = null ,

	@ApprovalofHuman varchar (20)  = null ,

	@ApproveofDate datetime   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [StudentID]
	, [UserID]
	, [CreateTime]
	, [Status]
	, [DegreeID]
	, [Notes]
	, [studies]
	, [ApplyDate]
	, [ApprovalofHuman]
	, [ApproveofDate]
    FROM
	[dbo].[Students]
    WHERE 
	 ([StudentID] = @StudentId OR @StudentId IS NULL)
	AND ([UserID] = @UserId OR @UserId IS NULL)
	AND ([CreateTime] = @CreateTime OR @CreateTime IS NULL)
	AND ([Status] = @Status OR @Status IS NULL)
	AND ([DegreeID] = @DegreeId OR @DegreeId IS NULL)
	AND ([Notes] = @Notes OR @Notes IS NULL)
	AND ([studies] = @Studies OR @Studies IS NULL)
	AND ([ApplyDate] = @ApplyDate OR @ApplyDate IS NULL)
	AND ([ApprovalofHuman] = @ApprovalofHuman OR @ApprovalofHuman IS NULL)
	AND ([ApproveofDate] = @ApproveofDate OR @ApproveofDate IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [StudentID]
	, [UserID]
	, [CreateTime]
	, [Status]
	, [DegreeID]
	, [Notes]
	, [studies]
	, [ApplyDate]
	, [ApprovalofHuman]
	, [ApproveofDate]
    FROM
	[dbo].[Students]
    WHERE 
	 ([StudentID] = @StudentId AND @StudentId is not null)
	OR ([UserID] = @UserId AND @UserId is not null)
	OR ([CreateTime] = @CreateTime AND @CreateTime is not null)
	OR ([Status] = @Status AND @Status is not null)
	OR ([DegreeID] = @DegreeId AND @DegreeId is not null)
	OR ([Notes] = @Notes AND @Notes is not null)
	OR ([studies] = @Studies AND @Studies is not null)
	OR ([ApplyDate] = @ApplyDate AND @ApplyDate is not null)
	OR ([ApprovalofHuman] = @ApprovalofHuman AND @ApprovalofHuman is not null)
	OR ([ApproveofDate] = @ApproveofDate AND @ApproveofDate is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Permission_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Permission_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Permission_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the Permission table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Permission_Get_List

AS


				
				SELECT
					[PermissionID],
					[PermissionName],
					[PermissionURL],
					[Status],
					[MenuID]
				FROM
					[dbo].[Permission]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Permission_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Permission_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Permission_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the Permission table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Permission_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [PermissionID] varchar(40) COLLATE database_default  
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([PermissionID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [PermissionID]'
				SET @SQL = @SQL + ' FROM [dbo].[Permission]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[PermissionID], O.[PermissionName], O.[PermissionURL], O.[Status], O.[MenuID]
				FROM
				    [dbo].[Permission] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[PermissionID] = PageIndex.[PermissionID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[Permission]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Permission_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Permission_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Permission_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the Permission table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Permission_Insert
(

	@PermissionId varchar (40)  ,

	@PermissionName varchar (150)  ,

	@PermissionUrl varchar (150)  ,

	@Status int   ,

	@MenuId varchar (40)  
)
AS


				
				INSERT INTO [dbo].[Permission]
					(
					[PermissionID]
					,[PermissionName]
					,[PermissionURL]
					,[Status]
					,[MenuID]
					)
				VALUES
					(
					@PermissionId
					,@PermissionName
					,@PermissionUrl
					,@Status
					,@MenuId
					)
				
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Permission_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Permission_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Permission_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the Permission table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Permission_Update
(

	@PermissionId varchar (40)  ,

	@OriginalPermissionId varchar (40)  ,

	@PermissionName varchar (150)  ,

	@PermissionUrl varchar (150)  ,

	@Status int   ,

	@MenuId varchar (40)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[Permission]
				SET
					[PermissionID] = @PermissionId
					,[PermissionName] = @PermissionName
					,[PermissionURL] = @PermissionUrl
					,[Status] = @Status
					,[MenuID] = @MenuId
				WHERE
[PermissionID] = @OriginalPermissionId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Permission_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Permission_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Permission_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the Permission table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Permission_Delete
(

	@PermissionId varchar (40)  
)
AS


				DELETE FROM [dbo].[Permission] WITH (ROWLOCK) 
				WHERE
					[PermissionID] = @PermissionId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Permission_GetByPermissionId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Permission_GetByPermissionId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Permission_GetByPermissionId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the Permission table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Permission_GetByPermissionId
(

	@PermissionId varchar (40)  
)
AS


				SELECT
					[PermissionID],
					[PermissionName],
					[PermissionURL],
					[Status],
					[MenuID]
				FROM
					[dbo].[Permission]
				WHERE
					[PermissionID] = @PermissionId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Permission_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Permission_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Permission_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the Permission table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Permission_Find
(

	@SearchUsingOR bit   = null ,

	@PermissionId varchar (40)  = null ,

	@PermissionName varchar (150)  = null ,

	@PermissionUrl varchar (150)  = null ,

	@Status int   = null ,

	@MenuId varchar (40)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [PermissionID]
	, [PermissionName]
	, [PermissionURL]
	, [Status]
	, [MenuID]
    FROM
	[dbo].[Permission]
    WHERE 
	 ([PermissionID] = @PermissionId OR @PermissionId IS NULL)
	AND ([PermissionName] = @PermissionName OR @PermissionName IS NULL)
	AND ([PermissionURL] = @PermissionUrl OR @PermissionUrl IS NULL)
	AND ([Status] = @Status OR @Status IS NULL)
	AND ([MenuID] = @MenuId OR @MenuId IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [PermissionID]
	, [PermissionName]
	, [PermissionURL]
	, [Status]
	, [MenuID]
    FROM
	[dbo].[Permission]
    WHERE 
	 ([PermissionID] = @PermissionId AND @PermissionId is not null)
	OR ([PermissionName] = @PermissionName AND @PermissionName is not null)
	OR ([PermissionURL] = @PermissionUrl AND @PermissionUrl is not null)
	OR ([Status] = @Status AND @Status is not null)
	OR ([MenuID] = @MenuId AND @MenuId is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.RolePermission_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.RolePermission_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.RolePermission_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the RolePermission table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.RolePermission_Get_List

AS


				
				SELECT
					[PermissionID],
					[RoleID]
				FROM
					[dbo].[RolePermission]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.RolePermission_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.RolePermission_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.RolePermission_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the RolePermission table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.RolePermission_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [PermissionID] varchar(40) COLLATE database_default , [RoleID] varchar(20) COLLATE database_default  
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([PermissionID], [RoleID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [PermissionID], [RoleID]'
				SET @SQL = @SQL + ' FROM [dbo].[RolePermission]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[PermissionID], O.[RoleID]
				FROM
				    [dbo].[RolePermission] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[PermissionID] = PageIndex.[PermissionID]
					AND O.[RoleID] = PageIndex.[RoleID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[RolePermission]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.RolePermission_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.RolePermission_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.RolePermission_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the RolePermission table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.RolePermission_Insert
(

	@PermissionId varchar (40)  ,

	@RoleId varchar (20)  
)
AS


				
				INSERT INTO [dbo].[RolePermission]
					(
					[PermissionID]
					,[RoleID]
					)
				VALUES
					(
					@PermissionId
					,@RoleId
					)
				
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.RolePermission_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.RolePermission_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.RolePermission_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the RolePermission table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.RolePermission_Update
(

	@PermissionId varchar (40)  ,

	@OriginalPermissionId varchar (40)  ,

	@RoleId varchar (20)  ,

	@OriginalRoleId varchar (20)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[RolePermission]
				SET
					[PermissionID] = @PermissionId
					,[RoleID] = @RoleId
				WHERE
[PermissionID] = @OriginalPermissionId 
AND [RoleID] = @OriginalRoleId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.RolePermission_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.RolePermission_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.RolePermission_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the RolePermission table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.RolePermission_Delete
(

	@PermissionId varchar (40)  ,

	@RoleId varchar (20)  
)
AS


				DELETE FROM [dbo].[RolePermission] WITH (ROWLOCK) 
				WHERE
					[PermissionID] = @PermissionId
					AND [RoleID] = @RoleId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.RolePermission_GetByPermissionIdRoleId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.RolePermission_GetByPermissionIdRoleId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.RolePermission_GetByPermissionIdRoleId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the RolePermission table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.RolePermission_GetByPermissionIdRoleId
(

	@PermissionId varchar (40)  ,

	@RoleId varchar (20)  
)
AS


				SELECT
					[PermissionID],
					[RoleID]
				FROM
					[dbo].[RolePermission]
				WHERE
					[PermissionID] = @PermissionId
					AND [RoleID] = @RoleId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.RolePermission_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.RolePermission_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.RolePermission_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the RolePermission table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.RolePermission_Find
(

	@SearchUsingOR bit   = null ,

	@PermissionId varchar (40)  = null ,

	@RoleId varchar (20)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [PermissionID]
	, [RoleID]
    FROM
	[dbo].[RolePermission]
    WHERE 
	 ([PermissionID] = @PermissionId OR @PermissionId IS NULL)
	AND ([RoleID] = @RoleId OR @RoleId IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [PermissionID]
	, [RoleID]
    FROM
	[dbo].[RolePermission]
    WHERE 
	 ([PermissionID] = @PermissionId AND @PermissionId is not null)
	OR ([RoleID] = @RoleId AND @RoleId is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Roles_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Roles_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Roles_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the Roles table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Roles_Get_List

AS


				
				SELECT
					[RoleID],
					[RoleName],
					[Description],
					[CreateTime],
					[CreateUserID],
					[Status]
				FROM
					[dbo].[Roles]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Roles_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Roles_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Roles_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the Roles table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Roles_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [RoleID] varchar(20) COLLATE database_default  
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([RoleID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [RoleID]'
				SET @SQL = @SQL + ' FROM [dbo].[Roles]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[RoleID], O.[RoleName], O.[Description], O.[CreateTime], O.[CreateUserID], O.[Status]
				FROM
				    [dbo].[Roles] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[RoleID] = PageIndex.[RoleID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[Roles]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Roles_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Roles_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Roles_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the Roles table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Roles_Insert
(

	@RoleId varchar (20)  ,

	@RoleName varchar (150)  ,

	@Description varchar (500)  ,

	@CreateTime datetime   ,

	@CreateUserId varchar (20)  ,

	@Status int   
)
AS


				
				INSERT INTO [dbo].[Roles]
					(
					[RoleID]
					,[RoleName]
					,[Description]
					,[CreateTime]
					,[CreateUserID]
					,[Status]
					)
				VALUES
					(
					@RoleId
					,@RoleName
					,@Description
					,@CreateTime
					,@CreateUserId
					,@Status
					)
				
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Roles_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Roles_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Roles_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the Roles table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Roles_Update
(

	@RoleId varchar (20)  ,

	@OriginalRoleId varchar (20)  ,

	@RoleName varchar (150)  ,

	@Description varchar (500)  ,

	@CreateTime datetime   ,

	@CreateUserId varchar (20)  ,

	@Status int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[Roles]
				SET
					[RoleID] = @RoleId
					,[RoleName] = @RoleName
					,[Description] = @Description
					,[CreateTime] = @CreateTime
					,[CreateUserID] = @CreateUserId
					,[Status] = @Status
				WHERE
[RoleID] = @OriginalRoleId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Roles_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Roles_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Roles_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the Roles table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Roles_Delete
(

	@RoleId varchar (20)  
)
AS


				DELETE FROM [dbo].[Roles] WITH (ROWLOCK) 
				WHERE
					[RoleID] = @RoleId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Roles_GetByRoleId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Roles_GetByRoleId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Roles_GetByRoleId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the Roles table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Roles_GetByRoleId
(

	@RoleId varchar (20)  
)
AS


				SELECT
					[RoleID],
					[RoleName],
					[Description],
					[CreateTime],
					[CreateUserID],
					[Status]
				FROM
					[dbo].[Roles]
				WHERE
					[RoleID] = @RoleId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Roles_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Roles_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Roles_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the Roles table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Roles_Find
(

	@SearchUsingOR bit   = null ,

	@RoleId varchar (20)  = null ,

	@RoleName varchar (150)  = null ,

	@Description varchar (500)  = null ,

	@CreateTime datetime   = null ,

	@CreateUserId varchar (20)  = null ,

	@Status int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [RoleID]
	, [RoleName]
	, [Description]
	, [CreateTime]
	, [CreateUserID]
	, [Status]
    FROM
	[dbo].[Roles]
    WHERE 
	 ([RoleID] = @RoleId OR @RoleId IS NULL)
	AND ([RoleName] = @RoleName OR @RoleName IS NULL)
	AND ([Description] = @Description OR @Description IS NULL)
	AND ([CreateTime] = @CreateTime OR @CreateTime IS NULL)
	AND ([CreateUserID] = @CreateUserId OR @CreateUserId IS NULL)
	AND ([Status] = @Status OR @Status IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [RoleID]
	, [RoleName]
	, [Description]
	, [CreateTime]
	, [CreateUserID]
	, [Status]
    FROM
	[dbo].[Roles]
    WHERE 
	 ([RoleID] = @RoleId AND @RoleId is not null)
	OR ([RoleName] = @RoleName AND @RoleName is not null)
	OR ([Description] = @Description AND @Description is not null)
	OR ([CreateTime] = @CreateTime AND @CreateTime is not null)
	OR ([CreateUserID] = @CreateUserId AND @CreateUserId is not null)
	OR ([Status] = @Status AND @Status is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.StudentCourseRelation_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.StudentCourseRelation_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.StudentCourseRelation_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the StudentCourseRelation table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.StudentCourseRelation_Get_List

AS


				
				SELECT
					[AutoID],
					[StudentID],
					[degreeCourseID],
					[Credentials],
					[Updatetime],
					[UpdateUserID],
					[CredentialsStyle],
					[AttachmentFileStyle],
					[AttachmentFilePath],
					[courseID],
					[UserID]
				FROM
					[dbo].[StudentCourseRelation]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.StudentCourseRelation_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.StudentCourseRelation_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.StudentCourseRelation_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the StudentCourseRelation table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.StudentCourseRelation_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [AutoID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([AutoID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [AutoID]'
				SET @SQL = @SQL + ' FROM [dbo].[StudentCourseRelation]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[AutoID], O.[StudentID], O.[degreeCourseID], O.[Credentials], O.[Updatetime], O.[UpdateUserID], O.[CredentialsStyle], O.[AttachmentFileStyle], O.[AttachmentFilePath], O.[courseID], O.[UserID]
				FROM
				    [dbo].[StudentCourseRelation] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[AutoID] = PageIndex.[AutoID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[StudentCourseRelation]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.StudentCourseRelation_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.StudentCourseRelation_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.StudentCourseRelation_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the StudentCourseRelation table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.StudentCourseRelation_Insert
(

	@AutoId int    OUTPUT,

	@StudentId int   ,

	@DegreeCourseId int   ,

	@Credentials image   ,

	@Updatetime datetime   ,

	@UpdateUserId varchar (20)  ,

	@CredentialsStyle int   ,

	@AttachmentFileStyle varchar (10)  ,

	@AttachmentFilePath varchar (200)  ,

	@CourseId varchar (20)  ,

	@UserId varchar (20)  
)
AS


				
				INSERT INTO [dbo].[StudentCourseRelation]
					(
					[StudentID]
					,[degreeCourseID]
					,[Credentials]
					,[Updatetime]
					,[UpdateUserID]
					,[CredentialsStyle]
					,[AttachmentFileStyle]
					,[AttachmentFilePath]
					,[courseID]
					,[UserID]
					)
				VALUES
					(
					@StudentId
					,@DegreeCourseId
					,@Credentials
					,@Updatetime
					,@UpdateUserId
					,@CredentialsStyle
					,@AttachmentFileStyle
					,@AttachmentFilePath
					,@CourseId
					,@UserId
					)
				
				-- Get the identity value
				SET @AutoId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.StudentCourseRelation_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.StudentCourseRelation_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.StudentCourseRelation_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the StudentCourseRelation table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.StudentCourseRelation_Update
(

	@AutoId int   ,

	@StudentId int   ,

	@DegreeCourseId int   ,

	@Credentials image   ,

	@Updatetime datetime   ,

	@UpdateUserId varchar (20)  ,

	@CredentialsStyle int   ,

	@AttachmentFileStyle varchar (10)  ,

	@AttachmentFilePath varchar (200)  ,

	@CourseId varchar (20)  ,

	@UserId varchar (20)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[StudentCourseRelation]
				SET
					[StudentID] = @StudentId
					,[degreeCourseID] = @DegreeCourseId
					,[Credentials] = @Credentials
					,[Updatetime] = @Updatetime
					,[UpdateUserID] = @UpdateUserId
					,[CredentialsStyle] = @CredentialsStyle
					,[AttachmentFileStyle] = @AttachmentFileStyle
					,[AttachmentFilePath] = @AttachmentFilePath
					,[courseID] = @CourseId
					,[UserID] = @UserId
				WHERE
[AutoID] = @AutoId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.StudentCourseRelation_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.StudentCourseRelation_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.StudentCourseRelation_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the StudentCourseRelation table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.StudentCourseRelation_Delete
(

	@AutoId int   
)
AS


				DELETE FROM [dbo].[StudentCourseRelation] WITH (ROWLOCK) 
				WHERE
					[AutoID] = @AutoId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.StudentCourseRelation_GetByAutoId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.StudentCourseRelation_GetByAutoId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.StudentCourseRelation_GetByAutoId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the StudentCourseRelation table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.StudentCourseRelation_GetByAutoId
(

	@AutoId int   
)
AS


				SELECT
					[AutoID],
					[StudentID],
					[degreeCourseID],
					[Credentials],
					[Updatetime],
					[UpdateUserID],
					[CredentialsStyle],
					[AttachmentFileStyle],
					[AttachmentFilePath],
					[courseID],
					[UserID]
				FROM
					[dbo].[StudentCourseRelation]
				WHERE
					[AutoID] = @AutoId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.StudentCourseRelation_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.StudentCourseRelation_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.StudentCourseRelation_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the StudentCourseRelation table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.StudentCourseRelation_Find
(

	@SearchUsingOR bit   = null ,

	@AutoId int   = null ,

	@StudentId int   = null ,

	@DegreeCourseId int   = null ,

	@Credentials image   = null ,

	@Updatetime datetime   = null ,

	@UpdateUserId varchar (20)  = null ,

	@CredentialsStyle int   = null ,

	@AttachmentFileStyle varchar (10)  = null ,

	@AttachmentFilePath varchar (200)  = null ,

	@CourseId varchar (20)  = null ,

	@UserId varchar (20)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [AutoID]
	, [StudentID]
	, [degreeCourseID]
	, [Credentials]
	, [Updatetime]
	, [UpdateUserID]
	, [CredentialsStyle]
	, [AttachmentFileStyle]
	, [AttachmentFilePath]
	, [courseID]
	, [UserID]
    FROM
	[dbo].[StudentCourseRelation]
    WHERE 
	 ([AutoID] = @AutoId OR @AutoId IS NULL)
	AND ([StudentID] = @StudentId OR @StudentId IS NULL)
	AND ([degreeCourseID] = @DegreeCourseId OR @DegreeCourseId IS NULL)
	AND ([Updatetime] = @Updatetime OR @Updatetime IS NULL)
	AND ([UpdateUserID] = @UpdateUserId OR @UpdateUserId IS NULL)
	AND ([CredentialsStyle] = @CredentialsStyle OR @CredentialsStyle IS NULL)
	AND ([AttachmentFileStyle] = @AttachmentFileStyle OR @AttachmentFileStyle IS NULL)
	AND ([AttachmentFilePath] = @AttachmentFilePath OR @AttachmentFilePath IS NULL)
	AND ([courseID] = @CourseId OR @CourseId IS NULL)
	AND ([UserID] = @UserId OR @UserId IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [AutoID]
	, [StudentID]
	, [degreeCourseID]
	, [Credentials]
	, [Updatetime]
	, [UpdateUserID]
	, [CredentialsStyle]
	, [AttachmentFileStyle]
	, [AttachmentFilePath]
	, [courseID]
	, [UserID]
    FROM
	[dbo].[StudentCourseRelation]
    WHERE 
	 ([AutoID] = @AutoId AND @AutoId is not null)
	OR ([StudentID] = @StudentId AND @StudentId is not null)
	OR ([degreeCourseID] = @DegreeCourseId AND @DegreeCourseId is not null)
	OR ([Updatetime] = @Updatetime AND @Updatetime is not null)
	OR ([UpdateUserID] = @UpdateUserId AND @UpdateUserId is not null)
	OR ([CredentialsStyle] = @CredentialsStyle AND @CredentialsStyle is not null)
	OR ([AttachmentFileStyle] = @AttachmentFileStyle AND @AttachmentFileStyle is not null)
	OR ([AttachmentFilePath] = @AttachmentFilePath AND @AttachmentFilePath is not null)
	OR ([courseID] = @CourseId AND @CourseId is not null)
	OR ([UserID] = @UserId AND @UserId is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserRole_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserRole_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserRole_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the UserRole table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserRole_Get_List

AS


				
				SELECT
					[RoleID],
					[UserID]
				FROM
					[dbo].[UserRole]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserRole_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserRole_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserRole_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the UserRole table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserRole_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [RoleID] varchar(20) COLLATE database_default , [UserID] varchar(20) COLLATE database_default  
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([RoleID], [UserID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [RoleID], [UserID]'
				SET @SQL = @SQL + ' FROM [dbo].[UserRole]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[RoleID], O.[UserID]
				FROM
				    [dbo].[UserRole] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[RoleID] = PageIndex.[RoleID]
					AND O.[UserID] = PageIndex.[UserID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[UserRole]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserRole_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserRole_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserRole_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the UserRole table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserRole_Insert
(

	@RoleId varchar (20)  ,

	@UserId varchar (20)  
)
AS


				
				INSERT INTO [dbo].[UserRole]
					(
					[RoleID]
					,[UserID]
					)
				VALUES
					(
					@RoleId
					,@UserId
					)
				
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserRole_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserRole_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserRole_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the UserRole table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserRole_Update
(

	@RoleId varchar (20)  ,

	@OriginalRoleId varchar (20)  ,

	@UserId varchar (20)  ,

	@OriginalUserId varchar (20)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[UserRole]
				SET
					[RoleID] = @RoleId
					,[UserID] = @UserId
				WHERE
[RoleID] = @OriginalRoleId 
AND [UserID] = @OriginalUserId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserRole_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserRole_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserRole_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the UserRole table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserRole_Delete
(

	@RoleId varchar (20)  ,

	@UserId varchar (20)  
)
AS


				DELETE FROM [dbo].[UserRole] WITH (ROWLOCK) 
				WHERE
					[RoleID] = @RoleId
					AND [UserID] = @UserId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserRole_GetByRoleIdUserId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserRole_GetByRoleIdUserId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserRole_GetByRoleIdUserId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the UserRole table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserRole_GetByRoleIdUserId
(

	@RoleId varchar (20)  ,

	@UserId varchar (20)  
)
AS


				SELECT
					[RoleID],
					[UserID]
				FROM
					[dbo].[UserRole]
				WHERE
					[RoleID] = @RoleId
					AND [UserID] = @UserId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.UserRole_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.UserRole_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.UserRole_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the UserRole table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.UserRole_Find
(

	@SearchUsingOR bit   = null ,

	@RoleId varchar (20)  = null ,

	@UserId varchar (20)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [RoleID]
	, [UserID]
    FROM
	[dbo].[UserRole]
    WHERE 
	 ([RoleID] = @RoleId OR @RoleId IS NULL)
	AND ([UserID] = @UserId OR @UserId IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [RoleID]
	, [UserID]
    FROM
	[dbo].[UserRole]
    WHERE 
	 ([RoleID] = @RoleId AND @RoleId is not null)
	OR ([UserID] = @UserId AND @UserId is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_article_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_article_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_article_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VU_article table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_article_Get_List

AS


				
				SELECT
					[id],
					[classid],
					[biaoti],
					[lianjie],
					[neirong],
					[today],
					[sorts],
					[closed]
				FROM
					[dbo].[VU_article]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_article_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_article_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_article_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VU_article table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_article_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [id]'
				SET @SQL = @SQL + ' FROM [dbo].[VU_article]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[id], O.[classid], O.[biaoti], O.[lianjie], O.[neirong], O.[today], O.[sorts], O.[closed]
				FROM
				    [dbo].[VU_article] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[id] = PageIndex.[id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[VU_article]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_article_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_article_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_article_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the VU_article table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_article_Insert
(

	@Id int    OUTPUT,

	@Classid nchar (10)  ,

	@Biaoti nvarchar (200)  ,

	@Lianjie nvarchar (500)  ,

	@Neirong text   ,

	@Today datetime   ,

	@Sorts int   ,

	@Closed int   
)
AS


				
				INSERT INTO [dbo].[VU_article]
					(
					[classid]
					,[biaoti]
					,[lianjie]
					,[neirong]
					,[today]
					,[sorts]
					,[closed]
					)
				VALUES
					(
					@Classid
					,@Biaoti
					,@Lianjie
					,@Neirong
					,@Today
					,@Sorts
					,@Closed
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_article_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_article_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_article_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the VU_article table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_article_Update
(

	@Id int   ,

	@Classid nchar (10)  ,

	@Biaoti nvarchar (200)  ,

	@Lianjie nvarchar (500)  ,

	@Neirong text   ,

	@Today datetime   ,

	@Sorts int   ,

	@Closed int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[VU_article]
				SET
					[classid] = @Classid
					,[biaoti] = @Biaoti
					,[lianjie] = @Lianjie
					,[neirong] = @Neirong
					,[today] = @Today
					,[sorts] = @Sorts
					,[closed] = @Closed
				WHERE
[id] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_article_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_article_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_article_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the VU_article table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_article_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[VU_article] WITH (ROWLOCK) 
				WHERE
					[id] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_article_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_article_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_article_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the VU_article table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_article_GetById
(

	@Id int   
)
AS


				SELECT
					[id],
					[classid],
					[biaoti],
					[lianjie],
					[neirong],
					[today],
					[sorts],
					[closed]
				FROM
					[dbo].[VU_article]
				WHERE
					[id] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_article_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_article_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_article_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the VU_article table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_article_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@Classid nchar (10)  = null ,

	@Biaoti nvarchar (200)  = null ,

	@Lianjie nvarchar (500)  = null ,

	@Neirong text   = null ,

	@Today datetime   = null ,

	@Sorts int   = null ,

	@Closed int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [id]
	, [classid]
	, [biaoti]
	, [lianjie]
	, [neirong]
	, [today]
	, [sorts]
	, [closed]
    FROM
	[dbo].[VU_article]
    WHERE 
	 ([id] = @Id OR @Id IS NULL)
	AND ([classid] = @Classid OR @Classid IS NULL)
	AND ([biaoti] = @Biaoti OR @Biaoti IS NULL)
	AND ([lianjie] = @Lianjie OR @Lianjie IS NULL)
	AND ([today] = @Today OR @Today IS NULL)
	AND ([sorts] = @Sorts OR @Sorts IS NULL)
	AND ([closed] = @Closed OR @Closed IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [id]
	, [classid]
	, [biaoti]
	, [lianjie]
	, [neirong]
	, [today]
	, [sorts]
	, [closed]
    FROM
	[dbo].[VU_article]
    WHERE 
	 ([id] = @Id AND @Id is not null)
	OR ([classid] = @Classid AND @Classid is not null)
	OR ([biaoti] = @Biaoti AND @Biaoti is not null)
	OR ([lianjie] = @Lianjie AND @Lianjie is not null)
	OR ([today] = @Today AND @Today is not null)
	OR ([sorts] = @Sorts AND @Sorts is not null)
	OR ([closed] = @Closed AND @Closed is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_GroupList_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_GroupList_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_GroupList_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VU_GroupList table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_GroupList_Get_List

AS


				
				SELECT
					[ID],
					[Groupname],
					[ExeSSO],
					[Classid]
				FROM
					[dbo].[VU_GroupList]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_GroupList_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_GroupList_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_GroupList_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VU_GroupList table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_GroupList_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [ID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([ID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [ID]'
				SET @SQL = @SQL + ' FROM [dbo].[VU_GroupList]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[ID], O.[Groupname], O.[ExeSSO], O.[Classid]
				FROM
				    [dbo].[VU_GroupList] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[ID] = PageIndex.[ID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[VU_GroupList]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_GroupList_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_GroupList_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_GroupList_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the VU_GroupList table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_GroupList_Insert
(

	@Id int    OUTPUT,

	@Groupname char (100)  ,

	@ExeSso char (20)  ,

	@Classid char (10)  
)
AS


				
				INSERT INTO [dbo].[VU_GroupList]
					(
					[Groupname]
					,[ExeSSO]
					,[Classid]
					)
				VALUES
					(
					@Groupname
					,@ExeSso
					,@Classid
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_GroupList_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_GroupList_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_GroupList_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the VU_GroupList table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_GroupList_Update
(

	@Id int   ,

	@Groupname char (100)  ,

	@ExeSso char (20)  ,

	@Classid char (10)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[VU_GroupList]
				SET
					[Groupname] = @Groupname
					,[ExeSSO] = @ExeSso
					,[Classid] = @Classid
				WHERE
[ID] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_GroupList_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_GroupList_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_GroupList_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the VU_GroupList table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_GroupList_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[VU_GroupList] WITH (ROWLOCK) 
				WHERE
					[ID] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_GroupList_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_GroupList_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_GroupList_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the VU_GroupList table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_GroupList_GetById
(

	@Id int   
)
AS


				SELECT
					[ID],
					[Groupname],
					[ExeSSO],
					[Classid]
				FROM
					[dbo].[VU_GroupList]
				WHERE
					[ID] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_GroupList_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_GroupList_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_GroupList_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the VU_GroupList table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_GroupList_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@Groupname char (100)  = null ,

	@ExeSso char (20)  = null ,

	@Classid char (10)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [ID]
	, [Groupname]
	, [ExeSSO]
	, [Classid]
    FROM
	[dbo].[VU_GroupList]
    WHERE 
	 ([ID] = @Id OR @Id IS NULL)
	AND ([Groupname] = @Groupname OR @Groupname IS NULL)
	AND ([ExeSSO] = @ExeSso OR @ExeSso IS NULL)
	AND ([Classid] = @Classid OR @Classid IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [ID]
	, [Groupname]
	, [ExeSSO]
	, [Classid]
    FROM
	[dbo].[VU_GroupList]
    WHERE 
	 ([ID] = @Id AND @Id is not null)
	OR ([Groupname] = @Groupname AND @Groupname is not null)
	OR ([ExeSSO] = @ExeSso AND @ExeSso is not null)
	OR ([Classid] = @Classid AND @Classid is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_NEWPOST_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_NEWPOST_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_NEWPOST_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VU_NEWPOST table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_NEWPOST_Get_List

AS


				
				SELECT
					[ID],
					[OBJECT],
					[CONENT],
					[SPOKERMAN],
					[SSO],
					[POPULARITY],
					[REPLYNUM],
					[REPLYMAN],
					[time],
					[lasttime],
					[tupian],
					[fujian],
					[icon],
					[isgreat],
					[updatetime],
					[catogary],
					[istop],
					[isxingming],
					[iskm],
					[score],
					[closed],
					[isdescore],
					[opentime],
					[closedtime],
					[replytimes],
					[owner],
					[modality],
					[groupid],
					[isopen],
					[issue],
					[askkm],
					[expert],
					[classid]
				FROM
					[dbo].[VU_NEWPOST]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_NEWPOST_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_NEWPOST_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_NEWPOST_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VU_NEWPOST table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_NEWPOST_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [ID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([ID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [ID]'
				SET @SQL = @SQL + ' FROM [dbo].[VU_NEWPOST]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[ID], O.[OBJECT], O.[CONENT], O.[SPOKERMAN], O.[SSO], O.[POPULARITY], O.[REPLYNUM], O.[REPLYMAN], O.[time], O.[lasttime], O.[tupian], O.[fujian], O.[icon], O.[isgreat], O.[updatetime], O.[catogary], O.[istop], O.[isxingming], O.[iskm], O.[score], O.[closed], O.[isdescore], O.[opentime], O.[closedtime], O.[replytimes], O.[owner], O.[modality], O.[groupid], O.[isopen], O.[issue], O.[askkm], O.[expert], O.[classid]
				FROM
				    [dbo].[VU_NEWPOST] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[ID] = PageIndex.[ID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[VU_NEWPOST]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_NEWPOST_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_NEWPOST_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_NEWPOST_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the VU_NEWPOST table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_NEWPOST_Insert
(

	@Id int    OUTPUT,

	@SafeNameObject nvarchar (50)  ,

	@Conent ntext   ,

	@Spokerman nvarchar (50)  ,

	@Sso nvarchar (50)  ,

	@Popularity int   ,

	@Replynum int   ,

	@Replyman nvarchar (50)  ,

	@Time smalldatetime   ,

	@Lasttime smalldatetime   ,

	@Tupian nvarchar (50)  ,

	@Fujian nvarchar (50)  ,

	@Icon nvarchar (50)  ,

	@Isgreat int   ,

	@Updatetime smalldatetime   ,

	@Catogary nvarchar (50)  ,

	@Istop int   ,

	@Isxingming int   ,

	@Iskm int   ,

	@Score numeric (18, 0)  ,

	@Closed int   ,

	@Isdescore int   ,

	@Opentime smalldatetime   ,

	@Closedtime smalldatetime   ,

	@Replytimes int   ,

	@Owner nvarchar (50)  ,

	@Modality nvarchar (50)  ,

	@Groupid int   ,

	@Isopen int   ,

	@Issue int   ,

	@Askkm int   ,

	@Expert nchar (10)  ,

	@Classid char (10)  
)
AS


				
				INSERT INTO [dbo].[VU_NEWPOST]
					(
					[OBJECT]
					,[CONENT]
					,[SPOKERMAN]
					,[SSO]
					,[POPULARITY]
					,[REPLYNUM]
					,[REPLYMAN]
					,[time]
					,[lasttime]
					,[tupian]
					,[fujian]
					,[icon]
					,[isgreat]
					,[updatetime]
					,[catogary]
					,[istop]
					,[isxingming]
					,[iskm]
					,[score]
					,[closed]
					,[isdescore]
					,[opentime]
					,[closedtime]
					,[replytimes]
					,[owner]
					,[modality]
					,[groupid]
					,[isopen]
					,[issue]
					,[askkm]
					,[expert]
					,[classid]
					)
				VALUES
					(
					@SafeNameObject
					,@Conent
					,@Spokerman
					,@Sso
					,@Popularity
					,@Replynum
					,@Replyman
					,@Time
					,@Lasttime
					,@Tupian
					,@Fujian
					,@Icon
					,@Isgreat
					,@Updatetime
					,@Catogary
					,@Istop
					,@Isxingming
					,@Iskm
					,@Score
					,@Closed
					,@Isdescore
					,@Opentime
					,@Closedtime
					,@Replytimes
					,@Owner
					,@Modality
					,@Groupid
					,@Isopen
					,@Issue
					,@Askkm
					,@Expert
					,@Classid
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_NEWPOST_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_NEWPOST_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_NEWPOST_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the VU_NEWPOST table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_NEWPOST_Update
(

	@Id int   ,

	@SafeNameObject nvarchar (50)  ,

	@Conent ntext   ,

	@Spokerman nvarchar (50)  ,

	@Sso nvarchar (50)  ,

	@Popularity int   ,

	@Replynum int   ,

	@Replyman nvarchar (50)  ,

	@Time smalldatetime   ,

	@Lasttime smalldatetime   ,

	@Tupian nvarchar (50)  ,

	@Fujian nvarchar (50)  ,

	@Icon nvarchar (50)  ,

	@Isgreat int   ,

	@Updatetime smalldatetime   ,

	@Catogary nvarchar (50)  ,

	@Istop int   ,

	@Isxingming int   ,

	@Iskm int   ,

	@Score numeric (18, 0)  ,

	@Closed int   ,

	@Isdescore int   ,

	@Opentime smalldatetime   ,

	@Closedtime smalldatetime   ,

	@Replytimes int   ,

	@Owner nvarchar (50)  ,

	@Modality nvarchar (50)  ,

	@Groupid int   ,

	@Isopen int   ,

	@Issue int   ,

	@Askkm int   ,

	@Expert nchar (10)  ,

	@Classid char (10)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[VU_NEWPOST]
				SET
					[OBJECT] = @SafeNameObject
					,[CONENT] = @Conent
					,[SPOKERMAN] = @Spokerman
					,[SSO] = @Sso
					,[POPULARITY] = @Popularity
					,[REPLYNUM] = @Replynum
					,[REPLYMAN] = @Replyman
					,[time] = @Time
					,[lasttime] = @Lasttime
					,[tupian] = @Tupian
					,[fujian] = @Fujian
					,[icon] = @Icon
					,[isgreat] = @Isgreat
					,[updatetime] = @Updatetime
					,[catogary] = @Catogary
					,[istop] = @Istop
					,[isxingming] = @Isxingming
					,[iskm] = @Iskm
					,[score] = @Score
					,[closed] = @Closed
					,[isdescore] = @Isdescore
					,[opentime] = @Opentime
					,[closedtime] = @Closedtime
					,[replytimes] = @Replytimes
					,[owner] = @Owner
					,[modality] = @Modality
					,[groupid] = @Groupid
					,[isopen] = @Isopen
					,[issue] = @Issue
					,[askkm] = @Askkm
					,[expert] = @Expert
					,[classid] = @Classid
				WHERE
[ID] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_NEWPOST_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_NEWPOST_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_NEWPOST_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the VU_NEWPOST table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_NEWPOST_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[VU_NEWPOST] WITH (ROWLOCK) 
				WHERE
					[ID] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_NEWPOST_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_NEWPOST_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_NEWPOST_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the VU_NEWPOST table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_NEWPOST_GetById
(

	@Id int   
)
AS


				SELECT
					[ID],
					[OBJECT],
					[CONENT],
					[SPOKERMAN],
					[SSO],
					[POPULARITY],
					[REPLYNUM],
					[REPLYMAN],
					[time],
					[lasttime],
					[tupian],
					[fujian],
					[icon],
					[isgreat],
					[updatetime],
					[catogary],
					[istop],
					[isxingming],
					[iskm],
					[score],
					[closed],
					[isdescore],
					[opentime],
					[closedtime],
					[replytimes],
					[owner],
					[modality],
					[groupid],
					[isopen],
					[issue],
					[askkm],
					[expert],
					[classid]
				FROM
					[dbo].[VU_NEWPOST]
				WHERE
					[ID] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_NEWPOST_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_NEWPOST_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_NEWPOST_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the VU_NEWPOST table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_NEWPOST_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@SafeNameObject nvarchar (50)  = null ,

	@Conent ntext   = null ,

	@Spokerman nvarchar (50)  = null ,

	@Sso nvarchar (50)  = null ,

	@Popularity int   = null ,

	@Replynum int   = null ,

	@Replyman nvarchar (50)  = null ,

	@Time smalldatetime   = null ,

	@Lasttime smalldatetime   = null ,

	@Tupian nvarchar (50)  = null ,

	@Fujian nvarchar (50)  = null ,

	@Icon nvarchar (50)  = null ,

	@Isgreat int   = null ,

	@Updatetime smalldatetime   = null ,

	@Catogary nvarchar (50)  = null ,

	@Istop int   = null ,

	@Isxingming int   = null ,

	@Iskm int   = null ,

	@Score numeric (18, 0)  = null ,

	@Closed int   = null ,

	@Isdescore int   = null ,

	@Opentime smalldatetime   = null ,

	@Closedtime smalldatetime   = null ,

	@Replytimes int   = null ,

	@Owner nvarchar (50)  = null ,

	@Modality nvarchar (50)  = null ,

	@Groupid int   = null ,

	@Isopen int   = null ,

	@Issue int   = null ,

	@Askkm int   = null ,

	@Expert nchar (10)  = null ,

	@Classid char (10)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [ID]
	, [OBJECT]
	, [CONENT]
	, [SPOKERMAN]
	, [SSO]
	, [POPULARITY]
	, [REPLYNUM]
	, [REPLYMAN]
	, [time]
	, [lasttime]
	, [tupian]
	, [fujian]
	, [icon]
	, [isgreat]
	, [updatetime]
	, [catogary]
	, [istop]
	, [isxingming]
	, [iskm]
	, [score]
	, [closed]
	, [isdescore]
	, [opentime]
	, [closedtime]
	, [replytimes]
	, [owner]
	, [modality]
	, [groupid]
	, [isopen]
	, [issue]
	, [askkm]
	, [expert]
	, [classid]
    FROM
	[dbo].[VU_NEWPOST]
    WHERE 
	 ([ID] = @Id OR @Id IS NULL)
	AND ([OBJECT] = @SafeNameObject OR @SafeNameObject IS NULL)
	AND ([SPOKERMAN] = @Spokerman OR @Spokerman IS NULL)
	AND ([SSO] = @Sso OR @Sso IS NULL)
	AND ([POPULARITY] = @Popularity OR @Popularity IS NULL)
	AND ([REPLYNUM] = @Replynum OR @Replynum IS NULL)
	AND ([REPLYMAN] = @Replyman OR @Replyman IS NULL)
	AND ([time] = @Time OR @Time IS NULL)
	AND ([lasttime] = @Lasttime OR @Lasttime IS NULL)
	AND ([tupian] = @Tupian OR @Tupian IS NULL)
	AND ([fujian] = @Fujian OR @Fujian IS NULL)
	AND ([icon] = @Icon OR @Icon IS NULL)
	AND ([isgreat] = @Isgreat OR @Isgreat IS NULL)
	AND ([updatetime] = @Updatetime OR @Updatetime IS NULL)
	AND ([catogary] = @Catogary OR @Catogary IS NULL)
	AND ([istop] = @Istop OR @Istop IS NULL)
	AND ([isxingming] = @Isxingming OR @Isxingming IS NULL)
	AND ([iskm] = @Iskm OR @Iskm IS NULL)
	AND ([score] = @Score OR @Score IS NULL)
	AND ([closed] = @Closed OR @Closed IS NULL)
	AND ([isdescore] = @Isdescore OR @Isdescore IS NULL)
	AND ([opentime] = @Opentime OR @Opentime IS NULL)
	AND ([closedtime] = @Closedtime OR @Closedtime IS NULL)
	AND ([replytimes] = @Replytimes OR @Replytimes IS NULL)
	AND ([owner] = @Owner OR @Owner IS NULL)
	AND ([modality] = @Modality OR @Modality IS NULL)
	AND ([groupid] = @Groupid OR @Groupid IS NULL)
	AND ([isopen] = @Isopen OR @Isopen IS NULL)
	AND ([issue] = @Issue OR @Issue IS NULL)
	AND ([askkm] = @Askkm OR @Askkm IS NULL)
	AND ([expert] = @Expert OR @Expert IS NULL)
	AND ([classid] = @Classid OR @Classid IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [ID]
	, [OBJECT]
	, [CONENT]
	, [SPOKERMAN]
	, [SSO]
	, [POPULARITY]
	, [REPLYNUM]
	, [REPLYMAN]
	, [time]
	, [lasttime]
	, [tupian]
	, [fujian]
	, [icon]
	, [isgreat]
	, [updatetime]
	, [catogary]
	, [istop]
	, [isxingming]
	, [iskm]
	, [score]
	, [closed]
	, [isdescore]
	, [opentime]
	, [closedtime]
	, [replytimes]
	, [owner]
	, [modality]
	, [groupid]
	, [isopen]
	, [issue]
	, [askkm]
	, [expert]
	, [classid]
    FROM
	[dbo].[VU_NEWPOST]
    WHERE 
	 ([ID] = @Id AND @Id is not null)
	OR ([OBJECT] = @SafeNameObject AND @SafeNameObject is not null)
	OR ([SPOKERMAN] = @Spokerman AND @Spokerman is not null)
	OR ([SSO] = @Sso AND @Sso is not null)
	OR ([POPULARITY] = @Popularity AND @Popularity is not null)
	OR ([REPLYNUM] = @Replynum AND @Replynum is not null)
	OR ([REPLYMAN] = @Replyman AND @Replyman is not null)
	OR ([time] = @Time AND @Time is not null)
	OR ([lasttime] = @Lasttime AND @Lasttime is not null)
	OR ([tupian] = @Tupian AND @Tupian is not null)
	OR ([fujian] = @Fujian AND @Fujian is not null)
	OR ([icon] = @Icon AND @Icon is not null)
	OR ([isgreat] = @Isgreat AND @Isgreat is not null)
	OR ([updatetime] = @Updatetime AND @Updatetime is not null)
	OR ([catogary] = @Catogary AND @Catogary is not null)
	OR ([istop] = @Istop AND @Istop is not null)
	OR ([isxingming] = @Isxingming AND @Isxingming is not null)
	OR ([iskm] = @Iskm AND @Iskm is not null)
	OR ([score] = @Score AND @Score is not null)
	OR ([closed] = @Closed AND @Closed is not null)
	OR ([isdescore] = @Isdescore AND @Isdescore is not null)
	OR ([opentime] = @Opentime AND @Opentime is not null)
	OR ([closedtime] = @Closedtime AND @Closedtime is not null)
	OR ([replytimes] = @Replytimes AND @Replytimes is not null)
	OR ([owner] = @Owner AND @Owner is not null)
	OR ([modality] = @Modality AND @Modality is not null)
	OR ([groupid] = @Groupid AND @Groupid is not null)
	OR ([isopen] = @Isopen AND @Isopen is not null)
	OR ([issue] = @Issue AND @Issue is not null)
	OR ([askkm] = @Askkm AND @Askkm is not null)
	OR ([expert] = @Expert AND @Expert is not null)
	OR ([classid] = @Classid AND @Classid is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_renyuan_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_renyuan_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_renyuan_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VU_renyuan table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_renyuan_Get_List

AS


				
				SELECT
					[id],
					[xingming],
					[mima],
					[quanxian],
					[username],
					[email],
					[closed],
					[headpic],
					[nicename],
					[bbsscore],
					[tel],
					[title],
					[team],
					[team1],
					[ClassID]
				FROM
					[dbo].[VU_renyuan]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_renyuan_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_renyuan_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_renyuan_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VU_renyuan table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_renyuan_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [id]'
				SET @SQL = @SQL + ' FROM [dbo].[VU_renyuan]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[id], O.[xingming], O.[mima], O.[quanxian], O.[username], O.[email], O.[closed], O.[headpic], O.[nicename], O.[bbsscore], O.[tel], O.[title], O.[team], O.[team1], O.[ClassID]
				FROM
				    [dbo].[VU_renyuan] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[id] = PageIndex.[id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[VU_renyuan]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_renyuan_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_renyuan_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_renyuan_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the VU_renyuan table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_renyuan_Insert
(

	@Id int    OUTPUT,

	@Xingming nvarchar (50)  ,

	@Mima nvarchar (50)  ,

	@Quanxian nvarchar (50)  ,

	@Username nvarchar (50)  ,

	@Email nchar (50)  ,

	@Closed int   ,

	@Headpic nvarchar (50)  ,

	@Nicename nvarchar (50)  ,

	@Bbsscore numeric (18, 1)  ,

	@Tel nvarchar (50)  ,

	@Title nvarchar (50)  ,

	@Team varchar (50)  ,

	@Team1 varchar (50)  ,

	@ClassId char (10)  
)
AS


				
				INSERT INTO [dbo].[VU_renyuan]
					(
					[xingming]
					,[mima]
					,[quanxian]
					,[username]
					,[email]
					,[closed]
					,[headpic]
					,[nicename]
					,[bbsscore]
					,[tel]
					,[title]
					,[team]
					,[team1]
					,[ClassID]
					)
				VALUES
					(
					@Xingming
					,@Mima
					,@Quanxian
					,@Username
					,@Email
					,@Closed
					,@Headpic
					,@Nicename
					,@Bbsscore
					,@Tel
					,@Title
					,@Team
					,@Team1
					,@ClassId
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_renyuan_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_renyuan_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_renyuan_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the VU_renyuan table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_renyuan_Update
(

	@Id int   ,

	@Xingming nvarchar (50)  ,

	@Mima nvarchar (50)  ,

	@Quanxian nvarchar (50)  ,

	@Username nvarchar (50)  ,

	@Email nchar (50)  ,

	@Closed int   ,

	@Headpic nvarchar (50)  ,

	@Nicename nvarchar (50)  ,

	@Bbsscore numeric (18, 1)  ,

	@Tel nvarchar (50)  ,

	@Title nvarchar (50)  ,

	@Team varchar (50)  ,

	@Team1 varchar (50)  ,

	@ClassId char (10)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[VU_renyuan]
				SET
					[xingming] = @Xingming
					,[mima] = @Mima
					,[quanxian] = @Quanxian
					,[username] = @Username
					,[email] = @Email
					,[closed] = @Closed
					,[headpic] = @Headpic
					,[nicename] = @Nicename
					,[bbsscore] = @Bbsscore
					,[tel] = @Tel
					,[title] = @Title
					,[team] = @Team
					,[team1] = @Team1
					,[ClassID] = @ClassId
				WHERE
[id] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_renyuan_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_renyuan_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_renyuan_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the VU_renyuan table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_renyuan_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[VU_renyuan] WITH (ROWLOCK) 
				WHERE
					[id] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_renyuan_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_renyuan_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_renyuan_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the VU_renyuan table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_renyuan_GetById
(

	@Id int   
)
AS


				SELECT
					[id],
					[xingming],
					[mima],
					[quanxian],
					[username],
					[email],
					[closed],
					[headpic],
					[nicename],
					[bbsscore],
					[tel],
					[title],
					[team],
					[team1],
					[ClassID]
				FROM
					[dbo].[VU_renyuan]
				WHERE
					[id] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_renyuan_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_renyuan_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_renyuan_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the VU_renyuan table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_renyuan_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@Xingming nvarchar (50)  = null ,

	@Mima nvarchar (50)  = null ,

	@Quanxian nvarchar (50)  = null ,

	@Username nvarchar (50)  = null ,

	@Email nchar (50)  = null ,

	@Closed int   = null ,

	@Headpic nvarchar (50)  = null ,

	@Nicename nvarchar (50)  = null ,

	@Bbsscore numeric (18, 1)  = null ,

	@Tel nvarchar (50)  = null ,

	@Title nvarchar (50)  = null ,

	@Team varchar (50)  = null ,

	@Team1 varchar (50)  = null ,

	@ClassId char (10)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [id]
	, [xingming]
	, [mima]
	, [quanxian]
	, [username]
	, [email]
	, [closed]
	, [headpic]
	, [nicename]
	, [bbsscore]
	, [tel]
	, [title]
	, [team]
	, [team1]
	, [ClassID]
    FROM
	[dbo].[VU_renyuan]
    WHERE 
	 ([id] = @Id OR @Id IS NULL)
	AND ([xingming] = @Xingming OR @Xingming IS NULL)
	AND ([mima] = @Mima OR @Mima IS NULL)
	AND ([quanxian] = @Quanxian OR @Quanxian IS NULL)
	AND ([username] = @Username OR @Username IS NULL)
	AND ([email] = @Email OR @Email IS NULL)
	AND ([closed] = @Closed OR @Closed IS NULL)
	AND ([headpic] = @Headpic OR @Headpic IS NULL)
	AND ([nicename] = @Nicename OR @Nicename IS NULL)
	AND ([bbsscore] = @Bbsscore OR @Bbsscore IS NULL)
	AND ([tel] = @Tel OR @Tel IS NULL)
	AND ([title] = @Title OR @Title IS NULL)
	AND ([team] = @Team OR @Team IS NULL)
	AND ([team1] = @Team1 OR @Team1 IS NULL)
	AND ([ClassID] = @ClassId OR @ClassId IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [id]
	, [xingming]
	, [mima]
	, [quanxian]
	, [username]
	, [email]
	, [closed]
	, [headpic]
	, [nicename]
	, [bbsscore]
	, [tel]
	, [title]
	, [team]
	, [team1]
	, [ClassID]
    FROM
	[dbo].[VU_renyuan]
    WHERE 
	 ([id] = @Id AND @Id is not null)
	OR ([xingming] = @Xingming AND @Xingming is not null)
	OR ([mima] = @Mima AND @Mima is not null)
	OR ([quanxian] = @Quanxian AND @Quanxian is not null)
	OR ([username] = @Username AND @Username is not null)
	OR ([email] = @Email AND @Email is not null)
	OR ([closed] = @Closed AND @Closed is not null)
	OR ([headpic] = @Headpic AND @Headpic is not null)
	OR ([nicename] = @Nicename AND @Nicename is not null)
	OR ([bbsscore] = @Bbsscore AND @Bbsscore is not null)
	OR ([tel] = @Tel AND @Tel is not null)
	OR ([title] = @Title AND @Title is not null)
	OR ([team] = @Team AND @Team is not null)
	OR ([team1] = @Team1 AND @Team1 is not null)
	OR ([ClassID] = @ClassId AND @ClassId is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_REPLYPOST_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_REPLYPOST_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_REPLYPOST_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VU_REPLYPOST table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_REPLYPOST_Get_List

AS


				
				SELECT
					[ID],
					[CONENT],
					[REPLYMAN],
					[SSO],
					[REPLYTIME],
					[tupian],
					[fujian],
					[icon],
					[ids],
					[catogary],
					[isxingming],
					[score],
					[closed],
					[isdescore],
					[comment],
					[recommend],
					[classid],
					[isjake]
				FROM
					[dbo].[VU_REPLYPOST]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_REPLYPOST_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_REPLYPOST_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_REPLYPOST_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VU_REPLYPOST table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_REPLYPOST_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [ids] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([ids])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [ids]'
				SET @SQL = @SQL + ' FROM [dbo].[VU_REPLYPOST]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[ID], O.[CONENT], O.[REPLYMAN], O.[SSO], O.[REPLYTIME], O.[tupian], O.[fujian], O.[icon], O.[ids], O.[catogary], O.[isxingming], O.[score], O.[closed], O.[isdescore], O.[comment], O.[recommend], O.[classid], O.[isjake]
				FROM
				    [dbo].[VU_REPLYPOST] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[ids] = PageIndex.[ids]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[VU_REPLYPOST]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_REPLYPOST_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_REPLYPOST_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_REPLYPOST_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the VU_REPLYPOST table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_REPLYPOST_Insert
(

	@Id int   ,

	@Conent ntext   ,

	@Replyman nvarchar (50)  ,

	@Sso nvarchar (50)  ,

	@Replytime smalldatetime   ,

	@Tupian nvarchar (50)  ,

	@Fujian nvarchar (50)  ,

	@Icon nvarchar (50)  ,

	@Ids int    OUTPUT,

	@Catogary int   ,

	@Isxingming int   ,

	@Score numeric (18, 0)  ,

	@Closed int   ,

	@Isdescore int   ,

	@Comment text   ,

	@Recommend int   ,

	@Classid char (10)  ,

	@Isjake nchar (10)  
)
AS


				
				INSERT INTO [dbo].[VU_REPLYPOST]
					(
					[ID]
					,[CONENT]
					,[REPLYMAN]
					,[SSO]
					,[REPLYTIME]
					,[tupian]
					,[fujian]
					,[icon]
					,[catogary]
					,[isxingming]
					,[score]
					,[closed]
					,[isdescore]
					,[comment]
					,[recommend]
					,[classid]
					,[isjake]
					)
				VALUES
					(
					@Id
					,@Conent
					,@Replyman
					,@Sso
					,@Replytime
					,@Tupian
					,@Fujian
					,@Icon
					,@Catogary
					,@Isxingming
					,@Score
					,@Closed
					,@Isdescore
					,@Comment
					,@Recommend
					,@Classid
					,@Isjake
					)
				
				-- Get the identity value
				SET @Ids = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_REPLYPOST_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_REPLYPOST_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_REPLYPOST_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the VU_REPLYPOST table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_REPLYPOST_Update
(

	@Id int   ,

	@Conent ntext   ,

	@Replyman nvarchar (50)  ,

	@Sso nvarchar (50)  ,

	@Replytime smalldatetime   ,

	@Tupian nvarchar (50)  ,

	@Fujian nvarchar (50)  ,

	@Icon nvarchar (50)  ,

	@Ids int   ,

	@Catogary int   ,

	@Isxingming int   ,

	@Score numeric (18, 0)  ,

	@Closed int   ,

	@Isdescore int   ,

	@Comment text   ,

	@Recommend int   ,

	@Classid char (10)  ,

	@Isjake nchar (10)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[VU_REPLYPOST]
				SET
					[ID] = @Id
					,[CONENT] = @Conent
					,[REPLYMAN] = @Replyman
					,[SSO] = @Sso
					,[REPLYTIME] = @Replytime
					,[tupian] = @Tupian
					,[fujian] = @Fujian
					,[icon] = @Icon
					,[catogary] = @Catogary
					,[isxingming] = @Isxingming
					,[score] = @Score
					,[closed] = @Closed
					,[isdescore] = @Isdescore
					,[comment] = @Comment
					,[recommend] = @Recommend
					,[classid] = @Classid
					,[isjake] = @Isjake
				WHERE
[ids] = @Ids 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_REPLYPOST_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_REPLYPOST_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_REPLYPOST_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the VU_REPLYPOST table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_REPLYPOST_Delete
(

	@Ids int   
)
AS


				DELETE FROM [dbo].[VU_REPLYPOST] WITH (ROWLOCK) 
				WHERE
					[ids] = @Ids
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_REPLYPOST_GetByIds procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_REPLYPOST_GetByIds') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_REPLYPOST_GetByIds
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the VU_REPLYPOST table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_REPLYPOST_GetByIds
(

	@Ids int   
)
AS


				SELECT
					[ID],
					[CONENT],
					[REPLYMAN],
					[SSO],
					[REPLYTIME],
					[tupian],
					[fujian],
					[icon],
					[ids],
					[catogary],
					[isxingming],
					[score],
					[closed],
					[isdescore],
					[comment],
					[recommend],
					[classid],
					[isjake]
				FROM
					[dbo].[VU_REPLYPOST]
				WHERE
					[ids] = @Ids
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_REPLYPOST_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_REPLYPOST_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_REPLYPOST_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the VU_REPLYPOST table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_REPLYPOST_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@Conent ntext   = null ,

	@Replyman nvarchar (50)  = null ,

	@Sso nvarchar (50)  = null ,

	@Replytime smalldatetime   = null ,

	@Tupian nvarchar (50)  = null ,

	@Fujian nvarchar (50)  = null ,

	@Icon nvarchar (50)  = null ,

	@Ids int   = null ,

	@Catogary int   = null ,

	@Isxingming int   = null ,

	@Score numeric (18, 0)  = null ,

	@Closed int   = null ,

	@Isdescore int   = null ,

	@Comment text   = null ,

	@Recommend int   = null ,

	@Classid char (10)  = null ,

	@Isjake nchar (10)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [ID]
	, [CONENT]
	, [REPLYMAN]
	, [SSO]
	, [REPLYTIME]
	, [tupian]
	, [fujian]
	, [icon]
	, [ids]
	, [catogary]
	, [isxingming]
	, [score]
	, [closed]
	, [isdescore]
	, [comment]
	, [recommend]
	, [classid]
	, [isjake]
    FROM
	[dbo].[VU_REPLYPOST]
    WHERE 
	 ([ID] = @Id OR @Id IS NULL)
	AND ([REPLYMAN] = @Replyman OR @Replyman IS NULL)
	AND ([SSO] = @Sso OR @Sso IS NULL)
	AND ([REPLYTIME] = @Replytime OR @Replytime IS NULL)
	AND ([tupian] = @Tupian OR @Tupian IS NULL)
	AND ([fujian] = @Fujian OR @Fujian IS NULL)
	AND ([icon] = @Icon OR @Icon IS NULL)
	AND ([ids] = @Ids OR @Ids IS NULL)
	AND ([catogary] = @Catogary OR @Catogary IS NULL)
	AND ([isxingming] = @Isxingming OR @Isxingming IS NULL)
	AND ([score] = @Score OR @Score IS NULL)
	AND ([closed] = @Closed OR @Closed IS NULL)
	AND ([isdescore] = @Isdescore OR @Isdescore IS NULL)
	AND ([recommend] = @Recommend OR @Recommend IS NULL)
	AND ([classid] = @Classid OR @Classid IS NULL)
	AND ([isjake] = @Isjake OR @Isjake IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [ID]
	, [CONENT]
	, [REPLYMAN]
	, [SSO]
	, [REPLYTIME]
	, [tupian]
	, [fujian]
	, [icon]
	, [ids]
	, [catogary]
	, [isxingming]
	, [score]
	, [closed]
	, [isdescore]
	, [comment]
	, [recommend]
	, [classid]
	, [isjake]
    FROM
	[dbo].[VU_REPLYPOST]
    WHERE 
	 ([ID] = @Id AND @Id is not null)
	OR ([REPLYMAN] = @Replyman AND @Replyman is not null)
	OR ([SSO] = @Sso AND @Sso is not null)
	OR ([REPLYTIME] = @Replytime AND @Replytime is not null)
	OR ([tupian] = @Tupian AND @Tupian is not null)
	OR ([fujian] = @Fujian AND @Fujian is not null)
	OR ([icon] = @Icon AND @Icon is not null)
	OR ([ids] = @Ids AND @Ids is not null)
	OR ([catogary] = @Catogary AND @Catogary is not null)
	OR ([isxingming] = @Isxingming AND @Isxingming is not null)
	OR ([score] = @Score AND @Score is not null)
	OR ([closed] = @Closed AND @Closed is not null)
	OR ([isdescore] = @Isdescore AND @Isdescore is not null)
	OR ([recommend] = @Recommend AND @Recommend is not null)
	OR ([classid] = @Classid AND @Classid is not null)
	OR ([isjake] = @Isjake AND @Isjake is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_GroupItem_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_GroupItem_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_GroupItem_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VU_GroupItem table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_GroupItem_Get_List

AS


				
				SELECT
					[ID],
					[GroupID],
					[GroupMember]
				FROM
					[dbo].[VU_GroupItem]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_GroupItem_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_GroupItem_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_GroupItem_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VU_GroupItem table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_GroupItem_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [ID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([ID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [ID]'
				SET @SQL = @SQL + ' FROM [dbo].[VU_GroupItem]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[ID], O.[GroupID], O.[GroupMember]
				FROM
				    [dbo].[VU_GroupItem] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[ID] = PageIndex.[ID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[VU_GroupItem]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_GroupItem_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_GroupItem_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_GroupItem_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the VU_GroupItem table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_GroupItem_Insert
(

	@Id int    OUTPUT,

	@GroupId int   ,

	@GroupMember char (20)  
)
AS


				
				INSERT INTO [dbo].[VU_GroupItem]
					(
					[GroupID]
					,[GroupMember]
					)
				VALUES
					(
					@GroupId
					,@GroupMember
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_GroupItem_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_GroupItem_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_GroupItem_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the VU_GroupItem table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_GroupItem_Update
(

	@Id int   ,

	@GroupId int   ,

	@GroupMember char (20)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[VU_GroupItem]
				SET
					[GroupID] = @GroupId
					,[GroupMember] = @GroupMember
				WHERE
[ID] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_GroupItem_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_GroupItem_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_GroupItem_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the VU_GroupItem table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_GroupItem_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[VU_GroupItem] WITH (ROWLOCK) 
				WHERE
					[ID] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_GroupItem_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_GroupItem_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_GroupItem_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the VU_GroupItem table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_GroupItem_GetById
(

	@Id int   
)
AS


				SELECT
					[ID],
					[GroupID],
					[GroupMember]
				FROM
					[dbo].[VU_GroupItem]
				WHERE
					[ID] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_GroupItem_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_GroupItem_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_GroupItem_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the VU_GroupItem table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_GroupItem_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@GroupId int   = null ,

	@GroupMember char (20)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [ID]
	, [GroupID]
	, [GroupMember]
    FROM
	[dbo].[VU_GroupItem]
    WHERE 
	 ([ID] = @Id OR @Id IS NULL)
	AND ([GroupID] = @GroupId OR @GroupId IS NULL)
	AND ([GroupMember] = @GroupMember OR @GroupMember IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [ID]
	, [GroupID]
	, [GroupMember]
    FROM
	[dbo].[VU_GroupItem]
    WHERE 
	 ([ID] = @Id AND @Id is not null)
	OR ([GroupID] = @GroupId AND @GroupId is not null)
	OR ([GroupMember] = @GroupMember AND @GroupMember is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.vu_friendship_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.vu_friendship_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.vu_friendship_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the vu_friendship table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.vu_friendship_Get_List

AS


				
				SELECT
					[ID],
					[webname],
					[weburl],
					[classid],
					[orderlist],
					[pic]
				FROM
					[dbo].[vu_friendship]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.vu_friendship_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.vu_friendship_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.vu_friendship_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the vu_friendship table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.vu_friendship_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [ID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([ID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [ID]'
				SET @SQL = @SQL + ' FROM [dbo].[vu_friendship]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[ID], O.[webname], O.[weburl], O.[classid], O.[orderlist], O.[pic]
				FROM
				    [dbo].[vu_friendship] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[ID] = PageIndex.[ID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[vu_friendship]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.vu_friendship_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.vu_friendship_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.vu_friendship_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the vu_friendship table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.vu_friendship_Insert
(

	@Id int    OUTPUT,

	@Webname nchar (50)  ,

	@Weburl nchar (100)  ,

	@Classid nchar (10)  ,

	@Orderlist int   ,

	@Pic nchar (100)  
)
AS


				
				INSERT INTO [dbo].[vu_friendship]
					(
					[webname]
					,[weburl]
					,[classid]
					,[orderlist]
					,[pic]
					)
				VALUES
					(
					@Webname
					,@Weburl
					,@Classid
					,@Orderlist
					,@Pic
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.vu_friendship_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.vu_friendship_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.vu_friendship_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the vu_friendship table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.vu_friendship_Update
(

	@Id int   ,

	@Webname nchar (50)  ,

	@Weburl nchar (100)  ,

	@Classid nchar (10)  ,

	@Orderlist int   ,

	@Pic nchar (100)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[vu_friendship]
				SET
					[webname] = @Webname
					,[weburl] = @Weburl
					,[classid] = @Classid
					,[orderlist] = @Orderlist
					,[pic] = @Pic
				WHERE
[ID] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.vu_friendship_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.vu_friendship_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.vu_friendship_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the vu_friendship table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.vu_friendship_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[vu_friendship] WITH (ROWLOCK) 
				WHERE
					[ID] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.vu_friendship_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.vu_friendship_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.vu_friendship_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the vu_friendship table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.vu_friendship_GetById
(

	@Id int   
)
AS


				SELECT
					[ID],
					[webname],
					[weburl],
					[classid],
					[orderlist],
					[pic]
				FROM
					[dbo].[vu_friendship]
				WHERE
					[ID] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.vu_friendship_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.vu_friendship_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.vu_friendship_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the vu_friendship table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.vu_friendship_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@Webname nchar (50)  = null ,

	@Weburl nchar (100)  = null ,

	@Classid nchar (10)  = null ,

	@Orderlist int   = null ,

	@Pic nchar (100)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [ID]
	, [webname]
	, [weburl]
	, [classid]
	, [orderlist]
	, [pic]
    FROM
	[dbo].[vu_friendship]
    WHERE 
	 ([ID] = @Id OR @Id IS NULL)
	AND ([webname] = @Webname OR @Webname IS NULL)
	AND ([weburl] = @Weburl OR @Weburl IS NULL)
	AND ([classid] = @Classid OR @Classid IS NULL)
	AND ([orderlist] = @Orderlist OR @Orderlist IS NULL)
	AND ([pic] = @Pic OR @Pic IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [ID]
	, [webname]
	, [weburl]
	, [classid]
	, [orderlist]
	, [pic]
    FROM
	[dbo].[vu_friendship]
    WHERE 
	 ([ID] = @Id AND @Id is not null)
	OR ([webname] = @Webname AND @Webname is not null)
	OR ([weburl] = @Weburl AND @Weburl is not null)
	OR ([classid] = @Classid AND @Classid is not null)
	OR ([orderlist] = @Orderlist AND @Orderlist is not null)
	OR ([pic] = @Pic AND @Pic is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_catogary_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_catogary_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_catogary_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VU_catogary table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_catogary_Get_List

AS


				
				SELECT
					[id],
					[classid],
					[fuid],
					[name],
					[pic],
					[closed],
					[owner],
					[score],
					[reply_rights],
					[isask]
				FROM
					[dbo].[VU_catogary]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_catogary_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_catogary_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_catogary_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VU_catogary table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_catogary_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [id]'
				SET @SQL = @SQL + ' FROM [dbo].[VU_catogary]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[id], O.[classid], O.[fuid], O.[name], O.[pic], O.[closed], O.[owner], O.[score], O.[reply_rights], O.[isask]
				FROM
				    [dbo].[VU_catogary] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[id] = PageIndex.[id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[VU_catogary]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_catogary_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_catogary_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_catogary_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the VU_catogary table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_catogary_Insert
(

	@Id int    OUTPUT,

	@Classid nchar (10)  ,

	@Fuid int   ,

	@Name nvarchar (50)  ,

	@Pic nchar (100)  ,

	@Closed int   ,

	@Owner nvarchar (50)  ,

	@Score numeric (18, 0)  ,

	@ReplyRights int   ,

	@Isask int   
)
AS


				
				INSERT INTO [dbo].[VU_catogary]
					(
					[classid]
					,[fuid]
					,[name]
					,[pic]
					,[closed]
					,[owner]
					,[score]
					,[reply_rights]
					,[isask]
					)
				VALUES
					(
					@Classid
					,@Fuid
					,@Name
					,@Pic
					,@Closed
					,@Owner
					,@Score
					,@ReplyRights
					,@Isask
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_catogary_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_catogary_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_catogary_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the VU_catogary table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_catogary_Update
(

	@Id int   ,

	@Classid nchar (10)  ,

	@Fuid int   ,

	@Name nvarchar (50)  ,

	@Pic nchar (100)  ,

	@Closed int   ,

	@Owner nvarchar (50)  ,

	@Score numeric (18, 0)  ,

	@ReplyRights int   ,

	@Isask int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[VU_catogary]
				SET
					[classid] = @Classid
					,[fuid] = @Fuid
					,[name] = @Name
					,[pic] = @Pic
					,[closed] = @Closed
					,[owner] = @Owner
					,[score] = @Score
					,[reply_rights] = @ReplyRights
					,[isask] = @Isask
				WHERE
[id] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_catogary_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_catogary_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_catogary_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the VU_catogary table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_catogary_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[VU_catogary] WITH (ROWLOCK) 
				WHERE
					[id] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_catogary_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_catogary_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_catogary_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the VU_catogary table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_catogary_GetById
(

	@Id int   
)
AS


				SELECT
					[id],
					[classid],
					[fuid],
					[name],
					[pic],
					[closed],
					[owner],
					[score],
					[reply_rights],
					[isask]
				FROM
					[dbo].[VU_catogary]
				WHERE
					[id] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_catogary_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_catogary_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_catogary_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the VU_catogary table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_catogary_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@Classid nchar (10)  = null ,

	@Fuid int   = null ,

	@Name nvarchar (50)  = null ,

	@Pic nchar (100)  = null ,

	@Closed int   = null ,

	@Owner nvarchar (50)  = null ,

	@Score numeric (18, 0)  = null ,

	@ReplyRights int   = null ,

	@Isask int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [id]
	, [classid]
	, [fuid]
	, [name]
	, [pic]
	, [closed]
	, [owner]
	, [score]
	, [reply_rights]
	, [isask]
    FROM
	[dbo].[VU_catogary]
    WHERE 
	 ([id] = @Id OR @Id IS NULL)
	AND ([classid] = @Classid OR @Classid IS NULL)
	AND ([fuid] = @Fuid OR @Fuid IS NULL)
	AND ([name] = @Name OR @Name IS NULL)
	AND ([pic] = @Pic OR @Pic IS NULL)
	AND ([closed] = @Closed OR @Closed IS NULL)
	AND ([owner] = @Owner OR @Owner IS NULL)
	AND ([score] = @Score OR @Score IS NULL)
	AND ([reply_rights] = @ReplyRights OR @ReplyRights IS NULL)
	AND ([isask] = @Isask OR @Isask IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [id]
	, [classid]
	, [fuid]
	, [name]
	, [pic]
	, [closed]
	, [owner]
	, [score]
	, [reply_rights]
	, [isask]
    FROM
	[dbo].[VU_catogary]
    WHERE 
	 ([id] = @Id AND @Id is not null)
	OR ([classid] = @Classid AND @Classid is not null)
	OR ([fuid] = @Fuid AND @Fuid is not null)
	OR ([name] = @Name AND @Name is not null)
	OR ([pic] = @Pic AND @Pic is not null)
	OR ([closed] = @Closed AND @Closed is not null)
	OR ([owner] = @Owner AND @Owner is not null)
	OR ([score] = @Score AND @Score is not null)
	OR ([reply_rights] = @ReplyRights AND @ReplyRights is not null)
	OR ([isask] = @Isask AND @Isask is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_Catogary_Experts_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_Catogary_Experts_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_Catogary_Experts_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VU_Catogary_Experts table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_Catogary_Experts_Get_List

AS


				
				SELECT
					[ID],
					[CatogaryID],
					[Owner],
					[email],
					[area],
					[name],
					[Classid]
				FROM
					[dbo].[VU_Catogary_Experts]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_Catogary_Experts_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_Catogary_Experts_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_Catogary_Experts_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VU_Catogary_Experts table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_Catogary_Experts_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [ID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([ID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [ID]'
				SET @SQL = @SQL + ' FROM [dbo].[VU_Catogary_Experts]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[ID], O.[CatogaryID], O.[Owner], O.[email], O.[area], O.[name], O.[Classid]
				FROM
				    [dbo].[VU_Catogary_Experts] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[ID] = PageIndex.[ID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[VU_Catogary_Experts]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_Catogary_Experts_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_Catogary_Experts_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_Catogary_Experts_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the VU_Catogary_Experts table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_Catogary_Experts_Insert
(

	@Id int    OUTPUT,

	@CatogaryId int   ,

	@Owner char (10)  ,

	@Email nchar (50)  ,

	@Area nchar (50)  ,

	@Name nchar (20)  ,

	@Classid nchar (10)  
)
AS


				
				INSERT INTO [dbo].[VU_Catogary_Experts]
					(
					[CatogaryID]
					,[Owner]
					,[email]
					,[area]
					,[name]
					,[Classid]
					)
				VALUES
					(
					@CatogaryId
					,@Owner
					,@Email
					,@Area
					,@Name
					,@Classid
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_Catogary_Experts_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_Catogary_Experts_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_Catogary_Experts_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the VU_Catogary_Experts table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_Catogary_Experts_Update
(

	@Id int   ,

	@CatogaryId int   ,

	@Owner char (10)  ,

	@Email nchar (50)  ,

	@Area nchar (50)  ,

	@Name nchar (20)  ,

	@Classid nchar (10)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[VU_Catogary_Experts]
				SET
					[CatogaryID] = @CatogaryId
					,[Owner] = @Owner
					,[email] = @Email
					,[area] = @Area
					,[name] = @Name
					,[Classid] = @Classid
				WHERE
[ID] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_Catogary_Experts_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_Catogary_Experts_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_Catogary_Experts_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the VU_Catogary_Experts table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_Catogary_Experts_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[VU_Catogary_Experts] WITH (ROWLOCK) 
				WHERE
					[ID] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_Catogary_Experts_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_Catogary_Experts_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_Catogary_Experts_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the VU_Catogary_Experts table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_Catogary_Experts_GetById
(

	@Id int   
)
AS


				SELECT
					[ID],
					[CatogaryID],
					[Owner],
					[email],
					[area],
					[name],
					[Classid]
				FROM
					[dbo].[VU_Catogary_Experts]
				WHERE
					[ID] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_Catogary_Experts_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_Catogary_Experts_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_Catogary_Experts_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the VU_Catogary_Experts table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_Catogary_Experts_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@CatogaryId int   = null ,

	@Owner char (10)  = null ,

	@Email nchar (50)  = null ,

	@Area nchar (50)  = null ,

	@Name nchar (20)  = null ,

	@Classid nchar (10)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [ID]
	, [CatogaryID]
	, [Owner]
	, [email]
	, [area]
	, [name]
	, [Classid]
    FROM
	[dbo].[VU_Catogary_Experts]
    WHERE 
	 ([ID] = @Id OR @Id IS NULL)
	AND ([CatogaryID] = @CatogaryId OR @CatogaryId IS NULL)
	AND ([Owner] = @Owner OR @Owner IS NULL)
	AND ([email] = @Email OR @Email IS NULL)
	AND ([area] = @Area OR @Area IS NULL)
	AND ([name] = @Name OR @Name IS NULL)
	AND ([Classid] = @Classid OR @Classid IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [ID]
	, [CatogaryID]
	, [Owner]
	, [email]
	, [area]
	, [name]
	, [Classid]
    FROM
	[dbo].[VU_Catogary_Experts]
    WHERE 
	 ([ID] = @Id AND @Id is not null)
	OR ([CatogaryID] = @CatogaryId AND @CatogaryId is not null)
	OR ([Owner] = @Owner AND @Owner is not null)
	OR ([email] = @Email AND @Email is not null)
	OR ([area] = @Area AND @Area is not null)
	OR ([name] = @Name AND @Name is not null)
	OR ([Classid] = @Classid AND @Classid is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_Catogary_Manager_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_Catogary_Manager_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_Catogary_Manager_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VU_Catogary_Manager table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_Catogary_Manager_Get_List

AS


				
				SELECT
					[ID],
					[CatogaryID],
					[Owner]
				FROM
					[dbo].[VU_Catogary_Manager]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_Catogary_Manager_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_Catogary_Manager_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_Catogary_Manager_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VU_Catogary_Manager table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_Catogary_Manager_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [ID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([ID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [ID]'
				SET @SQL = @SQL + ' FROM [dbo].[VU_Catogary_Manager]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[ID], O.[CatogaryID], O.[Owner]
				FROM
				    [dbo].[VU_Catogary_Manager] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[ID] = PageIndex.[ID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[VU_Catogary_Manager]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_Catogary_Manager_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_Catogary_Manager_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_Catogary_Manager_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the VU_Catogary_Manager table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_Catogary_Manager_Insert
(

	@Id int    OUTPUT,

	@CatogaryId int   ,

	@Owner char (10)  
)
AS


				
				INSERT INTO [dbo].[VU_Catogary_Manager]
					(
					[CatogaryID]
					,[Owner]
					)
				VALUES
					(
					@CatogaryId
					,@Owner
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_Catogary_Manager_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_Catogary_Manager_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_Catogary_Manager_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the VU_Catogary_Manager table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_Catogary_Manager_Update
(

	@Id int   ,

	@CatogaryId int   ,

	@Owner char (10)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[VU_Catogary_Manager]
				SET
					[CatogaryID] = @CatogaryId
					,[Owner] = @Owner
				WHERE
[ID] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_Catogary_Manager_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_Catogary_Manager_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_Catogary_Manager_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the VU_Catogary_Manager table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_Catogary_Manager_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[VU_Catogary_Manager] WITH (ROWLOCK) 
				WHERE
					[ID] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_Catogary_Manager_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_Catogary_Manager_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_Catogary_Manager_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the VU_Catogary_Manager table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_Catogary_Manager_GetById
(

	@Id int   
)
AS


				SELECT
					[ID],
					[CatogaryID],
					[Owner]
				FROM
					[dbo].[VU_Catogary_Manager]
				WHERE
					[ID] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_Catogary_Manager_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_Catogary_Manager_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_Catogary_Manager_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the VU_Catogary_Manager table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_Catogary_Manager_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@CatogaryId int   = null ,

	@Owner char (10)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [ID]
	, [CatogaryID]
	, [Owner]
    FROM
	[dbo].[VU_Catogary_Manager]
    WHERE 
	 ([ID] = @Id OR @Id IS NULL)
	AND ([CatogaryID] = @CatogaryId OR @CatogaryId IS NULL)
	AND ([Owner] = @Owner OR @Owner IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [ID]
	, [CatogaryID]
	, [Owner]
    FROM
	[dbo].[VU_Catogary_Manager]
    WHERE 
	 ([ID] = @Id AND @Id is not null)
	OR ([CatogaryID] = @CatogaryId AND @CatogaryId is not null)
	OR ([Owner] = @Owner AND @Owner is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_ClassInfo_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_ClassInfo_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_ClassInfo_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VU_ClassInfo table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_ClassInfo_Get_List

AS


				
				SELECT
					[ID],
					[ClassID],
					[FuID],
					[ClassName],
					[CreatDate],
					[ClassOwner],
					[ClassDESC],
					[counter],
					[Closed]
				FROM
					[dbo].[VU_ClassInfo]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_ClassInfo_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_ClassInfo_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_ClassInfo_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VU_ClassInfo table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_ClassInfo_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [ID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([ID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [ID]'
				SET @SQL = @SQL + ' FROM [dbo].[VU_ClassInfo]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[ID], O.[ClassID], O.[FuID], O.[ClassName], O.[CreatDate], O.[ClassOwner], O.[ClassDESC], O.[counter], O.[Closed]
				FROM
				    [dbo].[VU_ClassInfo] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[ID] = PageIndex.[ID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[VU_ClassInfo]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_ClassInfo_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_ClassInfo_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_ClassInfo_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the VU_ClassInfo table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_ClassInfo_Insert
(

	@Id int    OUTPUT,

	@ClassId nchar (10)  ,

	@FuId int   ,

	@ClassName nvarchar (128)  ,

	@CreatDate datetime   ,

	@ClassOwner nchar (10)  ,

	@ClassDesc nvarchar (200)  ,

	@Counter int   ,

	@Closed int   
)
AS


				
				INSERT INTO [dbo].[VU_ClassInfo]
					(
					[ClassID]
					,[FuID]
					,[ClassName]
					,[CreatDate]
					,[ClassOwner]
					,[ClassDESC]
					,[counter]
					,[Closed]
					)
				VALUES
					(
					@ClassId
					,@FuId
					,@ClassName
					,@CreatDate
					,@ClassOwner
					,@ClassDesc
					,@Counter
					,@Closed
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_ClassInfo_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_ClassInfo_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_ClassInfo_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the VU_ClassInfo table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_ClassInfo_Update
(

	@Id int   ,

	@ClassId nchar (10)  ,

	@FuId int   ,

	@ClassName nvarchar (128)  ,

	@CreatDate datetime   ,

	@ClassOwner nchar (10)  ,

	@ClassDesc nvarchar (200)  ,

	@Counter int   ,

	@Closed int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[VU_ClassInfo]
				SET
					[ClassID] = @ClassId
					,[FuID] = @FuId
					,[ClassName] = @ClassName
					,[CreatDate] = @CreatDate
					,[ClassOwner] = @ClassOwner
					,[ClassDESC] = @ClassDesc
					,[counter] = @Counter
					,[Closed] = @Closed
				WHERE
[ID] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_ClassInfo_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_ClassInfo_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_ClassInfo_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the VU_ClassInfo table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_ClassInfo_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[VU_ClassInfo] WITH (ROWLOCK) 
				WHERE
					[ID] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_ClassInfo_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_ClassInfo_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_ClassInfo_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the VU_ClassInfo table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_ClassInfo_GetById
(

	@Id int   
)
AS


				SELECT
					[ID],
					[ClassID],
					[FuID],
					[ClassName],
					[CreatDate],
					[ClassOwner],
					[ClassDESC],
					[counter],
					[Closed]
				FROM
					[dbo].[VU_ClassInfo]
				WHERE
					[ID] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_ClassInfo_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_ClassInfo_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_ClassInfo_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the VU_ClassInfo table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_ClassInfo_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@ClassId nchar (10)  = null ,

	@FuId int   = null ,

	@ClassName nvarchar (128)  = null ,

	@CreatDate datetime   = null ,

	@ClassOwner nchar (10)  = null ,

	@ClassDesc nvarchar (200)  = null ,

	@Counter int   = null ,

	@Closed int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [ID]
	, [ClassID]
	, [FuID]
	, [ClassName]
	, [CreatDate]
	, [ClassOwner]
	, [ClassDESC]
	, [counter]
	, [Closed]
    FROM
	[dbo].[VU_ClassInfo]
    WHERE 
	 ([ID] = @Id OR @Id IS NULL)
	AND ([ClassID] = @ClassId OR @ClassId IS NULL)
	AND ([FuID] = @FuId OR @FuId IS NULL)
	AND ([ClassName] = @ClassName OR @ClassName IS NULL)
	AND ([CreatDate] = @CreatDate OR @CreatDate IS NULL)
	AND ([ClassOwner] = @ClassOwner OR @ClassOwner IS NULL)
	AND ([ClassDESC] = @ClassDesc OR @ClassDesc IS NULL)
	AND ([counter] = @Counter OR @Counter IS NULL)
	AND ([Closed] = @Closed OR @Closed IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [ID]
	, [ClassID]
	, [FuID]
	, [ClassName]
	, [CreatDate]
	, [ClassOwner]
	, [ClassDESC]
	, [counter]
	, [Closed]
    FROM
	[dbo].[VU_ClassInfo]
    WHERE 
	 ([ID] = @Id AND @Id is not null)
	OR ([ClassID] = @ClassId AND @ClassId is not null)
	OR ([FuID] = @FuId AND @FuId is not null)
	OR ([ClassName] = @ClassName AND @ClassName is not null)
	OR ([CreatDate] = @CreatDate AND @CreatDate is not null)
	OR ([ClassOwner] = @ClassOwner AND @ClassOwner is not null)
	OR ([ClassDESC] = @ClassDesc AND @ClassDesc is not null)
	OR ([counter] = @Counter AND @Counter is not null)
	OR ([Closed] = @Closed AND @Closed is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Notices_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Notices_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Notices_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the Notices table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Notices_Get_List

AS


				
				SELECT
					[NoticeID],
					[NoticeTitle],
					[NoticeDetail],
					[NoticeType],
					[UserID],
					[UserReadTime],
					[CreateTime],
					[CreateUserID],
					[Status]
				FROM
					[dbo].[Notices]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Notices_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Notices_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Notices_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the Notices table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Notices_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [NoticeID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([NoticeID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [NoticeID]'
				SET @SQL = @SQL + ' FROM [dbo].[Notices]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[NoticeID], O.[NoticeTitle], O.[NoticeDetail], O.[NoticeType], O.[UserID], O.[UserReadTime], O.[CreateTime], O.[CreateUserID], O.[Status]
				FROM
				    [dbo].[Notices] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[NoticeID] = PageIndex.[NoticeID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[Notices]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Notices_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Notices_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Notices_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the Notices table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Notices_Insert
(

	@NoticeId int    OUTPUT,

	@NoticeTitle varchar (200)  ,

	@NoticeDetail varchar (2000)  ,

	@NoticeType int   ,

	@UserId varchar (20)  ,

	@UserReadTime datetime   ,

	@CreateTime datetime   ,

	@CreateUserId varchar (20)  ,

	@Status int   
)
AS


				
				INSERT INTO [dbo].[Notices]
					(
					[NoticeTitle]
					,[NoticeDetail]
					,[NoticeType]
					,[UserID]
					,[UserReadTime]
					,[CreateTime]
					,[CreateUserID]
					,[Status]
					)
				VALUES
					(
					@NoticeTitle
					,@NoticeDetail
					,@NoticeType
					,@UserId
					,@UserReadTime
					,@CreateTime
					,@CreateUserId
					,@Status
					)
				
				-- Get the identity value
				SET @NoticeId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Notices_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Notices_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Notices_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the Notices table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Notices_Update
(

	@NoticeId int   ,

	@NoticeTitle varchar (200)  ,

	@NoticeDetail varchar (2000)  ,

	@NoticeType int   ,

	@UserId varchar (20)  ,

	@UserReadTime datetime   ,

	@CreateTime datetime   ,

	@CreateUserId varchar (20)  ,

	@Status int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[Notices]
				SET
					[NoticeTitle] = @NoticeTitle
					,[NoticeDetail] = @NoticeDetail
					,[NoticeType] = @NoticeType
					,[UserID] = @UserId
					,[UserReadTime] = @UserReadTime
					,[CreateTime] = @CreateTime
					,[CreateUserID] = @CreateUserId
					,[Status] = @Status
				WHERE
[NoticeID] = @NoticeId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Notices_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Notices_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Notices_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the Notices table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Notices_Delete
(

	@NoticeId int   
)
AS


				DELETE FROM [dbo].[Notices] WITH (ROWLOCK) 
				WHERE
					[NoticeID] = @NoticeId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Notices_GetByNoticeId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Notices_GetByNoticeId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Notices_GetByNoticeId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the Notices table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Notices_GetByNoticeId
(

	@NoticeId int   
)
AS


				SELECT
					[NoticeID],
					[NoticeTitle],
					[NoticeDetail],
					[NoticeType],
					[UserID],
					[UserReadTime],
					[CreateTime],
					[CreateUserID],
					[Status]
				FROM
					[dbo].[Notices]
				WHERE
					[NoticeID] = @NoticeId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Notices_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Notices_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Notices_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the Notices table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Notices_Find
(

	@SearchUsingOR bit   = null ,

	@NoticeId int   = null ,

	@NoticeTitle varchar (200)  = null ,

	@NoticeDetail varchar (2000)  = null ,

	@NoticeType int   = null ,

	@UserId varchar (20)  = null ,

	@UserReadTime datetime   = null ,

	@CreateTime datetime   = null ,

	@CreateUserId varchar (20)  = null ,

	@Status int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [NoticeID]
	, [NoticeTitle]
	, [NoticeDetail]
	, [NoticeType]
	, [UserID]
	, [UserReadTime]
	, [CreateTime]
	, [CreateUserID]
	, [Status]
    FROM
	[dbo].[Notices]
    WHERE 
	 ([NoticeID] = @NoticeId OR @NoticeId IS NULL)
	AND ([NoticeTitle] = @NoticeTitle OR @NoticeTitle IS NULL)
	AND ([NoticeDetail] = @NoticeDetail OR @NoticeDetail IS NULL)
	AND ([NoticeType] = @NoticeType OR @NoticeType IS NULL)
	AND ([UserID] = @UserId OR @UserId IS NULL)
	AND ([UserReadTime] = @UserReadTime OR @UserReadTime IS NULL)
	AND ([CreateTime] = @CreateTime OR @CreateTime IS NULL)
	AND ([CreateUserID] = @CreateUserId OR @CreateUserId IS NULL)
	AND ([Status] = @Status OR @Status IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [NoticeID]
	, [NoticeTitle]
	, [NoticeDetail]
	, [NoticeType]
	, [UserID]
	, [UserReadTime]
	, [CreateTime]
	, [CreateUserID]
	, [Status]
    FROM
	[dbo].[Notices]
    WHERE 
	 ([NoticeID] = @NoticeId AND @NoticeId is not null)
	OR ([NoticeTitle] = @NoticeTitle AND @NoticeTitle is not null)
	OR ([NoticeDetail] = @NoticeDetail AND @NoticeDetail is not null)
	OR ([NoticeType] = @NoticeType AND @NoticeType is not null)
	OR ([UserID] = @UserId AND @UserId is not null)
	OR ([UserReadTime] = @UserReadTime AND @UserReadTime is not null)
	OR ([CreateTime] = @CreateTime AND @CreateTime is not null)
	OR ([CreateUserID] = @CreateUserId AND @CreateUserId is not null)
	OR ([Status] = @Status AND @Status is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Menus_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Menus_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Menus_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the Menus table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Menus_Get_List

AS


				
				SELECT
					[MenuID],
					[ParentMenuID],
					[MenuName],
					[ShowOrder],
					[PermissionID],
					[PageUrl],
					[HelpInfo],
					[Status]
				FROM
					[dbo].[Menus]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Menus_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Menus_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Menus_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the Menus table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Menus_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [MenuID] varchar(40) COLLATE database_default  
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([MenuID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [MenuID]'
				SET @SQL = @SQL + ' FROM [dbo].[Menus]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[MenuID], O.[ParentMenuID], O.[MenuName], O.[ShowOrder], O.[PermissionID], O.[PageUrl], O.[HelpInfo], O.[Status]
				FROM
				    [dbo].[Menus] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[MenuID] = PageIndex.[MenuID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[Menus]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Menus_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Menus_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Menus_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the Menus table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Menus_Insert
(

	@MenuId varchar (40)  ,

	@ParentMenuId varchar (40)  ,

	@MenuName varchar (40)  ,

	@ShowOrder int   ,

	@PermissionId varchar (40)  ,

	@PageUrl varchar (200)  ,

	@HelpInfo varchar (1000)  ,

	@Status int   
)
AS


				
				INSERT INTO [dbo].[Menus]
					(
					[MenuID]
					,[ParentMenuID]
					,[MenuName]
					,[ShowOrder]
					,[PermissionID]
					,[PageUrl]
					,[HelpInfo]
					,[Status]
					)
				VALUES
					(
					@MenuId
					,@ParentMenuId
					,@MenuName
					,@ShowOrder
					,@PermissionId
					,@PageUrl
					,@HelpInfo
					,@Status
					)
				
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Menus_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Menus_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Menus_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the Menus table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Menus_Update
(

	@MenuId varchar (40)  ,

	@OriginalMenuId varchar (40)  ,

	@ParentMenuId varchar (40)  ,

	@MenuName varchar (40)  ,

	@ShowOrder int   ,

	@PermissionId varchar (40)  ,

	@PageUrl varchar (200)  ,

	@HelpInfo varchar (1000)  ,

	@Status int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[Menus]
				SET
					[MenuID] = @MenuId
					,[ParentMenuID] = @ParentMenuId
					,[MenuName] = @MenuName
					,[ShowOrder] = @ShowOrder
					,[PermissionID] = @PermissionId
					,[PageUrl] = @PageUrl
					,[HelpInfo] = @HelpInfo
					,[Status] = @Status
				WHERE
[MenuID] = @OriginalMenuId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Menus_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Menus_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Menus_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the Menus table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Menus_Delete
(

	@MenuId varchar (40)  
)
AS


				DELETE FROM [dbo].[Menus] WITH (ROWLOCK) 
				WHERE
					[MenuID] = @MenuId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Menus_GetByMenuId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Menus_GetByMenuId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Menus_GetByMenuId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the Menus table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Menus_GetByMenuId
(

	@MenuId varchar (40)  
)
AS


				SELECT
					[MenuID],
					[ParentMenuID],
					[MenuName],
					[ShowOrder],
					[PermissionID],
					[PageUrl],
					[HelpInfo],
					[Status]
				FROM
					[dbo].[Menus]
				WHERE
					[MenuID] = @MenuId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Menus_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Menus_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Menus_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the Menus table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Menus_Find
(

	@SearchUsingOR bit   = null ,

	@MenuId varchar (40)  = null ,

	@ParentMenuId varchar (40)  = null ,

	@MenuName varchar (40)  = null ,

	@ShowOrder int   = null ,

	@PermissionId varchar (40)  = null ,

	@PageUrl varchar (200)  = null ,

	@HelpInfo varchar (1000)  = null ,

	@Status int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [MenuID]
	, [ParentMenuID]
	, [MenuName]
	, [ShowOrder]
	, [PermissionID]
	, [PageUrl]
	, [HelpInfo]
	, [Status]
    FROM
	[dbo].[Menus]
    WHERE 
	 ([MenuID] = @MenuId OR @MenuId IS NULL)
	AND ([ParentMenuID] = @ParentMenuId OR @ParentMenuId IS NULL)
	AND ([MenuName] = @MenuName OR @MenuName IS NULL)
	AND ([ShowOrder] = @ShowOrder OR @ShowOrder IS NULL)
	AND ([PermissionID] = @PermissionId OR @PermissionId IS NULL)
	AND ([PageUrl] = @PageUrl OR @PageUrl IS NULL)
	AND ([HelpInfo] = @HelpInfo OR @HelpInfo IS NULL)
	AND ([Status] = @Status OR @Status IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [MenuID]
	, [ParentMenuID]
	, [MenuName]
	, [ShowOrder]
	, [PermissionID]
	, [PageUrl]
	, [HelpInfo]
	, [Status]
    FROM
	[dbo].[Menus]
    WHERE 
	 ([MenuID] = @MenuId AND @MenuId is not null)
	OR ([ParentMenuID] = @ParentMenuId AND @ParentMenuId is not null)
	OR ([MenuName] = @MenuName AND @MenuName is not null)
	OR ([ShowOrder] = @ShowOrder AND @ShowOrder is not null)
	OR ([PermissionID] = @PermissionId AND @PermissionId is not null)
	OR ([PageUrl] = @PageUrl AND @PageUrl is not null)
	OR ([HelpInfo] = @HelpInfo AND @HelpInfo is not null)
	OR ([Status] = @Status AND @Status is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LoginLog_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LoginLog_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LoginLog_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the LoginLog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LoginLog_Get_List

AS


				
				SELECT
					[LoginLogID],
					[LogBeginTime],
					[LogEndTime],
					[MachineIP],
					[UserID],
					[Demo]
				FROM
					[dbo].[LoginLog]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LoginLog_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LoginLog_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LoginLog_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the LoginLog table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LoginLog_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [LoginLogID] bigint 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([LoginLogID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [LoginLogID]'
				SET @SQL = @SQL + ' FROM [dbo].[LoginLog]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[LoginLogID], O.[LogBeginTime], O.[LogEndTime], O.[MachineIP], O.[UserID], O.[Demo]
				FROM
				    [dbo].[LoginLog] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[LoginLogID] = PageIndex.[LoginLogID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[LoginLog]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LoginLog_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LoginLog_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LoginLog_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the LoginLog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LoginLog_Insert
(

	@LoginLogId bigint    OUTPUT,

	@LogBeginTime datetime   ,

	@LogEndTime datetime   ,

	@MachineIp varchar (20)  ,

	@UserId varchar (20)  ,

	@Demo nvarchar (50)  
)
AS


				
				INSERT INTO [dbo].[LoginLog]
					(
					[LogBeginTime]
					,[LogEndTime]
					,[MachineIP]
					,[UserID]
					,[Demo]
					)
				VALUES
					(
					@LogBeginTime
					,@LogEndTime
					,@MachineIp
					,@UserId
					,@Demo
					)
				
				-- Get the identity value
				SET @LoginLogId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LoginLog_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LoginLog_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LoginLog_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the LoginLog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LoginLog_Update
(

	@LoginLogId bigint   ,

	@LogBeginTime datetime   ,

	@LogEndTime datetime   ,

	@MachineIp varchar (20)  ,

	@UserId varchar (20)  ,

	@Demo nvarchar (50)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[LoginLog]
				SET
					[LogBeginTime] = @LogBeginTime
					,[LogEndTime] = @LogEndTime
					,[MachineIP] = @MachineIp
					,[UserID] = @UserId
					,[Demo] = @Demo
				WHERE
[LoginLogID] = @LoginLogId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LoginLog_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LoginLog_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LoginLog_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the LoginLog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LoginLog_Delete
(

	@LoginLogId bigint   
)
AS


				DELETE FROM [dbo].[LoginLog] WITH (ROWLOCK) 
				WHERE
					[LoginLogID] = @LoginLogId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LoginLog_GetByLoginLogId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LoginLog_GetByLoginLogId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LoginLog_GetByLoginLogId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the LoginLog table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LoginLog_GetByLoginLogId
(

	@LoginLogId bigint   
)
AS


				SELECT
					[LoginLogID],
					[LogBeginTime],
					[LogEndTime],
					[MachineIP],
					[UserID],
					[Demo]
				FROM
					[dbo].[LoginLog]
				WHERE
					[LoginLogID] = @LoginLogId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LoginLog_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LoginLog_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LoginLog_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the LoginLog table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LoginLog_Find
(

	@SearchUsingOR bit   = null ,

	@LoginLogId bigint   = null ,

	@LogBeginTime datetime   = null ,

	@LogEndTime datetime   = null ,

	@MachineIp varchar (20)  = null ,

	@UserId varchar (20)  = null ,

	@Demo nvarchar (50)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [LoginLogID]
	, [LogBeginTime]
	, [LogEndTime]
	, [MachineIP]
	, [UserID]
	, [Demo]
    FROM
	[dbo].[LoginLog]
    WHERE 
	 ([LoginLogID] = @LoginLogId OR @LoginLogId IS NULL)
	AND ([LogBeginTime] = @LogBeginTime OR @LogBeginTime IS NULL)
	AND ([LogEndTime] = @LogEndTime OR @LogEndTime IS NULL)
	AND ([MachineIP] = @MachineIp OR @MachineIp IS NULL)
	AND ([UserID] = @UserId OR @UserId IS NULL)
	AND ([Demo] = @Demo OR @Demo IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [LoginLogID]
	, [LogBeginTime]
	, [LogEndTime]
	, [MachineIP]
	, [UserID]
	, [Demo]
    FROM
	[dbo].[LoginLog]
    WHERE 
	 ([LoginLogID] = @LoginLogId AND @LoginLogId is not null)
	OR ([LogBeginTime] = @LogBeginTime AND @LogBeginTime is not null)
	OR ([LogEndTime] = @LogEndTime AND @LogEndTime is not null)
	OR ([MachineIP] = @MachineIp AND @MachineIp is not null)
	OR ([UserID] = @UserId AND @UserId is not null)
	OR ([Demo] = @Demo AND @Demo is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Department_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Department_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Department_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the Department table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Department_Get_List

AS


				
				SELECT
					[DepartmentName],
					[CreatedDate],
					[UpdatedDate]
				FROM
					[dbo].[Department]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Department_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Department_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Department_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the Department table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Department_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [DepartmentName] varchar(50) COLLATE database_default  
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([DepartmentName])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [DepartmentName]'
				SET @SQL = @SQL + ' FROM [dbo].[Department]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[DepartmentName], O.[CreatedDate], O.[UpdatedDate]
				FROM
				    [dbo].[Department] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[DepartmentName] = PageIndex.[DepartmentName]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[Department]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Department_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Department_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Department_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the Department table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Department_Insert
(

	@DepartmentName varchar (50)  ,

	@CreatedDate datetime   ,

	@UpdatedDate datetime   
)
AS


				
				INSERT INTO [dbo].[Department]
					(
					[DepartmentName]
					,[CreatedDate]
					,[UpdatedDate]
					)
				VALUES
					(
					@DepartmentName
					,@CreatedDate
					,@UpdatedDate
					)
				
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Department_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Department_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Department_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the Department table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Department_Update
(

	@DepartmentName varchar (50)  ,

	@OriginalDepartmentName varchar (50)  ,

	@CreatedDate datetime   ,

	@UpdatedDate datetime   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[Department]
				SET
					[DepartmentName] = @DepartmentName
					,[CreatedDate] = @CreatedDate
					,[UpdatedDate] = @UpdatedDate
				WHERE
[DepartmentName] = @OriginalDepartmentName 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Department_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Department_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Department_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the Department table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Department_Delete
(

	@DepartmentName varchar (50)  
)
AS


				DELETE FROM [dbo].[Department] WITH (ROWLOCK) 
				WHERE
					[DepartmentName] = @DepartmentName
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Department_GetByDepartmentName procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Department_GetByDepartmentName') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Department_GetByDepartmentName
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the Department table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Department_GetByDepartmentName
(

	@DepartmentName varchar (50)  
)
AS


				SELECT
					[DepartmentName],
					[CreatedDate],
					[UpdatedDate]
				FROM
					[dbo].[Department]
				WHERE
					[DepartmentName] = @DepartmentName
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Department_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Department_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Department_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the Department table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Department_Find
(

	@SearchUsingOR bit   = null ,

	@DepartmentName varchar (50)  = null ,

	@CreatedDate datetime   = null ,

	@UpdatedDate datetime   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [DepartmentName]
	, [CreatedDate]
	, [UpdatedDate]
    FROM
	[dbo].[Department]
    WHERE 
	 ([DepartmentName] = @DepartmentName OR @DepartmentName IS NULL)
	AND ([CreatedDate] = @CreatedDate OR @CreatedDate IS NULL)
	AND ([UpdatedDate] = @UpdatedDate OR @UpdatedDate IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [DepartmentName]
	, [CreatedDate]
	, [UpdatedDate]
    FROM
	[dbo].[Department]
    WHERE 
	 ([DepartmentName] = @DepartmentName AND @DepartmentName is not null)
	OR ([CreatedDate] = @CreatedDate AND @CreatedDate is not null)
	OR ([UpdatedDate] = @UpdatedDate AND @UpdatedDate is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_assessment_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_assessment_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_assessment_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the evl_assessment table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_assessment_Get_List

AS


				
				SELECT
					[id],
					[name],
					[usertype],
					[weight],
					[model_id]
				FROM
					[dbo].[evl_assessment]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_assessment_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_assessment_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_assessment_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the evl_assessment table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_assessment_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [id]'
				SET @SQL = @SQL + ' FROM [dbo].[evl_assessment]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[id], O.[name], O.[usertype], O.[weight], O.[model_id]
				FROM
				    [dbo].[evl_assessment] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[id] = PageIndex.[id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[evl_assessment]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_assessment_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_assessment_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_assessment_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the evl_assessment table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_assessment_Insert
(

	@Id int    OUTPUT,

	@Name varchar (50)  ,

	@Usertype int   ,

	@Weight decimal (9, 2)  ,

	@ModelId int   
)
AS


				
				INSERT INTO [dbo].[evl_assessment]
					(
					[name]
					,[usertype]
					,[weight]
					,[model_id]
					)
				VALUES
					(
					@Name
					,@Usertype
					,@Weight
					,@ModelId
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_assessment_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_assessment_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_assessment_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the evl_assessment table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_assessment_Update
(

	@Id int   ,

	@Name varchar (50)  ,

	@Usertype int   ,

	@Weight decimal (9, 2)  ,

	@ModelId int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[evl_assessment]
				SET
					[name] = @Name
					,[usertype] = @Usertype
					,[weight] = @Weight
					,[model_id] = @ModelId
				WHERE
[id] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_assessment_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_assessment_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_assessment_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the evl_assessment table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_assessment_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[evl_assessment] WITH (ROWLOCK) 
				WHERE
					[id] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_assessment_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_assessment_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_assessment_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the evl_assessment table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_assessment_GetById
(

	@Id int   
)
AS


				SELECT
					[id],
					[name],
					[usertype],
					[weight],
					[model_id]
				FROM
					[dbo].[evl_assessment]
				WHERE
					[id] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_assessment_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_assessment_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_assessment_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the evl_assessment table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_assessment_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@Name varchar (50)  = null ,

	@Usertype int   = null ,

	@Weight decimal (9, 2)  = null ,

	@ModelId int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [id]
	, [name]
	, [usertype]
	, [weight]
	, [model_id]
    FROM
	[dbo].[evl_assessment]
    WHERE 
	 ([id] = @Id OR @Id IS NULL)
	AND ([name] = @Name OR @Name IS NULL)
	AND ([usertype] = @Usertype OR @Usertype IS NULL)
	AND ([weight] = @Weight OR @Weight IS NULL)
	AND ([model_id] = @ModelId OR @ModelId IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [id]
	, [name]
	, [usertype]
	, [weight]
	, [model_id]
    FROM
	[dbo].[evl_assessment]
    WHERE 
	 ([id] = @Id AND @Id is not null)
	OR ([name] = @Name AND @Name is not null)
	OR ([usertype] = @Usertype AND @Usertype is not null)
	OR ([weight] = @Weight AND @Weight is not null)
	OR ([model_id] = @ModelId AND @ModelId is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_Behavior_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_Behavior_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_Behavior_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the evl_Behavior table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_Behavior_Get_List

AS


				
				SELECT
					[id],
					[subject],
					[catelog_id],
					[Weight],
					[model_id]
				FROM
					[dbo].[evl_Behavior]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_Behavior_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_Behavior_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_Behavior_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the evl_Behavior table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_Behavior_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [id]'
				SET @SQL = @SQL + ' FROM [dbo].[evl_Behavior]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[id], O.[subject], O.[catelog_id], O.[Weight], O.[model_id]
				FROM
				    [dbo].[evl_Behavior] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[id] = PageIndex.[id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[evl_Behavior]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_Behavior_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_Behavior_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_Behavior_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the evl_Behavior table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_Behavior_Insert
(

	@Id int    OUTPUT,

	@Subject varchar (8000)  ,

	@CatelogId int   ,

	@Weight numeric (9, 2)  ,

	@ModelId int   
)
AS


				
				INSERT INTO [dbo].[evl_Behavior]
					(
					[subject]
					,[catelog_id]
					,[Weight]
					,[model_id]
					)
				VALUES
					(
					@Subject
					,@CatelogId
					,@Weight
					,@ModelId
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_Behavior_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_Behavior_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_Behavior_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the evl_Behavior table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_Behavior_Update
(

	@Id int   ,

	@Subject varchar (8000)  ,

	@CatelogId int   ,

	@Weight numeric (9, 2)  ,

	@ModelId int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[evl_Behavior]
				SET
					[subject] = @Subject
					,[catelog_id] = @CatelogId
					,[Weight] = @Weight
					,[model_id] = @ModelId
				WHERE
[id] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_Behavior_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_Behavior_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_Behavior_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the evl_Behavior table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_Behavior_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[evl_Behavior] WITH (ROWLOCK) 
				WHERE
					[id] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_Behavior_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_Behavior_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_Behavior_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the evl_Behavior table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_Behavior_GetById
(

	@Id int   
)
AS


				SELECT
					[id],
					[subject],
					[catelog_id],
					[Weight],
					[model_id]
				FROM
					[dbo].[evl_Behavior]
				WHERE
					[id] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_Behavior_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_Behavior_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_Behavior_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the evl_Behavior table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_Behavior_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@Subject varchar (8000)  = null ,

	@CatelogId int   = null ,

	@Weight numeric (9, 2)  = null ,

	@ModelId int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [id]
	, [subject]
	, [catelog_id]
	, [Weight]
	, [model_id]
    FROM
	[dbo].[evl_Behavior]
    WHERE 
	 ([id] = @Id OR @Id IS NULL)
	AND ([subject] = @Subject OR @Subject IS NULL)
	AND ([catelog_id] = @CatelogId OR @CatelogId IS NULL)
	AND ([Weight] = @Weight OR @Weight IS NULL)
	AND ([model_id] = @ModelId OR @ModelId IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [id]
	, [subject]
	, [catelog_id]
	, [Weight]
	, [model_id]
    FROM
	[dbo].[evl_Behavior]
    WHERE 
	 ([id] = @Id AND @Id is not null)
	OR ([subject] = @Subject AND @Subject is not null)
	OR ([catelog_id] = @CatelogId AND @CatelogId is not null)
	OR ([Weight] = @Weight AND @Weight is not null)
	OR ([model_id] = @ModelId AND @ModelId is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_behaviordescription_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_behaviordescription_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_behaviordescription_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the evl_behaviordescription table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_behaviordescription_Get_List

AS


				
				SELECT
					[id],
					[behavior_id],
					[score],
					[dept]
				FROM
					[dbo].[evl_behaviordescription]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_behaviordescription_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_behaviordescription_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_behaviordescription_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the evl_behaviordescription table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_behaviordescription_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [id]'
				SET @SQL = @SQL + ' FROM [dbo].[evl_behaviordescription]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[id], O.[behavior_id], O.[score], O.[dept]
				FROM
				    [dbo].[evl_behaviordescription] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[id] = PageIndex.[id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[evl_behaviordescription]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_behaviordescription_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_behaviordescription_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_behaviordescription_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the evl_behaviordescription table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_behaviordescription_Insert
(

	@Id int    OUTPUT,

	@BehaviorId int   ,

	@Score int   ,

	@Dept varchar (200)  
)
AS


				
				INSERT INTO [dbo].[evl_behaviordescription]
					(
					[behavior_id]
					,[score]
					,[dept]
					)
				VALUES
					(
					@BehaviorId
					,@Score
					,@Dept
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_behaviordescription_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_behaviordescription_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_behaviordescription_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the evl_behaviordescription table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_behaviordescription_Update
(

	@Id int   ,

	@BehaviorId int   ,

	@Score int   ,

	@Dept varchar (200)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[evl_behaviordescription]
				SET
					[behavior_id] = @BehaviorId
					,[score] = @Score
					,[dept] = @Dept
				WHERE
[id] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_behaviordescription_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_behaviordescription_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_behaviordescription_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the evl_behaviordescription table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_behaviordescription_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[evl_behaviordescription] WITH (ROWLOCK) 
				WHERE
					[id] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_behaviordescription_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_behaviordescription_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_behaviordescription_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the evl_behaviordescription table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_behaviordescription_GetById
(

	@Id int   
)
AS


				SELECT
					[id],
					[behavior_id],
					[score],
					[dept]
				FROM
					[dbo].[evl_behaviordescription]
				WHERE
					[id] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_behaviordescription_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_behaviordescription_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_behaviordescription_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the evl_behaviordescription table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_behaviordescription_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@BehaviorId int   = null ,

	@Score int   = null ,

	@Dept varchar (200)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [id]
	, [behavior_id]
	, [score]
	, [dept]
    FROM
	[dbo].[evl_behaviordescription]
    WHERE 
	 ([id] = @Id OR @Id IS NULL)
	AND ([behavior_id] = @BehaviorId OR @BehaviorId IS NULL)
	AND ([score] = @Score OR @Score IS NULL)
	AND ([dept] = @Dept OR @Dept IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [id]
	, [behavior_id]
	, [score]
	, [dept]
    FROM
	[dbo].[evl_behaviordescription]
    WHERE 
	 ([id] = @Id AND @Id is not null)
	OR ([behavior_id] = @BehaviorId AND @BehaviorId is not null)
	OR ([score] = @Score AND @Score is not null)
	OR ([dept] = @Dept AND @Dept is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Degrees_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Degrees_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Degrees_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the Degrees table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Degrees_Get_List

AS


				
				SELECT
					[DegreeId],
					[DegreeName],
					[InstituteId],
					[Description],
					[Credithour],
					[Createtime],
					[CreateUserId],
					[Status],
					[ToApply]
				FROM
					[dbo].[Degrees]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Degrees_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Degrees_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Degrees_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the Degrees table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Degrees_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [DegreeId] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([DegreeId])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [DegreeId]'
				SET @SQL = @SQL + ' FROM [dbo].[Degrees]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[DegreeId], O.[DegreeName], O.[InstituteId], O.[Description], O.[Credithour], O.[Createtime], O.[CreateUserId], O.[Status], O.[ToApply]
				FROM
				    [dbo].[Degrees] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[DegreeId] = PageIndex.[DegreeId]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[Degrees]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Degrees_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Degrees_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Degrees_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the Degrees table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Degrees_Insert
(

	@DegreeId int    OUTPUT,

	@DegreeName varchar (150)  ,

	@InstituteId varchar (20)  ,

	@Description varchar (500)  ,

	@Credithour int   ,

	@Createtime datetime   ,

	@CreateUserId varchar (20)  ,

	@Status int   ,

	@ToApply int   
)
AS


				
				INSERT INTO [dbo].[Degrees]
					(
					[DegreeName]
					,[InstituteId]
					,[Description]
					,[Credithour]
					,[Createtime]
					,[CreateUserId]
					,[Status]
					,[ToApply]
					)
				VALUES
					(
					@DegreeName
					,@InstituteId
					,@Description
					,@Credithour
					,@Createtime
					,@CreateUserId
					,@Status
					,@ToApply
					)
				
				-- Get the identity value
				SET @DegreeId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Degrees_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Degrees_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Degrees_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the Degrees table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Degrees_Update
(

	@DegreeId int   ,

	@DegreeName varchar (150)  ,

	@InstituteId varchar (20)  ,

	@Description varchar (500)  ,

	@Credithour int   ,

	@Createtime datetime   ,

	@CreateUserId varchar (20)  ,

	@Status int   ,

	@ToApply int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[Degrees]
				SET
					[DegreeName] = @DegreeName
					,[InstituteId] = @InstituteId
					,[Description] = @Description
					,[Credithour] = @Credithour
					,[Createtime] = @Createtime
					,[CreateUserId] = @CreateUserId
					,[Status] = @Status
					,[ToApply] = @ToApply
				WHERE
[DegreeId] = @DegreeId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Degrees_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Degrees_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Degrees_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the Degrees table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Degrees_Delete
(

	@DegreeId int   
)
AS


				DELETE FROM [dbo].[Degrees] WITH (ROWLOCK) 
				WHERE
					[DegreeId] = @DegreeId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Degrees_GetByDegreeId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Degrees_GetByDegreeId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Degrees_GetByDegreeId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the Degrees table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Degrees_GetByDegreeId
(

	@DegreeId int   
)
AS


				SELECT
					[DegreeId],
					[DegreeName],
					[InstituteId],
					[Description],
					[Credithour],
					[Createtime],
					[CreateUserId],
					[Status],
					[ToApply]
				FROM
					[dbo].[Degrees]
				WHERE
					[DegreeId] = @DegreeId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Degrees_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Degrees_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Degrees_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the Degrees table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Degrees_Find
(

	@SearchUsingOR bit   = null ,

	@DegreeId int   = null ,

	@DegreeName varchar (150)  = null ,

	@InstituteId varchar (20)  = null ,

	@Description varchar (500)  = null ,

	@Credithour int   = null ,

	@Createtime datetime   = null ,

	@CreateUserId varchar (20)  = null ,

	@Status int   = null ,

	@ToApply int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [DegreeId]
	, [DegreeName]
	, [InstituteId]
	, [Description]
	, [Credithour]
	, [Createtime]
	, [CreateUserId]
	, [Status]
	, [ToApply]
    FROM
	[dbo].[Degrees]
    WHERE 
	 ([DegreeId] = @DegreeId OR @DegreeId IS NULL)
	AND ([DegreeName] = @DegreeName OR @DegreeName IS NULL)
	AND ([InstituteId] = @InstituteId OR @InstituteId IS NULL)
	AND ([Description] = @Description OR @Description IS NULL)
	AND ([Credithour] = @Credithour OR @Credithour IS NULL)
	AND ([Createtime] = @Createtime OR @Createtime IS NULL)
	AND ([CreateUserId] = @CreateUserId OR @CreateUserId IS NULL)
	AND ([Status] = @Status OR @Status IS NULL)
	AND ([ToApply] = @ToApply OR @ToApply IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [DegreeId]
	, [DegreeName]
	, [InstituteId]
	, [Description]
	, [Credithour]
	, [Createtime]
	, [CreateUserId]
	, [Status]
	, [ToApply]
    FROM
	[dbo].[Degrees]
    WHERE 
	 ([DegreeId] = @DegreeId AND @DegreeId is not null)
	OR ([DegreeName] = @DegreeName AND @DegreeName is not null)
	OR ([InstituteId] = @InstituteId AND @InstituteId is not null)
	OR ([Description] = @Description AND @Description is not null)
	OR ([Credithour] = @Credithour AND @Credithour is not null)
	OR ([Createtime] = @Createtime AND @Createtime is not null)
	OR ([CreateUserId] = @CreateUserId AND @CreateUserId is not null)
	OR ([Status] = @Status AND @Status is not null)
	OR ([ToApply] = @ToApply AND @ToApply is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.DegreeCourses_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DegreeCourses_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.DegreeCourses_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the DegreeCourses table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.DegreeCourses_Get_List

AS


				
				SELECT
					[DegreeCourseID],
					[CourseName],
					[CourseStyle],
					[CourseId],
					[Description],
					[CreditHour],
					[CreateUserID],
					[CreateTime],
					[Status],
					[DegreeId],
					[IsRequiredCourse]
				FROM
					[dbo].[DegreeCourses]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.DegreeCourses_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DegreeCourses_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.DegreeCourses_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the DegreeCourses table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.DegreeCourses_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [DegreeCourseID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([DegreeCourseID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [DegreeCourseID]'
				SET @SQL = @SQL + ' FROM [dbo].[DegreeCourses]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[DegreeCourseID], O.[CourseName], O.[CourseStyle], O.[CourseId], O.[Description], O.[CreditHour], O.[CreateUserID], O.[CreateTime], O.[Status], O.[DegreeId], O.[IsRequiredCourse]
				FROM
				    [dbo].[DegreeCourses] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[DegreeCourseID] = PageIndex.[DegreeCourseID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[DegreeCourses]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.DegreeCourses_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DegreeCourses_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.DegreeCourses_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the DegreeCourses table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.DegreeCourses_Insert
(

	@DegreeCourseId int    OUTPUT,

	@CourseName varchar (150)  ,

	@CourseStyle int   ,

	@CourseId varchar (20)  ,

	@Description varchar (500)  ,

	@CreditHour int   ,

	@CreateUserId varchar (20)  ,

	@CreateTime datetime   ,

	@Status int   ,

	@DegreeId int   ,

	@IsRequiredCourse int   
)
AS


				
				INSERT INTO [dbo].[DegreeCourses]
					(
					[CourseName]
					,[CourseStyle]
					,[CourseId]
					,[Description]
					,[CreditHour]
					,[CreateUserID]
					,[CreateTime]
					,[Status]
					,[DegreeId]
					,[IsRequiredCourse]
					)
				VALUES
					(
					@CourseName
					,@CourseStyle
					,@CourseId
					,@Description
					,@CreditHour
					,@CreateUserId
					,@CreateTime
					,@Status
					,@DegreeId
					,@IsRequiredCourse
					)
				
				-- Get the identity value
				SET @DegreeCourseId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.DegreeCourses_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DegreeCourses_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.DegreeCourses_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the DegreeCourses table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.DegreeCourses_Update
(

	@DegreeCourseId int   ,

	@CourseName varchar (150)  ,

	@CourseStyle int   ,

	@CourseId varchar (20)  ,

	@Description varchar (500)  ,

	@CreditHour int   ,

	@CreateUserId varchar (20)  ,

	@CreateTime datetime   ,

	@Status int   ,

	@DegreeId int   ,

	@IsRequiredCourse int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[DegreeCourses]
				SET
					[CourseName] = @CourseName
					,[CourseStyle] = @CourseStyle
					,[CourseId] = @CourseId
					,[Description] = @Description
					,[CreditHour] = @CreditHour
					,[CreateUserID] = @CreateUserId
					,[CreateTime] = @CreateTime
					,[Status] = @Status
					,[DegreeId] = @DegreeId
					,[IsRequiredCourse] = @IsRequiredCourse
				WHERE
[DegreeCourseID] = @DegreeCourseId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.DegreeCourses_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DegreeCourses_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.DegreeCourses_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the DegreeCourses table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.DegreeCourses_Delete
(

	@DegreeCourseId int   
)
AS


				DELETE FROM [dbo].[DegreeCourses] WITH (ROWLOCK) 
				WHERE
					[DegreeCourseID] = @DegreeCourseId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.DegreeCourses_GetByDegreeCourseId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DegreeCourses_GetByDegreeCourseId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.DegreeCourses_GetByDegreeCourseId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the DegreeCourses table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.DegreeCourses_GetByDegreeCourseId
(

	@DegreeCourseId int   
)
AS


				SELECT
					[DegreeCourseID],
					[CourseName],
					[CourseStyle],
					[CourseId],
					[Description],
					[CreditHour],
					[CreateUserID],
					[CreateTime],
					[Status],
					[DegreeId],
					[IsRequiredCourse]
				FROM
					[dbo].[DegreeCourses]
				WHERE
					[DegreeCourseID] = @DegreeCourseId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.DegreeCourses_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DegreeCourses_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.DegreeCourses_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the DegreeCourses table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.DegreeCourses_Find
(

	@SearchUsingOR bit   = null ,

	@DegreeCourseId int   = null ,

	@CourseName varchar (150)  = null ,

	@CourseStyle int   = null ,

	@CourseId varchar (20)  = null ,

	@Description varchar (500)  = null ,

	@CreditHour int   = null ,

	@CreateUserId varchar (20)  = null ,

	@CreateTime datetime   = null ,

	@Status int   = null ,

	@DegreeId int   = null ,

	@IsRequiredCourse int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [DegreeCourseID]
	, [CourseName]
	, [CourseStyle]
	, [CourseId]
	, [Description]
	, [CreditHour]
	, [CreateUserID]
	, [CreateTime]
	, [Status]
	, [DegreeId]
	, [IsRequiredCourse]
    FROM
	[dbo].[DegreeCourses]
    WHERE 
	 ([DegreeCourseID] = @DegreeCourseId OR @DegreeCourseId IS NULL)
	AND ([CourseName] = @CourseName OR @CourseName IS NULL)
	AND ([CourseStyle] = @CourseStyle OR @CourseStyle IS NULL)
	AND ([CourseId] = @CourseId OR @CourseId IS NULL)
	AND ([Description] = @Description OR @Description IS NULL)
	AND ([CreditHour] = @CreditHour OR @CreditHour IS NULL)
	AND ([CreateUserID] = @CreateUserId OR @CreateUserId IS NULL)
	AND ([CreateTime] = @CreateTime OR @CreateTime IS NULL)
	AND ([Status] = @Status OR @Status IS NULL)
	AND ([DegreeId] = @DegreeId OR @DegreeId IS NULL)
	AND ([IsRequiredCourse] = @IsRequiredCourse OR @IsRequiredCourse IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [DegreeCourseID]
	, [CourseName]
	, [CourseStyle]
	, [CourseId]
	, [Description]
	, [CreditHour]
	, [CreateUserID]
	, [CreateTime]
	, [Status]
	, [DegreeId]
	, [IsRequiredCourse]
    FROM
	[dbo].[DegreeCourses]
    WHERE 
	 ([DegreeCourseID] = @DegreeCourseId AND @DegreeCourseId is not null)
	OR ([CourseName] = @CourseName AND @CourseName is not null)
	OR ([CourseStyle] = @CourseStyle AND @CourseStyle is not null)
	OR ([CourseId] = @CourseId AND @CourseId is not null)
	OR ([Description] = @Description AND @Description is not null)
	OR ([CreditHour] = @CreditHour AND @CreditHour is not null)
	OR ([CreateUserID] = @CreateUserId AND @CreateUserId is not null)
	OR ([CreateTime] = @CreateTime AND @CreateTime is not null)
	OR ([Status] = @Status AND @Status is not null)
	OR ([DegreeId] = @DegreeId AND @DegreeId is not null)
	OR ([IsRequiredCourse] = @IsRequiredCourse AND @IsRequiredCourse is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.CourseIdea_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.CourseIdea_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.CourseIdea_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the CourseIdea table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.CourseIdea_Get_List

AS


				
				SELECT
					[CourseideaID],
					[CourseID],
					[CourseUserID],
					[CourseUserDate],
					[CourseKnowledge],
					[Courseinstance],
					[CourseUserIdea],
					[CheckUserID],
					[CheckUserDate],
					[CheckUserIdea],
					[Status]
				FROM
					[dbo].[CourseIdea]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.CourseIdea_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.CourseIdea_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.CourseIdea_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the CourseIdea table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.CourseIdea_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [CourseideaID] bigint 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([CourseideaID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [CourseideaID]'
				SET @SQL = @SQL + ' FROM [dbo].[CourseIdea]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[CourseideaID], O.[CourseID], O.[CourseUserID], O.[CourseUserDate], O.[CourseKnowledge], O.[Courseinstance], O.[CourseUserIdea], O.[CheckUserID], O.[CheckUserDate], O.[CheckUserIdea], O.[Status]
				FROM
				    [dbo].[CourseIdea] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[CourseideaID] = PageIndex.[CourseideaID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[CourseIdea]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.CourseIdea_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.CourseIdea_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.CourseIdea_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the CourseIdea table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.CourseIdea_Insert
(

	@CourseideaId bigint    OUTPUT,

	@CourseId varchar (20)  ,

	@CourseUserId varchar (20)  ,

	@CourseUserDate datetime   ,

	@CourseKnowledge nvarchar (250)  ,

	@Courseinstance nvarchar (MAX)  ,

	@CourseUserIdea nvarchar (MAX)  ,

	@CheckUserId varchar (20)  ,

	@CheckUserDate datetime   ,

	@CheckUserIdea nvarchar (MAX)  ,

	@Status int   
)
AS


				
				INSERT INTO [dbo].[CourseIdea]
					(
					[CourseID]
					,[CourseUserID]
					,[CourseUserDate]
					,[CourseKnowledge]
					,[Courseinstance]
					,[CourseUserIdea]
					,[CheckUserID]
					,[CheckUserDate]
					,[CheckUserIdea]
					,[Status]
					)
				VALUES
					(
					@CourseId
					,@CourseUserId
					,@CourseUserDate
					,@CourseKnowledge
					,@Courseinstance
					,@CourseUserIdea
					,@CheckUserId
					,@CheckUserDate
					,@CheckUserIdea
					,@Status
					)
				
				-- Get the identity value
				SET @CourseideaId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.CourseIdea_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.CourseIdea_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.CourseIdea_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the CourseIdea table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.CourseIdea_Update
(

	@CourseideaId bigint   ,

	@CourseId varchar (20)  ,

	@CourseUserId varchar (20)  ,

	@CourseUserDate datetime   ,

	@CourseKnowledge nvarchar (250)  ,

	@Courseinstance nvarchar (MAX)  ,

	@CourseUserIdea nvarchar (MAX)  ,

	@CheckUserId varchar (20)  ,

	@CheckUserDate datetime   ,

	@CheckUserIdea nvarchar (MAX)  ,

	@Status int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[CourseIdea]
				SET
					[CourseID] = @CourseId
					,[CourseUserID] = @CourseUserId
					,[CourseUserDate] = @CourseUserDate
					,[CourseKnowledge] = @CourseKnowledge
					,[Courseinstance] = @Courseinstance
					,[CourseUserIdea] = @CourseUserIdea
					,[CheckUserID] = @CheckUserId
					,[CheckUserDate] = @CheckUserDate
					,[CheckUserIdea] = @CheckUserIdea
					,[Status] = @Status
				WHERE
[CourseideaID] = @CourseideaId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.CourseIdea_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.CourseIdea_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.CourseIdea_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the CourseIdea table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.CourseIdea_Delete
(

	@CourseideaId bigint   
)
AS


				DELETE FROM [dbo].[CourseIdea] WITH (ROWLOCK) 
				WHERE
					[CourseideaID] = @CourseideaId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.CourseIdea_GetByCourseideaId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.CourseIdea_GetByCourseideaId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.CourseIdea_GetByCourseideaId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the CourseIdea table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.CourseIdea_GetByCourseideaId
(

	@CourseideaId bigint   
)
AS


				SELECT
					[CourseideaID],
					[CourseID],
					[CourseUserID],
					[CourseUserDate],
					[CourseKnowledge],
					[Courseinstance],
					[CourseUserIdea],
					[CheckUserID],
					[CheckUserDate],
					[CheckUserIdea],
					[Status]
				FROM
					[dbo].[CourseIdea]
				WHERE
					[CourseideaID] = @CourseideaId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.CourseIdea_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.CourseIdea_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.CourseIdea_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the CourseIdea table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.CourseIdea_Find
(

	@SearchUsingOR bit   = null ,

	@CourseideaId bigint   = null ,

	@CourseId varchar (20)  = null ,

	@CourseUserId varchar (20)  = null ,

	@CourseUserDate datetime   = null ,

	@CourseKnowledge nvarchar (250)  = null ,

	@Courseinstance nvarchar (MAX)  = null ,

	@CourseUserIdea nvarchar (MAX)  = null ,

	@CheckUserId varchar (20)  = null ,

	@CheckUserDate datetime   = null ,

	@CheckUserIdea nvarchar (MAX)  = null ,

	@Status int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [CourseideaID]
	, [CourseID]
	, [CourseUserID]
	, [CourseUserDate]
	, [CourseKnowledge]
	, [Courseinstance]
	, [CourseUserIdea]
	, [CheckUserID]
	, [CheckUserDate]
	, [CheckUserIdea]
	, [Status]
    FROM
	[dbo].[CourseIdea]
    WHERE 
	 ([CourseideaID] = @CourseideaId OR @CourseideaId IS NULL)
	AND ([CourseID] = @CourseId OR @CourseId IS NULL)
	AND ([CourseUserID] = @CourseUserId OR @CourseUserId IS NULL)
	AND ([CourseUserDate] = @CourseUserDate OR @CourseUserDate IS NULL)
	AND ([CourseKnowledge] = @CourseKnowledge OR @CourseKnowledge IS NULL)
	AND ([Courseinstance] = @Courseinstance OR @Courseinstance IS NULL)
	AND ([CourseUserIdea] = @CourseUserIdea OR @CourseUserIdea IS NULL)
	AND ([CheckUserID] = @CheckUserId OR @CheckUserId IS NULL)
	AND ([CheckUserDate] = @CheckUserDate OR @CheckUserDate IS NULL)
	AND ([CheckUserIdea] = @CheckUserIdea OR @CheckUserIdea IS NULL)
	AND ([Status] = @Status OR @Status IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [CourseideaID]
	, [CourseID]
	, [CourseUserID]
	, [CourseUserDate]
	, [CourseKnowledge]
	, [Courseinstance]
	, [CourseUserIdea]
	, [CheckUserID]
	, [CheckUserDate]
	, [CheckUserIdea]
	, [Status]
    FROM
	[dbo].[CourseIdea]
    WHERE 
	 ([CourseideaID] = @CourseideaId AND @CourseideaId is not null)
	OR ([CourseID] = @CourseId AND @CourseId is not null)
	OR ([CourseUserID] = @CourseUserId AND @CourseUserId is not null)
	OR ([CourseUserDate] = @CourseUserDate AND @CourseUserDate is not null)
	OR ([CourseKnowledge] = @CourseKnowledge AND @CourseKnowledge is not null)
	OR ([Courseinstance] = @Courseinstance AND @Courseinstance is not null)
	OR ([CourseUserIdea] = @CourseUserIdea AND @CourseUserIdea is not null)
	OR ([CheckUserID] = @CheckUserId AND @CheckUserId is not null)
	OR ([CheckUserDate] = @CheckUserDate AND @CheckUserDate is not null)
	OR ([CheckUserIdea] = @CheckUserIdea AND @CheckUserIdea is not null)
	OR ([Status] = @Status AND @Status is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Courses_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Courses_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Courses_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the Courses table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Courses_Get_List

AS


				
				SELECT
					[CourseID],
					[CourseName],
					[CreateUserID],
					[CourseCredit],
					[CreateTime],
					[Description],
					[CourseHour],
					[Status],
					[IsExperience],
					[CourseUrl]
				FROM
					[dbo].[Courses]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Courses_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Courses_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Courses_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the Courses table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Courses_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [CourseID] varchar(20) COLLATE database_default  
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([CourseID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [CourseID]'
				SET @SQL = @SQL + ' FROM [dbo].[Courses]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[CourseID], O.[CourseName], O.[CreateUserID], O.[CourseCredit], O.[CreateTime], O.[Description], O.[CourseHour], O.[Status], O.[IsExperience], O.[CourseUrl]
				FROM
				    [dbo].[Courses] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[CourseID] = PageIndex.[CourseID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[Courses]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Courses_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Courses_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Courses_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the Courses table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Courses_Insert
(

	@CourseId varchar (20)  ,

	@CourseName varchar (150)  ,

	@CreateUserId varchar (20)  ,

	@CourseCredit int   ,

	@CreateTime datetime   ,

	@Description varchar (500)  ,

	@CourseHour int   ,

	@Status int   ,

	@IsExperience int   ,

	@CourseUrl nvarchar (1000)  
)
AS


				
				INSERT INTO [dbo].[Courses]
					(
					[CourseID]
					,[CourseName]
					,[CreateUserID]
					,[CourseCredit]
					,[CreateTime]
					,[Description]
					,[CourseHour]
					,[Status]
					,[IsExperience]
					,[CourseUrl]
					)
				VALUES
					(
					@CourseId
					,@CourseName
					,@CreateUserId
					,@CourseCredit
					,@CreateTime
					,@Description
					,@CourseHour
					,@Status
					,@IsExperience
					,@CourseUrl
					)
				
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Courses_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Courses_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Courses_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the Courses table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Courses_Update
(

	@CourseId varchar (20)  ,

	@OriginalCourseId varchar (20)  ,

	@CourseName varchar (150)  ,

	@CreateUserId varchar (20)  ,

	@CourseCredit int   ,

	@CreateTime datetime   ,

	@Description varchar (500)  ,

	@CourseHour int   ,

	@Status int   ,

	@IsExperience int   ,

	@CourseUrl nvarchar (1000)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[Courses]
				SET
					[CourseID] = @CourseId
					,[CourseName] = @CourseName
					,[CreateUserID] = @CreateUserId
					,[CourseCredit] = @CourseCredit
					,[CreateTime] = @CreateTime
					,[Description] = @Description
					,[CourseHour] = @CourseHour
					,[Status] = @Status
					,[IsExperience] = @IsExperience
					,[CourseUrl] = @CourseUrl
				WHERE
[CourseID] = @OriginalCourseId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Courses_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Courses_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Courses_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the Courses table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Courses_Delete
(

	@CourseId varchar (20)  
)
AS


				DELETE FROM [dbo].[Courses] WITH (ROWLOCK) 
				WHERE
					[CourseID] = @CourseId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Courses_GetByCourseId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Courses_GetByCourseId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Courses_GetByCourseId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the Courses table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Courses_GetByCourseId
(

	@CourseId varchar (20)  
)
AS


				SELECT
					[CourseID],
					[CourseName],
					[CreateUserID],
					[CourseCredit],
					[CreateTime],
					[Description],
					[CourseHour],
					[Status],
					[IsExperience],
					[CourseUrl]
				FROM
					[dbo].[Courses]
				WHERE
					[CourseID] = @CourseId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Courses_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Courses_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Courses_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the Courses table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Courses_Find
(

	@SearchUsingOR bit   = null ,

	@CourseId varchar (20)  = null ,

	@CourseName varchar (150)  = null ,

	@CreateUserId varchar (20)  = null ,

	@CourseCredit int   = null ,

	@CreateTime datetime   = null ,

	@Description varchar (500)  = null ,

	@CourseHour int   = null ,

	@Status int   = null ,

	@IsExperience int   = null ,

	@CourseUrl nvarchar (1000)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [CourseID]
	, [CourseName]
	, [CreateUserID]
	, [CourseCredit]
	, [CreateTime]
	, [Description]
	, [CourseHour]
	, [Status]
	, [IsExperience]
	, [CourseUrl]
    FROM
	[dbo].[Courses]
    WHERE 
	 ([CourseID] = @CourseId OR @CourseId IS NULL)
	AND ([CourseName] = @CourseName OR @CourseName IS NULL)
	AND ([CreateUserID] = @CreateUserId OR @CreateUserId IS NULL)
	AND ([CourseCredit] = @CourseCredit OR @CourseCredit IS NULL)
	AND ([CreateTime] = @CreateTime OR @CreateTime IS NULL)
	AND ([Description] = @Description OR @Description IS NULL)
	AND ([CourseHour] = @CourseHour OR @CourseHour IS NULL)
	AND ([Status] = @Status OR @Status IS NULL)
	AND ([IsExperience] = @IsExperience OR @IsExperience IS NULL)
	AND ([CourseUrl] = @CourseUrl OR @CourseUrl IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [CourseID]
	, [CourseName]
	, [CreateUserID]
	, [CourseCredit]
	, [CreateTime]
	, [Description]
	, [CourseHour]
	, [Status]
	, [IsExperience]
	, [CourseUrl]
    FROM
	[dbo].[Courses]
    WHERE 
	 ([CourseID] = @CourseId AND @CourseId is not null)
	OR ([CourseName] = @CourseName AND @CourseName is not null)
	OR ([CreateUserID] = @CreateUserId AND @CreateUserId is not null)
	OR ([CourseCredit] = @CourseCredit AND @CourseCredit is not null)
	OR ([CreateTime] = @CreateTime AND @CreateTime is not null)
	OR ([Description] = @Description AND @Description is not null)
	OR ([CourseHour] = @CourseHour AND @CourseHour is not null)
	OR ([Status] = @Status AND @Status is not null)
	OR ([IsExperience] = @IsExperience AND @IsExperience is not null)
	OR ([CourseUrl] = @CourseUrl AND @CourseUrl is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Coursewares_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Coursewares_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Coursewares_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the Coursewares table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Coursewares_Get_List

AS


				
				SELECT
					[CoursewareID],
					[CoursewareName],
					[CreateTime],
					[CreateUserID],
					[CoursewareFileName],
					[CoursewareFilePath],
					[CoursewareDifficulty],
					[Description],
					[CoursewareOrder],
					[CoursewareType],
					[Status],
					[CourseID],
					[ResourceType]
				FROM
					[dbo].[Coursewares]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Coursewares_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Coursewares_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Coursewares_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the Coursewares table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Coursewares_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [CoursewareID] varchar(20) COLLATE database_default  
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([CoursewareID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [CoursewareID]'
				SET @SQL = @SQL + ' FROM [dbo].[Coursewares]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[CoursewareID], O.[CoursewareName], O.[CreateTime], O.[CreateUserID], O.[CoursewareFileName], O.[CoursewareFilePath], O.[CoursewareDifficulty], O.[Description], O.[CoursewareOrder], O.[CoursewareType], O.[Status], O.[CourseID], O.[ResourceType]
				FROM
				    [dbo].[Coursewares] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[CoursewareID] = PageIndex.[CoursewareID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[Coursewares]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Coursewares_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Coursewares_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Coursewares_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the Coursewares table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Coursewares_Insert
(

	@CoursewareId varchar (20)  ,

	@CoursewareName varchar (150)  ,

	@CreateTime datetime   ,

	@CreateUserId varchar (20)  ,

	@CoursewareFileName varchar (250)  ,

	@CoursewareFilePath varchar (250)  ,

	@CoursewareDifficulty int   ,

	@Description varchar (500)  ,

	@CoursewareOrder int   ,

	@CoursewareType int   ,

	@Status int   ,

	@CourseId varchar (20)  ,

	@ResourceType int   
)
AS


				
				INSERT INTO [dbo].[Coursewares]
					(
					[CoursewareID]
					,[CoursewareName]
					,[CreateTime]
					,[CreateUserID]
					,[CoursewareFileName]
					,[CoursewareFilePath]
					,[CoursewareDifficulty]
					,[Description]
					,[CoursewareOrder]
					,[CoursewareType]
					,[Status]
					,[CourseID]
					,[ResourceType]
					)
				VALUES
					(
					@CoursewareId
					,@CoursewareName
					,@CreateTime
					,@CreateUserId
					,@CoursewareFileName
					,@CoursewareFilePath
					,@CoursewareDifficulty
					,@Description
					,@CoursewareOrder
					,@CoursewareType
					,@Status
					,@CourseId
					,@ResourceType
					)
				
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Coursewares_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Coursewares_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Coursewares_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the Coursewares table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Coursewares_Update
(

	@CoursewareId varchar (20)  ,

	@OriginalCoursewareId varchar (20)  ,

	@CoursewareName varchar (150)  ,

	@CreateTime datetime   ,

	@CreateUserId varchar (20)  ,

	@CoursewareFileName varchar (250)  ,

	@CoursewareFilePath varchar (250)  ,

	@CoursewareDifficulty int   ,

	@Description varchar (500)  ,

	@CoursewareOrder int   ,

	@CoursewareType int   ,

	@Status int   ,

	@CourseId varchar (20)  ,

	@ResourceType int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[Coursewares]
				SET
					[CoursewareID] = @CoursewareId
					,[CoursewareName] = @CoursewareName
					,[CreateTime] = @CreateTime
					,[CreateUserID] = @CreateUserId
					,[CoursewareFileName] = @CoursewareFileName
					,[CoursewareFilePath] = @CoursewareFilePath
					,[CoursewareDifficulty] = @CoursewareDifficulty
					,[Description] = @Description
					,[CoursewareOrder] = @CoursewareOrder
					,[CoursewareType] = @CoursewareType
					,[Status] = @Status
					,[CourseID] = @CourseId
					,[ResourceType] = @ResourceType
				WHERE
[CoursewareID] = @OriginalCoursewareId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Coursewares_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Coursewares_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Coursewares_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the Coursewares table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Coursewares_Delete
(

	@CoursewareId varchar (20)  
)
AS


				DELETE FROM [dbo].[Coursewares] WITH (ROWLOCK) 
				WHERE
					[CoursewareID] = @CoursewareId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Coursewares_GetByCoursewareId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Coursewares_GetByCoursewareId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Coursewares_GetByCoursewareId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the Coursewares table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Coursewares_GetByCoursewareId
(

	@CoursewareId varchar (20)  
)
AS


				SELECT
					[CoursewareID],
					[CoursewareName],
					[CreateTime],
					[CreateUserID],
					[CoursewareFileName],
					[CoursewareFilePath],
					[CoursewareDifficulty],
					[Description],
					[CoursewareOrder],
					[CoursewareType],
					[Status],
					[CourseID],
					[ResourceType]
				FROM
					[dbo].[Coursewares]
				WHERE
					[CoursewareID] = @CoursewareId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Coursewares_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Coursewares_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Coursewares_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the Coursewares table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Coursewares_Find
(

	@SearchUsingOR bit   = null ,

	@CoursewareId varchar (20)  = null ,

	@CoursewareName varchar (150)  = null ,

	@CreateTime datetime   = null ,

	@CreateUserId varchar (20)  = null ,

	@CoursewareFileName varchar (250)  = null ,

	@CoursewareFilePath varchar (250)  = null ,

	@CoursewareDifficulty int   = null ,

	@Description varchar (500)  = null ,

	@CoursewareOrder int   = null ,

	@CoursewareType int   = null ,

	@Status int   = null ,

	@CourseId varchar (20)  = null ,

	@ResourceType int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [CoursewareID]
	, [CoursewareName]
	, [CreateTime]
	, [CreateUserID]
	, [CoursewareFileName]
	, [CoursewareFilePath]
	, [CoursewareDifficulty]
	, [Description]
	, [CoursewareOrder]
	, [CoursewareType]
	, [Status]
	, [CourseID]
	, [ResourceType]
    FROM
	[dbo].[Coursewares]
    WHERE 
	 ([CoursewareID] = @CoursewareId OR @CoursewareId IS NULL)
	AND ([CoursewareName] = @CoursewareName OR @CoursewareName IS NULL)
	AND ([CreateTime] = @CreateTime OR @CreateTime IS NULL)
	AND ([CreateUserID] = @CreateUserId OR @CreateUserId IS NULL)
	AND ([CoursewareFileName] = @CoursewareFileName OR @CoursewareFileName IS NULL)
	AND ([CoursewareFilePath] = @CoursewareFilePath OR @CoursewareFilePath IS NULL)
	AND ([CoursewareDifficulty] = @CoursewareDifficulty OR @CoursewareDifficulty IS NULL)
	AND ([Description] = @Description OR @Description IS NULL)
	AND ([CoursewareOrder] = @CoursewareOrder OR @CoursewareOrder IS NULL)
	AND ([CoursewareType] = @CoursewareType OR @CoursewareType IS NULL)
	AND ([Status] = @Status OR @Status IS NULL)
	AND ([CourseID] = @CourseId OR @CourseId IS NULL)
	AND ([ResourceType] = @ResourceType OR @ResourceType IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [CoursewareID]
	, [CoursewareName]
	, [CreateTime]
	, [CreateUserID]
	, [CoursewareFileName]
	, [CoursewareFilePath]
	, [CoursewareDifficulty]
	, [Description]
	, [CoursewareOrder]
	, [CoursewareType]
	, [Status]
	, [CourseID]
	, [ResourceType]
    FROM
	[dbo].[Coursewares]
    WHERE 
	 ([CoursewareID] = @CoursewareId AND @CoursewareId is not null)
	OR ([CoursewareName] = @CoursewareName AND @CoursewareName is not null)
	OR ([CreateTime] = @CreateTime AND @CreateTime is not null)
	OR ([CreateUserID] = @CreateUserId AND @CreateUserId is not null)
	OR ([CoursewareFileName] = @CoursewareFileName AND @CoursewareFileName is not null)
	OR ([CoursewareFilePath] = @CoursewareFilePath AND @CoursewareFilePath is not null)
	OR ([CoursewareDifficulty] = @CoursewareDifficulty AND @CoursewareDifficulty is not null)
	OR ([Description] = @Description AND @Description is not null)
	OR ([CoursewareOrder] = @CoursewareOrder AND @CoursewareOrder is not null)
	OR ([CoursewareType] = @CoursewareType AND @CoursewareType is not null)
	OR ([Status] = @Status AND @Status is not null)
	OR ([CourseID] = @CourseId AND @CourseId is not null)
	OR ([ResourceType] = @ResourceType AND @ResourceType is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.DegreeApply_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DegreeApply_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.DegreeApply_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the DegreeApply table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.DegreeApply_Get_List

AS


				
				SELECT
					[DegreeApplyID],
					[InstituteID],
					[DegreeId],
					[ApplyUserID],
					[ApproveUserID],
					[ApplyDate],
					[ApproveDate],
					[StudentID],
					[Description],
					[status]
				FROM
					[dbo].[DegreeApply]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.DegreeApply_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DegreeApply_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.DegreeApply_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the DegreeApply table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.DegreeApply_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [DegreeApplyID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([DegreeApplyID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [DegreeApplyID]'
				SET @SQL = @SQL + ' FROM [dbo].[DegreeApply]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[DegreeApplyID], O.[InstituteID], O.[DegreeId], O.[ApplyUserID], O.[ApproveUserID], O.[ApplyDate], O.[ApproveDate], O.[StudentID], O.[Description], O.[status]
				FROM
				    [dbo].[DegreeApply] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[DegreeApplyID] = PageIndex.[DegreeApplyID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[DegreeApply]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.DegreeApply_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DegreeApply_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.DegreeApply_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the DegreeApply table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.DegreeApply_Insert
(

	@DegreeApplyId int    OUTPUT,

	@InstituteId varchar (20)  ,

	@DegreeId int   ,

	@ApplyUserId varchar (20)  ,

	@ApproveUserId varchar (20)  ,

	@ApplyDate datetime   ,

	@ApproveDate datetime   ,

	@StudentId int   ,

	@Description varchar (500)  ,

	@Status int   
)
AS


				
				INSERT INTO [dbo].[DegreeApply]
					(
					[InstituteID]
					,[DegreeId]
					,[ApplyUserID]
					,[ApproveUserID]
					,[ApplyDate]
					,[ApproveDate]
					,[StudentID]
					,[Description]
					,[status]
					)
				VALUES
					(
					@InstituteId
					,@DegreeId
					,@ApplyUserId
					,@ApproveUserId
					,@ApplyDate
					,@ApproveDate
					,@StudentId
					,@Description
					,@Status
					)
				
				-- Get the identity value
				SET @DegreeApplyId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.DegreeApply_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DegreeApply_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.DegreeApply_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the DegreeApply table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.DegreeApply_Update
(

	@DegreeApplyId int   ,

	@InstituteId varchar (20)  ,

	@DegreeId int   ,

	@ApplyUserId varchar (20)  ,

	@ApproveUserId varchar (20)  ,

	@ApplyDate datetime   ,

	@ApproveDate datetime   ,

	@StudentId int   ,

	@Description varchar (500)  ,

	@Status int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[DegreeApply]
				SET
					[InstituteID] = @InstituteId
					,[DegreeId] = @DegreeId
					,[ApplyUserID] = @ApplyUserId
					,[ApproveUserID] = @ApproveUserId
					,[ApplyDate] = @ApplyDate
					,[ApproveDate] = @ApproveDate
					,[StudentID] = @StudentId
					,[Description] = @Description
					,[status] = @Status
				WHERE
[DegreeApplyID] = @DegreeApplyId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.DegreeApply_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DegreeApply_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.DegreeApply_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the DegreeApply table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.DegreeApply_Delete
(

	@DegreeApplyId int   
)
AS


				DELETE FROM [dbo].[DegreeApply] WITH (ROWLOCK) 
				WHERE
					[DegreeApplyID] = @DegreeApplyId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.DegreeApply_GetByDegreeApplyId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DegreeApply_GetByDegreeApplyId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.DegreeApply_GetByDegreeApplyId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the DegreeApply table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.DegreeApply_GetByDegreeApplyId
(

	@DegreeApplyId int   
)
AS


				SELECT
					[DegreeApplyID],
					[InstituteID],
					[DegreeId],
					[ApplyUserID],
					[ApproveUserID],
					[ApplyDate],
					[ApproveDate],
					[StudentID],
					[Description],
					[status]
				FROM
					[dbo].[DegreeApply]
				WHERE
					[DegreeApplyID] = @DegreeApplyId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.DegreeApply_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.DegreeApply_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.DegreeApply_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the DegreeApply table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.DegreeApply_Find
(

	@SearchUsingOR bit   = null ,

	@DegreeApplyId int   = null ,

	@InstituteId varchar (20)  = null ,

	@DegreeId int   = null ,

	@ApplyUserId varchar (20)  = null ,

	@ApproveUserId varchar (20)  = null ,

	@ApplyDate datetime   = null ,

	@ApproveDate datetime   = null ,

	@StudentId int   = null ,

	@Description varchar (500)  = null ,

	@Status int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [DegreeApplyID]
	, [InstituteID]
	, [DegreeId]
	, [ApplyUserID]
	, [ApproveUserID]
	, [ApplyDate]
	, [ApproveDate]
	, [StudentID]
	, [Description]
	, [status]
    FROM
	[dbo].[DegreeApply]
    WHERE 
	 ([DegreeApplyID] = @DegreeApplyId OR @DegreeApplyId IS NULL)
	AND ([InstituteID] = @InstituteId OR @InstituteId IS NULL)
	AND ([DegreeId] = @DegreeId OR @DegreeId IS NULL)
	AND ([ApplyUserID] = @ApplyUserId OR @ApplyUserId IS NULL)
	AND ([ApproveUserID] = @ApproveUserId OR @ApproveUserId IS NULL)
	AND ([ApplyDate] = @ApplyDate OR @ApplyDate IS NULL)
	AND ([ApproveDate] = @ApproveDate OR @ApproveDate IS NULL)
	AND ([StudentID] = @StudentId OR @StudentId IS NULL)
	AND ([Description] = @Description OR @Description IS NULL)
	AND ([status] = @Status OR @Status IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [DegreeApplyID]
	, [InstituteID]
	, [DegreeId]
	, [ApplyUserID]
	, [ApproveUserID]
	, [ApplyDate]
	, [ApproveDate]
	, [StudentID]
	, [Description]
	, [status]
    FROM
	[dbo].[DegreeApply]
    WHERE 
	 ([DegreeApplyID] = @DegreeApplyId AND @DegreeApplyId is not null)
	OR ([InstituteID] = @InstituteId AND @InstituteId is not null)
	OR ([DegreeId] = @DegreeId AND @DegreeId is not null)
	OR ([ApplyUserID] = @ApplyUserId AND @ApplyUserId is not null)
	OR ([ApproveUserID] = @ApproveUserId AND @ApproveUserId is not null)
	OR ([ApplyDate] = @ApplyDate AND @ApplyDate is not null)
	OR ([ApproveDate] = @ApproveDate AND @ApproveDate is not null)
	OR ([StudentID] = @StudentId AND @StudentId is not null)
	OR ([Description] = @Description AND @Description is not null)
	OR ([status] = @Status AND @Status is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_catalog_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_catalog_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_catalog_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the evl_catalog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_catalog_Get_List

AS


				
				SELECT
					[c_id],
					[c_name],
					[pid],
					[model_id],
					[ScoreMin],
					[ScoreMax],
					[ScoreScopeTitle]
				FROM
					[dbo].[evl_catalog]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_catalog_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_catalog_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_catalog_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the evl_catalog table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_catalog_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [c_id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([c_id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [c_id]'
				SET @SQL = @SQL + ' FROM [dbo].[evl_catalog]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[c_id], O.[c_name], O.[pid], O.[model_id], O.[ScoreMin], O.[ScoreMax], O.[ScoreScopeTitle]
				FROM
				    [dbo].[evl_catalog] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[c_id] = PageIndex.[c_id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[evl_catalog]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_catalog_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_catalog_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_catalog_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the evl_catalog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_catalog_Insert
(

	@CId int    OUTPUT,

	@CName varchar (2000)  ,

	@Pid int   ,

	@ModelId int   ,

	@ScoreMin int   ,

	@ScoreMax int   ,

	@ScoreScopeTitle varchar (2000)  
)
AS


				
				INSERT INTO [dbo].[evl_catalog]
					(
					[c_name]
					,[pid]
					,[model_id]
					,[ScoreMin]
					,[ScoreMax]
					,[ScoreScopeTitle]
					)
				VALUES
					(
					@CName
					,@Pid
					,@ModelId
					,@ScoreMin
					,@ScoreMax
					,@ScoreScopeTitle
					)
				
				-- Get the identity value
				SET @CId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_catalog_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_catalog_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_catalog_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the evl_catalog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_catalog_Update
(

	@CId int   ,

	@CName varchar (2000)  ,

	@Pid int   ,

	@ModelId int   ,

	@ScoreMin int   ,

	@ScoreMax int   ,

	@ScoreScopeTitle varchar (2000)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[evl_catalog]
				SET
					[c_name] = @CName
					,[pid] = @Pid
					,[model_id] = @ModelId
					,[ScoreMin] = @ScoreMin
					,[ScoreMax] = @ScoreMax
					,[ScoreScopeTitle] = @ScoreScopeTitle
				WHERE
[c_id] = @CId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_catalog_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_catalog_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_catalog_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the evl_catalog table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_catalog_Delete
(

	@CId int   
)
AS


				DELETE FROM [dbo].[evl_catalog] WITH (ROWLOCK) 
				WHERE
					[c_id] = @CId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_catalog_GetByCId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_catalog_GetByCId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_catalog_GetByCId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the evl_catalog table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_catalog_GetByCId
(

	@CId int   
)
AS


				SELECT
					[c_id],
					[c_name],
					[pid],
					[model_id],
					[ScoreMin],
					[ScoreMax],
					[ScoreScopeTitle]
				FROM
					[dbo].[evl_catalog]
				WHERE
					[c_id] = @CId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_catalog_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_catalog_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_catalog_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the evl_catalog table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_catalog_Find
(

	@SearchUsingOR bit   = null ,

	@CId int   = null ,

	@CName varchar (2000)  = null ,

	@Pid int   = null ,

	@ModelId int   = null ,

	@ScoreMin int   = null ,

	@ScoreMax int   = null ,

	@ScoreScopeTitle varchar (2000)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [c_id]
	, [c_name]
	, [pid]
	, [model_id]
	, [ScoreMin]
	, [ScoreMax]
	, [ScoreScopeTitle]
    FROM
	[dbo].[evl_catalog]
    WHERE 
	 ([c_id] = @CId OR @CId IS NULL)
	AND ([c_name] = @CName OR @CName IS NULL)
	AND ([pid] = @Pid OR @Pid IS NULL)
	AND ([model_id] = @ModelId OR @ModelId IS NULL)
	AND ([ScoreMin] = @ScoreMin OR @ScoreMin IS NULL)
	AND ([ScoreMax] = @ScoreMax OR @ScoreMax IS NULL)
	AND ([ScoreScopeTitle] = @ScoreScopeTitle OR @ScoreScopeTitle IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [c_id]
	, [c_name]
	, [pid]
	, [model_id]
	, [ScoreMin]
	, [ScoreMax]
	, [ScoreScopeTitle]
    FROM
	[dbo].[evl_catalog]
    WHERE 
	 ([c_id] = @CId AND @CId is not null)
	OR ([c_name] = @CName AND @CName is not null)
	OR ([pid] = @Pid AND @Pid is not null)
	OR ([model_id] = @ModelId AND @ModelId is not null)
	OR ([ScoreMin] = @ScoreMin AND @ScoreMin is not null)
	OR ([ScoreMax] = @ScoreMax AND @ScoreMax is not null)
	OR ([ScoreScopeTitle] = @ScoreScopeTitle AND @ScoreScopeTitle is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_competencyScoreDept_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_competencyScoreDept_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_competencyScoreDept_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the evl_competencyScoreDept table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_competencyScoreDept_Get_List

AS


				
				SELECT
					[id],
					[competencyid],
					[scorestart],
					[scoreend],
					[dept]
				FROM
					[dbo].[evl_competencyScoreDept]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_competencyScoreDept_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_competencyScoreDept_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_competencyScoreDept_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the evl_competencyScoreDept table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_competencyScoreDept_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [id]'
				SET @SQL = @SQL + ' FROM [dbo].[evl_competencyScoreDept]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[id], O.[competencyid], O.[scorestart], O.[scoreend], O.[dept]
				FROM
				    [dbo].[evl_competencyScoreDept] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[id] = PageIndex.[id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[evl_competencyScoreDept]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_competencyScoreDept_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_competencyScoreDept_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_competencyScoreDept_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the evl_competencyScoreDept table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_competencyScoreDept_Insert
(

	@Id int    OUTPUT,

	@Competencyid int   ,

	@Scorestart int   ,

	@Scoreend int   ,

	@Dept varchar (1000)  
)
AS


				
				INSERT INTO [dbo].[evl_competencyScoreDept]
					(
					[competencyid]
					,[scorestart]
					,[scoreend]
					,[dept]
					)
				VALUES
					(
					@Competencyid
					,@Scorestart
					,@Scoreend
					,@Dept
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_competencyScoreDept_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_competencyScoreDept_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_competencyScoreDept_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the evl_competencyScoreDept table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_competencyScoreDept_Update
(

	@Id int   ,

	@Competencyid int   ,

	@Scorestart int   ,

	@Scoreend int   ,

	@Dept varchar (1000)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[evl_competencyScoreDept]
				SET
					[competencyid] = @Competencyid
					,[scorestart] = @Scorestart
					,[scoreend] = @Scoreend
					,[dept] = @Dept
				WHERE
[id] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_competencyScoreDept_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_competencyScoreDept_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_competencyScoreDept_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the evl_competencyScoreDept table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_competencyScoreDept_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[evl_competencyScoreDept] WITH (ROWLOCK) 
				WHERE
					[id] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_competencyScoreDept_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_competencyScoreDept_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_competencyScoreDept_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the evl_competencyScoreDept table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_competencyScoreDept_GetById
(

	@Id int   
)
AS


				SELECT
					[id],
					[competencyid],
					[scorestart],
					[scoreend],
					[dept]
				FROM
					[dbo].[evl_competencyScoreDept]
				WHERE
					[id] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_competencyScoreDept_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_competencyScoreDept_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_competencyScoreDept_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the evl_competencyScoreDept table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_competencyScoreDept_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@Competencyid int   = null ,

	@Scorestart int   = null ,

	@Scoreend int   = null ,

	@Dept varchar (1000)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [id]
	, [competencyid]
	, [scorestart]
	, [scoreend]
	, [dept]
    FROM
	[dbo].[evl_competencyScoreDept]
    WHERE 
	 ([id] = @Id OR @Id IS NULL)
	AND ([competencyid] = @Competencyid OR @Competencyid IS NULL)
	AND ([scorestart] = @Scorestart OR @Scorestart IS NULL)
	AND ([scoreend] = @Scoreend OR @Scoreend IS NULL)
	AND ([dept] = @Dept OR @Dept IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [id]
	, [competencyid]
	, [scorestart]
	, [scoreend]
	, [dept]
    FROM
	[dbo].[evl_competencyScoreDept]
    WHERE 
	 ([id] = @Id AND @Id is not null)
	OR ([competencyid] = @Competencyid AND @Competencyid is not null)
	OR ([scorestart] = @Scorestart AND @Scorestart is not null)
	OR ([scoreend] = @Scoreend AND @Scoreend is not null)
	OR ([dept] = @Dept AND @Dept is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Groups_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Groups_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Groups_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the Groups table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Groups_Get_List

AS


				
				SELECT
					[GroupID],
					[GroupName],
					[Description],
					[Status],
					[LeaderUserID],
					[CreateTime],
					[CreateUserID]
				FROM
					[dbo].[Groups]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Groups_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Groups_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Groups_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the Groups table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Groups_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [GroupID] varchar(20) COLLATE database_default  
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([GroupID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [GroupID]'
				SET @SQL = @SQL + ' FROM [dbo].[Groups]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[GroupID], O.[GroupName], O.[Description], O.[Status], O.[LeaderUserID], O.[CreateTime], O.[CreateUserID]
				FROM
				    [dbo].[Groups] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[GroupID] = PageIndex.[GroupID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[Groups]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Groups_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Groups_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Groups_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the Groups table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Groups_Insert
(

	@GroupId varchar (20)  ,

	@GroupName varchar (50)  ,

	@Description varchar (500)  ,

	@Status int   ,

	@LeaderUserId varchar (20)  ,

	@CreateTime datetime   ,

	@CreateUserId varchar (20)  
)
AS


				
				INSERT INTO [dbo].[Groups]
					(
					[GroupID]
					,[GroupName]
					,[Description]
					,[Status]
					,[LeaderUserID]
					,[CreateTime]
					,[CreateUserID]
					)
				VALUES
					(
					@GroupId
					,@GroupName
					,@Description
					,@Status
					,@LeaderUserId
					,@CreateTime
					,@CreateUserId
					)
				
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Groups_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Groups_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Groups_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the Groups table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Groups_Update
(

	@GroupId varchar (20)  ,

	@OriginalGroupId varchar (20)  ,

	@GroupName varchar (50)  ,

	@Description varchar (500)  ,

	@Status int   ,

	@LeaderUserId varchar (20)  ,

	@CreateTime datetime   ,

	@CreateUserId varchar (20)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[Groups]
				SET
					[GroupID] = @GroupId
					,[GroupName] = @GroupName
					,[Description] = @Description
					,[Status] = @Status
					,[LeaderUserID] = @LeaderUserId
					,[CreateTime] = @CreateTime
					,[CreateUserID] = @CreateUserId
				WHERE
[GroupID] = @OriginalGroupId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Groups_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Groups_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Groups_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the Groups table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Groups_Delete
(

	@GroupId varchar (20)  
)
AS


				DELETE FROM [dbo].[Groups] WITH (ROWLOCK) 
				WHERE
					[GroupID] = @GroupId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Groups_GetByGroupId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Groups_GetByGroupId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Groups_GetByGroupId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the Groups table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Groups_GetByGroupId
(

	@GroupId varchar (20)  
)
AS


				SELECT
					[GroupID],
					[GroupName],
					[Description],
					[Status],
					[LeaderUserID],
					[CreateTime],
					[CreateUserID]
				FROM
					[dbo].[Groups]
				WHERE
					[GroupID] = @GroupId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Groups_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Groups_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Groups_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the Groups table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Groups_Find
(

	@SearchUsingOR bit   = null ,

	@GroupId varchar (20)  = null ,

	@GroupName varchar (50)  = null ,

	@Description varchar (500)  = null ,

	@Status int   = null ,

	@LeaderUserId varchar (20)  = null ,

	@CreateTime datetime   = null ,

	@CreateUserId varchar (20)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [GroupID]
	, [GroupName]
	, [Description]
	, [Status]
	, [LeaderUserID]
	, [CreateTime]
	, [CreateUserID]
    FROM
	[dbo].[Groups]
    WHERE 
	 ([GroupID] = @GroupId OR @GroupId IS NULL)
	AND ([GroupName] = @GroupName OR @GroupName IS NULL)
	AND ([Description] = @Description OR @Description IS NULL)
	AND ([Status] = @Status OR @Status IS NULL)
	AND ([LeaderUserID] = @LeaderUserId OR @LeaderUserId IS NULL)
	AND ([CreateTime] = @CreateTime OR @CreateTime IS NULL)
	AND ([CreateUserID] = @CreateUserId OR @CreateUserId IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [GroupID]
	, [GroupName]
	, [Description]
	, [Status]
	, [LeaderUserID]
	, [CreateTime]
	, [CreateUserID]
    FROM
	[dbo].[Groups]
    WHERE 
	 ([GroupID] = @GroupId AND @GroupId is not null)
	OR ([GroupName] = @GroupName AND @GroupName is not null)
	OR ([Description] = @Description AND @Description is not null)
	OR ([Status] = @Status AND @Status is not null)
	OR ([LeaderUserID] = @LeaderUserId AND @LeaderUserId is not null)
	OR ([CreateTime] = @CreateTime AND @CreateTime is not null)
	OR ([CreateUserID] = @CreateUserId AND @CreateUserId is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Institutes_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Institutes_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Institutes_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the Institutes table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Institutes_Get_List

AS


				
				SELECT
					[InstituteID],
					[InstituteName],
					[Description],
					[InstituteDean],
					[Createtime],
					[CreateUserID],
					[Status]
				FROM
					[dbo].[Institutes]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Institutes_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Institutes_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Institutes_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the Institutes table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Institutes_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [InstituteID] varchar(20) COLLATE database_default  
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([InstituteID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [InstituteID]'
				SET @SQL = @SQL + ' FROM [dbo].[Institutes]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[InstituteID], O.[InstituteName], O.[Description], O.[InstituteDean], O.[Createtime], O.[CreateUserID], O.[Status]
				FROM
				    [dbo].[Institutes] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[InstituteID] = PageIndex.[InstituteID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[Institutes]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Institutes_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Institutes_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Institutes_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the Institutes table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Institutes_Insert
(

	@InstituteId varchar (20)  ,

	@InstituteName varchar (150)  ,

	@Description varchar (500)  ,

	@InstituteDean varchar (20)  ,

	@Createtime datetime   ,

	@CreateUserId varchar (20)  ,

	@Status int   
)
AS


				
				INSERT INTO [dbo].[Institutes]
					(
					[InstituteID]
					,[InstituteName]
					,[Description]
					,[InstituteDean]
					,[Createtime]
					,[CreateUserID]
					,[Status]
					)
				VALUES
					(
					@InstituteId
					,@InstituteName
					,@Description
					,@InstituteDean
					,@Createtime
					,@CreateUserId
					,@Status
					)
				
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Institutes_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Institutes_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Institutes_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the Institutes table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Institutes_Update
(

	@InstituteId varchar (20)  ,

	@OriginalInstituteId varchar (20)  ,

	@InstituteName varchar (150)  ,

	@Description varchar (500)  ,

	@InstituteDean varchar (20)  ,

	@Createtime datetime   ,

	@CreateUserId varchar (20)  ,

	@Status int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[Institutes]
				SET
					[InstituteID] = @InstituteId
					,[InstituteName] = @InstituteName
					,[Description] = @Description
					,[InstituteDean] = @InstituteDean
					,[Createtime] = @Createtime
					,[CreateUserID] = @CreateUserId
					,[Status] = @Status
				WHERE
[InstituteID] = @OriginalInstituteId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Institutes_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Institutes_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Institutes_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the Institutes table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Institutes_Delete
(

	@InstituteId varchar (20)  
)
AS


				DELETE FROM [dbo].[Institutes] WITH (ROWLOCK) 
				WHERE
					[InstituteID] = @InstituteId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Institutes_GetByInstituteId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Institutes_GetByInstituteId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Institutes_GetByInstituteId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the Institutes table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Institutes_GetByInstituteId
(

	@InstituteId varchar (20)  
)
AS


				SELECT
					[InstituteID],
					[InstituteName],
					[Description],
					[InstituteDean],
					[Createtime],
					[CreateUserID],
					[Status]
				FROM
					[dbo].[Institutes]
				WHERE
					[InstituteID] = @InstituteId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.Institutes_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.Institutes_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.Institutes_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the Institutes table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.Institutes_Find
(

	@SearchUsingOR bit   = null ,

	@InstituteId varchar (20)  = null ,

	@InstituteName varchar (150)  = null ,

	@Description varchar (500)  = null ,

	@InstituteDean varchar (20)  = null ,

	@Createtime datetime   = null ,

	@CreateUserId varchar (20)  = null ,

	@Status int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [InstituteID]
	, [InstituteName]
	, [Description]
	, [InstituteDean]
	, [Createtime]
	, [CreateUserID]
	, [Status]
    FROM
	[dbo].[Institutes]
    WHERE 
	 ([InstituteID] = @InstituteId OR @InstituteId IS NULL)
	AND ([InstituteName] = @InstituteName OR @InstituteName IS NULL)
	AND ([Description] = @Description OR @Description IS NULL)
	AND ([InstituteDean] = @InstituteDean OR @InstituteDean IS NULL)
	AND ([Createtime] = @Createtime OR @Createtime IS NULL)
	AND ([CreateUserID] = @CreateUserId OR @CreateUserId IS NULL)
	AND ([Status] = @Status OR @Status IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [InstituteID]
	, [InstituteName]
	, [Description]
	, [InstituteDean]
	, [Createtime]
	, [CreateUserID]
	, [Status]
    FROM
	[dbo].[Institutes]
    WHERE 
	 ([InstituteID] = @InstituteId AND @InstituteId is not null)
	OR ([InstituteName] = @InstituteName AND @InstituteName is not null)
	OR ([Description] = @Description AND @Description is not null)
	OR ([InstituteDean] = @InstituteDean AND @InstituteDean is not null)
	OR ([Createtime] = @Createtime AND @Createtime is not null)
	OR ([CreateUserID] = @CreateUserId AND @CreateUserId is not null)
	OR ([Status] = @Status AND @Status is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LearningRecordCsv_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LearningRecordCsv_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LearningRecordCsv_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the LearningRecordCsv table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LearningRecordCsv_Get_List

AS


				
				SELECT
					[CourseName],
					[Description],
					[SSO],
					[UserName],
					[CompletedDate],
					[Status],
					[courseid],
					[ID],
					[CreatedDate]
				FROM
					[dbo].[LearningRecordCsv]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LearningRecordCsv_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LearningRecordCsv_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LearningRecordCsv_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the LearningRecordCsv table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LearningRecordCsv_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [ID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([ID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [ID]'
				SET @SQL = @SQL + ' FROM [dbo].[LearningRecordCsv]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[CourseName], O.[Description], O.[SSO], O.[UserName], O.[CompletedDate], O.[Status], O.[courseid], O.[ID], O.[CreatedDate]
				FROM
				    [dbo].[LearningRecordCsv] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[ID] = PageIndex.[ID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[LearningRecordCsv]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LearningRecordCsv_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LearningRecordCsv_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LearningRecordCsv_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the LearningRecordCsv table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LearningRecordCsv_Insert
(

	@CourseName varchar (255)  ,

	@Description varchar (255)  ,

	@Sso varchar (20)  ,

	@UserName varchar (255)  ,

	@CompletedDate varchar (255)  ,

	@Status varchar (255)  ,

	@Courseid varchar (50)  ,

	@Id int    OUTPUT,

	@CreatedDate datetime   
)
AS


				
				INSERT INTO [dbo].[LearningRecordCsv]
					(
					[CourseName]
					,[Description]
					,[SSO]
					,[UserName]
					,[CompletedDate]
					,[Status]
					,[courseid]
					,[CreatedDate]
					)
				VALUES
					(
					@CourseName
					,@Description
					,@Sso
					,@UserName
					,@CompletedDate
					,@Status
					,@Courseid
					,@CreatedDate
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LearningRecordCsv_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LearningRecordCsv_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LearningRecordCsv_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the LearningRecordCsv table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LearningRecordCsv_Update
(

	@CourseName varchar (255)  ,

	@Description varchar (255)  ,

	@Sso varchar (20)  ,

	@UserName varchar (255)  ,

	@CompletedDate varchar (255)  ,

	@Status varchar (255)  ,

	@Courseid varchar (50)  ,

	@Id int   ,

	@CreatedDate datetime   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[LearningRecordCsv]
				SET
					[CourseName] = @CourseName
					,[Description] = @Description
					,[SSO] = @Sso
					,[UserName] = @UserName
					,[CompletedDate] = @CompletedDate
					,[Status] = @Status
					,[courseid] = @Courseid
					,[CreatedDate] = @CreatedDate
				WHERE
[ID] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LearningRecordCsv_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LearningRecordCsv_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LearningRecordCsv_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the LearningRecordCsv table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LearningRecordCsv_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[LearningRecordCsv] WITH (ROWLOCK) 
				WHERE
					[ID] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LearningRecordCsv_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LearningRecordCsv_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LearningRecordCsv_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the LearningRecordCsv table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LearningRecordCsv_GetById
(

	@Id int   
)
AS


				SELECT
					[CourseName],
					[Description],
					[SSO],
					[UserName],
					[CompletedDate],
					[Status],
					[courseid],
					[ID],
					[CreatedDate]
				FROM
					[dbo].[LearningRecordCsv]
				WHERE
					[ID] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LearningRecordCsv_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LearningRecordCsv_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LearningRecordCsv_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the LearningRecordCsv table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LearningRecordCsv_Find
(

	@SearchUsingOR bit   = null ,

	@CourseName varchar (255)  = null ,

	@Description varchar (255)  = null ,

	@Sso varchar (20)  = null ,

	@UserName varchar (255)  = null ,

	@CompletedDate varchar (255)  = null ,

	@Status varchar (255)  = null ,

	@Courseid varchar (50)  = null ,

	@Id int   = null ,

	@CreatedDate datetime   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [CourseName]
	, [Description]
	, [SSO]
	, [UserName]
	, [CompletedDate]
	, [Status]
	, [courseid]
	, [ID]
	, [CreatedDate]
    FROM
	[dbo].[LearningRecordCsv]
    WHERE 
	 ([CourseName] = @CourseName OR @CourseName IS NULL)
	AND ([Description] = @Description OR @Description IS NULL)
	AND ([SSO] = @Sso OR @Sso IS NULL)
	AND ([UserName] = @UserName OR @UserName IS NULL)
	AND ([CompletedDate] = @CompletedDate OR @CompletedDate IS NULL)
	AND ([Status] = @Status OR @Status IS NULL)
	AND ([courseid] = @Courseid OR @Courseid IS NULL)
	AND ([ID] = @Id OR @Id IS NULL)
	AND ([CreatedDate] = @CreatedDate OR @CreatedDate IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [CourseName]
	, [Description]
	, [SSO]
	, [UserName]
	, [CompletedDate]
	, [Status]
	, [courseid]
	, [ID]
	, [CreatedDate]
    FROM
	[dbo].[LearningRecordCsv]
    WHERE 
	 ([CourseName] = @CourseName AND @CourseName is not null)
	OR ([Description] = @Description AND @Description is not null)
	OR ([SSO] = @Sso AND @Sso is not null)
	OR ([UserName] = @UserName AND @UserName is not null)
	OR ([CompletedDate] = @CompletedDate AND @CompletedDate is not null)
	OR ([Status] = @Status AND @Status is not null)
	OR ([courseid] = @Courseid AND @Courseid is not null)
	OR ([ID] = @Id AND @Id is not null)
	OR ([CreatedDate] = @CreatedDate AND @CreatedDate is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LearningRecordExcel_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LearningRecordExcel_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LearningRecordExcel_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the LearningRecordExcel table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LearningRecordExcel_Get_List

AS


				
				SELECT
					[CourseName],
					[SSO],
					[UserName],
					[Function],
					[StartDate],
					[CompletedDate],
					[Location],
					[Trainer],
					[courseid],
					[ID],
					[CreatedDate]
				FROM
					[dbo].[LearningRecordExcel]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LearningRecordExcel_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LearningRecordExcel_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LearningRecordExcel_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the LearningRecordExcel table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LearningRecordExcel_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [ID] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([ID])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [ID]'
				SET @SQL = @SQL + ' FROM [dbo].[LearningRecordExcel]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[CourseName], O.[SSO], O.[UserName], O.[Function], O.[StartDate], O.[CompletedDate], O.[Location], O.[Trainer], O.[courseid], O.[ID], O.[CreatedDate]
				FROM
				    [dbo].[LearningRecordExcel] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[ID] = PageIndex.[ID]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[LearningRecordExcel]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LearningRecordExcel_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LearningRecordExcel_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LearningRecordExcel_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the LearningRecordExcel table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LearningRecordExcel_Insert
(

	@CourseName nvarchar (255)  ,

	@Sso varchar (20)  ,

	@UserName nvarchar (255)  ,

	@Function nvarchar (255)  ,

	@StartDate smalldatetime   ,

	@CompletedDate smalldatetime   ,

	@Location nvarchar (255)  ,

	@Trainer nvarchar (255)  ,

	@Courseid varchar (50)  ,

	@Id int    OUTPUT,

	@CreatedDate datetime   
)
AS


				
				INSERT INTO [dbo].[LearningRecordExcel]
					(
					[CourseName]
					,[SSO]
					,[UserName]
					,[Function]
					,[StartDate]
					,[CompletedDate]
					,[Location]
					,[Trainer]
					,[courseid]
					,[CreatedDate]
					)
				VALUES
					(
					@CourseName
					,@Sso
					,@UserName
					,@Function
					,@StartDate
					,@CompletedDate
					,@Location
					,@Trainer
					,@Courseid
					,@CreatedDate
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LearningRecordExcel_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LearningRecordExcel_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LearningRecordExcel_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the LearningRecordExcel table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LearningRecordExcel_Update
(

	@CourseName nvarchar (255)  ,

	@Sso varchar (20)  ,

	@UserName nvarchar (255)  ,

	@Function nvarchar (255)  ,

	@StartDate smalldatetime   ,

	@CompletedDate smalldatetime   ,

	@Location nvarchar (255)  ,

	@Trainer nvarchar (255)  ,

	@Courseid varchar (50)  ,

	@Id int   ,

	@CreatedDate datetime   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[LearningRecordExcel]
				SET
					[CourseName] = @CourseName
					,[SSO] = @Sso
					,[UserName] = @UserName
					,[Function] = @Function
					,[StartDate] = @StartDate
					,[CompletedDate] = @CompletedDate
					,[Location] = @Location
					,[Trainer] = @Trainer
					,[courseid] = @Courseid
					,[CreatedDate] = @CreatedDate
				WHERE
[ID] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LearningRecordExcel_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LearningRecordExcel_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LearningRecordExcel_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the LearningRecordExcel table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LearningRecordExcel_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[LearningRecordExcel] WITH (ROWLOCK) 
				WHERE
					[ID] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LearningRecordExcel_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LearningRecordExcel_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LearningRecordExcel_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the LearningRecordExcel table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LearningRecordExcel_GetById
(

	@Id int   
)
AS


				SELECT
					[CourseName],
					[SSO],
					[UserName],
					[Function],
					[StartDate],
					[CompletedDate],
					[Location],
					[Trainer],
					[courseid],
					[ID],
					[CreatedDate]
				FROM
					[dbo].[LearningRecordExcel]
				WHERE
					[ID] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.LearningRecordExcel_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.LearningRecordExcel_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.LearningRecordExcel_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the LearningRecordExcel table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.LearningRecordExcel_Find
(

	@SearchUsingOR bit   = null ,

	@CourseName nvarchar (255)  = null ,

	@Sso varchar (20)  = null ,

	@UserName nvarchar (255)  = null ,

	@Function nvarchar (255)  = null ,

	@StartDate smalldatetime   = null ,

	@CompletedDate smalldatetime   = null ,

	@Location nvarchar (255)  = null ,

	@Trainer nvarchar (255)  = null ,

	@Courseid varchar (50)  = null ,

	@Id int   = null ,

	@CreatedDate datetime   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [CourseName]
	, [SSO]
	, [UserName]
	, [Function]
	, [StartDate]
	, [CompletedDate]
	, [Location]
	, [Trainer]
	, [courseid]
	, [ID]
	, [CreatedDate]
    FROM
	[dbo].[LearningRecordExcel]
    WHERE 
	 ([CourseName] = @CourseName OR @CourseName IS NULL)
	AND ([SSO] = @Sso OR @Sso IS NULL)
	AND ([UserName] = @UserName OR @UserName IS NULL)
	AND ([Function] = @Function OR @Function IS NULL)
	AND ([StartDate] = @StartDate OR @StartDate IS NULL)
	AND ([CompletedDate] = @CompletedDate OR @CompletedDate IS NULL)
	AND ([Location] = @Location OR @Location IS NULL)
	AND ([Trainer] = @Trainer OR @Trainer IS NULL)
	AND ([courseid] = @Courseid OR @Courseid IS NULL)
	AND ([ID] = @Id OR @Id IS NULL)
	AND ([CreatedDate] = @CreatedDate OR @CreatedDate IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [CourseName]
	, [SSO]
	, [UserName]
	, [Function]
	, [StartDate]
	, [CompletedDate]
	, [Location]
	, [Trainer]
	, [courseid]
	, [ID]
	, [CreatedDate]
    FROM
	[dbo].[LearningRecordExcel]
    WHERE 
	 ([CourseName] = @CourseName AND @CourseName is not null)
	OR ([SSO] = @Sso AND @Sso is not null)
	OR ([UserName] = @UserName AND @UserName is not null)
	OR ([Function] = @Function AND @Function is not null)
	OR ([StartDate] = @StartDate AND @StartDate is not null)
	OR ([CompletedDate] = @CompletedDate AND @CompletedDate is not null)
	OR ([Location] = @Location AND @Location is not null)
	OR ([Trainer] = @Trainer AND @Trainer is not null)
	OR ([courseid] = @Courseid AND @Courseid is not null)
	OR ([ID] = @Id AND @Id is not null)
	OR ([CreatedDate] = @CreatedDate AND @CreatedDate is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_usertype_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_usertype_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_usertype_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the evl_usertype table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_usertype_Get_List

AS


				
				SELECT
					[id],
					[UserType]
				FROM
					[dbo].[evl_usertype]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_usertype_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_usertype_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_usertype_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the evl_usertype table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_usertype_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [id]'
				SET @SQL = @SQL + ' FROM [dbo].[evl_usertype]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[id], O.[UserType]
				FROM
				    [dbo].[evl_usertype] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[id] = PageIndex.[id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[evl_usertype]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_usertype_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_usertype_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_usertype_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the evl_usertype table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_usertype_Insert
(

	@Id int   ,

	@UserType varchar (50)  
)
AS


				
				INSERT INTO [dbo].[evl_usertype]
					(
					[id]
					,[UserType]
					)
				VALUES
					(
					@Id
					,@UserType
					)
				
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_usertype_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_usertype_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_usertype_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the evl_usertype table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_usertype_Update
(

	@Id int   ,

	@OriginalId int   ,

	@UserType varchar (50)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[evl_usertype]
				SET
					[id] = @Id
					,[UserType] = @UserType
				WHERE
[id] = @OriginalId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_usertype_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_usertype_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_usertype_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the evl_usertype table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_usertype_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[evl_usertype] WITH (ROWLOCK) 
				WHERE
					[id] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_usertype_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_usertype_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_usertype_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the evl_usertype table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_usertype_GetById
(

	@Id int   
)
AS


				SELECT
					[id],
					[UserType]
				FROM
					[dbo].[evl_usertype]
				WHERE
					[id] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_usertype_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_usertype_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_usertype_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the evl_usertype table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_usertype_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@UserType varchar (50)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [id]
	, [UserType]
    FROM
	[dbo].[evl_usertype]
    WHERE 
	 ([id] = @Id OR @Id IS NULL)
	AND ([UserType] = @UserType OR @UserType IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [id]
	, [UserType]
    FROM
	[dbo].[evl_usertype]
    WHERE 
	 ([id] = @Id AND @Id is not null)
	OR ([UserType] = @UserType AND @UserType is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_user_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_user_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_user_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the evl_user table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_user_Get_List

AS


				
				SELECT
					[id],
					[userid],
					[model_id]
				FROM
					[dbo].[evl_user]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_user_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_user_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_user_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the evl_user table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_user_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [id]'
				SET @SQL = @SQL + ' FROM [dbo].[evl_user]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[id], O.[userid], O.[model_id]
				FROM
				    [dbo].[evl_user] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[id] = PageIndex.[id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[evl_user]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_user_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_user_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_user_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the evl_user table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_user_Insert
(

	@Id int    OUTPUT,

	@Userid varchar (50)  ,

	@ModelId int   
)
AS


				
				INSERT INTO [dbo].[evl_user]
					(
					[userid]
					,[model_id]
					)
				VALUES
					(
					@Userid
					,@ModelId
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_user_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_user_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_user_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the evl_user table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_user_Update
(

	@Id int   ,

	@Userid varchar (50)  ,

	@ModelId int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[evl_user]
				SET
					[userid] = @Userid
					,[model_id] = @ModelId
				WHERE
[id] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_user_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_user_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_user_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the evl_user table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_user_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[evl_user] WITH (ROWLOCK) 
				WHERE
					[id] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_user_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_user_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_user_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the evl_user table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_user_GetById
(

	@Id int   
)
AS


				SELECT
					[id],
					[userid],
					[model_id]
				FROM
					[dbo].[evl_user]
				WHERE
					[id] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_user_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_user_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_user_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the evl_user table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_user_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@Userid varchar (50)  = null ,

	@ModelId int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [id]
	, [userid]
	, [model_id]
    FROM
	[dbo].[evl_user]
    WHERE 
	 ([id] = @Id OR @Id IS NULL)
	AND ([userid] = @Userid OR @Userid IS NULL)
	AND ([model_id] = @ModelId OR @ModelId IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [id]
	, [userid]
	, [model_id]
    FROM
	[dbo].[evl_user]
    WHERE 
	 ([id] = @Id AND @Id is not null)
	OR ([userid] = @Userid AND @Userid is not null)
	OR ([model_id] = @ModelId AND @ModelId is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_guestevl_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_guestevl_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_guestevl_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the evl_guestevl table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_guestevl_Get_List

AS


				
				SELECT
					[id],
					[model_id],
					[assm_id],
					[email],
					[beEvaluationUserID],
					[link]
				FROM
					[dbo].[evl_guestevl]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_guestevl_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_guestevl_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_guestevl_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the evl_guestevl table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_guestevl_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [id]'
				SET @SQL = @SQL + ' FROM [dbo].[evl_guestevl]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[id], O.[model_id], O.[assm_id], O.[email], O.[beEvaluationUserID], O.[link]
				FROM
				    [dbo].[evl_guestevl] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[id] = PageIndex.[id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[evl_guestevl]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_guestevl_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_guestevl_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_guestevl_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the evl_guestevl table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_guestevl_Insert
(

	@Id int    OUTPUT,

	@ModelId int   ,

	@AssmId int   ,

	@Email varchar (50)  ,

	@BeEvaluationUserId varchar (50)  ,

	@Link varchar (50)  
)
AS


				
				INSERT INTO [dbo].[evl_guestevl]
					(
					[model_id]
					,[assm_id]
					,[email]
					,[beEvaluationUserID]
					,[link]
					)
				VALUES
					(
					@ModelId
					,@AssmId
					,@Email
					,@BeEvaluationUserId
					,@Link
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_guestevl_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_guestevl_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_guestevl_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the evl_guestevl table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_guestevl_Update
(

	@Id int   ,

	@ModelId int   ,

	@AssmId int   ,

	@Email varchar (50)  ,

	@BeEvaluationUserId varchar (50)  ,

	@Link varchar (50)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[evl_guestevl]
				SET
					[model_id] = @ModelId
					,[assm_id] = @AssmId
					,[email] = @Email
					,[beEvaluationUserID] = @BeEvaluationUserId
					,[link] = @Link
				WHERE
[id] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_guestevl_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_guestevl_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_guestevl_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the evl_guestevl table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_guestevl_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[evl_guestevl] WITH (ROWLOCK) 
				WHERE
					[id] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_guestevl_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_guestevl_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_guestevl_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the evl_guestevl table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_guestevl_GetById
(

	@Id int   
)
AS


				SELECT
					[id],
					[model_id],
					[assm_id],
					[email],
					[beEvaluationUserID],
					[link]
				FROM
					[dbo].[evl_guestevl]
				WHERE
					[id] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_guestevl_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_guestevl_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_guestevl_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the evl_guestevl table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_guestevl_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@ModelId int   = null ,

	@AssmId int   = null ,

	@Email varchar (50)  = null ,

	@BeEvaluationUserId varchar (50)  = null ,

	@Link varchar (50)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [id]
	, [model_id]
	, [assm_id]
	, [email]
	, [beEvaluationUserID]
	, [link]
    FROM
	[dbo].[evl_guestevl]
    WHERE 
	 ([id] = @Id OR @Id IS NULL)
	AND ([model_id] = @ModelId OR @ModelId IS NULL)
	AND ([assm_id] = @AssmId OR @AssmId IS NULL)
	AND ([email] = @Email OR @Email IS NULL)
	AND ([beEvaluationUserID] = @BeEvaluationUserId OR @BeEvaluationUserId IS NULL)
	AND ([link] = @Link OR @Link IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [id]
	, [model_id]
	, [assm_id]
	, [email]
	, [beEvaluationUserID]
	, [link]
    FROM
	[dbo].[evl_guestevl]
    WHERE 
	 ([id] = @Id AND @Id is not null)
	OR ([model_id] = @ModelId AND @ModelId is not null)
	OR ([assm_id] = @AssmId AND @AssmId is not null)
	OR ([email] = @Email AND @Email is not null)
	OR ([beEvaluationUserID] = @BeEvaluationUserId AND @BeEvaluationUserId is not null)
	OR ([link] = @Link AND @Link is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_model_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_model_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_model_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the evl_model table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_model_Get_List

AS


				
				SELECT
					[model_id],
					[name],
					[validdateStart],
					[validdateend],
					[evltimes],
					[isused]
				FROM
					[dbo].[evl_model]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_model_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_model_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_model_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the evl_model table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_model_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [model_id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([model_id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [model_id]'
				SET @SQL = @SQL + ' FROM [dbo].[evl_model]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[model_id], O.[name], O.[validdateStart], O.[validdateend], O.[evltimes], O.[isused]
				FROM
				    [dbo].[evl_model] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[model_id] = PageIndex.[model_id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[evl_model]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_model_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_model_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_model_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the evl_model table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_model_Insert
(

	@ModelId int    OUTPUT,

	@Name varchar (50)  ,

	@ValiddateStart datetime   ,

	@Validdateend datetime   ,

	@Evltimes int   ,

	@Isused int   
)
AS


				
				INSERT INTO [dbo].[evl_model]
					(
					[name]
					,[validdateStart]
					,[validdateend]
					,[evltimes]
					,[isused]
					)
				VALUES
					(
					@Name
					,@ValiddateStart
					,@Validdateend
					,@Evltimes
					,@Isused
					)
				
				-- Get the identity value
				SET @ModelId = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_model_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_model_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_model_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the evl_model table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_model_Update
(

	@ModelId int   ,

	@Name varchar (50)  ,

	@ValiddateStart datetime   ,

	@Validdateend datetime   ,

	@Evltimes int   ,

	@Isused int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[evl_model]
				SET
					[name] = @Name
					,[validdateStart] = @ValiddateStart
					,[validdateend] = @Validdateend
					,[evltimes] = @Evltimes
					,[isused] = @Isused
				WHERE
[model_id] = @ModelId 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_model_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_model_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_model_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the evl_model table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_model_Delete
(

	@ModelId int   
)
AS


				DELETE FROM [dbo].[evl_model] WITH (ROWLOCK) 
				WHERE
					[model_id] = @ModelId
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_model_GetByModelId procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_model_GetByModelId') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_model_GetByModelId
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the evl_model table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_model_GetByModelId
(

	@ModelId int   
)
AS


				SELECT
					[model_id],
					[name],
					[validdateStart],
					[validdateend],
					[evltimes],
					[isused]
				FROM
					[dbo].[evl_model]
				WHERE
					[model_id] = @ModelId
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_model_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_model_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_model_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the evl_model table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_model_Find
(

	@SearchUsingOR bit   = null ,

	@ModelId int   = null ,

	@Name varchar (50)  = null ,

	@ValiddateStart datetime   = null ,

	@Validdateend datetime   = null ,

	@Evltimes int   = null ,

	@Isused int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [model_id]
	, [name]
	, [validdateStart]
	, [validdateend]
	, [evltimes]
	, [isused]
    FROM
	[dbo].[evl_model]
    WHERE 
	 ([model_id] = @ModelId OR @ModelId IS NULL)
	AND ([name] = @Name OR @Name IS NULL)
	AND ([validdateStart] = @ValiddateStart OR @ValiddateStart IS NULL)
	AND ([validdateend] = @Validdateend OR @Validdateend IS NULL)
	AND ([evltimes] = @Evltimes OR @Evltimes IS NULL)
	AND ([isused] = @Isused OR @Isused IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [model_id]
	, [name]
	, [validdateStart]
	, [validdateend]
	, [evltimes]
	, [isused]
    FROM
	[dbo].[evl_model]
    WHERE 
	 ([model_id] = @ModelId AND @ModelId is not null)
	OR ([name] = @Name AND @Name is not null)
	OR ([validdateStart] = @ValiddateStart AND @ValiddateStart is not null)
	OR ([validdateend] = @Validdateend AND @Validdateend is not null)
	OR ([evltimes] = @Evltimes AND @Evltimes is not null)
	OR ([isused] = @Isused AND @Isused is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_score_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_score_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_score_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the evl_score table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_score_Get_List

AS


				
				SELECT
					[id],
					[userid],
					[assessmentid],
					[catalog_oneid],
					[catalog_twoid],
					[behaviorid],
					[scorelevel],
					[score],
					[scorereal],
					[model_id],
					[evlDate],
					[evlTimes]
				FROM
					[dbo].[evl_score]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_score_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_score_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_score_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the evl_score table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_score_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [id]'
				SET @SQL = @SQL + ' FROM [dbo].[evl_score]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[id], O.[userid], O.[assessmentid], O.[catalog_oneid], O.[catalog_twoid], O.[behaviorid], O.[scorelevel], O.[score], O.[scorereal], O.[model_id], O.[evlDate], O.[evlTimes]
				FROM
				    [dbo].[evl_score] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[id] = PageIndex.[id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[evl_score]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_score_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_score_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_score_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the evl_score table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_score_Insert
(

	@Id int    OUTPUT,

	@Userid varchar (50)  ,

	@Assessmentid int   ,

	@CatalogOneid int   ,

	@CatalogTwoid int   ,

	@Behaviorid int   ,

	@Scorelevel int   ,

	@Score decimal (9, 2)  ,

	@Scorereal decimal (9, 2)  ,

	@ModelId int   ,

	@EvlDate datetime   ,

	@EvlTimes int   
)
AS


				
				INSERT INTO [dbo].[evl_score]
					(
					[userid]
					,[assessmentid]
					,[catalog_oneid]
					,[catalog_twoid]
					,[behaviorid]
					,[scorelevel]
					,[score]
					,[scorereal]
					,[model_id]
					,[evlDate]
					,[evlTimes]
					)
				VALUES
					(
					@Userid
					,@Assessmentid
					,@CatalogOneid
					,@CatalogTwoid
					,@Behaviorid
					,@Scorelevel
					,@Score
					,@Scorereal
					,@ModelId
					,@EvlDate
					,@EvlTimes
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_score_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_score_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_score_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the evl_score table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_score_Update
(

	@Id int   ,

	@Userid varchar (50)  ,

	@Assessmentid int   ,

	@CatalogOneid int   ,

	@CatalogTwoid int   ,

	@Behaviorid int   ,

	@Scorelevel int   ,

	@Score decimal (9, 2)  ,

	@Scorereal decimal (9, 2)  ,

	@ModelId int   ,

	@EvlDate datetime   ,

	@EvlTimes int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[evl_score]
				SET
					[userid] = @Userid
					,[assessmentid] = @Assessmentid
					,[catalog_oneid] = @CatalogOneid
					,[catalog_twoid] = @CatalogTwoid
					,[behaviorid] = @Behaviorid
					,[scorelevel] = @Scorelevel
					,[score] = @Score
					,[scorereal] = @Scorereal
					,[model_id] = @ModelId
					,[evlDate] = @EvlDate
					,[evlTimes] = @EvlTimes
				WHERE
[id] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_score_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_score_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_score_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the evl_score table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_score_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[evl_score] WITH (ROWLOCK) 
				WHERE
					[id] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_score_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_score_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_score_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the evl_score table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_score_GetById
(

	@Id int   
)
AS


				SELECT
					[id],
					[userid],
					[assessmentid],
					[catalog_oneid],
					[catalog_twoid],
					[behaviorid],
					[scorelevel],
					[score],
					[scorereal],
					[model_id],
					[evlDate],
					[evlTimes]
				FROM
					[dbo].[evl_score]
				WHERE
					[id] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_score_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_score_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_score_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the evl_score table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_score_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@Userid varchar (50)  = null ,

	@Assessmentid int   = null ,

	@CatalogOneid int   = null ,

	@CatalogTwoid int   = null ,

	@Behaviorid int   = null ,

	@Scorelevel int   = null ,

	@Score decimal (9, 2)  = null ,

	@Scorereal decimal (9, 2)  = null ,

	@ModelId int   = null ,

	@EvlDate datetime   = null ,

	@EvlTimes int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [id]
	, [userid]
	, [assessmentid]
	, [catalog_oneid]
	, [catalog_twoid]
	, [behaviorid]
	, [scorelevel]
	, [score]
	, [scorereal]
	, [model_id]
	, [evlDate]
	, [evlTimes]
    FROM
	[dbo].[evl_score]
    WHERE 
	 ([id] = @Id OR @Id IS NULL)
	AND ([userid] = @Userid OR @Userid IS NULL)
	AND ([assessmentid] = @Assessmentid OR @Assessmentid IS NULL)
	AND ([catalog_oneid] = @CatalogOneid OR @CatalogOneid IS NULL)
	AND ([catalog_twoid] = @CatalogTwoid OR @CatalogTwoid IS NULL)
	AND ([behaviorid] = @Behaviorid OR @Behaviorid IS NULL)
	AND ([scorelevel] = @Scorelevel OR @Scorelevel IS NULL)
	AND ([score] = @Score OR @Score IS NULL)
	AND ([scorereal] = @Scorereal OR @Scorereal IS NULL)
	AND ([model_id] = @ModelId OR @ModelId IS NULL)
	AND ([evlDate] = @EvlDate OR @EvlDate IS NULL)
	AND ([evlTimes] = @EvlTimes OR @EvlTimes IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [id]
	, [userid]
	, [assessmentid]
	, [catalog_oneid]
	, [catalog_twoid]
	, [behaviorid]
	, [scorelevel]
	, [score]
	, [scorereal]
	, [model_id]
	, [evlDate]
	, [evlTimes]
    FROM
	[dbo].[evl_score]
    WHERE 
	 ([id] = @Id AND @Id is not null)
	OR ([userid] = @Userid AND @Userid is not null)
	OR ([assessmentid] = @Assessmentid AND @Assessmentid is not null)
	OR ([catalog_oneid] = @CatalogOneid AND @CatalogOneid is not null)
	OR ([catalog_twoid] = @CatalogTwoid AND @CatalogTwoid is not null)
	OR ([behaviorid] = @Behaviorid AND @Behaviorid is not null)
	OR ([scorelevel] = @Scorelevel AND @Scorelevel is not null)
	OR ([score] = @Score AND @Score is not null)
	OR ([scorereal] = @Scorereal AND @Scorereal is not null)
	OR ([model_id] = @ModelId AND @ModelId is not null)
	OR ([evlDate] = @EvlDate AND @EvlDate is not null)
	OR ([evlTimes] = @EvlTimes AND @EvlTimes is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_scoredescription_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_scoredescription_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_scoredescription_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the evl_scoredescription table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_scoredescription_Get_List

AS


				
				SELECT
					[id],
					[ScoreLevel],
					[Description]
				FROM
					[dbo].[evl_scoredescription]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_scoredescription_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_scoredescription_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_scoredescription_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the evl_scoredescription table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_scoredescription_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [id]'
				SET @SQL = @SQL + ' FROM [dbo].[evl_scoredescription]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[id], O.[ScoreLevel], O.[Description]
				FROM
				    [dbo].[evl_scoredescription] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[id] = PageIndex.[id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[evl_scoredescription]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_scoredescription_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_scoredescription_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_scoredescription_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the evl_scoredescription table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_scoredescription_Insert
(

	@Id int    OUTPUT,

	@ScoreLevel int   ,

	@Description varchar (1000)  
)
AS


				
				INSERT INTO [dbo].[evl_scoredescription]
					(
					[ScoreLevel]
					,[Description]
					)
				VALUES
					(
					@ScoreLevel
					,@Description
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_scoredescription_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_scoredescription_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_scoredescription_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the evl_scoredescription table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_scoredescription_Update
(

	@Id int   ,

	@ScoreLevel int   ,

	@Description varchar (1000)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[evl_scoredescription]
				SET
					[ScoreLevel] = @ScoreLevel
					,[Description] = @Description
				WHERE
[id] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_scoredescription_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_scoredescription_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_scoredescription_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the evl_scoredescription table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_scoredescription_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[evl_scoredescription] WITH (ROWLOCK) 
				WHERE
					[id] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_scoredescription_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_scoredescription_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_scoredescription_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the evl_scoredescription table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_scoredescription_GetById
(

	@Id int   
)
AS


				SELECT
					[id],
					[ScoreLevel],
					[Description]
				FROM
					[dbo].[evl_scoredescription]
				WHERE
					[id] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_scoredescription_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_scoredescription_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_scoredescription_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the evl_scoredescription table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_scoredescription_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@ScoreLevel int   = null ,

	@Description varchar (1000)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [id]
	, [ScoreLevel]
	, [Description]
    FROM
	[dbo].[evl_scoredescription]
    WHERE 
	 ([id] = @Id OR @Id IS NULL)
	AND ([ScoreLevel] = @ScoreLevel OR @ScoreLevel IS NULL)
	AND ([Description] = @Description OR @Description IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [id]
	, [ScoreLevel]
	, [Description]
    FROM
	[dbo].[evl_scoredescription]
    WHERE 
	 ([id] = @Id AND @Id is not null)
	OR ([ScoreLevel] = @ScoreLevel AND @ScoreLevel is not null)
	OR ([Description] = @Description AND @Description is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_rights_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_rights_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_rights_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VU_rights table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_rights_Get_List

AS


				
				SELECT
					[id],
					[rights],
					[shuoming]
				FROM
					[dbo].[VU_rights]
					
				SELECT @@ROWCOUNT
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_rights_GetPaged procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_rights_GetPaged') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_rights_GetPaged
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VU_rights table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_rights_GetPaged
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				CREATE TABLE #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [id] int 
				)
				
				-- Insert into the temp table
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex ([id])'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + CONVERT(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [id]'
				SET @SQL = @SQL + ' FROM [dbo].[VU_rights]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				EXEC sp_executesql @SQL

				-- Return paged results
				SELECT O.[id], O.[rights], O.[shuoming]
				FROM
				    [dbo].[VU_rights] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexId > @PageLowerBound
					AND O.[id] = PageIndex.[id]
				ORDER BY
				    PageIndex.IndexId
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) AS TotalRowCount'
				SET @SQL = @SQL + ' FROM [dbo].[VU_rights]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				EXEC sp_executesql @SQL
			
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_rights_Insert procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_rights_Insert') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_rights_Insert
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Inserts a record into the VU_rights table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_rights_Insert
(

	@Id int    OUTPUT,

	@Rights nvarchar (50)  ,

	@Shuoming nvarchar (100)  
)
AS


				
				INSERT INTO [dbo].[VU_rights]
					(
					[rights]
					,[shuoming]
					)
				VALUES
					(
					@Rights
					,@Shuoming
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
									
							
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_rights_Update procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_rights_Update') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_rights_Update
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Updates a record in the VU_rights table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_rights_Update
(

	@Id int   ,

	@Rights nvarchar (50)  ,

	@Shuoming nvarchar (100)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					[dbo].[VU_rights]
				SET
					[rights] = @Rights
					,[shuoming] = @Shuoming
				WHERE
[id] = @Id 
				
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_rights_Delete procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_rights_Delete') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_rights_Delete
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Deletes a record in the VU_rights table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_rights_Delete
(

	@Id int   
)
AS


				DELETE FROM [dbo].[VU_rights] WITH (ROWLOCK) 
				WHERE
					[id] = @Id
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_rights_GetById procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_rights_GetById') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_rights_GetById
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Select records from the VU_rights table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_rights_GetById
(

	@Id int   
)
AS


				SELECT
					[id],
					[rights],
					[shuoming]
				FROM
					[dbo].[VU_rights]
				WHERE
					[id] = @Id
				SELECT @@ROWCOUNT
					
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VU_rights_Find procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VU_rights_Find') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VU_rights_Find
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Finds records in the VU_rights table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VU_rights_Find
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@Rights nvarchar (50)  = null ,

	@Shuoming nvarchar (100)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [id]
	, [rights]
	, [shuoming]
    FROM
	[dbo].[VU_rights]
    WHERE 
	 ([id] = @Id OR @Id IS NULL)
	AND ([rights] = @Rights OR @Rights IS NULL)
	AND ([shuoming] = @Shuoming OR @Shuoming IS NULL)
						
  END
  ELSE
  BEGIN
    SELECT
	  [id]
	, [rights]
	, [shuoming]
    FROM
	[dbo].[VU_rights]
    WHERE 
	 ([id] = @Id AND @Id is not null)
	OR ([rights] = @Rights AND @Rights is not null)
	OR ([shuoming] = @Shuoming AND @Shuoming is not null)
	SELECT @@ROWCOUNT			
  END
				

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_v_LearningRecordCsv_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_v_LearningRecordCsv_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_v_LearningRecordCsv_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the evl_v_LearningRecordCsv view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_v_LearningRecordCsv_Get_List

AS


				
				SELECT
					[CourseName],
					[Description],
					[SSO],
					[UserName],
					[CompletedDate],
					[Status],
					[courseid],
					[ID],
					[CreatedDate]
				FROM
					[dbo].[evl_v_LearningRecordCsv]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_v_LearningRecordCsv_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_v_LearningRecordCsv_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_v_LearningRecordCsv_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the evl_v_LearningRecordCsv view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_v_LearningRecordCsv_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[evl_v_LearningRecordCsv]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_v_LearningRecordExcel_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_v_LearningRecordExcel_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_v_LearningRecordExcel_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the evl_v_LearningRecordExcel view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_v_LearningRecordExcel_Get_List

AS


				
				SELECT
					[CourseName],
					[SSO],
					[UserName],
					[Function],
					[StartDate],
					[CompletedDate],
					[Location],
					[Trainer],
					[courseid],
					[ID],
					[CreatedDate]
				FROM
					[dbo].[evl_v_LearningRecordExcel]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_v_LearningRecordExcel_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_v_LearningRecordExcel_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_v_LearningRecordExcel_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the evl_v_LearningRecordExcel view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_v_LearningRecordExcel_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[evl_v_LearningRecordExcel]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_v_score_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_v_score_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_v_score_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the evl_v_score view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_v_score_Get_List

AS


				
				SELECT
					[id],
					[userid],
					[assessmentid],
					[catalog_oneid],
					[catalog_twoid],
					[behaviorid],
					[scorelevel],
					[score],
					[evltimes],
					[model_id],
					[assessmentname],
					[catalog_onename],
					[catalog_twoname]
				FROM
					[dbo].[evl_v_score]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.evl_v_score_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.evl_v_score_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.evl_v_score_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the evl_v_score view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.evl_v_score_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[evl_v_score]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_DegreeCourses_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_DegreeCourses_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_DegreeCourses_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_DegreeCourses view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_DegreeCourses_Get_List

AS


				
				SELECT
					[DegreeId],
					[DegreeName],
					[DegreesDescription],
					[Credithour],
					[DegreeStatus],
					[DegreeCourseID],
					[CourseName],
					[CourseStyle],
					[CourseId],
					[DegreeCoursesDescription],
					[DegreeCoursesCreditHour],
					[DegreeCourseStatus],
					[IsRequiredCourse],
					[InstituteId]
				FROM
					[dbo].[VW_DegreeCourses]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_DegreeCourses_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_DegreeCourses_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_DegreeCourses_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_DegreeCourses view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_DegreeCourses_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_DegreeCourses]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_EvlUser_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_EvlUser_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_EvlUser_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_EvlUser view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_EvlUser_Get_List

AS


				
				SELECT
					[UserID],
					[UserCNName],
					[name],
					[validdateStart],
					[validdateend],
					[isused],
					[evltimes]
				FROM
					[dbo].[VW_EvlUser]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_EvlUser_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_EvlUser_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_EvlUser_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_EvlUser view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_EvlUser_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_EvlUser]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_InstituteDegreeCourses_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_InstituteDegreeCourses_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_InstituteDegreeCourses_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_InstituteDegreeCourses view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_InstituteDegreeCourses_Get_List

AS


				
				SELECT
					[InstituteID],
					[InstituteName],
					[Description],
					[InstituteDean],
					[InstituteStatus],
					[DegreeId],
					[DegreeName],
					[DegreesDescription],
					[Credithour],
					[DegreeStatus],
					[DegreeCourseID],
					[CourseName],
					[CourseStyle],
					[CourseId],
					[DegreeCoursesDescription],
					[DegreeCoursesCreditHour],
					[DegreeCourseStatus],
					[IsRequiredCourse]
				FROM
					[dbo].[VW_InstituteDegreeCourses]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_InstituteDegreeCourses_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_InstituteDegreeCourses_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_InstituteDegreeCourses_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_InstituteDegreeCourses view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_InstituteDegreeCourses_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_InstituteDegreeCourses]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_InstituteDegrees_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_InstituteDegrees_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_InstituteDegrees_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_InstituteDegrees view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_InstituteDegrees_Get_List

AS


				
				SELECT
					[InstituteID],
					[InstituteName],
					[Description],
					[InstituteDean],
					[InstituteStatus],
					[DegreeId],
					[DegreeName],
					[DegreesDescription],
					[Credithour],
					[DegreeStatus]
				FROM
					[dbo].[VW_InstituteDegrees]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_InstituteDegrees_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_InstituteDegrees_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_InstituteDegrees_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_InstituteDegrees view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_InstituteDegrees_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_InstituteDegrees]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_InstituteDegreeStudents_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_InstituteDegreeStudents_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_InstituteDegreeStudents_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_InstituteDegreeStudents view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_InstituteDegreeStudents_Get_List

AS


				
				SELECT
					[InstituteName],
					[DegreeId],
					[DegreeName],
					[InstituteId],
					[Credithour],
					[StudentID],
					[UserID],
					[Status],
					[studies],
					[InstituteDean],
					[CreateTime],
					[Notes]
				FROM
					[dbo].[VW_InstituteDegreeStudents]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_InstituteDegreeStudents_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_InstituteDegreeStudents_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_InstituteDegreeStudents_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_InstituteDegreeStudents view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_InstituteDegreeStudents_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_InstituteDegreeStudents]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_Institutes_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_Institutes_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_Institutes_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_Institutes view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_Institutes_Get_List

AS


				
				SELECT
					[InstituteID],
					[InstituteName],
					[Description],
					[InstituteDean],
					[Createtime],
					[CreateUserID],
					[Status],
					[UserID],
					[UserName],
					[UserCNName],
					[FEBadgeID]
				FROM
					[dbo].[VW_Institutes]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_Institutes_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_Institutes_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_Institutes_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_Institutes view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_Institutes_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_Institutes]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_MenuPermission_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_MenuPermission_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_MenuPermission_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_MenuPermission view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_MenuPermission_Get_List

AS


				
				SELECT
					[MenuID],
					[MenuName],
					[MenuStatus],
					[PermissionID],
					[PermissionName],
					[PermissionURL],
					[PermissionStatus],
					[ParentMenuID],
					[ShowOrder],
					[PageUrl],
					[HelpInfo]
				FROM
					[dbo].[VW_MenuPermission]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_MenuPermission_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_MenuPermission_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_MenuPermission_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_MenuPermission view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_MenuPermission_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_MenuPermission]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_RolePermission_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_RolePermission_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_RolePermission_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_RolePermission view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_RolePermission_Get_List

AS


				
				SELECT
					[PermissionID],
					[PermissionName],
					[PermissionURL],
					[MenuID],
					[RoleID],
					[RoleName],
					[PermissionStatus],
					[RoleStatus]
				FROM
					[dbo].[VW_RolePermission]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_RolePermission_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_RolePermission_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_RolePermission_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_RolePermission view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_RolePermission_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_RolePermission]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_Roles_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_Roles_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_Roles_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_Roles view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_Roles_Get_List

AS


				
				SELECT
					[RoleID],
					[RoleName],
					[Description],
					[CreateTime],
					[CreateUserID],
					[Status],
					[UserID],
					[UserName],
					[UserCNName],
					[FEBadgeID]
				FROM
					[dbo].[VW_Roles]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_Roles_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_Roles_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_Roles_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_Roles view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_Roles_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_Roles]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_StudentCourseRelation_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_StudentCourseRelation_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_StudentCourseRelation_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_StudentCourseRelation view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_StudentCourseRelation_Get_List

AS


				
				SELECT
					[StudentID],
					[StudentNote],
					[studies],
					[UserID],
					[UserName],
					[UserCNName],
					[AutoID],
					[Updatetime],
					[CredentialsStyle],
					[DegreeID],
					[degreeCourseID],
					[StudentStatus],
					[FEBadgeID],
					[AttachmentFileStyle],
					[AttachmentFilePath],
					[courseID],
					[UpdateUserID]
				FROM
					[dbo].[VW_StudentCourseRelation]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_StudentCourseRelation_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_StudentCourseRelation_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_StudentCourseRelation_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_StudentCourseRelation view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_StudentCourseRelation_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_StudentCourseRelation]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_Students_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_Students_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_Students_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_Students view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_Students_Get_List

AS


				
				SELECT
					[StudentID],
					[CreateTime],
					[Status],
					[Notes],
					[studies],
					[UserID],
					[UserName],
					[UserCNName],
					[DegreeID],
					[FEBadgeID],
					[department],
					[Email],
					[ApplyDate],
					[ApprovalofHuman],
					[ApproveofDate]
				FROM
					[dbo].[VW_Students]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_Students_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_Students_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_Students_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_Students view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_Students_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_Students]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_TrainingUser_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_TrainingUser_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_TrainingUser_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_TrainingUser view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_TrainingUser_Get_List

AS


				
				SELECT
					[TrainUserID],
					[TrainingUserType],
					[TrainUserStatus],
					[TrainAuditingStatus],
					[TrainAuditingMan],
					[TrainAuditingDate],
					[CreateTime],
					[TrainAuditingDescription],
					[UserID],
					[UserName],
					[UserCNName],
					[Email],
					[FEBadgeID],
					[GroupID],
					[TrainingFinishTime],
					[TestFinishTime],
					[InvestigationFinishTime],
					[StudyFinishTime],
					[TrainTimeUseCredit],
					[TrainTimeAddPoint],
					[CourseID]
				FROM
					[dbo].[VW_TrainingUser]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_TrainingUser_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_TrainingUser_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_TrainingUser_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_TrainingUser view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_TrainingUser_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_TrainingUser]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_TrainingUserLog_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_TrainingUserLog_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_TrainingUserLog_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_TrainingUserLog view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_TrainingUserLog_Get_List

AS


				
				SELECT
					[TrainUserID],
					[UserID],
					[GroupID],
					[TrainingUserType],
					[TrainUserStatus],
					[TrainAuditingStatus],
					[TrainAuditingMan],
					[TrainAuditingDate],
					[CreateTime],
					[TrainAuditingDescription],
					[TrainingFinishTime],
					[TestFinishTime],
					[InvestigationFinishTime],
					[StudyFinishTime],
					[TrainingLogID],
					[LogBeginTime],
					[LogEndTime],
					[TrainingTime],
					[MachineIP],
					[SessionID],
					[CourseWareID],
					[CourseID]
				FROM
					[dbo].[VW_TrainingUserLog]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_TrainingUserLog_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_TrainingUserLog_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_TrainingUserLog_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_TrainingUserLog view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_TrainingUserLog_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_TrainingUserLog]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_UserGroup_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_UserGroup_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_UserGroup_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_UserGroup view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_UserGroup_Get_List

AS


				
				SELECT
					[GroupID],
					[GroupName],
					[Description],
					[GroupStatus],
					[LeaderUserID],
					[UserID],
					[UserName],
					[UserCNName],
					[Email],
					[FEBadgeID]
				FROM
					[dbo].[VW_UserGroup]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_UserGroup_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_UserGroup_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_UserGroup_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_UserGroup view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_UserGroup_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_UserGroup]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_UserGroupPermission_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_UserGroupPermission_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_UserGroupPermission_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_UserGroupPermission view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_UserGroupPermission_Get_List

AS


				
				SELECT
					[UserCNName],
					[UserID],
					[RoleID],
					[RoleName],
					[PermissionID],
					[PermissionName],
					[GroupID]
				FROM
					[dbo].[VW_UserGroupPermission]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_UserGroupPermission_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_UserGroupPermission_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_UserGroupPermission_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_UserGroupPermission view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_UserGroupPermission_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_UserGroupPermission]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_UserRole_Get_List procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_UserRole_Get_List') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_UserRole_Get_List
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets all records from the VW_UserRole view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_UserRole_Get_List

AS


				
				SELECT
					[RoleID],
					[RoleName],
					[UserID],
					[UserName],
					[UserCNName],
					[Telephone],
					[Email],
					[UserStatus],
					[FEBadgeID],
					[Mobile],
					[UserType],
					[UserCredit],
					[Password]
				FROM
					[dbo].[VW_UserRole]
					
				SELECT @@ROWCOUNT			
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

	

-- Drop the dbo.VW_UserRole_Get procedure
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'dbo.VW_UserRole_Get') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE dbo.VW_UserRole_Get
GO

/*
----------------------------------------------------------------------------------------------------

-- Created By:  ()
-- Purpose: Gets records from the VW_UserRole view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE dbo.VW_UserRole_Get
(

	@WhereClause varchar (2000)  ,

	@OrderBy varchar (2000)  
)
AS


				
				BEGIN

				-- Build the sql query
				DECLARE @SQL AS nvarchar(4000)
				SET @SQL = ' SELECT * FROM [dbo].[VW_UserRole]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Execution the query
				EXEC sp_executesql @SQL
				
				-- Return total count
				SELECT @@ROWCOUNT AS TotalRowCount
				
				END
			

GO
SET QUOTED_IDENTIFIER ON 
GO
SET NOCOUNT ON
GO
SET ANSI_NULLS OFF 
GO

