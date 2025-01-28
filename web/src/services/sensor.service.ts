import axios from 'axios'
import config from './config.service'
import { Sensor } from '../types'

const API_URL = config.API_URL + 'sensor_data/'

class SensorService {

  async getSensors(userId, rucherId, rucheId) {
    const response = await axios.get(API_URL + userId + '/' + rucherId + '/' + rucheId)
    return response.data
  }
}
export default new SensorService()
