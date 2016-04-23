resource "aws_security_group" "restrict_jenkins" {
    name = "restrict_jenkins"
    description = "Restrict Jenkins traffic to known IPs"

    # inbound traffic is restricted to known IPs
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [
            "${var.aws_internal_ip_range}",
            "${var.github_ip_range}",
            "${var.home_ip}/32",
        ]
    }

    # outbound traffic has full access
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "jenkins" {
    ami = "${lookup(var.ami_ubuntu_1404_hvmebs, var.aws_region)}"
    instance_type = "t2.micro"
    availability_zone = "${var.aws_availability_zone}"
    security_groups = [
        "${aws_security_group.restrict_jenkins.name}"
    ]

    key_name = "${aws_key_pair.aws_auth.id}"

    connection {
        user = "ubuntu"
    }
}
