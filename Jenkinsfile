pipeline {
    agent any

    stages {
        stage('Pull') {
            steps {
                echo 'Code récupéré depuis GitHub'
            }
        }
      stage('Packer - Build image') {
            steps {
                echo 'Packer - Build image simulé '
            }
        }
        stage('Terraform - Crée les VMs') {
            steps {
                sh 'cd terraform-lab && terraform apply -auto-approve'
            }
        }
        stage('Ansible - Déploiement') {
            steps {
                sh 'cd ansible && ansible-playbook playbooks/deploy.yml'
            }
        }
    }
}
