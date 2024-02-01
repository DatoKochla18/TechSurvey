--CREATING FUCNTIONS FOR simplicity

CREATE FUNCTION dbo.AvgFromTextInput(@input nvarchar(100)) 
RETURNS int
AS
BEGIN
    DECLARE @firstNum int
    DECLARE @secondNum int
    
    IF @input like '%k-%'
	BEGIN
		SET @firstNum = cast(SUBSTRING(@input,1,CHARINDEX('-',@input,1)-2)as int)*1000
		SET @secondNum = cast(SUBSTRING(@input,CHARINDEX('-',@input,1)+1,CHARINDEX('k',@input,CHARINDEX('-',@input,1))-CHARINDEX('-',@input,1)-1) as int)*1000
    END

	ELSE IF @input like '0-500' 
	BEGIN
		SET @firstNum=cast(SUBSTRING(@input,1,CHARINDEX('-',@input,1)-1)as int)
		SET @secondNum=cast(SUBSTRING(@input,CHARINDEX('-',@input,1)+1,LEN(@input))as int)
	END

	ELSE IF @input like '%k+%'
	BEGIN
		SET @firstNum=cast(SUBSTRING(@input,1,CHARINDEX('k',@input,1)-1)as int)*1000
		SET @secondNum=0
	END

	ELSE IF @input like '500-1k'
	BEGIN 
		SET @firstNum=cast(SUBSTRING(@input,1,CHARINDEX('-',@input,1)-1)as int)
		SET @secondNum=cast(SUBSTRING(@input,CHARINDEX('-',@input,1)+1,1)as int)*1000
	END
    RETURN (@firstNum + @secondNum) / 2
END;

