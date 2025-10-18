demmy's dotfiles
========

## このVim設定でたぶん対象にできている言語

* C
* C++
* Java
* Scala
* Kotlin
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



## Windows のセットアップ

`windows_setup.ps1` スクリプトは、Neovim と WezTerm 向けの Windows 用シンボリックリンクを作成します。
Neovim は winget でインストールした構成を前提としています。

### 1. 前提条件

- PowerShell 5.0 以降を備えた Windows 10 以上。
- シンボリックリンクを許可するために、開発者モードの有効化または管理者権限の PowerShell セッション。
- 実行ポリシーが `RemoteSigned` であること（必要に応じて `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` を実行）。
- Git がインストールされていること。未インストールの場合は winget などで導入してください。

### 2. 必要なアプリのインストール

```powershell
PS> winget install Neovim.Neovim
PS> winget install WezTerm.WezTerm
```

- 既にインストール済みの場合は、この手順はスキップできます。

### 3. スクリプトの実行

```powershell
PS> git clone https://github.com/demmys/dotfiles.git
PS> Set-Location dotfiles
PS> .\windows_setup.ps1
```

- 既存の設定ファイルを置き換える必要がある場合は、`-Force` オプションを付けて実行します。

### 4. 実行後の確認

- Neovim を起動して `dein` がプラグインをインストールできるか確認します。
- WezTerm を再起動して新しい設定が読み込まれるか確認します。

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

### 3. NeovimとTmuxのインストール

以下の手順で[Homebrew](http://brew.sh/index_ja.html)をインストールした上でTmuxをインストールします。
また、Neovimについてもdotfilesの持つ機能を最大限活かすためにmacOS標準のものではなく、Homebrewを使ったものをインストールすることをおすすめします。
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install neovim tmux
```

### 4. 既存の設定の削除

もし、既にNeovimプラグインが`.config/nvim`ディレクトリに配置されている場合は、コンフリクトを避けるためにターミナルを開いて以下のコマンドを実行し、削除しておきます。
```
$ rm -rf ~/.config/nvim
```
また、ホームディレクトリに`.bashrc`、`.tmux.conf`、`.config/nvim/init.vim`といったファイルが存在する場合はこのdotfilesで上書きされてしまうため、残しておきたければ先に別の場所へ移動しておきます。

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
### 7. Neovimの初回起動とプラグインのインストール

dotfilesのインストール後、Neovimを起動すると自動で[dein](https://github.com/Shougo/dein.vim)のcloneと各プラグインのインストールが始まります。

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
$ rm -rf ~/.config/nvim ~/.config/nvim/init.vim ~/.tmux.conf ~/.bashrc ~/dotfiles
```

アンインストール後も上記インストール手順を踏めば再度dotfilesをインストールすることができます。


## 不具合報告

設定ファイルやリンク用のスクリプトなどに不具合を見つけた場合は、[dotfilesのGithubレポジトリのissue](https://github.com/demmys/dotfiles/issues)でお知らせいただけると助かります。


## dotfilesの拡張方法

dotfiles内のNeovim設定ファイルについては各コマンドに日本語のコメントを書いているため、初心者でも調べながら簡単に拡張することができます。

もし、大きな機能拡張を行いたくなった場合には、自分のGithubアカウントを作成してdotfilesのGithubレポジトリをForkし、独自の拡張をするといいでしょう。


