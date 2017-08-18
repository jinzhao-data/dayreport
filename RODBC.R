library(RODBC)
library(dplyr)
library(openxlsx)
library(ggplot2)
library(plotly)
options(scipen=200)
options(digits=2)
channel <- odbcConnect("native", uid = "native_data_pm_r", pwd = "nativeads_data_PW4Read",DBMSencoding="GBK")
sq <- sqlQuery(channel, "SELECT 
               company,
               MIN(stdate) AS MIN,
               MAX(stdate) AS MAX,
               DATEDIFF(STR_TO_DATE(MAX(stdate), '%Y-%m-%d'),STR_TO_DATE(MIN(stdate), '%Y-%m-%d')) + 1 AS onlineday,
               COUNT(DISTINCT stdate) AS count,
               SUM(shows) AS Showed,
               SUM(clicks) AS click,
               SUM(charge) AS cost,
               SUM(clicks) / SUM(shows) AS ctr,
               SUM(charge) / SUM(clicks) AS cpc,
               SUM(charge) / SUM(shows) AS cpm
               FROM
               native_report_fc_adver
               WHERE
               stdate BETWEEN '2017-04-01' AND '2017-06-30'
               and user_type = 'KA客户'
               GROUP BY company;")
View(sq)



