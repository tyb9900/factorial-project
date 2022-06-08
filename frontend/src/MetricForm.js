import './MetricForm.css';
import React from 'react';
import $ from 'jquery';

class MetricForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {name: ''};

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    var hash = {};
    hash[`${event.target.name}`] = event.target.value;
    this.setState(hash);
  }

  handleSubmit(event) {
    event.preventDefault();
    var request_data = this.props.requestData
    console.log(this.state)
    $.ajax({
      url: `${process.env.REACT_APP_BACKEND_URL}/api/v1/metrics`,
      type: 'POST',
      data: {
        'name': this.state.name,
        'value': this.state.value,
        'timestamp': this.state.timestamp,
      },
      cache: false,
      success: function(data) {
        request_data()
      },
      error: function(xhr, status, err) {
        console.log(xhr, status);
        console.log(err);
      }
    });
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit} className="form">
              <div class="subtitle">Let's enter a new metric!</div>
          <div class="input-container ic1">
          <input placeholder='Name' className="input" type="text" name="name" value={this.state.name} onChange={this.handleChange} required/>
          </div>
        
          <div class="input-container ic1">
          <input placeholder='Value' className="input" type="number" name="value" value={this.state.value} onChange={this.handleChange} required/>
          </div>
        
          <div class="input-container ic1">
          <input placeholder='Timestamp' className="input" type="datetime-local" name="timestamp" value={this.state.timestamp} onChange={this.handleChange} required/>
          </div>

        <input type="submit" value="Submit" class="submit"/>
      </form>
    );
  }
}
export default MetricForm;
