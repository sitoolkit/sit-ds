import { test as base } from '@playwright/test';

export { expect } from '@playwright/test';


export type TestOptions = {
  user: {
    id: string;
    password: string;
  };
};

export const test = base.extend<TestOptions>({
  user: {
    id: process.env.USER_ID ?? 'admin',
    password:
      process.env.PASSWORD ?? process.env.LDAP_MANAGER_PASSWORD ?? 'admin',
  },
});
