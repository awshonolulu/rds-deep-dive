output "mysql_endpoint" {
  value = "${module.db.this_db_instance_endpoint}"
}

output "dbname" {
  value = "${module.db.this_db_instance_name}"
}

output "user" {
  value = "${module.db.this_db_instance_username}"
}

output "pass" {
  value = "************"
}
