INSERT INTO auth_sources
  (id, "type", name, host, port, account, account_password, base_dn, attr_login, attr_firstname, attr_lastname, attr_mail, onthefly_register, tls, "filter", timeout)
VALUES(1, 'AuthSourceLdap', 'LDAP', '{{ .Env.LDAP_HOST  }}', {{ .Env.LDAP_PORT }}, '{{ .Env.LDAP_MANAGER_DN  }}', '{{ .Env.LDAP_MANAGER_PASSWORD  }}', '{{ .Env.LDAP_ROOT_DN  }}', 'cn', 'givenName', 'sn', 'mail', true, false, '', NULL);

INSERT INTO settings
  (name, value, updated_on)
VALUES
  ('mail_from', '{{ .Env.MAIL_RELAY_USER }}', current_timestamp),
  ('bcc_recipients', '1', current_timestamp),
  ('plain_text_mail', '0', current_timestamp),
  ('notified_events', '---\n- issue_added\n- issue_updated', current_timestamp),
  ('emails_header', '', current_timestamp),
  ('emails_footer', 'You have received this notification because you have either subscribed to it, or are involved in it.\r\nTo change your notification preferences, please click here: http://hostname/my/account', current_timestamp);

SELECT *
FROM auth_sources;
SELECT *
FROM settings;

