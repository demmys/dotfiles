demmy's dotfiles
========

## このVim設定で使用実績のある言語・フレームワーク

* C
* C++
* Java (Java8シンタックスは未対応)
* Scala
* Swift
* Haskell
* Go
* Ruby
* Python
* JavaScript
* CoffeeScript
* Perl
* PHP
* Vim
* Otter
* LLVM-IR
* Verilog
* Markdown
* HTML
* CSS
* Less
* Ruby on Rails
* Play! Framework
* Yesod
* バイナリファイル


## Mac OS Xの場合のインストール方法

dotfilesのインストールは必ず下記手順を全て読んでから行ってください。

### 1. Xcodeのインストール

Xcodeをインストールしていない場合は、Mac AppStoreから最新版のXcodeをインストールします。

### 2. Command Line Tools for Xcodeのインストール

[AppleのDevelopper向けダウンロードページ](https://developer.apple.com/downloads/index.action)から自分の使用しているOS XバージョンおよびXcodeバージョンに合ったCommand Line Toolsをダウンロード・インストールします。

インストールが完了したらターミナルを開いて
```
$ git --version
```
と打ち込み、Gitがインストールされていることを確認します。


### 3. 既存の設定の削除

もし、既に他の`.tmux.conf`や`.vimrc`、Vimプラグインを使用している場合には、コンフリクトを避けるためにターミナルを開いて以下のコマンドを実行し、先に全て削除しておきます。
```
$ rm -rf ~/.tmux.conf ~/.vim ~/.vimrc
```

削除したくない場合は、上記コマンドの代わりに下記のコマンドを実行して、ファイルを別の場所に移動させるといいでしょう。
```
$ mv ~/.tmux.conf /tmp/
$ mv ~/.vim /tmp/
$ mv ~/.vimrc /tmp/
```


### 4. dotfilesのダウンロードとインストール

dotfilesはターミナルを開き、以下のコマンドを順に実行することで簡単にダウンロード・インストールすることができます。
```
$ cd
$ git clone https://github.com/demmys/dotfiles.git
$ cd dotfiles
$ ./symlink.sh
```

最後のコマンドを入力すると[`neobundle.vim`](https://github.com/Shougo/neobundle.vim)が`~/.vim/`以下にインストールされ、ホームディレクトリに`~/dotfiles`ディレクトリ内の`.vimrc`および生成された`.tmux.conf`のシンボリックリンクが作成されます。


### 5. Vimの初回起動とプラグインのインストール

dotfilesのインストール後、Vimを起動するとプラグインのインストールをするかどうか尋ねられるため、`y`と返答すると、即座にプラグインをインストールすることができます。

dotfilesの`.vimrc`はプラグインをインストールしない限りまっとうに使用することはできませんので、必ずインストールを行うようにしてください。


## リモート環境でのインストール

SSHなどを利用して接続するリモート環境では、ローカル環境で起動したTmux内で接続すると、Tmuxのプレフィックスのキーバインドが衝突するため、リモート環境でTmuxを使用することができなくなってしまいます。

そのため、リモート環境でインストールする際には`symlink.sh`の実行時に
```
$ $TMUX_ENV=remote ./symlink.sh
```

とすると、プレフィックス設定がローカルでは`Ctrl-g`、リモート環境では`Ctrl-t`と分かれるので、リモート環境でもTmuxを使用できるようになります。


## Tmux 1.8環境でのインストール

dotfilesの`.tmux.conf`はTmux 1.9以上の環境を想定して書かれていますが、バージョンが1.8系統の環境でもブランチtmux18のものであれば使用することができます。
tmux18ブランチのものをインストールするためには、上記インストール手順4番の中で実行されていたコマンドの代わりに以下のコマンドを実行します。
```
$ cd
$ git clone -b tmux18 https://github.com/demmys/dotfiles.git
$ cd dotfiles
$ git rebase origin/master
$ ./symlink.sh
```

上記コマンドを実行することで、バージョン1.8用でありながらmasterブランチと全く同じ機能を持った設定ファイルをインストールすることができます。

## Mac OS Xの場合のアンインストール方法

上記手順でインストールを行った場合、アンインストールは作成されたファイルやディレクトリを全て削除するだけで完了します。
```
$ rm -rf ~/.vim ~/.vimrc ~/.tmux.conf ~/dotfiles
```

アンインストール後も上記インストール手順を踏めば再度dotfilesをインストールすることができます。


## 不具合報告

設定ファイルやリンク用のスクリプトなどに不具合を見つけた場合は、[dotfilesのGithubレポジトリのissue](https://github.com/demmys/dotfiles/issues)でお知らせいただけると助かります。


## dotfilesの拡張方法

dotfiles内のVim設定ファイルについては各コマンドに日本語のコメントを書いているため、初心者でも調べながら簡単に拡張することができます。

もし、大きな機能拡張を行いたくなった場合には、自分のGithubアカウントを作成してdotfilesのGithubレポジトリをForkし、独自の拡張をするといいでしょう。
