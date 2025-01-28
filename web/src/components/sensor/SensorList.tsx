import { EuiBasicTable, EuiText } from '@elastic/eui'
import { useState } from 'react'
import { Sensor } from '../../types'

type SensorListProps = {
  sensors: Array< Sensor | null>
  allSensor: Boolean
}

const SensorList = (props: SensorListProps) => {
  const { sensors, allSensor } = props

  //Pagination and sorting
  const [pageIndex, setPageIndex] = useState(0)
  const [pageSize, setPageSize] = useState(5)
  const [sortField, setSortField] = useState('heure')
  const [sortDirection, setSortDirection] = useState('asc')

  //Pagination handler
  const onTableChange = ({ page = {}, sort = {} }) => {
    const { index: pageIndex, size: pageSize } = page
    const { field: sortField, direction: sortDirection } = sort

    setPageIndex(pageIndex)
    setPageSize(pageSize)
    setSortField(sortField)
    setSortDirection(sortDirection)
  }

  const sortedSensors = sensors
  sortedSensors.sort((a, b) => {
    let diff = 0
    if (a.heure && b.heure) diff = b.heure.localeCompare(a.heure)
    return sortDirection === 'asc' ? diff : -1 * diff
  })


  const pagination = {
    pageIndex: pageIndex,
    pageSize: pageSize,
    totalItemCount: sortedSensors.length,
    pageSizeOptions: [5, 10, 25, 50],
  }

  const sorting = {
    sort: {
      field: sortField,
      direction: sortDirection,
    },
  }

  const columns = [
    ...(allSensor
      ? [
          {
            field: 'date',
            name: 'Date',
            sortable: true,
          },
        ]
      : []),
    {
        field: 'heure',
        name: 'Heure',
        sortable: true,
    },
    {
      field: 'temperature',
      name: 'Température (°)',
    },
    {
      field: 'humidite',
      name: 'Humidité (%)',
    },
    {
        field: 'couvercle',
        name: 'Couvercle',
    },

  ]

  return (
    <EuiBasicTable
      items={sortedSensors.slice(
        pageIndex * pageSize,
        pageIndex * pageSize + pageSize
      )}
      itemId='id'
      hasActions={true}
      columns={columns}
      pagination={pagination}
      sorting={sorting}
      onChange={onTableChange}
      noItemsMessage={'Aucune mesure'}
    />
  )
}

SensorList.defaultProps = {
  sensors: [],
}

export default SensorList
