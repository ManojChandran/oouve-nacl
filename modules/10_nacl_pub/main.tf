#------------------------------10_nacl_pub/main.tf---------------------------
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#--------------------------------------------------------------------------
#-------------variable section----------------------
variable "vpc-id" {}
variable "pub-subnet-tagname" {}

#-------------data section--------------------------
data "aws_subnet_ids" "oouve-subnet-id" {
  vpc_id = "${var.vpc-id}"

  filter {
    name   = "tag:Name"
    values = ["${var.pub-subnet-tagname}*"]
  }
}

#-------------control section-----------------------
resource "aws_network_acl" "oouve-pub-nacl" {
  vpc_id     = "${var.vpc-id}"
  subnet_ids = "${data.aws_subnet_ids.oouve-subnet-id.ids}"

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 102
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 103
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  #  egress {
  #    protocol = "all"
  #    rule_no = 100
  #    action = "allow"
  #    cidr_block =  "0.0.0.0/0"
  #    from_port = 0
  #    to_port = 65535
  #  }

  egress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = "tcp"
    rule_no    = 102
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "tcp"
    rule_no    = 103
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  tags = {
    Name = "oouve-pub-nacl"
  }
}
#-------------output section------------------------
output "pub-sub-ids" {
  value = "${join(", ", data.aws_subnet_ids.oouve-subnet-id.ids)}"
}
