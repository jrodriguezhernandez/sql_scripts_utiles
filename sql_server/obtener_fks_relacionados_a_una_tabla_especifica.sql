DECLARE @TablaDestino VARCHAR(MAX) = ''
DECLARE @TablaOrigen VARCHAR(MAX) = '[APP].[TablaXYZ]'
DECLARE @NombreForeingKey VARCHAR(MAX) = ''
DECLARE @NombreCampo VARCHAR(MAX) = ''

DECLARE @Query_Drop VARCHAR(MAX) = ''
DECLARE @Query_Add VARCHAR(MAX) = ''
DECLARE @Query_Check VARCHAR(MAX) = ''

SELECT 
	 @TablaDestino = '[' + OBJECT_SCHEMA_NAME(A.parent_object_id) + '].[' + OBJECT_NAME(A.parent_object_id) + ']'
	-- ,@TablaOrigen = '[' + OBJECT_SCHEMA_NAME(A.referenced_object_id) + '].[' + OBJECT_NAME(A.referenced_object_id) + ']'     
    ,@NombreForeingKey = A.name
    ,@NombreCampo = OBJECT_NAME(A.referenced_object_id) + '_Id'
    ,@Query_Drop = @Query_Drop + 'ALTER TABLE ' + @TablaDestino +  ' DROP CONSTRAINT ' + @NombreForeingKey + CHAR(13)
	,@Query_Add = @Query_Add + 'ALTER TABLE ' + @TablaDestino + ' WITH CHECK ADD CONSTRAINT [' + @NombreForeingKey + '] FOREIGN KEY([' + @NombreCampo + ']) REFERENCES ' + @TablaOrigen + ' ([' + @NombreCampo + '])' + CHAR(13)
	,@Query_Check = @Query_Check + 'ALTER TABLE ' + @TablaDestino + ' CHECK CONSTRAINT [' + @NombreForeingKey + ']' + CHAR(13)
FROM sys.foreign_keys A
WHERE referenced_object_id = object_id(@TablaOrigen)

PRINT @Query_Drop
PRINT CHAR(13)
PRINT @Query_Add
PRINT CHAR(13)
PRINT @Query_Check
