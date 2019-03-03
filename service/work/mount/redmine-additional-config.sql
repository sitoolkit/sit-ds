INSERT INTO auth_sources
  (id, "type", name, host, port, account, account_password, base_dn, attr_login, attr_firstname, attr_lastname, attr_mail, onthefly_register, tls, "filter", timeout)
VALUES(1, 'AuthSourceLdap', 'LDAP', '{{ .Env.LDAP_HOST  }}', {{ .Env.LDAP_PORT }}, '{{ .Env.LDAP_MANAGER_DN  }}', '{{ .Env.LDAP_MANAGER_PASSWORD  }}', '{{ .Env.LDAP_ROOT_DN  }}', '{{ .Env.LDAP_LOGIN_ATTRIBUTE }}', 'givenName', 'sn', '{{ .Env.LDAP_MAIL_ATTRIBUTE }}', true, false, '', NULL);

INSERT INTO settings
  (name, value, updated_on)
VALUES
  ('emails_footer', 'You have received this notification because you have either subscribed to it, or are involved in it.\r\nTo change your notification preferences, please click here: {{ .Env.PUBLIC_PROTOCOL }}://{{ .Env.PUBLIC_HOST }}/redmine/my/account', current_timestamp)
  ,('host_name', '{{ .Env.PUBLIC_HOST }}/redmine', current_timestamp)
  ,('mail_from', '{{ .Env.MAIL_RELAY_USER }}', current_timestamp)
  ,('protocol', '{{ .Env.PUBLIC_PROTOCOL }}', current_timestamp)
  ,('text_formatting', 'markdown', current_timestamp)
  ;

SELECT *
FROM auth_sources;
SELECT *
FROM settings;

