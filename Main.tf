terraform {
  backend "http" {
  }
  required_providers {
    template = {
      source = "hashicorp/template"
    }
    vsphere = {
      source = "hashicorp/vsphere"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}


provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

#module "test" {
module "vs_k8s_master1" {
##### required part #####
  source               = "./vm"
  dc                   = "main"
  vmtemplate           = "Ubu22KubTemplate"
  vmname               = "k8s-master1"
  compute_cluster      = "cluster"
  cpu_number           = "4"
  num_cores_per_socket = "1"
  ram_size             = "8192"
  network_cards        = ["VM Network","s3"]
  datastore            = "other"
  ipv4                 = {"VM Network" = ["192.168.100.10"],"s3hispeed" = ["10.0.0.10"]}
  ipv4submask          = ["16","24"]
  vmgateway            = "192.168.0.1"
  vmdns                = ["192.168.0.1"]
  data_disk_size_gb    = ["50"]
  thin_provisioned     = ["true"]
##### optional part #####
  firmware          = "bios"
  vmdomain          = "net.local"
  vmfolder          = "test"
}

module "vs_k8s_worker1" {
##### required part #####
  source               = "./vm"
  dc                   = "main"
  vmtemplate           = "Ubu22KubTemplate"
  vmname               = "k8s-worker1"
  compute_cluster      = "cluster"
  cpu_number           = "8"
  num_cores_per_socket = "1"
  ram_size             = "16384"
  network_cards        = ["VM Network","s3"]
  datastore            = "other"
  ipv4                 = {"VM Network" = ["192.168.100.11"],"s3hispeed" = ["10.0.0.11"]}
  ipv4submask          = ["16","24"]
  vmgateway            = "192.168.0.1"
  vmdns                = ["192.168.0.1"]
  data_disk_size_gb    = ["50"]
  thin_provisioned     = ["true"]
##### optional part #####
  firmware          = "bios"
  vmdomain          = "net.local"
  vmfolder          = "test"
}

module "vs_k8s_worker2" {
##### required part #####
  source               = "./vm"
  dc                   = "main"
  vmtemplate           = "Ubu22KubTemplate"
  vmname               = "k8s-worker2"
  compute_cluster      = "cluster"
  cpu_number           = "8"
  num_cores_per_socket = "1"
  ram_size             = "16384"
  network_cards        = ["VM Network","s3"]
  datastore            = "other"
  ipv4                 = {"VM Network" = ["192.168.100.12"],"s3hispeed" = ["10.0.0.12"]}
  ipv4submask          = ["16","24"]
  vmgateway            = "192.168.0.1"
  vmdns                = ["192.168.0.1"]
  data_disk_size_gb    = ["50"]
  thin_provisioned     = ["true"]
##### optional part #####
  firmware          = "bios"
  vmdomain          = "net.local"
  vmfolder          = "test"
}

module "vs_k8s_ingress" {
##### required part #####
  source               = "./vm"
  dc                   = "main"
  vmtemplate           = "Ubu22KubTemplate"
  vmname               = "k8s-ingress"
  compute_cluster      = "cluster"
  cpu_number           = "2"
  num_cores_per_socket = "1"
  ram_size             = "4096"
  network_cards        = ["VM Network"]
  datastore            = "other"
  ipv4                 = {"VM Network" = ["192.168.100.20"]}
  ipv4submask          = ["16"]
  vmgateway            = "192.168.0.1"
  vmdns                = ["192.168.0.1"
  thin_provisioned     = ["true"]
##### optional part #####
  firmware          = "bios"
  vmdomain          = "net.local"
  vmfolder          = "test"
}