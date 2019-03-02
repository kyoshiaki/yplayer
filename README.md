
# yplayer

PC の中に保存された音声ファイルをブラウザを使って再生できます。再生位置も保存することができます。このプログラムは Ruby on Rails で作成されています。

## 【スクリーンショット】

<img src="https://kyoshiaki.sakura.ne.jp/github/yplayer/directory0.png" height="600" alt="directory">   <img src="https://kyoshiaki.sakura.ne.jp/github/yplayer/directory1.png" height="600" alt="directory">   <img  src="https://kyoshiaki.sakura.ne.jp/github/yplayer/player1.png" height="600" alt="player">    

## 【動画】

[![yplayer](https://kyoshiaki.sakura.ne.jp/github/yplayer/youtube450.png)](https://www.youtube.com/watch?v=MEe2lbwvAWQ&t=1s "yplayer")

[https://www.youtube.com/watch?v=MEe2lbwvAWQ&t=1s](https://www.youtube.com/watch?v=MEe2lbwvAWQ&t=1s) 

## 【内容】

- [インストールと yplayer の起動](#【インストールと-yplayer-の起動】)
- [yplayer の使用方法](#【yplayer-の使用方法】)
- [動作環境](#【動作環境】)
- [ライセンス](#【ライセンス】)

## 【インストールと yplayer の起動】

1. 音声ファイルが保存されている PC に Ruby on Rails をインストールしてください。

[Install Ruby On Rails on Ubuntu 18.04 Bionic Beaver | GoRails](https://gorails.com/setup/ubuntu/18.04)  
[https://gorails.com/setup/ubuntu/18.04](https://gorails.com/setup/ubuntu/18.04) 

上記 URL に OS 別 Ruby on Rails インストール方法が記載されています。

私は Rapsberry Pi に Ruby on Rails をインストールし、 Rapsberry Pi 上で録音した Radiko.jp の音声ファイルを yplayer を使って iPhone XS Max の Safari で聴いています。
Rapsberry Pi に Ruby on Rails をインストールする方法、systemd を使った yplayer の自動起動方法の詳細は [tools/README.md](tools/README.md) を参照してください。 

2. ターミナルで git コマンドを使って yplayer をダウンロードします。

下記例ではホームディレクトリに rails という名前のディレクトリを作成し、その中に yplayer をダウンロードしています。

```
$ mkdir rails
$ cd rails
$ git clone https://github.com/kyoshiaki/yplayer.git
```
3. radio という名前で yplayer/public ディレクトリに再生したい音声ファイルが含まれるディレクトリのシンボリックリンクを作成してください。

例) /home/pi/raido ディレクトリに音声ファルがある場合、コマンド ln を使って radio という名前で下記のようにシンボリックリンクを作成します。

```
$ cd yplayer/public
$ ln -s /home/pi/radio radio
```

4. gem パッケージをインストールする。

```
$ cd ..
$ bundle install
```

5. 秘密鍵の表示

```
 $ bin/rails secret
760a21dfc61f8d3d376b2854db951c99c1e248b76c9ec346152017431ab3a9babf1e958709b7827b9f4a67e261e5ce1721b4da3af9db3b6324f924f2809c6fdb
```

6. 秘密鍵を環境変数 SECRET_KEY_BASE に指定して production 環境でマイグレーションを実行し、データベースの作成や構成を行います。

```
 $ SECRET_KEY_BASE=760a21dfc61f8d3d376b2854db951c99c1e248b76c9ec346152017431ab3a9babf1e958709b7827b9f4a67e261e5ce1721b4da3af9db3b6324f924f2809c6fdb RAILS_ENV=production bin/rails db:migrate
```

データベースを初期化したい場合は、下記コマンドを実行してください。

```
 $ SECRET_KEY_BASE=760a21dfc61f8d3d376b2854db951c99c1e248b76c9ec346152017431ab3a9babf1e958709b7827b9f4a67e261e5ce1721b4da3af9db3b6324f924f2809c6fdb DISABLE_DATABASE_ENVIRONMENT_CHECK=1 RAILS_ENV=production bin/rails db:migrate:reset
```

7. 秘密鍵を環境変数 SECRET_KEY_BASE に指定して production 環境で yplayer を起動します。

```
 $ SECRET_KEY_BASE=760a21dfc61f8d3d376b2854db951c99c1e248b76c9ec346152017431ab3a9babf1e958709b7827b9f4a67e261e5ce1721b4da3af9db3b6324f924f2809c6fdb bin/rails server --environment production
```

8. 後はブラウザで PC の IP アドレスにアクセスするだけです。次の [yplayer の使用方法](#【yplayer-の使用方法】) を参照してください。


## 【yplayer の使用方法】

```
$ SECRET_KEY_BASE=760a21dfc61f8d3d376b2854db951c99c1e248b76c9ec346152017431ab3a9babf1e958709b7827b9f4a67e261e5ce1721b4da3af9db3b6324f924f2809c6fdb bin/rails server --environment production
=> Booting Puma
=> Rails 5.2.2 application starting in production 
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.12.0 (ruby 2.6.1-p33), codename: Llamas in Pajamas
* Min threads: 5, max threads: 5
* Environment: production
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop
```

1. production 環境で yplayer を起動すると上記メッセージが表示されます。yplayer を起動した PC 上のブラウザなら http://localhost:3000、 それ以外は yplayer をインストールした PC の IP アドレス、例えば IP アドレスが 192.168.1.2 なら http://192.168.1.2:3000 にブラウザでアクセスします。 yplayer のログイン画面が表示されます。

2. アカウントを入力してログインしてください。アカウントがない場合は、'新規登録' リンクをクリックしてアカウントを作成してください。

新規登録画面で管理者にチェックを入れると他のユーザーを削除することができます。

3. 指定したディレクトリ yplayer/public/radio のファイル一覧が表示されます。ファイル一覧として表示した時に一度も表示されていない音声ファイルの情報がデーターベースに追加されます。保存されるデータベースの情報は、ナビゲーション > ログイン名 > プロフィール で表示される Sounds Table を参照してください。絶対パスは音声ファイルがあるディレクトリだけ表示されていますが、実体は下記の通りフルパスです。

```
yoshiaki

絶対パス : Home/tama 
ファイル名 : daikichi_2018-12-26-12_55.m4a 
マーク済み : ☐
再生済み : ☐
再生位置 : 0 
作成日 : 2018/12/26(水), 18:28:00 
更新日 : 2018/12/26(水), 18:28:00 
削除
```

Raspberry Pi だと Home は /home/pi/rails/yplayer/public/radio ディレクトリを指します。上記例では、絶対パスが Home/tama ですが、実際に保存されている絶対パスは /home/pi/rails/yplayer/public/radio/tama/daikichi_2018-12-26-12_55.m4a です。

ディレクトリ一覧が表示される度に新規のデータがデータベースに追加され、マーク済み、再生済み、再生位置の更新は、ファイル名をクリックして表示される音声再生プレイヤーで変更できます。

4. ファイル一覧が下記のように色分けされています。

- 緑色: ディレクトリ
- 水色: カレントディレクトリ (.) または 親ディレクトリ (..) 
- 白色: 音声ファイル及びディレクトリ以外のファイル
- 赤色: 再生位置が 0 の音声ファイル。新規の音声ファイル。
- 黄色: マーク済みにチェックマークを付けた音声ファイル。再生済みのチェックマークが付いている場合は、マーク済みにチェックマークが付いていても無効になります。後で必ず聴きたい音声ファイルに印を付けるのに使用してください。
- 青色: 再生位置が 0 より大きく、音声ファイルの長さより小さい。尚且つ、マーク済みと再生済みにチェックが付いていない音声ファイル。再生途中の音声ファイル。
- 濃いグレー: 再生位置が音声ファイルの長さ以上で、再生済みのチェックマークが付いている音声ファイル。最後まで聴いた音声ファイル。
- 薄いグレー: 再生位置が音声ファイルの長さより小さく、再生済みのチェックマークが付いている音声ファイル。再生を放棄した音声ファイル。

5. 表示される音声ファイルの情報

```
daikichi_2018-12-26-12_55.m4a
[2018/12/26(水), 15:34:51]
56926483 bytes
1 (h) 14 (m) 23 (s) / 2 (h) 40 (m) 0 (s) 
4463/9600
マーク済み : ☑︎
再生済み : ☐
```

上記例では、

```
ファイル名: daikichi_2018-12-26-12_55.m4a
ファイルの最終更新時刻: [2018/12/26(水), 15:34:51]
サイズ: 56926483 bytes
再生位置 / 音声ファイルの長さ : 1 時間 14 分 23 秒 / 2 時間 40 分 0 秒 
再生位置(秒数) / 音声ファイルの総秒数: 4463/9600
マーク済み : ☑︎ (チェックマークが付いている)
再生済み : ☐ (チェックマークが付いていない)
```

です。

Radiko.jp をスクリプトでファイルに保存中の場合、音声ファイルの長さが 0 (h) 0 (m) 0 (s) と表示されます。スクリプトが終了したかはファイルサイズを参考にしてください。

6. 再生したい音声ファイルの名前をクリックしてください。音声再生プレイヤーが表示されます。

7. Play ボタンをクリックすると保存されていた再生位置から音声ファイルが再生されます。(注意、プログラムの構造上、早送りなどのボタンやスライダーを正しく動作させるために、必ず最初に Play ボタンをクリックしてください。またブラウザ標準のオーディオコントロールは使わないでください。)

ボタン
- 0: 再生位置を先頭に移動
- -60: 60秒巻き戻し
- -30: 30秒巻き戻し
- -15: 15秒巻き戻し
- Play: 再生
- Stop: 停止
- 15: 15秒早送り
- 30: 30秒早送り
- 60: 60秒早送り


8. 再生位置を保存する方法。

    1. Get ボタンをクリックして、現在再生しているオーディオコントロールの再生位置をラベル '再生位置'の右横のテキストフィールドに代入する。
    2. マーク済み、再生済みにチェックを入れたい場合、それぞれのチェックボックスにチェックを入れる。
    3. 'サウンド情報を更新' ボタンをクリックするとデータベースに保存されます。画面上部にデータベースに更新した時刻と再生位置が書かれたメッセージが表示されます。

上部に表示されるメッセージは、'サウンド情報を更新' ボタンをクリックする度に追加されます。消去したい場合、'すべてのメッセージを消去' ボタンをクリックしてください。

Set ボタンをクリックするとテキストフィールドに保存された再生位置にジャンプします。

'サウンド情報を更新' ボタンをクリックしない限り、再生位置は保存されないので注意していください。

9. その他の操作

ナビゲーション

- Home

yplayer/public/radio ディレクトリのファイル一覧を表示します。

- アカウント

ログインしていない時に表示されます。

- アカウント > ログイン

ログイン画面を開きます。

- Users

ログインしている時に表示され、クリックするとユーザー一覧が表示されます。
管理者権限が付いているユーザーは、他のアカウントを削除できます。自分自身は削除できないので注意してください。

- ログイン名

ログインしている時に表示されます。

- ログイン名 > プロフィール

プロフィールを表示します。
データーベースの更新履歴も表示されます。最後に再生した音声ファイルを探すのに便利です。ただし、ファイル一覧で作成された音声ファイルのデータも表示されるので注意してください。

- ログイン名 > 設定

アカウント名、パスワードを変更できます。  
アカウント名や管理者権限だけを変更したい場合、パスワードは入力する必要はありません。

- ログイン名 > ログアウト

 ログアウトします。

## 【動作環境】

ruby 2.6.1p33 (2019-01-30 revision 66950) [armv6l-linux-eabihf]  
Rails 5.2.2  
Safari iOS 12.1.4(16D57) iPhone XS Max  

## 【ライセンス】

Ruby on Rails で作成された yplayer の KOYAMA Yoshiaki によって書かれたソースコードは [MIT ライセンス](LICENSE) のもとで公開します。

ログイン処理は

```
2017/10/09(Mon) 18:40:59
Ruby on Rails Tutorial: Learn Web Development with Rails (Addison-Wesley Professional Ruby Series)Nov 17, 2016 | Kindle eBook
by Michael Hartl
Kindle Edition
$ 42.84
1$ = ¥112.70
¥4824
クレジット会社
¥4935
```

上記書籍のサンプルソースコードを参考にしています。書籍としては古いので注意してください。ライセンスは下記の通りです。

All source code in the [Ruby on Rails Tutorial](http://railstutorial.org/) is available jointly under the MIT License and the Beerware License.

```
The MIT License

Copyright (c) 2016 Michael Hartl

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

```
THE BEERWARE LICENSE (Revision 42)

Michael Hartl wrote this code. As long as you retain this notice you can do
whatever you want with this stuff. If we meet some day, and you think this
stuff is worth it, you can buy me a beer in return.
```
