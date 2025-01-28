import {
    EuiButton,
    EuiFlexGroup,
    EuiFlexItem,
    EuiText,
    EuiTitle,
  } from '@elastic/eui'
import { AxiosError } from 'axios'
import { useEffect, useState } from 'react'
import { useLoaderData } from 'react-router-dom'
import { useModal } from '../contexts/modal'
import { useToasts } from '../contexts/toasts'
import { User } from '../types'
import UserForm from '../components/users/UserForm'
import UserService from '../services/user.service'
import authService from '../services/auth.service'

export async function loader() {
  const user = await authService.getCurrentUser()
  const users = await UserService.getUsers()
  return { users, user }
}

const AccountUserView = () => {
  const { users, user } = useLoaderData()

  const { showModal, closeModal } = useModal()
  const { showToasts } = useToasts()

  const handleSubmit = async (values: User) => {
    try {
      const userToUpdate = await UserService.updateUser(values.id, values)
      showToasts([
        {
          title: 'Votre compte utlisateur a été mis à jour',
          color: 'success',
        },
      ])
      setUser(userToUpdate)
      closeModal()
    } catch (err: Error | AxiosError) {
      showToasts([
        {
          title: 'Une erreur est survenue',
          color: 'danger',
          text:
            err instanceof AxiosError ? err.response.data.message : err.message,
        },
      ])
    }
  }

  const onEditAccount = (user: User): void => {
    showModal(
      <UserForm
        user={user}
        account={true}
        users={users}
        onCancel={closeModal}
        handleSubmit={handleSubmit}
      />,
      false
    )
  }

  return (
    <EuiFlexGroup direction='column'>
      <EuiFlexItem>
        <EuiFlexGroup alignItems='center'>
          <EuiFlexItem grow={false}>
            <EuiTitle size='xs'>
            <h1> Informations du compte utilisateur </h1>
            </EuiTitle>
          </EuiFlexItem>
          <EuiFlexItem grow={false}>
            <EuiButton
              onClick={() => onEditAccount(user)}
              iconType='pencil'
              size='s'
              >
              Modifier
            </EuiButton>
          </EuiFlexItem>
        </EuiFlexGroup>
      </EuiFlexItem>
      <EuiFlexItem>
        <EuiText>
          Username : <b>{user.username}</b>
        </EuiText>
      </EuiFlexItem>
      <EuiFlexItem>
        <EuiText style={{ textAlign: 'justify' }}>
          Nom : <b>{user.nom}</b>
        </EuiText>
      </EuiFlexItem>
      <EuiFlexItem>
        <EuiText>
          Prénom : <b>{user.prenom}</b>
        </EuiText>
      </EuiFlexItem>
      <EuiFlexItem>
        <EuiText>
          Adresse : <b>{user.adresse}</b>
        </EuiText>
      </EuiFlexItem>
      <EuiFlexItem>
        <EuiText>
          Email : <b>{user.email}</b>
        </EuiText>
      </EuiFlexItem>
      <EuiFlexItem>
        <EuiText>
          Password : <b>**********</b>
        </EuiText>
      </EuiFlexItem>
    </EuiFlexGroup>
  )
}

export default AccountUserView
