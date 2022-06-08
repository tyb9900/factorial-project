import './Timeline.css';
import { Bar } from 'react-chartjs-2';
import React from 'react';
import MetricForm from './MetricForm';
import { Chart as ChartJS } from 'chart.js/auto'
import { Chart }            from 'react-chartjs-2'


class Timeline extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      labels: [],
      dataset: [],
      avg_by: ''
    };
  }

  data() {
    return (
      {
        labels: this.state.labels,
        datasets: [
          {
            label: 'value',
            data: this.state.dataset,
            backgroundColor: [
              'rgba(0, 136, 221, 0.2)',
            ],
            borderColor: [
              'rgba(0, 136, 221, 1)',
            ],
            borderWidth: 1,
          },
        ],
      }
    );
  }

  requestData(avg_by) {
    fetch(`${process.env.REACT_APP_BACKEND_URL}/api/v1/metrics?avg_by=${avg_by}`)
    .then(res => res.json())
    .then(
      (result) => {
        this.setState({
          labels: Object.keys(result),
          dataset: Object.values(result),
          avg_by: avg_by,
        });
      },
      (error) => {
        console.log("error reponse");
        console.log(error);
      }
    )
  }

  render() {
    return (
      <div className="Graph">
        <div className='parent'>
        <div className='child1'>
        <MetricForm requestData={() => this.requestData(this.state.avg_by)}/>
        </div>
        <div className='child2'>
        <h1 className=''>Select Avg By</h1>
        <button className="avg-button" onClick={() => this.requestData("day")}>
          Per day
        </button>
        <br></br>
        <button className="avg-button" onClick={() => this.requestData("hour")}>
          Per hour
        </button>
        <br></br>
        <button className="avg-button" onClick={() => this.requestData("minute")}>
          Per minute
        </button>
        </div>
        </div>
        <div className='bar-graph'>
          <Bar data={this.data()} options={options}/>
        </div>
      </div>
    );
  }
}


const options = {
  indexAxis: 'y',
  elements: {
    bar: {
      borderWidth: 2,
    },
  },
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: {
      position: 'right',
    },
    title: {
      display: false,
    },
  },
};


export default Timeline;
