ARG PNPM_VERSION=10.6.2
ARG NODE_VERSION=22.14.0
ARG ALPINE_VERSION=3.20

ARG APP_DIR=apps/core/task-organizer-read
ARG WORK_DIR=/app

#################################################################
# Base Stage: 共通のベースイメージ（pnpm のインストールなど）
#################################################################

FROM node:${NODE_VERSION}-alpine${ALPINE_VERSION} AS base

# ビルド引数を再宣言（RUN 命令で利用するため）
ARG PNPM_VERSION
ARG WORK_DIR

# pnpm をグローバルにインストール
RUN npm install -g pnpm@${PNPM_VERSION}

# 作業ディレクトリを設定
WORKDIR ${WORK_DIR}

# ソースコード全体をコピー
COPY . .

# 依存関係のインストール
RUN pnpm install --frozen-lockfile

#################################################################
# Builder Stage: プロダクション用のビルド（ソースコードのビルド＆本番依存のインストール）
#################################################################

FROM base AS builder

# 必要な引数を再宣言
ARG APP_DIR
ARG WORK_DIR

# 作業ディレクトリを設定
WORKDIR ${WORK_DIR}

# ビルド
RUN pnpm build

# deploy に依存モジュールを格納
RUN pnpm --filter ./${APP_DIR} --prod deploy ./deploy

# Workaround for Prisma + pnpm bug
RUN find . -path '*/node_modules/.pnpm/@prisma+client*/node_modules/.prisma' | xargs -r -I{} sh -c "cp -R {} ./deploy/{}"

#################################################################
# Prod Stage: 本番用イメージ（builder ステージの成果物を利用）
#################################################################
FROM node:${NODE_VERSION}-alpine${ALPINE_VERSION} AS prod

ARG APP_DIR
ARG WORK_DIR

# ワークスペースルートを設定
WORKDIR ${WORK_DIR}

# 非特権ユーザーに切り替え（必要に応じて）
USER node

# deploy されたアプリケーションを一括コピー
COPY --from=builder ${WORK_DIR}/deploy .
# 必要なポートを公開
EXPOSE 3000

# 本番実行コマンド
CMD ["node", "dist/main.js"]

#################################################################
# Dev Stage: 開発用イメージ（ソース全体をコピーして dev 用コマンドで起動）
#################################################################
FROM base AS dev

ARG APP_DIR
ARG WORK_DIR

# ワークスペースルートを設定
WORKDIR ${WORK_DIR}

RUN pnpm build

# アプリケーションのディレクトリへ移動
WORKDIR ${WORK_DIR}/${APP_DIR}

# 必要なポートを公開
EXPOSE 3000

# 開発用実行コマンド
CMD ["pnpm", "start:dev"]
