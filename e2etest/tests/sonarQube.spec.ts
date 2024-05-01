import { expect, test } from './base';

test('login', async ({ page, baseURL, user, admin }) => {
  const sqUser = user.id === admin.id ? admin : user;

  await page.goto('/sonarqube/sessions/new');

  await page.locator('#login').fill(sqUser.id);
  await page.locator('#password').fill(sqUser.password);
  await page.locator('#login_form').getByRole('button').click();
  await page.waitForURL(/.*(projects|account).*/);

  if (page.url() === baseURL + '/sonarqube/account/reset_password') {
    await expect(page.getByText('Update your password')).toBeVisible();
    return;
  }

  await page.goto('/sonarqube/account');
  await expect(page.locator('#login')).toHaveText(sqUser.id);
});
