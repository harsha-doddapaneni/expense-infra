# resource "aws_key_pair" "eks" {
#   key_name   = "eks"
#   # you can paste the public key directly like this
#   #public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL6ONJth+DzeXbU3oGATxjVmoRjPepdl7sBuPzzQT2Nc sivak@BOOK-I6CR3LQ85Q"
#   //public_key = file("~/.ssh/eks.pub")
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDCIVuBNLK+INiJezk1EO68MmkuhOugXTQqeYFUolkFncXQpd4twb5FOBdbO4NJKqH/XDhBDXw7I9GaWsN9efA7HjikcgoxugTh6R9azazv+TfJnFCYlHbnc66HrFpuZRqaaFwozyb7ri5pg6B4BTbbozuEoz5Rd9/jKzf4vJrhpKrFch7RKOWpL1Vtvx68BRsGKDJ4BBmxE7x3ipQ6yMXKaiVVkuNylml+ItEN5H0FGYXiOeln2oT2CPfkLJw3emoCzL/v0YofbdOvarBVegstU0cUhAkb/IBDuwrOHVUa//zokJP/ORi1hiTwKTwQy9ktwGJO4WcSLrkXU6qjje9c89r/VdW7FZdhQH9nqgRhQlywhz/YeQ8zdAUIwVoi2jEfrhs7iIBHER5CSoYeiwh9D+eDnyvBgTbLcv5UzM1qE8Ivx8snB1KvbYwmGywBqwxSyOxp+FYlquhMMmALFV4JMWa1nV0YA0nBUM+Mj709OkNjuLL1WUFdllr382zXxwsL3j1ST7vnD0r6wfMRzI2HLFIiUK2QPenik3tD58EFOQeUcXPEt7ac0qEcVxOoHuL0Ydi0VFwOYVn8eew/AMIzuLpSUz4FEdT9Jr9A27UGd1axlUSKaWQ97xk98L+zyGaNMzD2rZXOY0/O3dZdlPopMcprYT7yLi2BejMdAzW8Uw== eks-key"
#   # ~ means windows home directory
# }

# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "20.8.4"


#   cluster_name    = "${var.project_name}-${var.environment}"
#   cluster_version = "1.31"

#   cluster_endpoint_public_access  = true

#   cluster_addons = {
#     coredns                = {}
#     eks-pod-identity-agent = {}
#     kube-proxy             = {}
#     vpc-cni                = {}
#   }

#   vpc_id                   = data.aws_ssm_parameter.vpc_id.value
#   subnet_ids               = local.private_subnet_ids
#   control_plane_subnet_ids = local.private_subnet_ids

#   create_cluster_security_group = false
#   cluster_security_group_id     = local.eks_control_plane_sg_id

#   create_node_security_group = false
#   node_security_group_id     = local.node_sg_id

#   # the user which you used to create cluster will get admin access

#   # EKS Managed Node Group(s)
#   eks_managed_node_group_defaults = {
#     instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
#   }

#   eks_managed_node_groups = {
#     # blue = {
#     #   min_size      = 3
#     #   max_size      = 10
#     #   desired_size  = 3
#     #   capacity_type = "SPOT"
#     #   iam_role_additional_policies = {
#     #     AmazonEBSCSIDriverPolicy          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
#     #     AmazonElasticFileSystemFullAccess = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
#     #     ElasticLoadBalancingFullAccess = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
#     #   }
#     #   # EKS takes AWS Linux 2 as it's OS to the nodes
#     #   key_name = aws_key_pair.eks.key_name
#     # }
#     green = {
#       min_size      = 3
#       max_size      = 10
#       desired_size  = 3
#       capacity_type = "SPOT"
#       iam_role_additional_policies = {
#         AmazonEBSCSIDriverPolicy          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
#         AmazonElasticFileSystemFullAccess = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
#         ElasticLoadBalancingFullAccess = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
#       }
#       # EKS takes AWS Linux 2 as it's OS to the nodes
#       key_name = aws_key_pair.eks.key_name
#     }
#   }

#   # Cluster access entry
#   # To add the current caller identity as an administrator
#   enable_cluster_creator_admin_permissions = true

#   tags = var.common_tags
# }

resource "aws_key_pair" "eks" {
  key_name   = "eks"
  # Reference your public key file directly, or paste the key
  public_key = file("~/.ssh/eks.pub")
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.0.4" # Upgraded to the latest stable version

  cluster_name    = "${var.project_name}-${var.environment}"
  cluster_version = "1.31"

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = data.aws_ssm_parameter.vpc_id.value
  subnet_ids               = local.private_subnet_ids
  control_plane_subnet_ids = local.private_subnet_ids

  create_cluster_security_group = false
  cluster_security_group_id     = local.eks_control_plane_sg_id

  create_node_security_group = false
  node_security_group_id     = local.node_sg_id

  # Managed Node Group defaults
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    green = {
      min_size      = 3
      max_size      = 10
      desired_size  = 3
      capacity_type = "SPOT"
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonElasticFileSystemFullAccess = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
        ElasticLoadBalancingFullAccess    = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
      }
      key_name = aws_key_pair.eks.key_name
    }
  }

  enable_cluster_creator_admin_permissions = true

  tags = var.common_tags
}
