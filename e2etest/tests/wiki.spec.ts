import { expect, test } from './base';

test.use({
  baseURL: async ({ baseURL }, use) => {
    const url = new URL(baseURL);
    await use(url.protocol + '//wiki.' + url.hostname);
  },
});

test('login', async ({ page, user }) => {
  await page.goto('/login');

  if (user.id === 'admin') {
    user.id = 'admin@' + (process.env.LDAP_DOMAIN ?? 'example.org');
  } else {
    await page.getByText('LDAP / Active Directory').click();
  }

  await page.locator('.login-form input').nth(0).fill(user.id);
  await page.locator('.login-form input').nth(1).fill(user.password);
  await page.locator('.login-form > button').click();

  await page.waitForURL('/');

  await page.goto('/p/profile');
  await page.locator('header button').click();
  await page.waitForTimeout(500);
  await expect(
    page.locator('div[role="menu"]').getByText(user.id).nth(0),
  ).toBeVisible();
});
