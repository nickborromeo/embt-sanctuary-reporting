# Embarcadero Sanctuary Reporting Tool
===

### Description

The simple web application connects to an Oracle database. This queries that database based on dates of the user's choosing. It can also be filtered by the Company and the product family *Database* and/or *Developer*.

This uses JRuby to connect to the Oracle Database. 


### Usage

User will input a start date. End date is automatically set to today's date. Optionally, he/she can put in a company name (checked against using a LIKE clause). Users will choose from three radio buttons of Database, Developer or Both.

A report on the criteria is generated. This report can then be exported to Excel for further data manipulation. 



