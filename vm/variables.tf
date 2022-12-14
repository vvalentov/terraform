variable "vmname" {
  description = "The name of the virtual machine used to deploy the vms"
  default     = "terraformvm"
}

variable "vmnamesuffix" {
  description = "vmname suffix after numbered index coming from instance variable"
  default     = ""
}

variable "vmnameliteral" {
  description = "vmname without any suffix or Prefix, only to be used for single instances"
  default     = ""
}

variable "vmtemplate" {
  description = "Name of the template available in the vSphere"
}

variable "instances" {
  description = "number of instances you want deploy from the template"
  default     = 1
}

variable "cpu_number" {
  description = "number of CPU (core per CPU) for the VM"
  default     = 2
}

variable "ram_size" {
  description = "VM RAM size in megabytes"
  default     = 4096
}

variable "network_cards" {
  description = ""
  type        = list(string)
  #type        = string
}

variable "ipv4" {
  description = "host(VM) IP address in map format, support more than one IP. Should correspond to number of instances"
  type        = map(any)
}

variable "ipv4submask" {
  description = "ipv4 Subnet mask"
  type        = list(any)
  default     = ["24"]
}

variable "dc" {
  description = "Name of the datacenter you want to deploy the VM to"
}

variable "compute_cluster" {
  description = "Cluster that VM will be deployed to."
}

variable "ds_cluster" {
  description = "Datastore cluster to deploy the VM."
  default     = ""
}

variable "datastore" {
  description = "Datastore to deploy the VM."
  default     = ""
}


variable "vmfolder" {
  description = "The path to the folder to put this virtual machine in, relative to the datacenter that the resource pool is in."
  default     = null
}

variable "vmgateway" {
  description = "VM gateway to set during provisioning"
  default     = null
}

variable "vmdns" {
  type    = list(string)
  default = null
}

#Global Customization Variables
variable "tags" {
  description = "The names of any tags to attach to this resource. They shoud already exist"
  type        = map(any)
  default     = null
}

variable "custom_attributes" {
  description = "Map of custom attribute ids to attribute value strings to set for virtual machine."
  type        = map(any)
  default     = null
}

variable "extra_config" {
  description = "Extra configuration data for this virtual machine. Can be used to supply advanced parameters not normally in configuration, such as instance metadata.'disk.enableUUID', 'True'"
  type        = map(any)
  default     = null
}

variable "annotation" {
  description = "A user-provided description of the virtual machine. The default is no annotation."
  default     = null
}


variable "linked_clone" {
  description = "Clone this virtual machine from a snapshot. Templates must have a single snapshot only in order to be eligible."
  default     = false
}

variable "timeout" {
  description = "The timeout, in minutes, to wait for the virtual machine clone to complete."
  type        = number
  default     = 30
}

variable "dns_suffix_list" {
  description = "A list of DNS search domains to add to the DNS configuration on the virtual machine."
  type        = list(string)
  default     = null
}

variable "firmware" {
  description = "The firmware interface to use on the virtual machine. Can be one of bios or EFI."
  default     = "efi"
}

variable "num_cores_per_socket" {
  description = "The number of cores to distribute among the CPUs in this virtual machine. If specified, the value supplied to num_cpus must be evenly divisible by this value."
  type        = number
  default     = 1
}


variable "cpu_hot_add_enabled" {
  description = "Allow CPUs to be added to this virtual machine while it is running."
  default     = true
}

variable "cpu_hot_remove_enabled" {
  description = "Allow CPUs to be removed to this virtual machine while it is running."
  default     = null
}

variable "memory_hot_add_enabled" {
  description = "Allow memory to be added to this virtual machine while it is running."
  default     = true
}

variable "latency_sensitivity" {
  description = "Controls the scheduling delay of the virtual machine. Can be one normal or high. If set to high - need to reserve memory and cpu for this VM"
  default     = "normal"
}

variable "cpu_reservation" {
  description = "The amount of CPU (in MHz) that this virtual machine is guaranteed. The default is no reservation."
  default     = null
}

variable "cpu_limit" {
  description = "The maximum amount of CPU (in MHz) that this virtual machine can consume, regardless of available resources. The default is no limit."
  default     = null
}

variable "memory_reservation" {
  description = "The amount of memory (in MB) that this virtual machine is guaranteed. The default is no reservation."
  default     = null
}

variable "memory_limit" {
  description = "The maximum amount of memory (in MB) that this virtual machine can consume, regardless of available resources. The default is no limit."
  default     = null
}

variable "cpu_share_level" {
  description = "The allocation level for CPU resources. Can be one of high, low, normal, or custom."
  default     = "normal"
}

variable "cpu_share_count" {
  description = "The number of CPU shares allocated to the virtual machine when the cpu_share_level is custom."
  default     = null
}

variable "memory_share_level" {
  description = " The allocation level for memory resources. Can be one of high, low, normal, or custom."
  default     = "normal"
}

variable "memory_share_count" {
  description = "The number of memory shares allocated to the virtual machine when the memory_share_level is custom."
  default     = null
}



variable "disk_label" {
  description = "Storage data disk labels"
  type        = list(any)
  default     = []
}

variable "data_disk_label" {
  description = "Storage data disk labels"
  type        = list(any)
  default     = []
}

variable "data_disk_size_gb" {
  description = "List of Storage data disk size"
  type        = list(any)
  default     = []
}

