import axios from 'axios'
import config from './config.service'
import { Ruche } from '../types'

const API_URL = config.API_URL + 'user/rucher/ruche/'

class RucheService {

  async getRuches(userId, rucherId) {
    const response = await axios.get(API_URL + userId + '/' + rucherId)
    return response.data
  }

  async getRuche(userId, rucherId, rucheId) {
    const response = await axios.get(API_URL + '/' + userId + '/' + rucherId + '/' + rucheId)
    return response.data
  }

  async updateRuche(userId: string, rucherId: string, rucheId: string, ruche: Ruche) {
    const response = await axios.put(API_URL + userId + '/' + rucherId + '/' + rucheId, ruche)
    return response.data
  }

  async deleteRuche(userId: string, rucherId: string, rucheId: string,) {
    const response = await axios.delete(API_URL + userId + '/' + rucherId + '/' + rucheId)
    return response.data
  }

  async createRuche(userId: string, rucherId: string, ruche: Ruche) {
    const response = await axios.post(API_URL + userId + '/' + rucherId, ruche)
    return response.data
  }
}
export default new RucheService()
