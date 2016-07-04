-- Books metadata raw files table
DROP TABLE IF EXISTS BOOKS_META_RAW;
CREATE EXTERNAL TABLE BOOKS_META_RAW 
(
    textcol string
) 
STORED AS TEXTFILE LOCATION '/tmp/bigdatalondon/books_meta';


-- This table contains a row for each 
DROP TABLE IF EXISTS BOOKS_META_ONELINE;
CREATE EXTERNAL TABLE BOOKS_META_ONELINE
(
    book_name string, 
    json_body string
)
STORED AS TEXTFILE LOCATION '/tmp/bigdatalondon/hive_dbs';

INSERT OVERWRITE TABLE BOOKS_META_ONELINE
    SELECT 
            INPUT__FILE__NAME, CONCAT_WS(' ',COLLECT_LIST(textcol))
    FROM 
    (
        SELECT 
            INPUT__FILE__NAME,
            BLOCK__OFFSET__INSIDE__FILE, 
            textcol 
        FROM 
            BOOKS_META_RAW DISTRIBUTE 
                BY 
                    INPUT__FILE__NAME 
        SORT BY 
            BLOCK__OFFSET__INSIDE__FILE
    ) AS x
    GROUP BY 
        INPUT__FILE__NAME;
