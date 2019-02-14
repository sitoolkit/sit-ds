import jenkins.model.*

def env = System.getenv()

def config = JenkinsLocationConfiguration.get()
config.setAdminAddress("${env.MAIL_RELAY_USER}")
config.save()

def instance = Jenkins.getInstance()

def mailer = instance.getDescriptor("hudson.tasks.Mailer")
mailer.setSmtpHost("${env.MAIL_SMTP_HOST}")
mailer.setSmtpPort("${env.SMTP_PORT}")
mailer.save()

def extEmail = instance.getDescriptor("hudson.plugins.emailext.ExtendedEmailPublisher")
extEmail.setSmtpServer("${env.MAIL_SMTP_HOST}")
extEmail.setSmtpPort("${env.SMTP_PORT}")
extEmail.save()
