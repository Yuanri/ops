## Influxdb
时间序列的数据库

#### 1、常用命令：

    # 创建数据库
    CREATE DATABASE "db_name"
    # 显示所有数据库
    SHOW DATABASES
    # 删除数据库
    DROP DATABASE "db_name"

    # 使用数据库
    USE mydb

    # 显示该数据库中的表
    SHOW MEASUREMENTS

    # 创建表
    # 直接在插入数据的时候指定表名（weather就是表名）
    insert weather,altitude=1000,area=北 temperature=11,humidity=-4


    # 删除单个表：
    DROP MEASUREMENT measurement_name

    # 普通用户删除表：
    DROP SERIES FROM    measurement_name

    # 删除所有的数据
    DROP SERIES FROM /.*/

    # 删除指定的Fields:
    DROP SERIES FROM /.*/ WHERE "your-tag" = 'tag-value-to-delete-data'
