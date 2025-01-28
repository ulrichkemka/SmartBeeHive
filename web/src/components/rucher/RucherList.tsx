import  React, { FunctionComponent, useState, useEffect } from 'react'
import { EuiBasicTable, EuiText, EuiButton, EuiConfirmModal, EuiSpacer, EuiSelectable } from '@elastic/eui'
import { Rucher, User } from '../../types'
import { useModal } from '../../contexts/modal'
import { useToasts } from '../../contexts/toasts'
import RucherForm from './RucherForm'
import RucherService from '../../services/rucher.service'

type RucherListProps = {
  ruchers: Array< Rucher | null>
  onRucherSelected: (rucher: Rucher) => void
  currentUser: User
}

const RucherList:  FunctionComponent<RucherListProps> = ({ 
  ruchers, onRucherSelected, currentUser
}) => {
  const { showModal, closeModal } = useModal()
  const { showToasts } = useToasts()
  const [rucherList, setRucherList] = useState(ruchers)
  const [toDeleteId, setToDeleteId] = useState(null)
  const [isModalOpen, setIsModalOpen] = useState(false)
  const closeModalRucher = () => setIsModalOpen(false)
  const [selectedRuchers, setSelectedRuchers] = useState([])
  
  const handleSubmit = async (values: Rucher): void => {
    try {
      if (values.id) {
        const newRucher = await RucherService.updateRucher(currentUser.id, values.id, values)
        setRucherList((ruchers) =>
          ruchers.map((rucher) => (rucher.id === values.id ? newRucher : rucher))
        )
        showToasts([
          {
            title: 'Le rucher a été modifié',
            color: 'success',
          },
        ])
      } else {
        const newRucher = await RucherService.createRucher(currentUser.id, values)
        setRucherList((ruchers) => ruchers.concat(newRucher))
        showToasts([
          {
            title: 'Le rucher a été créé',
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


  const onEditOrCreateRucher = (rucher: Rucher | null): void => {
    showModal(
      <RucherForm
        rucher={rucher}
        onCancel={closeModal}
        handleSubmit={handleSubmit}
      />,
      false
    )
  }


  const deleteRucher = async () => {
    setIsModalOpen(false)
    await RucherService.deleteRucher(currentUser.id, toDeleteId)
    setToDeleteId(null)
    setRucherList(rucherList.filter((rucher) => rucher.id !== toDeleteId))
    showToasts([
      {
        title: 'Le rucher a été supprimé',
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

  const sortedRuchers = rucherList
  sortedRuchers.sort((a, b) => {
    let diff = 0
    if (a.nom && b.nom) diff = b.nom.localeCompare(a.nom)
    return sortDirection === 'asc' ? diff : -1 * diff
  })

  const pagination = {
    pageIndex: pageIndex,
    pageSize: pageSize,
    totalItemCount: sortedRuchers.length,
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
      name: 'Descritopn',
    },
    {
      field: 'adresse',
      name: 'Adresse',
    },
    {
        name: 'Action',
        actions: [
          {
            name: 'Ruches',
            description: 'Voir les ruches',
            icon: 'eye',
            type: 'icon',
            onClick: (rucher) =>
            onRucherSelected(rucher),
          },
          {
            name: 'Modifier',
            description: 'Modifier le rucher',
            icon: 'pencil',
            type: 'icon',
            onClick: (rucher) =>
            onEditOrCreateRucher(rucher),
          },
          {
            name: 'Supprimer',
            description: 'Supprimer le rucher',
            icon: 'trash',
            type: 'icon',
            color: 'danger',
            onClick: (rucher) => {
              setToDeleteId(rucher.id)
              setIsModalOpen(true)
            },
          },
        ],
    },
  ]

  return (
     <div>
      <EuiBasicTable
        items={sortedRuchers.slice(
          pageIndex * pageSize,
          pageIndex * pageSize + pageSize
        )}
        itemId='id'
        hasActions={true}
        columns={columns}
        pagination={pagination}
        sorting={sorting}
        onChange={onTableChange}
        noItemsMessage={'Aucun rucher'}
      />
      <EuiSpacer size='m' />
      <EuiButton
          onClick={() => onEditOrCreateRucher(null)}
          iconType='plusInCircle'
      >
          Ajouter un rucher
      </EuiButton>
      {isModalOpen && (
          <EuiConfirmModal
            title='Supprimer ce rucher ?'
            onCancel={closeModalRucher}
            onConfirm={deleteRucher}
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

RucherList.defaultProps = {
  ruchers: [],
}

export default RucherList
