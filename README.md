# 拾阶六级学习室：GitHub + Cloudflare 发布版

这个目录不含本机用户数据库、密码或 API 密钥。

1. 在 GitHub 创建名为 cet6-study-room 的仓库。仓库可以 Private，网站仍可公开访问。
2. 把本目录内的文件和文件夹上传到仓库根目录，不要只上传压缩包，不要额外套一层文件夹。
3. 在 Cloudflare 控制台的 D1 SQL database 中新建 cet6-learning 数据库，复制 Database ID。
4. 在 GitHub 编辑 wrangler.jsonc，只把 REPLACE_WITH_YOUR_D1_DATABASE_ID 替换成真实 Database ID。binding 保持 DB。
5. 打开 Cloudflare 的该数据库，选择 Console。将 drizzle/0000_learning_accounts.sql 的完整内容粘贴执行。Tables 中应出现 users、sessions、user_state、auth_limits 四张表。
6. 在 Cloudflare Workers & Pages 选择 Create application → GitHub，授权并选择这个仓库。创建 Worker，不选择纯静态 Pages。
7. Worker 名称 cet6-study-room；生产分支 main；根目录保持仓库根目录；Build command 填 npm run build；Deploy command 填 npm run deploy。API token 使用平台自动生成选项。保存并部署。
8. 成功后使用平台实际显示的 https://cet6-study-room.<你的子域>.workers.dev 网址。该格式只是示例，不是已生成链接。
9. 在线注册新账户，做一次练习，退出再登录检查进度。可从本机版导出 JSON，再登录线上账户导入；本机账户不会自动迁移。

更新网站：修改 GitHub 中的文件并提交，已连接的 Cloudflare 项目会重新构建发布。
AI 自动批改仍未启用。发布不会自动开通 OpenAI。

常见问题：
- 找不到 package.json：上传时额外套了一层目录。将 package.json 和 wrangler.jsonc 放在仓库首页。
- 数据库未配置：检查 wrangler.jsonc 的 database_id、binding=DB，以及 Cloudflare 中的数据库是否属于同一账户。
- no such table：重新核对第 5 步是否在正确数据库执行初始化 SQL。
- Worker 名称不一致：控制台的名称必须和 wrangler.jsonc 中的 name 相同。
- 可以打开网页但不能注册：检查上述数据库绑定与建表步骤，而不是只检查网页是否能显示。

官方说明：
https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository
https://developers.cloudflare.com/workers/ci-cd/builds/
https://developers.cloudflare.com/d1/get-started/
