import { render, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { rest } from 'msw'
import { setupServer } from 'msw/node'
import { MemoryRouter } from 'react-router-dom'
import { expect, test, vi } from 'vitest'
import { AuthProvider } from '../../contexts/auth'
import UserForm from './UserForm'
import config from '../../services/config.service'

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

function setup(editUser = null, onCancel = null, handleSubmit = null) {
  const user = userEvent.setup()
  const route = '/users'

  const utils = render(
    <AuthProvider>
      <MemoryRouter initialEntries={[route]}>
        <UserForm
          user={editUser}
          onCancel={onCancel}
          handleSubmit={handleSubmit}
        />
      </MemoryRouter>
    </AuthProvider>
  )

  return {
    ...utils,
    user,
  }
}

test('it displays title', async () => {
  const { getByRole } = setup()

  // expect header
  expect(getByRole('heading')).toHaveTextContent(/Créer un compte utilisateur/)
})

test('it displays error messages', async () => {
  const { getByRole, getByText, queryByText, user } = setup()

  const submitBtn = getByRole('button', { name: 'Créer' })
  await user.click(submitBtn)
  expect(getByText(/Veuillez renseigner un identifiant./)).toBeVisible()
  expect(getByText(/Veuillez renseigner un nom./)).toBeVisible()
  expect(getByText(/Veuillez renseigner un prénom./)).toBeVisible()
  expect(getByText(/Veuillez renseigner un email./)).toBeVisible()

  await user.type(getByRole('textbox', { name: 'Email' }), 'tata@gmail')
  expect(getByText(/Veuillez renseigner un email au bon format./)).toBeVisible()
  expect(getByText(/Veuillez renseigner une adresse postale./)).toBeVisible()
  expect(getByText(/Veuillez selectionner un rôle./)).toBeVisible()
  expect(getByText(/Veuillez renseigner un mot de passe./)).toBeVisible()

  await user.type(getByRole('textbox', { name: 'Mot de passe' }), '12345')
  expect(getByText(/Le mot de passe doit contenir au moins 6 caractères./)).toBeVisible()
  expect(getByText(/Veuillez confirmer le mot de passe./)).toBeVisible()
  expect(queryByText(/Les mots de passe ne correspondent pas./)).toBeNull()

  await user.type(getByRole('textbox', { name: 'Mot de passe' }), 'password')
  await user.type(
    getByRole('textbox', { name: 'Confirmer le mot de passe' }),
    'qsdfmlj'
  )
  expect(getByText(/Les mots de passe ne correspondent pas./)).toBeVisible()
})

test('it displays default user values', async () => {
  const editUser = {
    id: 15,
    nom: 'John',
    role: 'apiculteur',
  }
  const { getByRole } = setup(editUser)

  expect(getByRole('textbox', { name: "Nom d'utilisateur" })).toHaveValue(
    editUser.nom
  )
})

test('admin user cannot delete his own admin account', async () => {
  const editUser = {
    id: 38,
    nom: 'adminUser',
  };
  const { getByRole, queryByRole } = setup(editUser);

  expect(getByRole('textbox', { name: "Nom d'utilisateur" })).toHaveValue(
    editUser.nom
  );
  const deleteButton = queryByRole('button', { name: 'Supprimer' })
  expect(deleteButton).toBeNull()
});


test('cancel button calls cancel callback', async () => {
  const onCancel = vi.fn()
  const { getByRole, user } = setup(null, onCancel, null)

  const cancelBtn = getByRole('button', { name: 'Annuler' })
  await user.click(cancelBtn)

  expect(onCancel).toHaveBeenCalledOnce()
})

// test('submit button calls submit callback with input values', async () => {
//   const handleSubmit = vi.fn()
//   const { getByRole, user } = setup(null, null, handleSubmit)

//   await user.type(
//     getByRole('textbox', { name: "Nom d'utilisateur" }),
//     'newUserName'
//   )
//   await user.type(
//     getByRole('textbox', { name: 'Confirmer le mot de passe' }),
//     'newPass'
//   )
//   await user.type(getByRole('textbox', { name: 'Mot de passe' }), 'newPass')
//   await user.type(getByRole('textbox', { name: 'Identifiant' }), 'newidenti')
//   await user.type(getByRole('textbox', { name: 'Prénom' }), 'newPrenom')
//   await user.type(getByRole('textbox', { name: 'Email' }), 'test@tou.ok')
//   await user.type(getByRole('textbox', { name: 'Adresse postale' }), 'levallois')
//   await user.type(getByRole('combobox', { name: 'Rôle' }), 'administrateur')

//   const submitBtn = getByRole('button', { name: 'Créer' })
//   await user.click(submitBtn)

//   expect(handleSubmit).toHaveBeenCalledWith({
//     id: '',
//     username: 'newUserName',
//     password: 'newPass',
//     confirmPassword: 'newPass',
//     role: 'administrateur',
//     adresse: 'levallois',
//     prenom: 'newPrenom',
//     email: 'test@tou.ok',
//     username: 'newidenti',
//     nom: 'newUserName',
//   })
// })
