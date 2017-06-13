# AWS client Command

### 常用命令 
    #检查EC2 实例状态 
    aws ec2 describe-instance-status

    #过滤实例状态异常的EC2
    aws ec2 describe-instance-status --filters Name=instance-status.status,Values=impaired

    #查看指定EC2 实例状态
    aws ec2 describe-instance-status --instance-ids i-1234567890abcdef0

    # 反馈状态异常的EC2实例
    aws ec2 report-instance-status --instances i-1234567890abcdef0 --status impaired --reason-codes code

    #查看可用的地理区域
    aws ec2 describe-regions

    #查看指定region 可用zone
    aws ec2 describe-availability-zones --region region-name
