resource "aws_instance" "helloworld" {
  ami           = "ami-03326c3f2f37e56a4"
  instance_type = "t2.micro"
  tags = {
    "Name" = "HelloWorld"
  }
}
