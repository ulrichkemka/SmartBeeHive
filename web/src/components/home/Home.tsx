import {
  EuiButton,
  EuiButtonIcon,
  EuiContextMenu,
  EuiFlexGroup,
  EuiFlexItem,
  EuiPanel,
  EuiPopover,
  EuiSpacer,
  EuiTabbedContent,
  EuiTitle,
  EuiCard,
  EuiText,
} from '@elastic/eui'
import { FunctionComponent, useEffect, useState } from 'react'
import './Home.css'
import SensorList from '../sensor/SensorList'
import SensorGraph from '../sensor/SensorGraph'
import { Sensor, Rucher, Ruche, User } from '../../types'
import RucherList from '../rucher/RucherList'
import RucheList from '../ruche/RucheList'
import { useModal } from '../../contexts/modal'
import RucheService from '../../services/ruche.service'
import sensorService from '../../services/sensor.service'

type HomeProps = {
  ruchers: Array< Rucher | null >
  currentUser: user 
}

const Home: FunctionComponent<HomeProps> = ({ ruchers, currentUser }) => {
  
  const [sensorsList, setSensorsList] = useState([])
  const [rucherList, setRucherList] = useState(ruchers)
  const [rucheList, setRucheList] = useState([])
  const { showModal, closeModal } = useModal()
  const [selectedRucherId, setSelectedRucherId] = useState(undefined)
  const [selectedRuche, setSelectedRuche] = useState(undefined)
  const [currentSensor, setCurrentSensor] = useState(undefined)
  const [rucheName, setRucheName] = useState(undefined)
  
  const onRucherSelected = async (rucher: Rucher) => {
    const _ruches = await RucheService.getRuches(currentUser.id, rucher.id)
    setRucheList(_ruches)
    setSelectedRucherId(rucher.id)
  }

  const onRucheSelected = async (ruche: Ruche) => {
    const _sensors = await sensorService.getSensors(currentUser.id, selectedRucherId, ruche.id)
    setSensorsList(_sensors)
    setSelectedRuche(ruche.id)
    setRucheName(ruche.nom)
  }

    /**
   * Set current sensor to last sensor's date
   */
    const updateCurrentSensor = async () => {
      let lastSensor = null
      sensorsList.forEach((sensor) => {
      setCurrentSensor(lastSensor)
        if (!lastSensor || sensor.heure.isBefore(lastSensor.heure)) {
          lastSensor = sensor
        }
      })
      setCurrentSensor(lastSensor)
    }

    /**
   * On rucheList change, update current sensor
   */
    useEffect(() => {
      updateCurrentSensor()
    }, [selectedRuche])
  
  const onShowAllSensor = (sensor: Sensor): void => {
    <EuiSpacer size='s' />
      showModal(
        <div>
          <EuiTitle size='s'>
            <h2>{'Historique des Mesures'}</h2>
          </EuiTitle>
          <EuiSpacer size='l' />
          <SensorList
            sensors={sensorsList}
            allSensor={true}
          />
        </div>
      )
  }

  const onShowGraphSensor = (sensor: Sensor): void => {
    <EuiSpacer size='s' />
      showModal(
        <div>
          <SensorGraph
            sensors={sensorsList}
          />
        </div>
      )
  }

  return (
    <div>
      {/* {user &&  */}
      <EuiFlexGroup direction={'column'}>
            <EuiFlexItem grow={false}>
              <EuiTitle size='s'>
                <h2>Tableau de bord</h2>
              </EuiTitle>
            </EuiFlexItem>

        <EuiFlexGroup direction={'row'}>
          <EuiFlexItem grow={5}>
            <EuiFlexGroup direction={'column'}>
              <EuiFlexItem grow={false}>
                <EuiPanel>
                    <EuiTitle size='s'>
                      <h2>{'Liste des ruchers'}</h2>
                    </EuiTitle>
                    <EuiSpacer size='s' />
                    <RucherList 
                      currentUser={currentUser}
                      ruchers={rucherList} 
                      onRucherSelected={onRucherSelected}
                      />
                  </EuiPanel>
              </EuiFlexItem>
              <EuiFlexItem grow={false}>
                <EuiPanel>
                    <EuiTitle size='s'>
                      <h2>{'Liste des ruches'}</h2>
                    </EuiTitle>
                    <EuiSpacer size='s' />
                    {selectedRucherId ? (
                      <RucheList
                          ruches={rucheList} 
                          onRucheSelected={onRucheSelected}
                          rucherId={selectedRucherId}
                          currentUser={currentUser}
                      />
                      ) : 'Veuillez sélectionner un rucher'}
                  </EuiPanel>
              </EuiFlexItem>
            </EuiFlexGroup>
          </EuiFlexItem>

          <EuiFlexItem grow={7}>
            <EuiFlexGroup direction={'column'}>
              <EuiFlexItem grow={false}>
                <EuiPanel>
                  <EuiTitle size='s'>
                    <h2>{selectedRuche && ('Nom de la Ruche : ' + rucheName)}</h2>
                  </EuiTitle>
                  <EuiSpacer size='l' />
                  <EuiText className="mesure-actuelle" textAlign='center'>
                      <h3>Mesures actuelles</h3>
                  </EuiText>
                  <EuiSpacer size='l' />
                  <EuiFlexGroup className="horizontal-cards-container">
                    <EuiFlexItem>
                      <EuiCard
                        title={'Température'}
                        description={currentSensor ? currentSensor.temperature + '°' : 'Sélectionnez une ruche'}
                        style={{ backgroundColor: 'lightgrey' }}
                      />
                    </EuiFlexItem>
                    <EuiFlexItem>
                      <EuiCard
                        title={'Humidité'}
                        description={currentSensor ? currentSensor.humidite + '%' : 'Sélectionnez une ruche'}
                        style={{ backgroundColor: 'lightgreen' }}
                      />
                    </EuiFlexItem>
                    <EuiFlexItem>
                      <EuiCard
                        title={'Couverture'}
                        description={currentSensor ? currentSensor.couvercle : 'Sélectionnez une ruche'}
                        style={{ backgroundColor: 'lightblue' }}
                      />
                    </EuiFlexItem>
                  </EuiFlexGroup>

                  <EuiSpacer size='l' />

                  <EuiPanel>
                    <EuiTitle size='s'>
                      <h2>{'Mesures journalières '}</h2>
                    </EuiTitle>
                    <EuiSpacer size='s' />
                    {selectedRuche ? 
                      ( <SensorList sensors={sensorsList} allSensor={false}  /> ) :
                      'Sélectionner une ruche'
                    }
                  </EuiPanel>
                  <EuiSpacer/>
                  <EuiFlexGroup>
                    <EuiButton onClick={() => onShowAllSensor()} >
                      Afficher l'historique des mesures
                    </EuiButton>
                    <EuiButton onClick={() => onShowGraphSensor()} >
                      Afficher le graphe des mesures
                    </EuiButton>
                  </EuiFlexGroup>
                </EuiPanel>
              </EuiFlexItem>
            </EuiFlexGroup>
          </EuiFlexItem>
        </EuiFlexGroup>
      </EuiFlexGroup>
      {/* } */}
    </div>
  )
}

export default Home
