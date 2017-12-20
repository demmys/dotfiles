demmy's dotfiles
========

## このVim設定でたぶん対象にできている言語

* C
* C++
* Java
* Scala
* Swift
* Haskell
* Go
* Ruby
* Python
* JavaScript
* CoffeeScript
* Pug
* Perl
* PHP
* Vim
* LLVM-IR
* Verilog
* Markdown
* HTML
* CSS
* Less
* Ruby on Rails
* バイナリファイル


## macOSの場合のインストール方法

dotfilesのインストールは必ず下記手順を全て読んでから行ってください。

### 1. Xcodeのインストール

Xcodeをインストールしていない場合は、Mac AppStoreから最新版のXcodeをインストールします。

### 2. Command Line Tools for Xcodeのインストール

[AppleのDevelopper向けダウンロードページ](https://developer.apple.com/downloads/index.action)から自分の使用しているmacOSバージョンおよびXcodeバージョンに合ったCommand Line Toolsをダウンロード・インストールします。

インストールが完了したらターミナルを開いて
```
$ git --version
```
と打ち込み、Gitがインストールされていることを確認します。

### 3. VimとTmuxのインストール

以下の手順で[Homebrew](http://brew.sh/index_ja.html)をインストールした上でTmuxをインストールします。
また、Vimについてもdotfilesの持つ機能を最大限活かすためにmacOS標準のものではなく、Homebrewを使ったものをインストールすることをおすすめします。
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install tmux lua
$ brew install vim --with-lua
```

### 4. 既存の設定の削除

もし、既にVimプラグインが`.vim`ディレクトリに配置されている場合は、コンフリクトを避けるためにターミナルを開いて以下のコマンドを実行し、削除しておきます。
```
$ rm -rf ~/.vim
```
また、ホームディレクトリに`.bashrc`、`.tmux.conf`、`.vimrc`といったファイルが存在する場合はこのdotfilesで上書きされてしまうため、残しておきたければ先に別の場所へ移動しておきます。

### 5. dotfilesのダウンロードとインストール

dotfilesはターミナルを開き、以下のコマンドを順に実行することで簡単にダウンロード・インストールすることができます。
```
$ cd
$ git clone https://github.com/demmys/dotfiles.git
$ cd dotfiles
$ ./symlink.sh
```
最後のコマンドを入力するとホームディレクトリに各dotfilesが配置されます。

### 6. .bash_profileへの追記

`.bashrc`ファイルが確実に読み込まれることを保証するために`.bash_profile`ファイルの先頭に以下を追記します。
```bashrc
source ~/.bashrc
```
### 7. Vimの初回起動とプラグインのインストール

dotfilesのインストール後、Vimを起動すると自動で[dein](https://github.com/Shougo/dein.vim)のcloneと各プラグインのインストールが始まります。

## リモート環境でのインストール

SSHなどを利用して接続するリモート環境では、ローカル環境で起動したTmux内で接続すると、Tmuxのプレフィックスのキーバインドが衝突するため、リモート環境でTmuxを使用することができなくなってしまいます。

そのため、リモート環境でインストールする際には`symlink.sh`の実行時に
```
$ $TMUX_ENV=remote ./symlink.sh
```

とすると、プレフィックス設定がローカルでは`Ctrl-g`、リモート環境では`Ctrl-t`と分かれるので、リモート環境でもTmuxを使用できるようになります。

## Tmux 1.8環境でのインストール

dotfilesの`.tmux.conf`はTmux 1.9以上の環境を想定して書かれていますが、バージョンが1.8系統の環境でもブランチtmux18のものであれば使用することができます。
tmux18ブランチのものをインストールするためには、上記インストール手順5番の中で実行されていたコマンドの代わりに以下のコマンドを実行します。
```
$ cd
$ git clone -b tmux18 https://github.com/demmys/dotfiles.git
$ cd dotfiles
$ git rebase origin/master
$ ./symlink.sh
```

上記コマンドを実行することで、バージョン1.8用でありながらmasterブランチと全く同じ機能を持った設定ファイルをインストールすることができます。

## macOSの場合のアンインストール方法

上記手順でインストールを行った場合、アンインストールは作成されたファイルやディレクトリを全て削除するだけで完了します。
```
$ rm -rf ~/.vim ~/.vimrc ~/.tmux.conf ~/.bashrc ~/dotfiles
```

アンインストール後も上記インストール手順を踏めば再度dotfilesをインストールすることができます。


## 不具合報告

設定ファイルやリンク用のスクリプトなどに不具合を見つけた場合は、[dotfilesのGithubレポジトリのissue](https://github.com/demmys/dotfiles/issues)でお知らせいただけると助かります。


## dotfilesの拡張方法

dotfiles内のVim設定ファイルについては各コマンドに日本語のコメントを書いているため、初心者でも調べながら簡単に拡張することができます。

もし、大きな機能拡張を行いたくなった場合には、自分のGithubアカウントを作成してdotfilesのGithubレポジトリをForkし、独自の拡張をするといいでしょう。
