pipelineJob('infrastructure/terraform') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://github.com/Bodiok007/TerraformAppForJenkins.git')
                        // credentials('my-credentials')
                    }
                    branch('*/main')
                    extensions { }
                }
            }
            scriptPath('terraform.Jenkinsfile')
            lightweight(true)
        }
    }
}

pipelineJob('ansible/ansible') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://github.com/Bodiok007/AnsibleForJenkins.git')
                        // credentials('my-credentials2')
                    }
                    branch('*/main')
                    extensions { }
                }
            }
            scriptPath('ansible.Jenkinsfile')
            lightweight(true)
        }
    }
}

pipelineJob('application/nodejs') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://github.com/Bodiok007/AppForJenkins.git')
                        //credentials('my-credentials3')
                    }
                    branch('*/master')
                    extensions { }
                }
            }
            scriptPath('app.Jenkinsfile')
            lightweight(true)
        }
    }
}