// 通信内容をコンソールにそのまま出力するエコーサーバー
package main

import (
	"fmt"
	"log"
	"net/http"
	"net/http/httputil"
)

func handler(w http.ResponseWriter, r *http.Request) {
	// リクエスト情報を受け取り処理して返す
	dump, err := httputil.DumpRequest(r, true)
	if err != nil {
		http.Error(w, fmt.Sprint(err), http.StatusInternalServerError)
		return
	}
	fmt.Println(string(dump))
	fmt.Fprintf(w, "<html><body>hello</body></html>\n")
}

func main() {
	var httpServer http.Server
	http.HandleFunc("/", handler) // パス "/" にアクセスがあったとき handler 関数が呼び出されるように登録
	log.Println("start http listening :18888")
	httpServer.Addr = ":18888" // ポート番号18888で起動
	log.Println(httpServer.ListenAndServe())
}
