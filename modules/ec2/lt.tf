resource "aws_launch_template" "web_servers" {
  name                   = "web_servers"
  image_id               = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.web_servers_sg_ids
  user_data              = var.is_custom_user_data ? filebase64(var.user_data_file_path) : ""

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = var.volume_size
      encrypted   = true
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name          = "web-server"
      Description   = "Host the web server"
      ProvisionedBy = "web-servers ASG"
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      Name          = "web-server"
      Description   = "Volume for the web server instance"
      ProvisionedBy = "web-servers ASG"
    }
  }

  tags = {
    Name        = "web_servers"
    Description = "Launch template for the web servers"
  }
}