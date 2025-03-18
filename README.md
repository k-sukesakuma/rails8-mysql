
# Rails 8 Docker 開発環境

## 環境
- Ruby 3.3.0
- Rails 8.0.2
- MySQL 8.0
- Docker
- Docker Compose

## セットアップ手順

1. リポジトリのクローン
```bash
git clone <repository-url>
cd <repository-name>
```

2. Dockerイメージのビルド
```bash
docker compose build --no-cache
```

3. データベースの作成
```bash
docker compose run --rm web bundle exec rails db:create
docker compose run --rm web bundle exec rails db:migrate
```

4. アプリケーションの起動
```bash
docker compose up -d
```

アプリケーションは http://localhost:53000 でアクセスできます

## よく使うコマンド

### ログの確認
```bash
docker compose logs -f
```

### アプリケーションの停止
```bash
docker compose down
```

### Railsコマンドの実行
```bash
docker compose run --rm web bundle exec rails <command>
```

### Railsコンソールの起動
```bash
docker compose run --rm web bundle exec rails console
```

### Gemfile変更後の再ビルド
```bash
docker compose down
docker compose build --no-cache
docker compose up -d
```

### クリーンアップ
```bash
# 停止中のコンテナ、未使用ネットワーク、イメージの削除
docker compose down --volumes --remove-orphans
docker system prune
```

## コンテナ構成
- Webサーバー: ポート53000
- MySQL: ポート3306
- アプリケーションコードは、コンテナ内の `/rails` ディレクトリにマウント
