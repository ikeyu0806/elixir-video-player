# VideoPlayer
Elixir試したくて作ったプロジェクト

## プロジェクト作成コマンド
```
docker compose run --rm elixir-video-player mix phx.new . --app video_player
```

## サーバ立ち上げ
envファイルを用意して必要なAPIキーを設定してください
```
cp config/.env.exs.example config/.env.exs
docker compose up
```

http://localhost:4567/

## Tips
Repl実行
```
iex -S mix
```

環境変数の確認
```
iex -S mix
System.get_env
```


## 以下phx.newで生成された文言

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
