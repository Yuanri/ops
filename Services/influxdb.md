## Influxdb
时间序列的数据库

### 1、数据库和表操作：

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

### 2、数据保存策略（Retention Policies）

    # 查看当前数据库的Retention Policies
    SHOW RETENTION POLICIES ON "testDB"

    # 创建新的Retention Policies
    CREATE RETENTION POLICY "rp_name" ON "db_name" DURATION 30d REPLICATION 1 DEFAULT
    其中：
    rp_name：策略名
    db_name：具体的数据库名
    30d：保存30天，30天之前的数据将被删除
    它具有各种时间参数，比如：h（小时），w（星期）
    REPLICATION 1：副本个数，这里填1就可以了
    DEFAULT 设为默认的策略

    # 修改Retention Policies
    ALTER RETENTION POLICY "rp_name" ON db_name" DURATION 3w DEFAULT

    # 删除Retention Policies
    DROP RETENTION POLICY "rp_name" ON "db_name"

### 3、用户管理
    # 显示用户
    SHOW USERS
    # 创建用户
    CREATE USER "username" WITH PASSWORD 'password'
    # 创建管理员权限的用户
    CREATE USER "username" WITH PASSWORD 'password' WITH ALL PRIVILEGES
    
    # 删除用户
    DROP USER "username"
