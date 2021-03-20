<template>
  <div>
    <h1>Hello World!</h1>
    <ul>
      <li v-for="user in users">
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
    axios
      .get('localhost:3000/users')
      .then(response => this.users = response)
  }
}
</script>

