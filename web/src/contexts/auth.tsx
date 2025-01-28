import {
  createContext,
  FC,
  useState,
  ReactNode,
  useContext,
  useEffect,
} from 'react'
import UserService from '../services/user.service'
import AuthService from '../services/auth.service'
import { User } from '../types'

type AuthContextType = {
  user: User | null
  setUser: (user: User) => void
  login: (data: FormData) => void
  logout: () => void
}

const AuthContext = createContext<AuthContextType>({} as AuthContextType)

interface AuthContextProviderProps {
  children: ReactNode
}

const AuthProvider: FC<AuthContextProviderProps> = ({ children }) => {
  const [user, setUser] = useState<User>()

  const login = async (email: string, password: string): User => {
    const dataUser = await AuthService.login(email, password)
    const user = await UserService.getProfile(dataUser.user_id)
    localStorage.setItem('user', JSON.stringify(user))

    setUser(user)
    return user
  }

  const logout = () => {
    localStorage.removeItem('token')
    localStorage.removeItem('user')
    setUser(undefined)
  }

  const isAdmin = () => {
    return Boolean(user && user.role === 'administrateur')
  }

  return (
    <AuthContext.Provider value={{ user, setUser, login, logout }}>
      {children}
    </AuthContext.Provider>
  )
}

const useAuth = (): AuthContextType => {
  return useContext(AuthContext)
}

export { AuthProvider, useAuth }
