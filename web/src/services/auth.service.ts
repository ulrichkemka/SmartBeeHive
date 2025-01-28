import axios from 'axios'
import jwtDecode from 'jwt-decode'
import config from './config.service'


const API_URL = config.API_URL + 'auth/'

class AuthService {

  async login(email: string, password: string) {
    const response = await axios.post(API_URL + 'signIn/' + email + '/' + password,)
    localStorage.setItem('token', response.data.idToken)

    const decodedToken = jwtDecode(response.data.idToken)
    return decodedToken
  }

  getCurrentUser() {
    const user = localStorage.getItem('user')
    if (user !== null) return JSON.parse(user)
    return null
  }
}

export default new AuthService()
