#infra  

module "MODULE_NAME" { #Имя модуля терраформа, разделитель строго "_", уникальное поле  
##### required part #####  
  source               = "./vm" #Указание на директорию с дефолтными переменными  
  dc                   = "DataCenter" #Имя дата-центра в vCenter  
  vmtemplate           = "archlinux" #имя тимплейта в vCenter  
  vmname               = "k8s-master" #имя виртуальной машины, уникальное поле  
  compute_cluster      = "vSAN Cluster" #имя кластера в дата-центре  
  cpu_number           = "4" #количество vCPU  
  num_cores_per_socket = "2" #минимальное количество ядер на сокет, т.к. в серверах по 2 процессора оптимальное значение cpu_number/2  
  ram_size             = "4096" #количество оперативной памяти, не желательно превышать количество физической памяти на одном хосте  
  network_cards        = ["int-vm"] #имена сетей в vCenter, тип list  
  datastore            = "vSAN_AllFlash" #имя дата стораджа в vCenter  
  ipv4                 = {"int-vm" = ["10.1.0.20"]} #назначение ip адресов для каждой из объявленных сетей  
  ipv4submask          = ["24"] #дефолтная маска сети  
  vmgateway            = "10.1.0.1" #дефолт гейтвей, по умолчанию - это NSX  
  vmdns                = ["10.1.0.3"] #дефолт dns  
  data_disk_size_gb    = ["150"] #размер второго диска в Gb  
  data_disk_datastore  = ["vSAN_AllFlash"] #дата сторадж для второго диска  
  thin_provisioned     = ["true"] #включение технологии thin provisioning для всех дисков  
##### optional part #####  
  vmdomain          = "org.local" #домен для vm  
  vmfolder          = "k8s" #папка в рамках vCenter  
}
