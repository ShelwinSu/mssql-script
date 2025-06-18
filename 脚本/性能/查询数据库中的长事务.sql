

-- =============================================
-- Create date: <2014/4/18>
-- Description: 查询数据库中的长事务
-- =============================================


SELECT  b.[session_id] , 
        b.[open_transaction_count],
		b.[total_elapsed_time],
        a.[name] AS 'transaction_name',
        b.[command] ,
        a.[transaction_begin_time] ,
	DATEDIFF(MINUTE, transaction_begin_time, GETDATE()) AS duration_minutes,  --事务已存在的时间（用分钟表示）
        b.[blocking_session_id] ,
        DB_NAME(b.[database_id]) AS 'current_dbname'
FROM    sys.[dm_tran_active_transactions] AS a
        INNER JOIN sys.[dm_exec_requests] AS b ON a.[transaction_id] = b.[transaction_id]
		WHERE [b].[database_id]=DB_ID()
                 AND transaction_begin_time  BETWEEN '2025-06-17 23:16:00' AND '2025-06-18 01:00:33' 
	        --DATEDIFF(HOUR, transaction_begin_time, GETDATE()) >= 1;


