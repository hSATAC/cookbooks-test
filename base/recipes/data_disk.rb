bash "prepare /data disk" do 
  code <<-END
    parted /dev/sdb mklabel gpt
    parted -a optimal /dev/sdb mkpart data 1 100 
    mkfs.ext4 /dev/sdb1
    mkdir /data
    mount -t ext4 /dev/sdb1 /data
  END
  not_if "test -d /data"
end