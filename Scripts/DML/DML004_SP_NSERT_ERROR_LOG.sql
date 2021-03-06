USE [spacesurgeondb]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert_error_log]    Script Date: 28.04.2022 10:14:20 ******/
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
ALTER   PROCEDURE [dbo].[sp_insert_error_log]
AS BEGIN
BEGIN TRY
	INSERT INTO dbo.ErrorLogs
    VALUES
	(
		SUSER_SNAME(),
		ERROR_NUMBER(),
		ERROR_STATE(),
		ERROR_SEVERITY(),
		ERROR_LINE(),
		ERROR_PROCEDURE(),
		ERROR_MESSAGE(),
		GETDATE()
	)
END TRY
BEGIN CATCH

	DECLARE @error_sp varchar(500) = ERROR_PROCEDURE()

	RAISERROR('Unexpected Error: %s',16,1, @error_sp)

END CATCH
END