import axios from 'axios'
import config from './config.service'
import { User } from '../types'

const API_URL = config.API_URL + 'user/'

class UserService {

  // async getProfile() {
  //   const response = await axios.get(API_URL + 'me')
  //   return response.data
  // }

  async getProfile(userId: string) {
    const response = await axios.get(API_URL + userId)
    return response.data
  }

  async getUsers() {
    const response = await axios.get(API_URL)
    return response.data
  }

  async updateUser(userId: string, user: User) {
    const response = await axios.put(API_URL + userId + '/Administrateur', user )
    return response.data
  }

  async deleteUser(userId: string) {
    const response = await axios.delete(API_URL + userId)
    return response.data
  }

  async createUser(user: User) {
    const response = await axios.post(API_URL, user)
    return response.data
  }
}
export default new UserService()
