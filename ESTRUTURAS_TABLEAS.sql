SELECT *  FROM [unifortprodtable].[dbo].[sqvi_estoque_sap];
CREATE INDEX indexmaterial ON [unifortprodtable].[dbo].[sqvi_estoque_sap] (MATERIAL);
CREATE INDEX indexdata ON [unifortprodtable].[dbo].[sqvi_estoque_sap] (DATA_rel);



SELECT *  FROM [unifortprodtable].[dbo].[VBRK];
CREATE INDEX indexVBELN ON [unifortprodtable].[dbo].[VBRK] (VBELN);
CREATE INDEX indexFKDAT ON [unifortprodtable].[dbo].[VBRK] (FKDAT);
ALTER TABLE [unifortprodtable].[dbo].[VBRK] ALTER COLUMN [VBELN] varchar(50) NOT NULL;
ALTER TABLE [unifortprodtable].[dbo].[VBRK] ADD CONSTRAINT PK_VBELN PRIMARY KEY (VBELN);
ALTER TABLE [unifortprodtable].[dbo].[VBRK] ADD FOREIGN KEY (FK_VBELN) REFERENCES [unifortprodtable].[dbo].[VBRP](VBELN);



SELECT *  FROM [unifortprodtable].[dbo].[VBRP];
CREATE INDEX indexVBELN ON [unifortprodtable].[dbo].[VBRP] (VBELN);
CREATE INDEX indexFBUDA ON [unifortprodtable].[dbo].[VBRP] (FBUDA);
ALTER TABLE [unifortprodtable].[dbo].[VBRP] ALTER COLUMN [VBELN] varchar(50) NOT NULL;
