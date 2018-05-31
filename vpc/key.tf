resource "aws_key_pair" "key" {
  key_name = "key-${terraform.workspace}"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
