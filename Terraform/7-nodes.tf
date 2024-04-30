resource "aws_iam_role" "nodes" {
  name = "eks-node-group-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}


resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.project_eks.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    aws_subnet.private-us-east-1a.id,
    aws_subnet.private-us-east-1b.id,
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.micro"]

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }
 

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}
# #resource "aws_eks_addon" "coreDNS" {
#   #cluster_name                = aws_eks_cluster.project_eks.name
#   addon_name                  = "coredns"
#   addon_version               = "v1.11.1-eksbuild.4" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
#   # resolve_conflicts_on_update = "PRESERVE"
# }
# resource "aws_eks_addon" "kube_proxy" {
#   cluster_name                = aws_eks_cluster.project_eks.name
#   addon_name                  = "kubeproxy"
#   addon_version               = "v1.29.3-eksbuild.2" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
#   # resolve_conflicts_on_update = "PRESERVE"
# }
# resource "aws_eks_addon" "amazon_vpc_cni" {
#   cluster_name                = aws_eks_cluster.project_eks.name
#   addon_name                  = "amazonvpccni"
#   addon_version               = "v1.18.0-eksbuild.1" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
#   # resolve_conflicts_on_update = "PRESERVE"
# }
# resource "aws_eks_addon" "Amazon_EKS_Pod_Identity_Agent" {
#   cluster_name                = aws_eks_cluster.project_eks.name
#   addon_name                  = "amazonekspodidentityagent"    
#   addon_version               = "v1.0.0-eksbuild.1" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1#REMOVE
#   # resolve_conflicts_on_update = "PRESERVE"
# }



