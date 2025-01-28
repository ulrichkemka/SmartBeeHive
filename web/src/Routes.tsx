import Login from './routes/Login'
import HomeView, {
  loader as HomeLoader,
} from './routes/HomeView'
import TopMenuBarView, {
  loader as TopMenuBarLoader,
} from './routes/TopMenuBarView'
import UserListView, {
  loader as userListLoader,
} from './routes/UserListView'
import AccountUserView, {
  loader as AccountUserLoader,
}  from './routes/AccountUserView'

export const routes = [
  {
    path: '/',
    element: <TopMenuBarView />,
    loader: TopMenuBarLoader,
    children: [
      {
        index: true,
        path: 'login',
        element: <Login />,
      },
      {
        path: 'home',
        element: <HomeView />,
        loader: HomeLoader,
      },
      {
        path: 'users',
        element: <UserListView />,
        loader: userListLoader,
      },
      {
        path: 'account',
        element: <AccountUserView />,
        loader: AccountUserLoader,
      },
    ],
  },
]
