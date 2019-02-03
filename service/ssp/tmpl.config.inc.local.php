<?php

$ldap_binddn = '{{ .Env.LDAP_MANAGER_DN }}';
$ldap_bindpw = '{{ .Env.LDAP_MANAGER_PASSWORD }}';
$ldap_base = '{{ .Env.LDAP_ROOT_DN }}';
$ldap_login_attribute = '{{ .Env.LDAP_LOGIN_ATTRIBUTE }}';
$ldap_fullname_attribute = '{{ .Env.LDAP_FULLNAME_ATTRIBUTE }}';
$ldap_url = '{{ .Env.LDAP_URL }}';
$ldap_filter = "(&(objectClass=person)($ldap_login_attribute={login}))";

$mail_from = '{{ .Env.MAIL_RELAY_USER }}';

$mail_smtp_host = '{{ .Env.MAIL_SMTP_HOST }}';
$mail_smtp_port = {{ .Env.SMTP_PORT }};
$mail_smtp_secure = '';
$mail_smtp_autotls = false;

$keyphrase = 'sit-ci-secret'; 
?>
