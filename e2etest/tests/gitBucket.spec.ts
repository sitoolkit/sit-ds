import { expect, test } from './base';

test('login', async ({ page, user, admin, root }) => {
  const gbUser = user.id === admin.id ? root : user;

  await page.goto('/gitbucket/signin');

  await page.locator('#userName').fill(gbUser.id);
  await page.locator('#password').fill(gbUser.password);
  await page.getByRole('button', { name: 'Sign in' }).click();

  await page.locator('.dropdown.notifications-menu').nth(1).click();
  await page.getByRole('link', { name: 'Your profile' }).click();
  await expect(page.locator('.pull-left.info p')).toHaveText(gbUser.id);
});
