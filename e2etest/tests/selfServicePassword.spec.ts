import { Page } from 'playwright-core';
import { expect, test } from './base';

const chPass = async (
  page: Page,
  id: string,
  oldPass: string,
  newPass: string,
): Promise<void> => {
  await page.goto('/passchg');

  await page.locator('#login').fill(id);
  await page.locator('#oldpassword').fill(oldPass);
  await page.locator('#newpassword').fill(newPass);
  await page.locator('#confirmpassword').fill(newPass);
  await page.locator('.btn-success').click();

  await expect(page.locator('.alert-success')).toBeVisible();
};

test('change password', async ({ page, user }) => {
  test.skip(user.id === 'admin');

  await chPass(page, user.id, user.password, `${user.password}2`);
});

test('revert password', async ({ page, user }) => {
  test.skip(user.id === 'admin');

  await chPass(page, user.id, `${user.password}2`, user.password);
});
