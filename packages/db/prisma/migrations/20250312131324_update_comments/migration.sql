-- Prisma Database Comments Generator v1.0.3

-- sites comments
COMMENT ON COLUMN "sites"."name" IS 'サイト名';
COMMENT ON COLUMN "sites"."description" IS 'サイトの説明';
COMMENT ON COLUMN "sites"."domain" IS 'サイトのドメイン (ユニーク)';
COMMENT ON COLUMN "sites"."apiKey" IS 'クライアント認証用APIキー';
COMMENT ON COLUMN "sites"."sendgridApiKey" IS 'SendGrid APIキー';
COMMENT ON COLUMN "sites"."webhookPublicKey" IS 'SendGrid webhook public key';
COMMENT ON COLUMN "sites"."createdAt" IS 'レコードの作成日時';
COMMENT ON COLUMN "sites"."updatedAt" IS 'レコードの更新日時';

-- customers comments
COMMENT ON COLUMN "customers"."id" IS '顧客の一意な識別子';
COMMENT ON COLUMN "customers"."email" IS '顧客のメールアドレス';
COMMENT ON COLUMN "customers"."name" IS '顧客の名前（オプション）';
COMMENT ON COLUMN "customers"."siteId" IS '顧客が所属するサイトのID';
COMMENT ON COLUMN "customers"."active" IS '顧客のアクティブ状態 (デフォルト: true)';
COMMENT ON COLUMN "customers"."createdAt" IS 'レコードの作成日時';
COMMENT ON COLUMN "customers"."updatedAt" IS 'レコードの更新日時';
