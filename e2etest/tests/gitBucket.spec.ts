import { expect, test } from './base';

const gbAdmin = { id: 'root', password: 'root' };

test('login', async ({ page, user }) => {
  if (user.id === 'admin') user = gbAdmin;

  await page.goto('/gitbucket/signin');

  await page.locator('#userName').fill(user.id);
  await page.locator('#password').fill(user.password);
  await page.getByRole('button', { name: 'Sign in' }).click();

  await page.locator('.dropdown.notifications-menu').nth(1).click();
  await page.getByRole('link', { name: 'Your profile' }).click();
  await expect(page.locator('.pull-left.info p')).toHaveText(user.id);
});
