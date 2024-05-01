import { test as base } from '@playwright/test';

export { expect } from '@playwright/test';

export type User = {
  id: string;
  password: string;
};

export type TestOptions = {
  user: User;
  admin: User;
  root: User;
};

export const test = base.extend<TestOptions>({
  user: {
    id: process.env.USER_ID ?? 'admin',
    password: process.env.PASSWORD ?? process.env.LDAP_MANAGER_PASSWORD,
  },
  admin: {
    id: 'admin',
    password: 'admin',
  },
  root: {
    id: 'root',
    password: 'root',
  },
});
