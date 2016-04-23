provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_route53_zone" "201apps" {
    name = "201apps.net"
}

resource "aws_route53_record" "ci" {
    zone_id = "${aws_route53_zone.201apps.zone_id}"
    name = "ci"
    type = "A"
    ttl = "60"
    records = [
        "${aws_instance.jenkins.public_ip}"
    ]
}
