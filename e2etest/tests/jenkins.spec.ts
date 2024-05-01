import { expect, test } from './base';

test('login', async ({ page, user }) => {
  await page.goto('/jenkins/login');

  await page.locator('#j_username').fill(user.id);
  await page.locator('input[name="j_password"]').fill(user.password);
  await page.locator('button[name="Submit"]').click();

  await expect(page.getByRole('link', { name: user.id })).toBeVisible();
});
