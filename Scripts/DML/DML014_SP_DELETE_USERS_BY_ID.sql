USE [spacesurgeondb]
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_users_by_id]    Script Date: 28.04.2022 10:12:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[sp_delete_users_by_id]
(
	@USER_ID int
)
AS BEGIN
BEGIN TRY
	
	DECLARE @prev_xstate int = XACT_STATE()
	
	IF @prev_xstate = -1 
		ROLLBACK TRANSACTION
	ELSE IF @prev_xstate = 0
		BEGIN TRANSACTION
	ELSE 
		SAVE TRANSACTION sp_update_user

	UPDATE Users 
	SET USER_IS_ACTIVE = 0 
	WHERE USER_ID = @USER_ID AND 
	USER_IS_ACTIVE = 1

	DECLARE @curr_xstate int = XACT_STATE()
	
	IF @curr_xstate = 1
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

