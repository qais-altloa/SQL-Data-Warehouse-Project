/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

create OR Alter Procedure bronze.load_bronze AS
Begin
	Declare @start_time DATETIME, @end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
	SET @batch_start_time = GETDATE();
	Begin Try
		print'--------------------------------';
		print'Loading Bronze Layer';
		print'--------------------------------';

		print'--------------------------------';
		print'Loading CRM Tables';
		print'--------------------------------';

		SET @start_time = GETDATE();
		print'>> Truncating Table: bronze.crm_cust_info';
		Truncate Table bronze.crm_cust_info;

		print'>> inserting data into Table: bronze.crm_cust_info';
		Bulk insert bronze.crm_cust_info
		from 'D:\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
		FirstRow = 2,
		FieldTerminator = ',',
		TabLock
		);
		SET @end_time = GETDATE();
		print '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS nvarchar) + ' second ';
		print '>> ---------------------';

		SET @start_time = GETDATE();
		print'>> Truncating Table: bronze.crm_prd_info';
		Truncate Table bronze.crm_prd_info;

		print'>> inserting data into Table: bronze.crm_prd_info';
		Bulk insert bronze.crm_prd_info
		from 'D:\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
		FirstRow = 2,
		FieldTerminator = ',',
		TabLock
		);
		SET @end_time = GETDATE();
		print '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS nvarchar) + ' second ';
		print '>> ---------------------';

		SET @start_time = GETDATE();
		print'>> Truncating Table: bronze.crm_sales_details';
		Truncate Table bronze.crm_sales_details;

		print'>> inserting data into Table: bronze.crm_sales_details';
		Bulk insert bronze.crm_sales_details
		from 'D:\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
		FirstRow = 2,
		FieldTerminator = ',',
		TabLock
		);
		SET @end_time = GETDATE();
		print '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS nvarchar) + ' second ';
		print '>> ---------------------';

		print'--------------------------------';
		print'Loading ERP Tables';
		print'--------------------------------';

		SET @start_time = GETDATE();
		print'>> Truncating Table: bronze.erp_cust_az12';
		Truncate Table bronze.erp_cust_az12;

		print'>> inserting data into Table: bronze.erp_cust_az12';
		Bulk insert bronze.erp_cust_az12
		from 'D:\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
		FirstRow = 2,
		FieldTerminator = ',',
		TabLock
		);
		SET @end_time = GETDATE();
		print '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS nvarchar) + ' second ';
		print '>> ---------------------';

		SET @start_time = GETDATE();
		print'>> Truncating Table: bronze.erp_loc_a101';
		Truncate Table bronze.erp_loc_a101;

		print'>> inserting data into Table: bronze.erp_loc_a101';
		Bulk insert bronze.erp_loc_a101
		from 'D:\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
		FirstRow = 2,
		FieldTerminator = ',',
		TabLock
		);
		SET @end_time = GETDATE();
		print '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS nvarchar) + ' second ';
		print '>> ---------------------';

		SET @start_time = GETDATE();
		print'>> Truncating Table: bronze.erp_px_cat_g1v2';
		Truncate Table bronze.erp_px_cat_g1v2;

		print'>> inserting data into Table: bronze.erp_px_cat_g1v2';
		Bulk insert bronze.erp_px_cat_g1v2
		from 'D:\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
		FirstRow = 2,
		FieldTerminator = ',',
		TabLock
		);
		SET @end_time = GETDATE();
		print '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS nvarchar) + ' second ';
		print '>> ---------------------';
		SET @batch_end_time  = GETDATE();

		print '================================';
		print 'Loading Bronze Layer is Completed';
		print '  - Total Load Duration: ' + CAST(DATEDIFF(second,@batch_start_time ,@batch_end_time ) AS nvarchar) + ' second ';
		print '================================';
	End Try

	Begin Catch
		print '================================';
		print 'ERROR OCCURED DURING LOADINIG BRONZE LAYER';
		print 'Error Message '+ CAST (ERROR_MESSAGE() As nvarchar);
		print 'Error Message '+ CAST (ERROR_NUMBER() As nvarchar);
		print '================================';
	End Catch
End
