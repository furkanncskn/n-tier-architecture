USE [spacesurgeondb]
GO
/****** Object:  StoredProcedure [dbo].[sp_get_users_by_id]    Script Date: 28.04.2022 10:13:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[sp_get_users_by_id]
(
	@USER_ID int
)
AS BEGIN
	SELECT 
		USER_ID,
		USER_NAME,
		dbo.[hide_text](USER_PASSWORD, '*', 2,0) AS 'USER_PASSWORD',
		USER_EMAIL,
		USER_REGISTER_DATE,
		USER_IS_ACTIVE
	FROM Users WHERE USER_ID = @USER_ID AND USER_IS_ACTIVE = 1	
END
