import { expect, test } from './base';

const rmAdmin = { id: 'admin', password: 'admin' };

test('login', async ({ page, user }) => {
  if (user.id === 'admin') user = rmAdmin;

  await page.goto('/redmine/login');

  await page.locator('#username').fill(user.id);
  await page.locator('#password').fill(user.password);
  await page.locator('#login-submit').click();

  await expect(page.locator('#loggedas .user.active')).toHaveText(user.id);
});
