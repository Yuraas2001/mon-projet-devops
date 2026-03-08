pipeline {
    agent any
    stages {
        stage('Pull') {
            steps {
                echo 'Code récupéré depuis GitHub '
            }
        }
        stage('Packer - Build image') {
            steps {
                echo 'Packer - Build image simulé '
            }
        }
        stage('Terraform - Crée les VMs') {
            steps {
                echo 'Terraform - Création des VMs simulée '
            }
        }
        stage('Ansible - Déploiement') {
            steps {
                echo 'Ansible - Déploiement simulé '
            }
        }
    }
}
