data "aws_caller_identity" "current" {}

resource "aws_db_instance_automated_backups_replication" "this" {
  count = var.create && var.enable_backup_replication ? 1 : 0

  source_db_instance_arn = aws_db_instance.this[0].arn
  kms_key_id             = "arn:aws:kms:${var.backup_replication_region}:${data.aws_caller_identity.current.account_id}:alias/aws/rds"
  region                 = var.backup_replication_region
  retention_period       = var.backup_replication_retention_days

  # Only needed for MySQL/MariaDB engines
  # pre_signed_url = var.pre_signed_url

  depends_on = [aws_db_instance.this]
}
