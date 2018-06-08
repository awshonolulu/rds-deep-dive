module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.mysql_dbname}"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "${var.mysql_instance_type}"
  allocated_storage = 5

  name     = "${var.mysql_dbname}"
  username = "${var.mysql_user}"
  password = "${var.mysql_pass}"
  port     = "${var.mysql_port}"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = ["${aws_security_group.rds_open.id}"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval = "30"

  monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true
  publicly_accessible    = true
  multi_az               = true
  apply_immediately      = true

  tags = "${merge(var.global_tags, map("Name","${var.service}-${var.service_instance}"))}"

  # DB subnet group (in production use database_subnets)
  subnet_ids = ["${module.vpc.public_subnets}"]

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "${var.mysql_dbname}-final"

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8"
    },
    {
      name  = "character_set_server"
      value = "utf8"
    },
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"
    },
  ]
}
