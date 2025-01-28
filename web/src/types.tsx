export interface User {
  username: string
  nom: string
  prenom: string
  adresse: string
  email: string
  password: string
  role: string
}

export interface Sensor {
  date: string
  heure: string
  humidite: number
  temperature: number
  couvercle: string
}

export interface Ruche {
  nom: string
  description: string
  adresseMac: string
  email: string
}

export interface Rucher {
  nom: string
  description: string
  adresse: string
}