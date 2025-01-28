import  React, { FunctionComponent, useState } from 'react'
import { EuiBasicTable, EuiText, EuiButton, EuiConfirmModal, EuiSpacer, EuiSelectable } from '@elastic/eui'
import { Ruche, Rucher, User } from '../../types'
import { useModal } from '../../contexts/modal'
import { useToasts } from '../../contexts/toasts'
import { useAuth } from '../../contexts/auth'
import RucheForm from './RucheForm'
import RucheService from '../../services/ruche.service'

type RucheListProps = {
  ruches: Array<Ruche | null>
  onRucheSelected: (ruche: Ruche) => void
  rucherId: string
  currentUser: User
}

const RucheList: FunctionComponent<RucheListProps> = ({ 
  ruches, onRucheSelected, rucherId, currentUser
}) => {
  const { showModal, closeModal } = useModal()
  const { showToasts } = useToasts()
  const [rucheList, setRucheList] = useState(ruches)
  const [toDeleteId, setToDeleteId] = useState(null)
  const [isModalOpen, setIsModalOpen] = useState(false)
  const closeModalRuche = () => setIsModalOpen(false)

  const handleSubmit = async (values: Ruche): void => {
    try {
      if (values.id) {
        const newRuche = await RucheService.updateRuche(currentUser.id, rucherId, values.id, values)
        setRucheList((ruches) =>
        ruches.map((ruche) => (ruche.id === values.id ? newRuche : ruche))
        )
        showToasts([
          {
            title: 'La ruche a été modifiée',
            color: 'success',
          },
        ])
      } else {
        const newRuche = await RucheService.updateRuche(currentUser.id, rucherId, values)
        setRucheList((ruches) => ruches.concat(newRuche))
        showToasts([
          {
            title: 'La ruche a été créée',
            color: 'success',
          },
        ])
      }
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

  const onEditOrCreateRuche = (ruche: Ruche | null): void => {
    showModal(
      <RucheForm
        ruche={ruche}
        onCancel={closeModal}
        handleSubmit={handleSubmit}
      />,
      false
    )
  }

  const deleteRuche = async () => {
    setIsModalOpen(false)
    await RucheService.deleteRuche(currentUser.id, rucherId, toDeleteId)
    setToDeleteId(null)
    setRucheList(rucheList.filter((ruche) => ruche.id !== toDeleteId))
    showToasts([
      {
        title: 'Le ruche a été supprimé',
        color: 'success',
      },
    ])
  }


  //Pagination and sorting
  const [pageIndex, setPageIndex] = useState(0)
  const [pageSize, setPageSize] = useState(5)
  const [sortField, setSortField] = useState('nom')
  const [sortDirection, setSortDirection] = useState('desc')

  //Pagination handler
  const onTableChange = ({ page = {}, sort = {} }) => {
    const { index: pageIndex, size: pageSize } = page
    const { field: sortField, direction: sortDirection } = sort

    setPageIndex(pageIndex)
    setPageSize(pageSize)
    setSortField(sortField)
    setSortDirection(sortDirection)
  }

  const sortedRuches = ruches
  sortedRuches.sort((a, b) => {
    let diff = 0
    if (a.nom && b.name) diff = b.nom.localeCompare(a.nom)
    return sortDirection === 'asc' ? diff : -1 * diff
  })


  const pagination = {
    pageIndex: pageIndex,
    pageSize: pageSize,
    totalItemCount: sortedRuches.length,
    pageSizeOptions: [5, 10, 25, 50],
  }

  const sorting = {
    sort: {
      field: sortField,
      direction: sortDirection,
    },
  }

  const columns = [
    {
        field: 'nom',
        name: 'Nom',
        sortable: true,
    },
    {
      field: 'description',
      name: 'Descritpion',
    },
    {
      field: 'email',
      name: 'Envoi des mails',
      render : (email) => {
        return email === 1 ? 'Activer' : 'Désactiver'
      }
    },
    {
        name: 'Action',
        actions: [
          {
            name: 'Mesures',
            description: 'Voir les mesures',
            icon: 'eye',
            type: 'icon',
            onClick: (ruche) =>
            onRucheSelected(ruche),
          },
          {
            name: 'Modifier',
            description: 'Modifier la ruche',
            icon: 'pencil',
            type: 'icon',
            onClick: (ruche) =>
            onEditOrCreateRuche(ruche),
          },
          {
            name: 'Supprimer',
            description: 'Supprimer la ruche',
            icon: 'trash',
            type: 'icon',
            color: 'danger',
            onClick: (ruche) => {
              setToDeleteId(ruche.id)
              setIsModalOpen(true)
            },
          },
        ],
      },
  
  ]

  return (
    <div>
      <EuiBasicTable
        items={sortedRuches.slice(
          pageIndex * pageSize,
          pageIndex * pageSize + pageSize
        )}
        itemId='id'
        hasActions={true}
        columns={columns}
        pagination={pagination}
        sorting={sorting}
        onChange={onTableChange}
        noItemsMessage={'Aucune ruche'}
      />
      <EuiSpacer size='m' />
      <EuiButton
          onClick={() => onEditOrCreateRuche(null)}
          iconType='plusInCircle'
      >
          Ajouter une ruche
      </EuiButton>
      {isModalOpen && (
          <EuiConfirmModal
            title='Supprimer cette ruche ?'
            onCancel={closeModalRuche}
            onConfirm={deleteRuche}
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

RucheList.defaultProps = {
  ruches: [],
}

export default RucheList
