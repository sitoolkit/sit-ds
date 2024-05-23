import { expect, test } from './base';

test('login', async ({ page, user, admin }) => {
  const rmUser = user.id === admin.id ? admin : user;

  await page.goto('/redmine/login');

  await page.locator('#username').fill(rmUser.id);
  await page.locator('#password').fill(rmUser.password);
  await page.locator('#login-submit').click();

  await expect(page.locator('#loggedas .user.active')).toHaveText(rmUser.id);
});