variable "disk_datastore" {
  description = "Define where the OS disk should be stored"
  type        = string
  default     = ""
}

variable "data_disk_datastore" {
  description = "Define where the data disk should be stored, should be equal to number of defined data disks"
  type        = list(any)
  default     = []
  # validation {
  #   condition     = length(var.disk_datastore) == 0 || length(var.disk_datastore) == length(var.data_disk_size_gb)
  #       error_message = "The list of disk datastore must be equal in length to disk_size_gb"
  # }
}

variable "data_disk_scsi_controller" {
  description = "scsi_controller number for the data disk, should be equal to number of defined data disk"
  type        = list(any)
  default     = []
  # validation {
  #   condition     = max(var.data_disk_scsi_controller...) < 4 && max(var.data_disk_scsi_controller...) > -1
  #       error_message = "The scsi_controller must be between 0 and 3"
  # }
}
variable "scsi_type" {
  description = "scsi_controller type, acceptable values lsilogic,pvscsi "
  type        = string
  default     = ""
}

variable "scsi_controller" {
  description = "scsi_controller number for the main OS disk"
  type        = number
  default     = 0
  # validation {
  #   condition     = var.scsi_controller < 4 && var.scsi_controller > -1
  #       error_message = "The scsi_controller must be between 0 and 3"
  # }
}

variable "thin_provisioned" {
  description = "If true, this disk is thin provisioned, with space for the file being allocated on an as-needed basis."
  type        = list(any)
  default     = null
}

variable "eagerly_scrub" {
  description = "if set to true, the disk space is zeroed out on VM creation. This will delay the creation of the disk or virtual machine. Cannot be set to true when thin_provisioned is true."
  type        = list(any)
  default     = null
}

variable "enable_disk_uuid" {
  description = "Expose the UUIDs of attached virtual disks to the virtual machine, allowing access to them in the guest."
  default     = null
}

variable "network_type" {
  description = "Define network type for each network interface"
  type        = list(any)
  default     = null
}

#Linux Customization Variables
variable "hw_clock_utc" {
  description = "Tells the operating system that the hardware clock is set to UTC"
  default     = true
}

variable "vmdomain" {
  description = "default VM domain for linux guest customization"
  default     = "Development.com"
}


#Windows Customization Variables
variable "is_windows_image" {
  description = "Boolean flag to notify when the custom image is windows based."
  default     = false
}

variable "local_adminpass" {
  description = "The administrator password for this virtual machine.(Required) when using join_windomain option"
  default     = null
}

variable "workgroup" {
  description = "The workgroup name for this virtual machine. One of this or join_domain must be included."
  default     = null
}

variable "windomain" {
  description = "The domain to join for this virtual machine. One of this or workgroup must be included."
  default     = null
}

variable "domain_admin_user" {
  description = "Domain admin user to join the server to AD.(Required) when using join_windomain option"
  default     = null
}

variable "domain_admin_password" {
  description = "Doamin User pssword to join the server to AD.(Required) when using join_windomain option"
  default     = null
}

variable "orgname" {
  description = "Organization name for when joining windows server to AD"
  default     = null
}

variable "auto_logon" {
  description = " Specifies whether or not the VM automatically logs on as Administrator. Default: false"
  default     = null
}

variable "auto_logon_count" {
  description = "Specifies how many times the VM should auto-logon the Administrator account when auto_logon is true. This should be set accordingly to ensure that all of your commands that run in run_once_command_list can log in to run"
  default     = null
}

variable "time_zone" {
  description = "The new time zone for the virtual machine. This is a numeric, sysprep-dictated, timezone code."
  default     = null
}

variable "run_once" {
  description = "List of Comamnd to run during first logon (Automatic login set to 1)"
  type        = list(string)
  default     = null
}

variable "productkey" {
  description = "Product key to be used during windows customization."
  default     = null
}

variable "full_name" {
  description = "The full name of the user of this virtual machine. This populates the user field in the general Windows system information. Default - Administrator"
  default     = null
}

variable "wait_for_guest_net_routable" {
  description = "Controls whether or not the guest network waiter waits for a routable address. When false, the waiter does not wait for a default gateway, nor are IP addresses checked against any discovered default gateways as part of its success criteria. This property is ignored if the wait_for_guest_ip_timeout waiter is used."
  default     = true
  type        = bool
}

variable "wait_for_guest_ip_timeout" {
  description = "The amount of time, in minutes, to wait for an available guest IP address on this virtual machine. This should only be used if your version of VMware Tools does not allow the wait_for_guest_net_timeout waiter to be used. A value less than 1 disables the waiter."
  default     = 0
  type        = number
}

variable "wait_for_guest_net_timeout" {
  description = "The amount of time, in minutes, to wait for an available IP address on this virtual machine's NICs. Older versions of VMware Tools do not populate this property. In those cases, this waiter can be disabled and the wait_for_guest_ip_timeout waiter can be used instead. A value less than 1 disables the waiter."
  default     = 5
  type        = number
}

variable "vm_depends_on" {
  description = "Add any external depend on module here like vm_depends_on = [module.fw_core01.firewall]"
  type        = any
  default     = null
}

variable "data_disk_attach_path" {
  description = "data_disk_attach_path"
  type        = list(any)
  default     = []
}
