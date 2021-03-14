# vagrant-rails-nginx
- Vagrantで仮想マシンを立ち上げる
- docker-composeでRailsとNginxを起動する
- http://example.comで Nginxページを、 http://api.example.com でRailsページを表示する


## 事前準備
- VirtualBoxをインストールする
  - `brew cask install virtualbox`
  - 参考: [Virtualboxのインストール](https://qiita.com/zaburo/items/770091883581985b1c05)
- Vagrantをインストールする
  - `brew cask install vagrant`
  - `vagrant plugin install vagrant-hostsupdater`
    - ホスト名で仮想マシンにアクセスするためのプラグイン
    - https://github.com/agiledivider/vagrant-hostsupdater

## セットアップ

```bash
$ git clone https://github.com/youichiro/vagrant-rails-nginx.git
$ cd vagrant-rails-nginx

# 仮想マシンを起動し、vagrant/init.shを実行
$ vagrant up

# 仮想マシンにログインする
$ vagrant ssh

# プロンプトが vagrant@ubuntu-focal:~$ に変わる
# rootユーザに切り替える
$ sudo su

# プロンプトが root@ubuntu-focal:/home/vagrant に変わる
# 仮想マシンの中でも git clone する
$ cd /var/app
$ git clone https://github.com/youichiro/vagrant-rails-nginx.git
$ cd vagrant-rails-nginx

# docker-composeを起動する
$ docker-compose build
$ docker-compose up -d
$ docker-compose run --rm api bin/rails db:create
```

## ブラウザで表示する
ブラウザで http://example.com を開く

![image](https://user-images.githubusercontent.com/20487308/111075735-bd8b2480-852c-11eb-88f0-7c14c8a93041.png)

ブラウザで http://api.example.com を開く

![image](https://user-images.githubusercontent.com/20487308/111075773-de537a00-852c-11eb-8c87-4400f5d947a0.png)


## 説明
### 仮想マシンのOS
vagrantで立ち上げるOSは Ubuntu 20.04
Vagrantfileで指定している

```Vagrantfile
  config.vm.box = "ubuntu/focal64"
```

### 複数のネットワーク・ホスト名を用意する
vagrant-hostsupdaterをインストールすれば複数のネットワークに対してそれぞれのホスト名を割り当てることができる<br>
https://github.com/agiledivider/vagrant-hostsupdater#multiple-private-network-adapters

```Vagrantfile
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "private_network", ip: "192.168.33.11"
  config.hostsupdater.aliases = {
      '192.168.33.10' => ['example.com'],
      '192.168.33.11' => ['api.example.com']
  }
```

これで example.com と api.example.com からのリクエストを別々に受け取ることができる


## TODO
- [ ] nginxのログ
- [ ] railsのproduction実行
- [ ] docker-compose.ymlをdev環境とproduction環境に分ける
- [ ] フロントエンド
