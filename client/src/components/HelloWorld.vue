<template>
  <div>
    <h1>Hello World!</h1>
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
    // axios.defaults.headers.common['Content-Type'] = 'application/json';
    axios
      .get('http://localhost:3000/users')
      .then(response => this.users = response)
  }
}
</script>

