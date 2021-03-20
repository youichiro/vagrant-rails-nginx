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
    const api_url = process.env.VUE_APP_API_URL || 'http://localhost:3000' + '/users'
    axios
      .get(api_url)
      .then(response => this.users = response.data)
  }
}
</script>

