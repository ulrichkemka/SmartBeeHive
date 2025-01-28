import React from 'react'
import ReactApexChart from 'react-apexcharts'
import { Sensor } from '../../types'

type SensorGraphProps = {
  sensors: Array<Sensor>
}

const SensorGraph = (props: SensorGraphProps) => {
  const { sensors } = props
  const heureData = sensors.map((sensor) => sensor.heure)
  const temperatureData = sensors.map((sensor) => sensor.temperature)
  const humidideData = sensors.map((sensor) => sensor.humidite)
 
    const series = [
      {
        name: 'Température',
        data: temperatureData,
      },
      {
        name: 'Humidité',
        data: humidideData,
      },
    ]

    const options = {
      chart: {
        height: 500,
        type: 'line',
        dropShadow: {
          enabled: true,
          color: '#000',
          top: 18,
          left: 7,
          blur: 10,
          opacity: 0.2
        },
        toolbar: {
          show: true
        }
      },
      colors: ['#77B6EA', '#545454'],
      dataLabels: {
        enabled: true,
      },
      stroke: {
        curve: 'smooth'
      },
      title: {
        text: "Mesure de la température et de l'humidité des ruches",
        align: 'left'
      },
      grid: {
        borderColor: '#e7e7e7',
        row: {
          colors: ['#f3f3f3', 'transparent'], 
          opacity: 0.5
        },
      },
      markers: {
        size: 1
      },
      xaxis: {
        categories: heureData,
        title: {
          text: 'Heure',
          offsetY: -30,
          offsetX: -5
        }
      },
      yaxis: {
        title: {
          text: 'Temperature / Humidité'
        },
        min: 5,
        max: 50
      },
      legend: {
        position: 'bottom',
        horizontalAlign: 'right',
        floating: true,
        offsetY: -10,
        offsetX: -5
      }
    }
  
    return (
      <div id="chart">
        <ReactApexChart options={options} series={series} type="line" height={500} />
      </div>
    )
  }

  export default SensorGraph
