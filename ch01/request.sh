#!/bin/bash

# go run echo_server.go が実行された状態でリクエストを送る

# HTTP/0.9 の代わりに擬似的に 1.0 を使う
curl --http1.0 "http://localhost:18888/greeting"

# URL の末尾にクエリを付与
curl --http1.0 --get --data-urlencode "Search word" "http://localhost:18888"

# python3 で立ち上げたサーバーに nc コマンドを使って HTTP/0.9 でリクエストを送信
echo -e "GET /memo.html\r\n" | nc localhost 8000

# リクエスト・レスポンスの詳細を見る
curl -v --http1.0 "http://localhost:18888/greeting"

# 独自ヘッダーを送信
curl --http1.0 -H "X-Test: Hello" "http://localhost:18888"

# User-Agent ヘッダを Internet Explorer 10 に偽装
curl --http1.0 -A "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)" "http://localhost:18888"
# -H オプションを使った同じリクエスト
curl --http1.0 -H "User-Agent: Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)" "http://localhost:18888"

# リクエスト時にボディも送付する(URLに使える文字列で構成されている場合)
curl -d "hello=world" -H "Content-Type: application/json" "http://localhost:18888"

# リクエスト時にボディも送付する(URLにそのまま使えない文字列で構成されている場合)
curl --data-urlencode "hello=ワールド" -H "Content-Type: application/json" "http://localhost:18888"

# リクエスト時にボディも送付する(JSON形式のテキストの場合)
curl -d "{\"hello\": \"world\"}" -H "Content-Type: application/json" "http://localhost:18888"