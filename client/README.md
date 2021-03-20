# LOG
Vueアプリケーションの作成・設定のログを残す

## プロジェクトの作成

```bash
$ vue create client

Vue CLI v4.5.12
? Please pick a preset: Manually select features
? Check the features needed for your project: Choose Vue version
? Choose a version of Vue.js that you want to start the project with 2.x
? Where do you prefer placing config for Babel, ESLint, etc.? In dedicated config files
? Save this as a preset for future projects? No
```

## axiosのインストール

```bash
$ npm install axios
```

## APIを叩いた結果を表示するコンポーネントの作成

```vue:client/src/components/HelloWorld.vue
<template>
  <div>
    <h1>Users</h1>
    <ul>
      <li v-for="user in users" :key="user.id">
        {{ user.name }}
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'HelloWorld',
  data () {
    return {
      users: []
    }
  },
  mounted () {
    const api_url = process.env.VUE_APP_API_URL + '/users'
    axios
      .get(api_url)
      .then(response => this.users = response.data)
  }
}
</script>
```
