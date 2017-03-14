# 1 hadoop 集群安装部署

## 1.1  环境准备
    Centos 6.5
    hadoop 2.7.3
    java 1.7
    
    创建 hadoop 用户,并设置密码：
    # useradd -m hadoop -s /bin/bash
    # echo 'password' | password --stdin hadoop
    
    依赖环境准备：
    # yum install openssh-clinets openssh-server rsync java-1.7.0.openjdk java-1.7.0.openjdk-devel -y
    
    配置免密码登录：
    # su - hadoop
    $ ssh-keygen
    $ cat .ssh/id_rsd.pub > .ssh/authorized_keys
    $ chmod 600 .ssh/authorized_keys
    
    测试ssh 免密码登录 是否可用：
    $ ssh localhost 
    
## 1.2 Hadoop 安装
### 1.2.1 环境准备
    配置JAVA_HOME 环境变量
    # su - hadoop
    $ echo 'export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk'  >> ~/.bashrc
    $ source ~/.bashrc
    $ java -version
    
### 1.2.2 安装hadoop2
    下载地址：
     http://mirror.bit.edu.cn/apache/hadoop/common/ 
     http://mirrors.cnnic.cn/apache/hadoop/common/ 
     
     我这边下载hadoop-.2.7.3.tar.gz 这是已编译好的，另一个 src 是 hadoop 源代码，需要进行编译才可使用
     
     我这边选择将hadoop 安装在  /data/softwares/
     # tar -zxvf  hadoop-2.7.3.tar.gz -C  /data/softwares/
     # chown -R  hadoop.hadoop  /data/softwares/hadoop-2.7.3 
     # ln -s hadoop-2.7.3  hadoop
     
     测试hadoop 是否可用：
     # su - hadoop
     $ cd  /data/softwares/hadoop
     $ ./bin/hadoop version
     
### 1.2.3 hadoop 单机配置（非分布式）
无需进行其他设置，即 单 java 进程，方便进行调试

    hadoop 自带丰富的例子：
    ./bin/hadoop jar ./share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar
    
    可以看到 workcount、 terasort 、join 、grep等
    测试grep :
    $ cd  /data/softwares/hadoop
    $ mkdir input
    $ cp ./etc/hadoop/*.xml ./input
    $ ./bin/hadoop jar ./share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar grep ./input ./output 'dfs[a-z.]+'
    $ cat ./output
    
    注：output 不能是已存在的文件夹
    注：如果出现提示“INFO metrics.MetricsUtil: Unable to obtain hostName ..... java.net.UnknowHostException” 
    在 /etc/hosts 中添加hostname 的主机记录
    
    
### 1.2.4 hadoop 伪分布配置
hadoop 可以再单节点上以伪分布的方式运行，Hadoop 进程已分离的java 进程来运行，节点既作为 NameNode 也作为 DataNode ，读取的是HDFS中的文件

    
    
    配置hadoop 用户的环境变量：
    编辑  ~/.bashrc   添加如下记录
    export HADOOP_HOME=/data/softwares/hadoop
    export HADOOP_INSTALL=$HADOOP_HOME
    export HADOOP_MAPRED_HOME=$HADOOP_HOME
    export HADOOP_COMMON_HOME=$HADOOP_HOME
    export HADOOP_HDFS_HOME=$HADOOP_HOME
    export YARN_HOME=$HADOOP_HOME
    export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
    export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$JAVA_HOME/bin:$PATH
    
    $ source ~/.bashrc
    
    配置文件路径 hadoop/etc/hadoop
    伪分布式需要两个文件：
    core-site.xml
    hdfs-site.xml
    
    Hadoop的配置文件是 xml 格式，每个配置以声明 property 的 name 和 value 的方式来实现
    修改core-site.xml 为下面的配置：
    <configuration>
      <property>
        <name>hadoop.tmp.dir</name>
        <value>file:/data/softwares/hadoop/tmp</value>
        <description>Abase for other temporary directories.</description>
      </property>
      <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
      </property>
    </configuration>
    
    修改hdfs-site.xml 为下面的配置：
    <configuration>
      <property>
        <name>dfs.replication</name>
        <value>1</value>
      </property>
      <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:/data/softwares/hadoop/tmp/dfs/name</value>
      </property>
      <property>
        <name>dfs.datanode.data.dir</name>
        <value>file:/data/softwares/hadoop/tmp/dfs/data</value>
      </property>
    </configuration>
    
    
    配置完成之后，制定 NameNode 格式化
    $ cd /data/softwares/hadoop
    $ ./bin/hdfs namenode -format
    
    成功的话，会看到 “successfully formatted” 和 “Exitting with status 0” 的提示，若为 “Exitting with status 1” 则是出错
    
    接着开启 NameNode 和 DataNode 守护进程
    $  ./sbin/start-dfs.sh
    
    启动完成后，可以通过命令 jps 来判断是否成功启动，若成功启动则会列出如下进程:
    NameNode
    DataNode
    SecondaryNameNode
    
    如果 SecondaryNameNode 没有启动，请运行 sbin/stop-dfs.sh 关闭进程，然后再次尝试启动尝试）。
    如果没有 NameNode 或 DataNode ，那就是配置不成功，请仔细检查之前步骤，或通过查看启动日志排查原因
    
    成功启动之后，可以访问WEB 界面：  http://localhost:50070
    查看 NameNode 和 DataNode 信息，可以在线查看HDFS 中文件和日志
    
     
     
      
     
