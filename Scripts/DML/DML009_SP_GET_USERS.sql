USE [spacesurgeondb]
GO
/****** Object:  StoredProcedure [dbo].[sp_get_users]    Script Date: 28.04.2022 10:12:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*************************************************************
Object: Stored Procedure
Author: Furkan Coşkun
Script Date: April 25, 2022
Description: Get Active Users
**************************************************************/
ALTER   PROCEDURE [dbo].[sp_get_users]
AS BEGIN
	SELECT 
		USER_ID,
		USER_NAME,
		dbo.[hide_text](USER_PASSWORD, '*', 2,0) AS 'USER_PASSWORD',
		USER_EMAIL,
		USER_REGISTER_DATE,
		USER_IS_ACTIVE
	FROM Users 
	WHERE USER_IS_ACTIVE = 1
END
