 
	簡易 radiko.jp プレミアム対応 Radiko 録音スクリプト rec_radiko2.sh

【概要】
radiko.jp プレミアム録音スクリプト。

【内容】
rec_radiko2 -+ rec_radiko2.sh	    ; 簡易 radiko.jp プレミアム対応 Radiko 録音スクリプト
	     + delete.py	    ; 古いファイルを削除するスプリクト
	     + radiko_curl_area.sh  ; コマンド curl を使った放送局の station id 確認スクリプト
	     + radiko_wget_area.sh  ; コマンド wget を使った放送局の station id 確認スクリプト
	     + ReadMe.txt	    ; このファイル
	     + KOYAMA Yoshiaki のブログ.webloc ; Safari ブックマーク

【使い方】

詳しい解説は、

KOYAMA Yoshiaki のブログ
http://kyoshiaki.hatenablog.com/entries/2014/05/04


を参照してください。

rec_radiko2.sh の引数は

rec_radiko2.sh <channel_name_id> <minutes> <mail address> <password> [outputdir] [prefix]

です。

引数の詳細は

channel_name_id: 放送局の station id
minutes: 何分録音するか
mail address: radiko.jp プレミアムにログインするメールアドレス
password: radiko.jp プレミアムにログインするパスワード
outputdir: 出力するディレクトリ
[prefix]: 保存ファイル名の先頭文字。指定されない場合 channel_name_id
が使われます。

例) 
pi@raspberrypi ~ ./rec_radiko2.sh TBS 1 mail password
TBS を 1分間録音してカレントディレクトリに名前の先頭が TBS のファイル
を MP3 形式で保存します。

pi@raspberrypi ~ ./rec_radiko2.sh TBS 120 mail pasword radio
TBSラジオを 120分録音してカレントディレクトリの radio ディレクトリに
名前の先頭が TBS のファイルを MP3 形式で保存します。
です。
