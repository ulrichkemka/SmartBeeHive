import axios from 'axios'
import config from './config.service'
import { Rucher } from '../types'

const API_URL = config.API_URL + 'user/rucher/'

class RucherService {

  async getRuchers(userId) {
    const response = await axios.get(API_URL + userId)
    return response.data
  }

  async getRucher(userId, rucherId) {
    const response = await axios.get(API_URL + userId + '/' + rucherId)
    return response.data
  }

  async updateRucher(userId: string, rucherId: string, rucher: Rucher) {
    const response = await axios.put(API_URL + userId + '/' + rucherId, rucher)
    return response.data
  }

  async deleteRucher(userId: string, rucherId: string) {
    const response = await axios.delete(API_URL + userId + '/' + rucherId)
    return response.data
  }

  async createRucher(userId: string, rucher: Rucher) {
    const response = await axios.post(API_URL + userId, rucher)
    return response.data
  }
}
export default new RucherService()
