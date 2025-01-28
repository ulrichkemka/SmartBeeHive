import axios from 'axios'
import config from './config.service'

const API_URL = config.API_URL + 'file/'

class FileService {
  async downloadFile(filePath) {
    const response = await axios.get(API_URL + 'download/' + filePath, {
      responseType: 'blob',
    })
    return response
  }

  async uploadFile(file, rootFolder, id) {
    let formData = new FormData()
    formData.append('destinationFolder', rootFolder + '/' + id)
    formData.append('file', file)

    const response = await axios.post(API_URL + 'upload', formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    })
    return response
  }
}

export default new FileService()
