provider "aws" {
  region = var.region
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

resource "aws_iam_role" "eks_cluster" {
  name = "${var.eks_cluster_name}-eks-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com",
      },
    }],
  })
}

resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.eks_cluster_name}-nodes"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = var.subnet_ids
  capacity_type   = "ON_DEMAND"
  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_capacity
    min_size     = var.min_capacity
  }
  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "aws_iam_role" "eks_nodes" {
  name = "${var.eks_cluster_name}-nodes-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com",
      },
    }],
  })
}

resource "aws_security_group" "eks_cluster_sg" {
  name        = "${var.eks_cluster_name}-sg"
  description = "Security group for EKS cluster"
  vpc_id      = var.vpc_id
  // Add your security group rules here if needed
}

resource "aws_security_group_rule" "eks_cluster_ingress" {
  security_group_id      = aws_security_group.eks_cluster_sg.id
  type                   = "ingress"
  from_port              = 0
  to_port                = 65535
  protocol               = "-1"
  cidr_blocks            = ["0.0.0.0/0"]  # Adjust this to your specific CIDR block
  # Add other required parameters as needed
}

resource "aws_security_group_rule" "eks_cluster_egress" {
  security_group_id      = aws_security_group.eks_cluster_sg.id
  type                   = "egress"
  from_port              = 0
  to_port                = 0
  protocol               = "-1"
  cidr_blocks            = ["0.0.0.0/0"]  # Adjust this to your specific CIDR block
  # Add other required parameters as needed
}
