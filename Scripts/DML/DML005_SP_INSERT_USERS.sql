USE [spacesurgeondb]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_users]    Script Date: 29.04.2022 12:40:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************
Object: Stored Procedure
Author: Furkan Coşkun
Script Date: April 17, 2022
Description: insert to db_error table
**************************************************************/
ALTER PROCEDURE [dbo].[sp_insert_users]
(
	@USER_ID int,
	@USER_NAME varchar(150),
	@USER_PASSWORD varchar(150),
	@USER_EMAIL varchar(150),
	@USER_REGISTER_DATE datetime,
	@USER_IS_ACTIVE bit
)
AS BEGIN
BEGIN TRY
	
	DECLARE @prev_xstate int = XACT_STATE()
	
	IF @prev_xstate = -1
		ROLLBACK TRANSACTION
	ELSE IF @prev_xstate = 1
		SAVE TRANSACTION save_sp_insert_users
	ELSE
		BEGIN TRANSACTION

	INSERT INTO Users
	(
		USER_NAME,
		USER_PASSWORD,
		USER_EMAIL,
		USER_REGISTER_DATE,
		USER_IS_ACTIVE
	)
	VALUES
	(
		@USER_NAME,
		@USER_PASSWORD,
		@USER_EMAIL,
		@USER_REGISTER_DATE,
		CASE 
		WHEN @USER_IS_ACTIVE = NULL THEN 1
		ELSE @USER_IS_ACTIVE
		END
	)
	
	DECLARE @curr_xstate int = XACT_STATE()
	
	IF (@curr_xstate) = 1
		COMMIT TRANSACTION

END TRY
BEGIN CATCH
	
	EXEC dbo.sp_insert_error_log

	IF @curr_xstate = -1 
		ROLLBACK TRANSACTION
	ELSE IF @curr_xstate = 1 AND @prev_xstate = 0
		ROLLBACK TRANSACTION
	ELSE IF @curr_xstate = 1 AND @prev_xstate = 1
		ROLLBACK TRANSACTION sp_update_user

END CATCH
END 