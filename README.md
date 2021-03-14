# vagrant-rails-nginx

## 事前準備
- VirtualBoxをインストールする
  - `brew cask install virtualbox`
  - 参考: [Virtualboxのインストール](https://qiita.com/zaburo/items/770091883581985b1c05)
- Vagrantをインストールする
  - `brew cask install vagrant`

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
`http://example.com`

![image](https://user-images.githubusercontent.com/20487308/111075735-bd8b2480-852c-11eb-88f0-7c14c8a93041.png)

`http://api.example.com`

![image](https://user-images.githubusercontent.com/20487308/111075773-de537a00-852c-11eb-8c87-4400f5d947a0.png)
