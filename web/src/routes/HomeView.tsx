import React, { useEffect, useState } from 'react'
import { redirect, useLoaderData } from 'react-router-dom'
import Home from '../components/home/Home'
import RucherService from '../services/rucher.service'
import authService from '../services/auth.service'

export async function loader() {
  const currentUser = await authService.getCurrentUser()
  const ruchers = await RucherService.getRuchers(currentUser.id)
  return { ruchers, currentUser }
}

const HomeView = () => {
  const { ruchers, currentUser } = useLoaderData()
  return <Home ruchers={ruchers} currentUser={currentUser} />
}

export default HomeView
