import { render, waitFor, within } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { rest } from 'msw'
import { setupServer } from 'msw/node'
import { MemoryRouter } from 'react-router-dom'
import { expect, test } from 'vitest'
import { AuthProvider } from '../../contexts/auth'
import { ModalProvider } from '../../contexts/modal'
import { ToastsProvider } from '../../contexts/toasts'
import config from '../../services/config.service'
import UserList from './UserList'

const API_URL = config.API_URL

const server = setupServer(
  // The auth context sets the current user upon loading
  rest.get(API_URL + 'user/me', (req, res, ctx) => {
    return res(
      ctx.json({
        id: 38,
        username: 'adminUser',
        roles: ['ROLE_PLAYER', 'ROLE_ADMIN'],
      })
    )
  })
)

beforeAll(() => server.listen())
afterEach(() => server.resetHandlers())
afterAll(() => server.close())

function setup() {
  const user = userEvent.setup()
  const route = '/users'
  const users = [
    {
      id: 13,
      username: 'playerUser',
      roles: [
        {
          roleName: 'player',
        },
      ],
    },
    {
      id: 27,
      username: 'editorUser',
      roles: [
        {
          roleName: 'player',
        },
        {
          roleName: 'editor',
        },
      ],
    },
    {
      id: 38,
      username: 'adminUser',
      roles: [
        {
          roleName: 'player',
        },
        {
          roleName: 'admin',
        },
      ],
    },
  ]

  const utils = render(
    <AuthProvider>
      <ToastsProvider>
        <ModalProvider>
          <MemoryRouter initialEntries={[route]}>
            <UserList users={users} />
          </MemoryRouter>
        </ModalProvider>
      </ToastsProvider>
    </AuthProvider>
  )

  const clearSearchValue = () => user.clear(utils.getByRole('searchbox'))
  const setSearchValue = (value: string) =>
    user.type(utils.getByRole('searchbox'), value)

  return {
    ...utils,
    user,
    users,
    clearSearchValue,
    setSearchValue,
  }
}

test('it displays title', async () => {
  const { getByRole } = setup()

  // expect header
  expect(getByRole('heading')).toHaveTextContent(/Liste des utilisateurs/)
})
