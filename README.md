# vagrant-rails-vue-nginx
docker-composeで Rails API + Vue.js の開発環境・本番環境を構築するためのサンプルコード
Vagrantで仮想サーバを立ち上げて動作確認できるようにしている


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
$ docker-compose -f docker-compose.prod.yml build
$ docker-compose -f docker-compose.prod.yml up -d
$ docker-compose -f docker-compose.prod.yml exec api bin/rails db:migrate
$ docker-compose -f docker-compose.prod.yml exec api bin/rails db:seed
```

## ブラウザで表示する
ブラウザで http://example.com を開くとVue.jsのページが表示され、さらにRails APIを叩いた結果が表示される

![image](https://user-images.githubusercontent.com/20487308/111874182-5c090100-89d7-11eb-85a8-9f13d8322b78.png)

ブラウザで http://api.example.com/users を開くとRails APIのレスポンスデータが表示される

![image](https://user-images.githubusercontent.com/20487308/111874184-5dd2c480-89d7-11eb-89ef-a7e17ed2d22d.png)

## 説明
### 仮想マシンのOS
vagrantで立ち上げるOSは Ubuntu 20.04 LTS
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


### 開発環境と本番環境
開発環境では`docker-compose.yml`、本番環境では`docker-compose.prod.yml`を使用する

||開発環境|本番環境|
|---|---|---|
|起動するコンテナ|db, api, client|db, api, client, nginx|
|起動コマンド|`docker-compose up -d`|`docker-compose -f docker-compose.prod.yml up -d`|
|URL|vue → `http://localhost:8080`<br>rails → `http://localhost:3000`|vue → `http://example.com`<br>rails → `http://api.example.com/users`|
|DBのパスワード|無し|有り|
|Railsの起動|developmentモードで3000番ポートで起動|productionモードでソケットで起動|
|Vueページの表示|`npm run serve`の結果|`npm run build`の結果|


### 秘匿情報
このレポジトリでは`.env`を公開しているが、本当はgitignoreして公開しないようにする必要がある<br>
Railsの秘匿情報の復号化に使用する`RAILS_MASTER_KEY`やDBのパスワードなどが記載されているため


### HTTPS対応
未対応<br>
この記事を参考にする
- [Ubuntu 20.04でLet’s Encryptを使用してNginxを保護する方法](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-20-04-ja)
