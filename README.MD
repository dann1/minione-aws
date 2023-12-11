# minione + terraform + aws

This is a small example of how to quickly deploy [minione](https://github.com/OpenNebula/minione) on AWS using terraform.

## Requirements

- [terraform](https://github.com/hashicorp/terraform) and the [AWS provider](https://github.com/hashicorp/terraform-provider-aws) for terraform.
  - For this you'll need [awscli](https://aws.amazon.com/cli/) properly setup with your [API Key](https://aws.amazon.com/what-is/api-key/) for your IAM user.
- An AWS [VPC](https://docs.aws.amazon.com/vpc/latest/userguide/) with a [public subnet](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html#subnet-types).
- An [SSH key pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html) for your IAM user on AWS.


## Configure

Setup your `terraform.tfvars` file at the project root level with the requirements mentioned above and the EC2 instance configuration

```hcl
vpc_id = "your_vpc_id"
subnet_id = "your_public_subnet_id"
instance_type = "t2.small"
ami_id       = "ami-0fc5d935ebf8bc3bc" # Ubuntu 2204
volume_size  = 25

ssh_key = "your_ssh_key_pair_name"
ssh_key_path = "your_private_ssh_key_path"
ssh_user = "ubuntu" # required by the AMI in this example

one_version = "6.8"
one_ee = "--enterprise <your_ee_token>" # or leave empty string as "" for CE install
one_password = "opennebula"
one_sunstone_port = "80"
one_fireedge_port = "443"
```




## Use

Issue `terraform init` to gather the AWS provider and `terraform apply` to create the minione instance. Should take about **7 minutes**. Upon completion you should receive a message with the connection details

```
Outputs:

ssh_connection = ssh -i ~/.ssh/aws_one_dclavijo.pem ubuntu@ec2-100-25-198-47.compute-1.amazonaws.com
```

Example run

```
 ~/P/t/aws-minione   …  terraform apply --auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.minione will be created
  + resource "aws_instance" "minione" {
      + ami                                  = "ami-0fc5d935ebf8bc3bc"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.small"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "dclavijo"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = "subnet-0bd619242b4e583c2"
      + tags                                 = {
          + "Name" = "minione"
        }
      + tags_all                             = {
          + "Name" = "minione"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + root_block_device {
          + delete_on_termination = true
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = 25
          + volume_type           = (known after apply)
        }
    }

  # aws_security_group.allow_web will be created
  + resource "aws_security_group" "allow_web" {
      + arn                    = (known after apply)
      + description            = "Allow Web inbound traffic"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTP"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTPS"
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
        ]
      + name                   = "allow_web_traffic"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = "vpc-36fbf74d"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + ssh_connection = (known after apply)
aws_security_group.allow_web: Creating...
aws_instance.minione: Creating...
aws_security_group.allow_web: Creation complete after 3s [id=sg-08646393c665083e6]
aws_instance.minione: Still creating... [10s elapsed]
aws_instance.minione: Still creating... [20s elapsed]
aws_instance.minione: Still creating... [30s elapsed]
aws_instance.minione: Provisioning with 'remote-exec'...
Connecting to remote host via SSH...
  Host: ec2-100-25-198-47.compute-1.amazonaws.com
  User: ubuntu
  Password: false
  Private key: true
  Certificate: false
  SSH Agent: true
  Checking Host Key: false
  Target Platform: unix
Connecting to remote host via SSH...
  Host: ec2-100-25-198-47.compute-1.amazonaws.com
  User: ubuntu
  Password: false
  Private key: true
  Certificate: false
  SSH Agent: true
  Checking Host Key: false
  Target Platform: unix
aws_instance.minione: Still creating... [40s elapsed]
Connecting to remote host via SSH...
  Host: ec2-100-25-198-47.compute-1.amazonaws.com
  User: ubuntu
  Password: false
  Private key: true
  Certificate: false
  SSH Agent: true
  Checking Host Key: false
  Target Platform: unix
Connecting to remote host via SSH...
  Host: ec2-100-25-198-47.compute-1.amazonaws.com
  User: ubuntu
  Password: false
  Private key: true
  Certificate: false
  SSH Agent: true
  Checking Host Key: false
  Target Platform: unix
Connected!
aws_instance.minione (remote-exec):
0% [Working]
Get:1 http://security.ubuntu.com/ubuntu jammy-security InRelease [110 kB]
aws_instance.minione (remote-exec):
0% [Connecting to archive.ubuntu.com] [
0% [Connecting to archive.ubuntu.com]
Hit:2 http://archive.ubuntu.com/ubuntu jammy InRelease
aws_instance.minione (remote-exec):
0% [Waiting for headers]
Get:3 http://archive.ubuntu.com/ubuntu jammy-updates InRelease [119 kB]
aws_instance.minione (remote-exec):
0% [3 InRelease 14.2 kB/119 kB 12%]
aws_instance.minione (remote-exec):
0% [Waiting for headers]
Get:4 http://archive.ubuntu.com/ubuntu jammy-backports InRelease [109 kB]
aws_instance.minione (remote-exec):
0% [4 InRelease 12.7 kB/109 kB 12%]
0% [4 InRelease 38.8 kB/109 kB 36%]
Get:5 http://security.ubuntu.com/ubuntu jammy-security/main amd64 Packages [1016 kB]
aws_instance.minione (remote-exec):
0% [4 InRelease 64.9 kB/109 kB 60%] [5
0% [5 Packages 1012 kB/1016 kB 100%]
0% [Working]
Get:6 http://security.ubuntu.com/ubuntu jammy-security/main Translation-en [195 kB]
Get:7 http://security.ubuntu.com/ubuntu jammy-security/main amd64 c-n-f Metadata [11.4 kB]
Get:8 http://security.ubuntu.com/ubuntu jammy-security/restricted amd64 Packages [1179 kB]
aws_instance.minione (remote-exec):
0% [8 Packages 54.8 kB/1179 kB 5%]
0% [5 Packages store 0 B] [8 Packages 3
0% [5 Packages store 0 B]
Get:9 http://security.ubuntu.com/ubuntu jammy-security/restricted Translation-en [191 kB]
aws_instance.minione (remote-exec):
0% [5 Packages store 0 B] [9 Translatio
0% [5 Packages store 0 B]
Get:10 http://security.ubuntu.com/ubuntu jammy-security/restricted amd64 c-n-f Metadata [520 B]
aws_instance.minione (remote-exec):
0% [5 Packages store 0 B] [10 Commands-
0% [5 Packages store 0 B]
Get:11 http://security.ubuntu.com/ubuntu jammy-security/universe amd64 Packages [815 kB]
aws_instance.minione (remote-exec):
0% [5 Packages store 0 B] [11 Packages
0% [5 Packages store 0 B]
Get:12 http://security.ubuntu.com/ubuntu jammy-security/universe Translation-en [152 kB]
aws_instance.minione (remote-exec):
0% [5 Packages store 0 B] [12 Translati
0% [5 Packages store 0 B]
Get:13 http://security.ubuntu.com/ubuntu jammy-security/universe amd64 c-n-f Metadata [16.8 kB]
aws_instance.minione (remote-exec):
0% [5 Packages store 0 B] [13 Commands-
0% [5 Packages store 0 B]
Get:14 http://security.ubuntu.com/ubuntu jammy-security/multiverse amd64 Packages [36.5 kB]
aws_instance.minione (remote-exec):
0% [5 Packages store 0 B] [14 Packages
0% [5 Packages store 0 B]
Get:15 http://security.ubuntu.com/ubuntu jammy-security/multiverse Translation-en [7060 B]
aws_instance.minione (remote-exec):
0% [5 Packages store 0 B] [15 Translati
0% [5 Packages store 0 B]
Get:16 http://security.ubuntu.com/ubuntu jammy-security/multiverse amd64 c-n-f Metadata [260 B]
aws_instance.minione: Still creating... [50s elapsed]
aws_instance.minione (remote-exec):
0% [5 Packages store 0 B] [16 Commands-
0% [5 Packages store 0 B]
aws_instance.minione (remote-exec):
0% [5 Packages store 0 B]
0% [Waiting for headers]
0% [6 Translation-en store 0 B] [Waitin
Get:17 http://archive.ubuntu.com/ubuntu jammy/universe amd64 Packages [14.1 MB]
aws_instance.minione (remote-exec):
0% [6 Translation-en store 0 B] [17 Pac
aws_instance.minione (remote-exec):
0% [17 Packages 567 kB/14.1 MB 4%]
0% [7 Commands-amd64 store 0 B] [17 Pac
0% [17 Packages 633 kB/14.1 MB 4%]
0% [8 Packages store 0 B] [17 Packages
aws_instance.minione (remote-exec):
0% [8 Packages store 0 B] [17 Packages
aws_instance.minione (remote-exec):
0% [8 Packages store 0 B]
Get:18 http://archive.ubuntu.com/ubuntu jammy/universe Translation-en [5652 kB]
aws_instance.minione (remote-exec):
0% [8 Packages store 0 B] [18 Translati
0% [18 Translation-en 798 kB/5652 kB 14
0% [9 Translation-en store 0 B] [18 Tra
aws_instance.minione (remote-exec):
70% [9 Translation-en store 0 B] [18 Tr
aws_instance.minione (remote-exec):
78% [18 Translation-en 5652 kB/5652 kB
78% [10 Commands-amd64 store 0 B] [18 T
78% [18 Translation-en 5652 kB/5652 kB
78% [11 Packages store 0 B] [18 Transla
Get:19 http://archive.ubuntu.com/ubuntu jammy/universe amd64 c-n-f Metadata [286 kB]
aws_instance.minione (remote-exec):
79% [11 Packages store 0 B] [19 Command
79% [11 Packages store 0 B]
Get:20 http://archive.ubuntu.com/ubuntu jammy/multiverse amd64 Packages [217 kB]
aws_instance.minione (remote-exec):
79% [11 Packages store 0 B] [20 Package
80% [11 Packages store 0 B]
Get:21 http://archive.ubuntu.com/ubuntu jammy/multiverse Translation-en [112 kB]
aws_instance.minione (remote-exec):
80% [11 Packages store 0 B] [21 Transla
80% [11 Packages store 0 B]
Get:22 http://archive.ubuntu.com/ubuntu jammy/multiverse amd64 c-n-f Metadata [8372 B]
aws_instance.minione (remote-exec):
80% [11 Packages store 0 B] [22 Command
80% [11 Packages store 0 B]
Get:23 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 Packages [1244 kB]
aws_instance.minione (remote-exec):
80% [11 Packages store 0 B] [23 Package
84% [11 Packages store 0 B]
Get:24 http://archive.ubuntu.com/ubuntu jammy-updates/main Translation-en [257 kB]
aws_instance.minione (remote-exec):
84% [11 Packages store 0 B] [24 Transla
84% [11 Packages store 0 B]
Get:25 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 c-n-f Metadata [16.1 kB]
aws_instance.minione (remote-exec):
84% [11 Packages store 0 B] [25 Command
85% [25 Commands-amd64 14.2 kB/16.1 kB
85% [12 Translation-en store 0 B] [25 C
85% [12 Translation-en store 0 B] [Wait
85% [Waiting for headers]
85% [13 Commands-amd64 store 0 B] [Wait
85% [Waiting for headers]
85% [14 Packages store 0 B] [Waiting fo
85% [Waiting for headers]
85% [15 Translation-en store 0 B] [Wait
Get:26 http://archive.ubuntu.com/ubuntu jammy-updates/restricted amd64 Packages [1226 kB]
aws_instance.minione (remote-exec):
85% [15 Translation-en store 0 B] [26 P
86% [26 Packages 2655 B/1226 kB 0%]
86% [16 Commands-amd64 store 0 B] [26 P
86% [26 Packages 5551 B/1226 kB 0%]
86% [17 Packages store 0 B] [26 Package
aws_instance.minione (remote-exec):
88% [17 Packages store 0 B] [26 Package
89% [17 Packages store 0 B]
Get:27 http://archive.ubuntu.com/ubuntu jammy-updates/restricted Translation-en [199 kB]
aws_instance.minione (remote-exec):
89% [17 Packages store 0 B] [27 Transla
Get:28 http://archive.ubuntu.com/ubuntu jammy-updates/restricted amd64 c-n-f Metadata [520 B]
aws_instance.minione (remote-exec):
90% [17 Packages store 0 B] [28 Command
Get:29 http://archive.ubuntu.com/ubuntu jammy-updates/universe amd64 Packages [1018 kB]
aws_instance.minione (remote-exec):
90% [17 Packages store 0 B] [29 Package
93% [17 Packages store 0 B]
Get:30 http://archive.ubuntu.com/ubuntu jammy-updates/universe Translation-en [226 kB]
aws_instance.minione (remote-exec):
93% [17 Packages store 0 B] [30 Transla
93% [17 Packages store 0 B]
Get:31 http://archive.ubuntu.com/ubuntu jammy-updates/universe amd64 c-n-f Metadata [22.1 kB]
aws_instance.minione (remote-exec):
93% [17 Packages store 0 B] [31 Command
93% [17 Packages store 0 B]
Get:32 http://archive.ubuntu.com/ubuntu jammy-updates/multiverse amd64 Packages [41.6 kB]
aws_instance.minione (remote-exec):
93% [17 Packages store 0 B] [32 Package
93% [17 Packages store 0 B]
Get:33 http://archive.ubuntu.com/ubuntu jammy-updates/multiverse Translation-en [9768 B]
aws_instance.minione (remote-exec):
93% [17 Packages store 0 B] [33 Transla
93% [17 Packages store 0 B]
Get:34 http://archive.ubuntu.com/ubuntu jammy-updates/multiverse amd64 c-n-f Metadata [472 B]
aws_instance.minione (remote-exec):
93% [17 Packages store 0 B] [34 Command
93% [17 Packages store 0 B]
Get:35 http://archive.ubuntu.com/ubuntu jammy-backports/main amd64 Packages [64.2 kB]
aws_instance.minione (remote-exec):
94% [17 Packages store 0 B] [35 Package
Get:36 http://archive.ubuntu.com/ubuntu jammy-backports/main Translation-en [10.5 kB]
aws_instance.minione (remote-exec):
94% [17 Packages store 0 B] [36 Transla
94% [17 Packages store 0 B] [Waiting fo
Get:37 http://archive.ubuntu.com/ubuntu jammy-backports/main amd64 c-n-f Metadata [388 B]
Get:38 http://archive.ubuntu.com/ubuntu jammy-backports/restricted amd64 c-n-f Metadata [116 B]
Get:39 http://archive.ubuntu.com/ubuntu jammy-backports/universe amd64 Packages [27.8 kB]
aws_instance.minione (remote-exec):
94% [17 Packages store 0 B] [39 Package
Get:40 http://archive.ubuntu.com/ubuntu jammy-backports/universe Translation-en [16.5 kB]
aws_instance.minione (remote-exec):
94% [17 Packages store 0 B] [40 Transla
Get:41 http://archive.ubuntu.com/ubuntu jammy-backports/universe amd64 c-n-f Metadata [644 B]
Get:42 http://archive.ubuntu.com/ubuntu jammy-backports/multiverse amd64 c-n-f Metadata [116 B]
aws_instance.minione (remote-exec):
94% [17 Packages store 0 B]
aws_instance.minione (remote-exec):
94% [17 Packages store 0 B]
aws_instance.minione (remote-exec):
94% [17 Packages store 0 B]
aws_instance.minione (remote-exec):
94% [17 Packages store 0 B]
aws_instance.minione (remote-exec):
94% [17 Packages store 0 B]
aws_instance.minione (remote-exec):
94% [17 Packages store 0 B]
aws_instance.minione (remote-exec):
94% [17 Packages store 0 B]
94% [Working]              4722 kB/s 0s
94% [18 Translation-en store 0 B]
aws_instance.minione (remote-exec):
94% [18 Translation-en store 0 B]
aws_instance.minione (remote-exec):
94% [18 Translation-en store 0 B]
aws_instance.minione (remote-exec):
94% [Working]              4722 kB/s 0s
94% [19 Commands-amd64 store 0 B]
95% [Working]              4722 kB/s 0s
95% [20 Packages store 0 B]
95% [Working]              4722 kB/s 0s
95% [21 Translation-en store 0 B]
95% [Working]              4722 kB/s 0s
95% [22 Commands-amd64 store 0 B]
95% [Working]              4722 kB/s 0s
95% [23 Packages store 0 B]
aws_instance.minione (remote-exec):
95% [Working]              4722 kB/s 0s
95% [24 Translation-en store 0 B]
aws_instance.minione (remote-exec):
96% [Working]              4722 kB/s 0s
96% [25 Commands-amd64 store 0 B]
96% [Working]              4722 kB/s 0s
96% [26 Packages store 0 B]
aws_instance.minione (remote-exec):
96% [Working]              4722 kB/s 0s
96% [27 Translation-en store 0 B]
aws_instance.minione (remote-exec):
96% [Working]              4722 kB/s 0s
96% [28 Commands-amd64 store 0 B]
97% [Working]              4722 kB/s 0s
97% [29 Packages store 0 B]
aws_instance.minione (remote-exec):
97% [Working]              4722 kB/s 0s
97% [30 Translation-en store 0 B]
97% [Working]              4722 kB/s 0s
97% [31 Commands-amd64 store 0 B]
97% [Working]              4722 kB/s 0s
97% [32 Packages store 0 B]
98% [Working]              4722 kB/s 0s
98% [33 Translation-en store 0 B]
98% [Working]              4722 kB/s 0s
98% [34 Commands-amd64 store 0 B]
98% [Working]              4722 kB/s 0s
98% [35 Packages store 0 B]
98% [Working]              4722 kB/s 0s
98% [36 Translation-en store 0 B]
99% [Working]              4722 kB/s 0s
99% [37 Commands-amd64 store 0 B]
99% [Working]              4722 kB/s 0s
99% [38 Commands-amd64 store 0 B]
99% [Working]              4722 kB/s 0s
99% [39 Packages store 0 B]
99% [Working]              4722 kB/s 0s
99% [40 Translation-en store 0 B]
100% [Working]             4722 kB/s 0s
100% [41 Commands-amd64 store 0 B]
100% [Working]             4722 kB/s 0s
100% [42 Commands-amd64 store 0 B]
100% [Working]             4722 kB/s 0s
Fetched 28.7 MB in 11s (2701 kB/s)
WARNING:root:cannot read /var/lib/command-not-found/commands.db.metadata: [Errno 2] No such file or directory: '/var/lib/apt/lists/archive.ubuntu.com_ubuntu_dists_jammy_restricted_cnf_Commands-amd64'
E: Could not open file /var/lib/apt/lists/archive.ubuntu.com_ubuntu_dists_jammy_restricted_cnf_Commands-amd64 - open (2: No such file or directory)
aws_instance.minione: Still creating... [1m0s elapsed]
Traceback (most recent call last):
  File "/usr/lib/cnf-update-db", line 32, in <module>
    col.create(db)
  File "/usr/lib/python3/dist-packages/CommandNotFound/db/creator.py", line 95, in create
    self._fill_commands(con)
  File "/usr/lib/python3/dist-packages/CommandNotFound/db/creator.py", line 144, in _fill_commands
    raise subprocess.CalledProcessError(returncode=sub.returncode,
subprocess.CalledProcessError: Command '/usr/lib/apt/apt-helper cat-file /var/lib/apt/lists/archive.ubuntu.com_ubuntu_dists_jammy_restricted_cnf_Commands-amd64' returned non-zero exit status 100.
Reading package lists... 0%
Reading package lists... 0%
Reading package lists... 0%
Reading package lists... 20%
Reading package lists... 20%
Reading package lists... 32%
Reading package lists... 32%
Reading package lists... 58%
Reading package lists... 58%
Reading package lists... 72%
Reading package lists... 72%
Reading package lists... 90%
Reading package lists... 90%
Reading package lists... 96%
Reading package lists... 96%
Reading package lists... 97%
Reading package lists... 97%
Reading package lists... 97%
Reading package lists... 97%
Reading package lists... Done
E: Problem executing scripts APT::Update::Post-Invoke-Success 'if /usr/bin/test -w /var/lib/command-not-found/ -a -e /usr/lib/cnf-update-db; then /usr/lib/cnf-update-db > /dev/null; fi'
E: Sub-process returned an error code
Reading package lists... 0%
Reading package lists... 0%
Reading package lists... 0%
Reading package lists... 4%
Reading package lists... 4%
Reading package lists... 5%
Reading package lists... 5%
Reading package lists... 6%
Reading package lists... 6%
Reading package lists... 6%
Reading package lists... 6%
Reading package lists... 27%
Reading package lists... 45%
Reading package lists... 45%
Reading package lists... 61%
Reading package lists... 63%
Reading package lists... 63%
Reading package lists... 64%
Reading package lists... 64%
Reading package lists... 64%
Reading package lists... 64%
Reading package lists... 68%
Reading package lists... 68%
Reading package lists... 70%
Reading package lists... 70%
Reading package lists... 75%
Reading package lists... 75%
Reading package lists... 77%
Reading package lists... 77%
Reading package lists... 81%
Reading package lists... 81%
Reading package lists... 82%
Reading package lists... 82%
Reading package lists... 82%
Reading package lists... 82%
Reading package lists... 82%
Reading package lists... 82%
Reading package lists... 83%
Reading package lists... 83%
Reading package lists... 83%
Reading package lists... 83%
Reading package lists... 83%
Reading package lists... 83%
Reading package lists... 83%
Reading package lists... 83%
Reading package lists... 86%
Reading package lists... 86%
Reading package lists... 88%
Reading package lists... 88%
Reading package lists... 93%
Reading package lists... 93%
Reading package lists... 95%
Reading package lists... 95%
Reading package lists... 98%
Reading package lists... 98%
Reading package lists... 99%
Reading package lists... 99%
Reading package lists... 99%
Reading package lists... 99%
Reading package lists... 99%
Reading package lists... 99%
Reading package lists... Done
Building dependency tree... 0%
Building dependency tree... 0%
Building dependency tree... 0%
Building dependency tree... 50%
Building dependency tree... 50%
Building dependency tree... Done
Reading state information... 0%
Reading state information... 0%
Reading state information... Done
ca-certificates is already the newest version (20230311ubuntu0.22.04.1).
ca-certificates set to manually installed.
0 upgraded, 0 newly installed, 0 to remove and 74 not upgraded.
--2023-12-10 16:52:29--  https://github.com/OpenNebula/minione/releases/latest/download/minione
Resolving github.com (github.com)... 140.82.113.4
Connecting to github.com (github.com)|140.82.113.4|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://github.com/OpenNebula/minione/releases/download/v6.8.0.2/minione [following]
--2023-12-10 16:52:29--  https://github.com/OpenNebula/minione/releases/download/v6.8.0.2/minione
Reusing existing connection to github.com:443.
HTTP request sent, awaiting response... 302 Found
Location: https://objects.githubusercontent.com/github-production-release-asset-2e65be/159492522/edbb2b6c-a9e9-4c04-811e-70e7b0118bd7?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20231210%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20231210T165229Z&X-Amz-Expires=300&X-Amz-Signature=5dc99c97ce31fb984f3a3193d5f128fa25b0c6fa3e16ad4952b1160baf86855f&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=159492522&response-content-disposition=attachment%3B%20filename%3Dminione&response-content-type=application%2Foctet-stream [following]
--2023-12-10 16:52:29--  https://objects.githubusercontent.com/github-production-release-asset-2e65be/159492522/edbb2b6c-a9e9-4c04-811e-70e7b0118bd7?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20231210%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20231210T165229Z&X-Amz-Expires=300&X-Amz-Signature=5dc99c97ce31fb984f3a3193d5f128fa25b0c6fa3e16ad4952b1160baf86855f&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=159492522&response-content-disposition=attachment%3B%20filename%3Dminione&response-content-type=application%2Foctet-stream
Resolving objects.githubusercontent.com (objects.githubusercontent.com)... 185.199.110.133, 185.199.111.133, 185.199.108.133, ...
Connecting to objects.githubusercontent.com (objects.githubusercontent.com)|185.199.110.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 50762 (50K) [application/octet-stream]
Saving to: ‘minione’

minione        0%       0  --.-KB/s
minione      100%  49.57K  --.-KB/s    in 0.001s

2023-12-10 16:52:29 (42.6 MB/s) - ‘minione’ saved [50762/50762]


### Checks & detection
Checking cpu virtualization capabilities  SKIP QEMU will be used
Checking augeas is installed  SKIP will try to install
Checking apt-transport-https is installed  SKIP will try to install
Checking AppArmor  SKIP will try to modify
aws_instance.minione: Still creating... [1m10s elapsed]
Checking for present ssh key  SKIP
Checking (iptables|netfilter)-persistent are installed  SKIP will try to install
Checking docker is installed  SKIP will try to install
Checking python3-pip is installed  SKIP will try to install
Checking ansible  SKIP will try to install
Checking terraform  SKIP will try to install
Checking unzip is installed  SKIP will try to install

### Main deployment steps:
Install OpenNebula frontend version 6.8
Install Terraform
Install Docker
Configure bridge minionebr with IP 172.16.100.1/24
Enable NAT over eth0
Modify AppArmor
Install OpenNebula KVM node
Export appliance and update VM template
Install  augeas-tools apt-transport-https iptables-persistent netfilter-persistent python3-pip unzip
Install pip 'ansible==2.9.9'

Do you agree? [yes/no]:

### Installation
Updating APT cache
aws_instance.minione: Still creating... [1m20s elapsed]
OK
Install  augeas-tools apt-transport-https iptables-persistent netfilter-persistent python3-pip unzip
aws_instance.minione: Still creating... [1m30s elapsed]
aws_instance.minione: Still creating... [1m40s elapsed]
aws_instance.minione: Still creating... [1m50s elapsed]
aws_instance.minione: Still creating... [2m0s elapsed]
OK
Updating PIP
OK
Install from PyPI 'ansible==2.9.9'
aws_instance.minione: Still creating... [2m10s elapsed]
aws_instance.minione: Still creating... [2m20s elapsed]
OK
Creating bridge interface minionebr  OK
Bring bridge interfaces up
aws_instance.minione: Still creating... [2m30s elapsed]
OK
Enabling IPv4 forward  OK
Persisting IPv4 forward  OK
Configuring NAT using iptables  OK
Saving iptables changes  OK
Installing DNSMasq
OK
Starting DNSMasq
OK
Configuring repositories
OK
Updating APT cache
aws_instance.minione: Still creating... [2m40s elapsed]
OK
Installing OpenNebula packages
aws_instance.minione: Still creating... [2m50s elapsed]
aws_instance.minione: Still creating... [3m0s elapsed]
aws_instance.minione: Still creating... [3m10s elapsed]
aws_instance.minione: Still creating... [3m20s elapsed]
aws_instance.minione: Still creating... [3m30s elapsed]
aws_instance.minione: Still creating... [3m40s elapsed]
aws_instance.minione: Still creating... [3m50s elapsed]
aws_instance.minione: Still creating... [4m0s elapsed]
aws_instance.minione: Still creating... [4m10s elapsed]
aws_instance.minione: Still creating... [4m20s elapsed]
OK
Installing opennebula-provision package
aws_instance.minione: Still creating... [4m30s elapsed]
OK
Installing TerraForm
OK
Create docker packages repository
aws_instance.minione: Still creating... [4m40s elapsed]
OK
Install docker
aws_instance.minione: Still creating... [4m50s elapsed]
aws_instance.minione: Still creating... [5m0s elapsed]
aws_instance.minione: Still creating... [5m10s elapsed]
OK
Start docker service  OK
Enable docker service
OK
Installing OpenNebula kvm node packages
aws_instance.minione: Still creating... [5m20s elapsed]
aws_instance.minione: Still creating... [5m30s elapsed]
aws_instance.minione: Still creating... [5m40s elapsed]
aws_instance.minione: Still creating... [5m50s elapsed]
aws_instance.minione: Still creating... [6m0s elapsed]
OK
Updating AppArmor
OK
Disable default libvirtd networking  OK
Restart libvirtd  OK

### Configuration
Generating ssh keypair in /root/.ssh-oneprovision/id_rsa
OK
Add oneadmin to docker group  OK
Update network hooks  OK
Switching OneGate endpoint in oned.conf
OK
Switching OneGate endpoint in onegate-server.conf  OK
Switching keep_empty_bridge on in OpenNebulaNetwork.conf  OK
Switching scheduler interval in oned.conf
aws_instance.minione: Still creating... [6m10s elapsed]
OK
Setting initial password for current user and oneadmin  OK
Changing WebUI to listen on port 80  OK
Switching FireEdge public endpoint  OK
Starting OpenNebula services
aws_instance.minione: Still creating... [6m20s elapsed]
OK
Enabling OpenNebula services
OK
Add ssh key to oneadmin user
OK
Update ssh configs to allow VM addresses reusing  OK
Ensure own hostname is resolvable  OK
Checking OpenNebula is working
OK
Disabling ssh from virtual network
OK
Adding localhost ssh key to known_hosts
aws_instance.minione: Still creating... [6m30s elapsed]
OK
Testing ssh connection to localhost
OK
Updating datastores template
OK
Creating qemu host
OK
Restarting OpenNebula
aws_instance.minione: Still creating... [6m40s elapsed]
aws_instance.minione: Still creating... [6m50s elapsed]
OK
Creating virtual network
OK
Exporting [Alpine Linux 3.17] from Marketplace to local datastore
aws_instance.minione: Still creating... [7m0s elapsed]
aws_instance.minione: Still creating... [7m10s elapsed]
OK
Waiting until the image is ready
aws_instance.minione: Still creating... [7m20s elapsed]
OK
Updating VM template
aws_instance.minione: Still creating... [7m30s elapsed]
OK

### Report
OpenNebula 6.8 was installed
Sunstone is running on:
  http://100.25.198.47/
FireEdge is running on:
  http://100.25.198.47:2616/
Use following to login:
  user: oneadmin
  password: opennebula
aws_instance.minione: Creation complete after 7m31s [id=i-010e7c210e99c2d76]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

ssh_connection = "ssh -i ~/.ssh/aws_one_dclavijo.pem ubuntu@ec2-100-25-198-47.compute-1.amazonaws.com"
 ~/P/t/aws-minione   …  terraform^C                                                                                                                                     7m37s
 ~/P/t/aws-minione   …  ssh -i ~/.ssh/aws_one_dclavijo.pem ubuntu@ec2-100-25-198-47.compute-1.amazonaws.com                                                             7m37s
Warning: Permanently added 'ec2-100-25-198-47.compute-1.amazonaws.com' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 6.2.0-1012-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sun Dec 10 17:21:35 UTC 2023

  System load:  0.0458984375       Users logged in:            0
  Usage of /:   20.1% of 24.05GB   IPv4 address for docker0:   172.17.0.1
  Memory usage: 70%                IPv4 address for eth0:      172.31.3.211
  Swap usage:   0%                 IPv4 address for minionebr: 172.16.100.1
  Processes:    139                IPv4 address for virbr0:    192.168.122.1


Expanded Security Maintenance for Applications is not enabled.

61 updates can be applied immediately.
38 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


*** System restart required ***
Last login: Sun Dec 10 16:52:14 2023 from 189.172.230.123
ubuntu@ip-172-31-3-211:~$ oned --version | grep "Enterprise Edition"
OpenNebula 6.8.0 (bf030d2b) Enterprise Edition
ubuntu@ip-172-31-3-211:~$ sudo su
root@ip-172-31-3-211:/home/ubuntu# onehost list
  ID NAME                                                                                                                CLUSTER    TVM      ALLOCATED_CPU      ALLOCATED_MEM STAT
   0 localhost                                                                                                           default      0       0 / 100 (0%)     0K / 1.9G (0%) on
root@ip-172-31-3-211:/home/ubuntu# ontemplate list
oneontemplate: command not found
root@ip-172-31-3-211:/home/ubuntu# onetemplate list
  ID USER     GROUP    NAME                                                                                                                                                REGTIME
   0 oneadmin oneadmin Alpine Linux 3.17                                                                                                                            12/10 16:58:41
root@ip-172-31-3-211:/home/ubuntu# oneimage list
  ID USER     GROUP    NAME                                                                                                                  DATASTORE     SIZE TYPE PER STAT RVMS
   0 oneadmin oneadmin Alpine Linux 3.17                                                                                                     default       256M OS    No rdy     0
```
