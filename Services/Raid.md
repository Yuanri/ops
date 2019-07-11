# RAID 磁盘阵列



## 1、更换坏损磁盘
#### 软raid 更换磁盘

#### 1.1 查看raid信息

    # cat /proc/mdstat 
    Personalities : [linear] [raid0] [raid1] [raid10] [raid6] [raid5] [raid4] 
    md1 : active raid5 sdm[5] sdl[4] sdk[3] sdj[2] sdi[1] sdh[0]
          9766917440 blocks super 1.2 level 5, 64k chunk, algorithm 2 [6/6] [UUUUUU]
          bitmap: 0/4 pages [0KB], 262144KB chunk

    md0 : active raid5 sdg[5] sdf[4](F) sde[3] sdd[2] sdc[1] sdb[0]
          9766917440 blocks super 1.2 level 5, 64k chunk, algorithm 2 [6/5] [UUUU_U]
          bitmap: 4/4 pages [16KB], 262144KB chunk

#### 1.2 从以上信息，可以看到 md0中的 sdf 磁盘存在问题，先将sdf 标记为失败：
    # mdadm --manage /dev/md0 --fail /dev/sdf
    mdadm: set /dev/sdf faulty in /dev/md0
      
#### 1.3 删除 md0中的 sdf ：
    # mdadm --manage /dev/md0 --remove  /dev/sdf
    mdadm: hot removed /dev/sdf from /dev/md0
    
#### 1.4 再次查看raid信息，md0 中的 sdf 已经不存在了
    # cat /proc/mdstat 
    Personalities : [linear] [raid0] [raid1] [raid10] [raid6] [raid5] [raid4] 
    md1 : active raid5 sdm[5] sdl[4] sdk[3] sdj[2] sdi[1] sdh[0]
          9766917440 blocks super 1.2 level 5, 64k chunk, algorithm 2 [6/6] [UUUUUU]
          bitmap: 0/4 pages [0KB], 262144KB chunk

    md0 : active raid5 sdg[5] sde[3] sdd[2] sdc[1] sdb[0]
          9766917440 blocks super 1.2 level 5, 64k chunk, algorithm 2 [6/5] [UUUU_U]
          bitmap: 4/4 pages [16KB], 262144KB chunk
      
#### 1.5 向 md0中的添加 sdf ：
    # mdadm --manage /dev/md0 --add  /dev/sdf
    mdadm: hot removed /dev/sdf from /dev/md0
