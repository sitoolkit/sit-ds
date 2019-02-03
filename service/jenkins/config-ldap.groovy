import jenkins.*
import hudson.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.jenkins.plugins.sshcredentials.impl.*
import hudson.plugins.sshslaves.*;
import hudson.model.*
import jenkins.model.*
import hudson.security.*


def instance = Jenkins.getInstance()


// NOW TIME TO CONFIGURE GLOBAL SECURITY
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
def env = System.getenv()

def server = "ldap://${env.LDAP_HOST}"
def rootDN = "${env.LDAP_ROOT_DN}"
def userSearchBase = ''
def userSearch = "${env.LDAP_USER_SEARCH}"
def groupSearchBase = ''
def managerDN = "${env.LDAP_MANAGER_DN}"
String passcode = "${env.LDAP_MANAGER_PASSWORD}"
boolean inhibitInferRootDN = true

SecurityRealm ldap_realm = new LDAPSecurityRealm(server, rootDN, userSearchBase, userSearch, groupSearchBase, managerDN, passcode, inhibitInferRootDN) 
instance.setSecurityRealm(ldap_realm)

instance.save()