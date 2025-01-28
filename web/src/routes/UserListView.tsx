import UserList from '../components/users/UserList'
import UserService from '../services/user.service'
import { useLoaderData } from 'react-router-dom'

export async function loader() {
  const users = await UserService.getUsers()
  return { users }
}

const UserListView = () => {
  const { users } = useLoaderData()
  return <UserList users={users}/>
}
export default UserListView
