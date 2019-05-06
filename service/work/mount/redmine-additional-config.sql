INSERT INTO auth_sources
  (id, "type", name, host, port,
  account, account_password, base_dn,
  attr_login, attr_firstname, attr_lastname, attr_mail, onthefly_register, tls, "filter", timeout)
VALUES(1, 'AuthSourceLdap', 'LDAP', '{{ .Env.LDAP_HOST  }}', {{ .Env.LDAP_PORT }},
  '{{ .Env.LDAP_MANAGER_DN  }}', '{{ .Env.LDAP_MANAGER_PASSWORD  }}', '{{ .Env.LDAP_ROOT_DN  }}', 
  '{{ .Env.LDAP_LOGIN_ATTRIBUTE }}', 'givenName', 'sn', '{{ .Env.LDAP_MAIL_ATTRIBUTE }}', true, false, '', NULL)
ON CONFLICT (id)
DO UPDATE SET
  host = '{{ .Env.LDAP_HOST  }}',
  port =  {{ .Env.LDAP_PORT }},
  account = '{{ .Env.LDAP_MANAGER_DN  }}',
  account_password = '{{ .Env.LDAP_MANAGER_PASSWORD  }}',
  base_dn = '{{ .Env.LDAP_ROOT_DN  }}',
  attr_login = '{{ .Env.LDAP_LOGIN_ATTRIBUTE }}',
  attr_mail = '{{ .Env.LDAP_MAIL_ATTRIBUTE }}'
;

INSERT INTO settings
  (id, name, value, updated_on)
VALUES
  (1, 'emails_footer', 'You have received this notification because you have either subscribed to it, or are involved in it.\r\nTo change your notification preferences, please click here: {{ .Env.PUBLIC_PROTOCOL }}://{{ .Env.PUBLIC_HOST }}/redmine/my/account', current_timestamp)
ON CONFLICT (id)
DO NOTHING
;

INSERT INTO settings
  (id, name, value, updated_on)
VALUES
  (2, 'host_name', '{{ .Env.PUBLIC_HOST }}/redmine', current_timestamp)
ON CONFLICT (id)
DO UPDATE SET
  value = '{{ .Env.PUBLIC_HOST }}/redmine',
  updated_on = current_timestamp
;

INSERT INTO settings
  (id, name, value, updated_on)
VALUES
  (3, 'mail_from', '{{ .Env.MAIL_RELAY_USER }}', current_timestamp)
ON CONFLICT (id)
DO UPDATE SET
  value = '{{ .Env.MAIL_RELAY_USER }}',
  updated_on = current_timestamp
;

INSERT INTO settings
  (id, name, value, updated_on)
VALUES
  (4, 'protocol', '{{ .Env.PUBLIC_PROTOCOL }}', current_timestamp)
DO UPDATE SET
  value = '{{ .Env.PUBLIC_PROTOCOL }}',
  updated_on = current_timestamp
;

INSERT INTO settings
  (id, name, value, updated_on)
VALUES
  (5, 'text_formatting', 'markdown', current_timestamp)
ON CONFLICT (id)
DO NOTHING
;


SELECT *
FROM auth_sources;
SELECT *
FROM settings;

