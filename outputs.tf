#----root/outputs.tf----

output "oouve-public-subnet-ids" {
  value = "${module.nacl-public.pub-sub-ids}"
}
output "oouve-private-subnet-ids" {
  value = "${module.nacl-private.pvt-sub-ids}"
}
output "oouve-data-subnet-ids" {
  value = "${module.nacl-data.db-sub-ids}"
}
