import {
  EuiBasicTable,
  EuiButton,
  EuiCallOut,
  EuiConfirmModal,
  EuiFlexGroup,
  EuiFlexItem,
  EuiSearchBar,
  EuiTitle,
} from '@elastic/eui'
import { AxiosError } from 'axios'
import { FunctionComponent, useState } from 'react'
import { useAuth } from '../../contexts/auth'
import { useModal } from '../../contexts/modal'
import { useToasts } from '../../contexts/toasts'
import UserService from '../../services/user.service'
import { User } from '../../types'
import UserForm from './UserForm'
import { icon } from '@elastic/eui/src/components/icon/assets/empty'

interface UserListProps {
  users: Array<User>
}

const initialQuery = EuiSearchBar.Query.MATCH_ALL

const UserList: FunctionComponent<UserListProps> = ({ users }) => {
  const { showModal, closeModal } = useModal()
  const { showToasts } = useToasts()
  const [userList, setUserList] = useState(users)
  const [toDeleteId, setToDeleteId] = useState(null)
  const [isModalOpen, setIsModalOpen] = useState(false)
  const closeModalUser = () => setIsModalOpen(false)
  const { user: currentUser } = useAuth()

  //Pagination and sorting
  const [pageIndex, setPageIndex] = useState(0)
  const [pageSize, setPageSize] = useState(10)
  const [sortField, setSortField] = useState('username')
  const [sortDirection, setSortDirection] = useState('desc')

  //Searchable items
  const [query, setQuery] = useState(initialQuery)
  const [error, setError] = useState(null)

  //Pagination handler
  const onTableChange = ({ page = {}, sort = {} }) => {
    const { index: pageIndex, size: pageSize } = page
    const { field: sortField, direction: sortDirection } = sort

    setPageIndex(pageIndex)
    setPageSize(pageSize)
    setSortField(sortField)
    setSortDirection(sortDirection)
  }

  //Search bar handler
  const onSearchChange = ({ query, error }) => {
    if (error) {
      setError(error)
    } else {
      setError(null)
      setQuery(query)
    }
  }

  const sortedUsers = userList
  sortedUsers.sort((a, b) => {
    let diff = 0
    if (a.username && b.username) diff = b.username.localeCompare(a.username)
    return sortDirection === 'asc' ? diff : -1 * diff
  })

  const queriedUsers = EuiSearchBar.Query.execute(query, sortedUsers, {
    defaultFields: ['username', 'role'],
  })

  const pagination = {
    pageIndex: pageIndex,
    pageSize: pageSize,
    totalItemCount: queriedUsers.length,
    pageSizeOptions: [5, 10, 25, 50],
  }

  const handleUserSubmit = async (values: User) => {
    try {
      if (values.id) {
        await UserService.updateUser(values.id, values)
      } else {
        await UserService.createUser(values)
      }
      const users = await UserService.getUsers()
      showToasts([
        {
          title: values.id
            ? 'Le compte utilisateur a été mis à jour'
            : 'Le compte utilisateur a été créé',
            color: 'success',
          },
        ])
      setUserList(users)
    } catch (err: Error | AxiosError) {
      showToasts([
        {
          title: 'Une erreur est survenue',
          color: 'danger',
          text:
            err instanceof AxiosError ? err.response.data.message : err.message,
        },
      ])
    } finally {
      closeModal()
    }
  }

  const onEditOrCreateUser = (user: User | null): void => {
    showModal(
      <UserForm
        users={userList}
        user={user}
        account={false}
        handleSubmit={handleUserSubmit}
        onCancel={closeModal}
      />,
      false
    )
  }

  const deleteUser = async () => {
    setIsModalOpen(false)
    await UserService.deleteUser(toDeleteId)
    setToDeleteId(null)
    setUserList(userList.filter((user) => user.id !== toDeleteId))
    showToasts([
      {
        title: 'Le compte utilisateur a été supprimé',
        color: 'success',
      },
    ])
  }

  const columns = [
    {
      field: 'username',
      sortable: true,
      name: "Identifiant",
      'data-testid': 'user-item',
    },
    {
      field: 'nom',
      name: 'Nom',
    },
    {
      field: 'prenom',
      name: 'Prénom',
    },
    {
      field: 'email',
      name: 'Email',
    },
    {
      field: 'adresse',
      name: 'Adresse',
    },
    {
      field: 'role',
      name: 'Rôles',
    },
    {
      name: 'Action',
      actions: [
        {
          name: 'Modifier',
          description: 'Modifier le compte utilisateur',
          icon: 'pencil',
          type: 'icon',
          onClick: (user) => onEditOrCreateUser(user),
        },
        {
          name: 'Supprimer',
          description: 'Supprimer le compte utilisateur',
          icon: 'trash',
          type: 'icon',
          color: 'danger',
          onClick: (user) => {
            setToDeleteId(user.id)
            setIsModalOpen(true)
          },
          available: (user) => user.id !== currentUser?.id,
          'data-testid': 'delete-button',
        },
      ],
    },
  ]

  const sorting = {
    sort: {
      field: sortField,
      direction: sortDirection,
    },
  }

  return (
    <div>
      <EuiFlexGroup direction='column'>
        <EuiFlexGroup direction='row' justifyContent='spaceBetween'>
          <EuiFlexItem grow={false}>
            <EuiTitle size='m'>
              <h2> Liste des utilisateurs </h2>
            </EuiTitle>
          </EuiFlexItem>
          <EuiFlexItem grow={false}>
            <EuiButton
              onClick={() => onEditOrCreateUser(null)}
              iconType='plusInCircle'
              data-testid='create-button'
            >
              Créer un compte
            </EuiButton>
          </EuiFlexItem>
        </EuiFlexGroup>
        <EuiFlexItem>
          <EuiSearchBar
            defaultQuery={initialQuery}
            box={{
              placeholder: 'Rechercher parmi les utilisateurs',
              incremental: true,
            }}
            onChange={onSearchChange}
          />
        </EuiFlexItem>
        <EuiFlexItem>
          {error && (
            <EuiCallOut
              iconType='faceSad'
              color='danger'
              title={`Invalid search: ${error.message}`}
            />
          )}
          {!error && (
            <EuiBasicTable
              items={queriedUsers.slice(
                pageIndex * pageSize,
                pageIndex * pageSize + pageSize
              )}
              columns={columns}
              pagination={pagination}
              sorting={sorting}
              onChange={onTableChange}
              noItemsMessage={'Aucun utilisateur'}
            />
          )}
        </EuiFlexItem>
      </EuiFlexGroup>
      {isModalOpen && (
        <EuiConfirmModal
          title='Supprimer cet utilisateur ?'
          onCancel={closeModalUser}
          onConfirm={deleteUser}
          cancelButtonText='Annuler'
          confirmButtonText='Supprimer'
          buttonColor='danger'
          defaultFocusedButton='confirm'
          role='alertdialog'
        ></EuiConfirmModal>
      )}
    </div>
  )
}

UserList.defaultProps = {
  users: [],
}

export default UserList
