import { expect, it } from 'vitest'
import { rest } from 'msw'
import { setupServer } from 'msw/node'
import { render, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { MemoryRouter } from 'react-router-dom'
import { AuthProvider } from '../../contexts/auth'
import { ToastsProvider } from '../../contexts/toasts'
import LoginForm from './LoginForm'
import config from '../../services/config.service'

const API_URL = config.API_URL

const ACCESS_TOKEN = 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImIyZGZmNzhhMGJkZDVhMDIyMTIwNjM0OTlkNzdlZjRkZWVkMWY2NWIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vc21hcnRiZWVoaXZlLWY2N2YxIiwiYXVkIjoic21hcnRiZWVoaXZlLWY2N2YxIiwiYXV0aF90aW1lIjoxNjg5ODAzODkxLCJ1c2VyX2lkIjoiZjdlOTEzODYtZjIxNC00NTE3LWExMjItMzlhOTUwYmNlOWQ2Iiwic3ViIjoiZjdlOTEzODYtZjIxNC00NTE3LWExMjItMzlhOTUwYmNlOWQ2IiwiaWF0IjoxNjg5ODAzODkxLCJleHAiOjE2ODk4MDc0OTEsImVtYWlsIjoiam9yZGFuQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJqb3JkYW5AZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.vRhXPMMo2Ctwe9Y6QAlBEfhFDbCpXnHtc_O1WlNR0ujREeiVb-7H6jPphkZ5o69NF5W-BYRJBq4nADzW5PyPP0h44ia6WxGbTjrPCZp2S08WIX0p-ngn1cg2EgLpdeI1ReAvtrBs3_KAW83P-95eNuNNbVi2a3s12uOrQUwmw0jbn3AI11rU99gl7zSpCjebHgmHaVuHEFOlTRDfR4QGtGzk3fXOySoc44En-Ke99wTqz-H7KIi37fzs4hEaYBLi90UQXQDylrziIQoWmqOKxwOr7yrXg01lUJexZ8VP7ZD506wf9piHTNfW1eZlqGZbq9kfA7ddjlWW_9buRz8ETg'
const server = setupServer(
  // Upon loading the auth context tries to load user profile
  // return 401 to simulate logged out user
  rest.get(API_URL + 'user/f7e91386-f214-4517-a122-39a950bce9d6', (req, res, ctx) => {
    return res(ctx.status(401))
  }),

  rest.post(API_URL + 'auth/signIn/jordan%40gmail.com/aaaaaa')
)

beforeAll(() => server.listen())
afterEach(() => server.resetHandlers())
afterAll(() => server.close())

function setup() {
  const user = userEvent.setup()
  const route = '/some-route'
  const utils = render(
    <AuthProvider>
      <ToastsProvider>
        <MemoryRouter initialEntries={[route]}>
          <LoginForm />
        </MemoryRouter>
      </ToastsProvider>
    </AuthProvider>
  )
  const setMailInput = (value: string) =>
    user.type(utils.getByLabelText(/Mail/i), value)
  const setPasswordInput = (value: string) =>
    user.type(utils.getByLabelText(/Mot de passe/i), value)
  return {
    ...utils,
    user,
    setMailInput,
    setPasswordInput,
  }
}

it('should render a sign in button', async () => {
  const { getByRole } = setup()
  expect(getByRole('button', { name: 'Se connecter' })).toHaveTextContent(
    /Se connecter/i
  )
})

it('should display required helper text', async () => {
  const { getByRole, getByText, user } = setup()

  const loginBtn = getByRole('button', { name: 'Se connecter' })
  await user.click(loginBtn)

  expect(getByText(/Le mail de l'utilisateur est requis./i)).toBeVisible()
  expect(getByText(/Un mot de passe est requis./i)).toBeVisible()
})

it('should login user', async () => {
  const { getByRole, getByText, user, setMailInput, setPasswordInput } =
    setup()

  await setMailInput('jordan@gmail.com')
  await setPasswordInput('aaaaaa')
  const loginBtn = getByRole('button', { name: 'Se connecter' })

  await user.click(loginBtn)

  // expect(getByText(/Connexion réussie./i)).toBeVisible()
  // expect(localStorage.getItem('token')).toEqual(ACCESS_TOKEN)
})

