import jenkins.model.*
import hudson.security.*
import com.cloudbees.hudson.plugins.folder.properties.AuthorizationMatrixProperty

def instance = Jenkins.getInstance()

def strategy = new hudson.security.GlobalMatrixAuthorizationStrategy()
strategy.add(Jenkins.ADMINISTER, 'authenticated')
strategy.add(Jenkins.READ, 'anonymous')
instance.setAuthorizationStrategy(strategy)

instance.save()
