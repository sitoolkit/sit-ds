INSERT INTO auth_sources
(id, "type", name, host, port, account, account_password, base_dn, attr_login, attr_firstname, attr_lastname, attr_mail, onthefly_register, tls, "filter", timeout)
VALUES(1, 'AuthSourceLdap', 'LDAP', '{{ .Env.LDAP_HOST  }}', {{ .Env.LDAP_PORT }}, '{{ .Env.LDAP_MANAGER_DN  }}', '{{ .Env.LDAP_MANAGER_PASSWORD  }}', '{{ .Env.LDAP_ROOT_DN  }}', 'cn', 'givenName', 'sn', 'mail', true, false, '', NULL);

SELECT * FROM auth_sources;