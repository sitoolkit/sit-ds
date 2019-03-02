import jenkins.model.JenkinsLocationConfiguration

def env = System.getenv()

def config = JenkinsLocationConfiguration.get()
config.setUrl("${env.PUBLIC_PROTOCOL}://${env.PUBLIC_HOST}/jenkins/")
config.save()