import { expect, test } from './base';

test('login', async ({ page, user }) => {
  await page.goto('/nexus');

  await page.getByText('Sign in').click();
  await page.locator('input[name="username"]').fill(user.id);
  await page.locator('input[name="password"]').fill(user.password);
  await page.getByRole('button', { name: 'Sign in', exact: true }).click();

  await expect(page.locator('a[data-name="user"]')).toHaveText(user.id);
});
