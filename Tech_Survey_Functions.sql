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




CREATE FUNCTION dbo.AVGWorkHour(@input nvarchar(50))
RETURNS INT
as
BEGIN
	DECLARE @first int
	DECLARE @second int

	IF @input like '%-%'
	BEGIN
		SET @first = cast( LEFT(@input,CHARINDEX('-',@input,1)-1) as int)
		SET @second = cast(RIGHT(@input,len(@input)-CHARINDEX('-',@input,1)) as int)
	END


	RETURN (@first+@second)/2
END



ALTER FUNCTION dbo.AvgGPA(@input nvarchar(50))
RETURNS decimal(4,2)
as
BEGIN
	DECLARE @first float
	DECLARE @second float

	
	IF @input like '%-%'
	BEGIN 
		set @first=CAST(left(@input,CHARINDEX('-',@input,1)-1) as decimal(18,2))
		set @second = CAST(RIGHT(@input,LEN(@input)-CHARINDEX('-',@input,1)) as decimal(18,2))
	END

	ELSE IF @input like '%4%'
	BEGIN 
		SET @first=4.0
		SET @second=0.0
	END

RETURN (@first+@second)/2
END
	
