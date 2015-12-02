// var DatePicker = require('react-datepicker');

// require('react-datepicker/dist/react-datepicker.css');

var DatePickerForm = React.createClass({
  getInitialState: function() {
    return {
      startDate: moment().subtract(4, 'days'),
      endDate: moment(),
    };
  },
  handleSubmit: function(e) {
    e.preventDefault();
    var startDate = this.state.startDate;
    var endDate = this.state.endDate;

    if (!endDate || !startDate) {
      return;
    }

    // convert dates to string representing the beginning and end of each day
    startDate = startDate.startOf('day').format("YYYY-MM-DD HH:mm:ss");
    endDate = endDate.endOf('day').format("YYYY-MM-DD HH:mm:ss");

    // trigger an event that will tell the graphbox component to fetch data.
    $(document).trigger({type: 'FridgeApp::UpdateDateRange', dateParams: {start_date: startDate, end_date: endDate}});

    return;
  },
  handleStartChange: function(date) {
    this.setState({
      startDate: date
    });
  },
  handleEndChange: function(date) {
    this.setState({
      endDate: date
    });
  },
  render: function() {
    return (
      <form className="date-picker-container" onSubmit={this.handleSubmit}>
        <div className="date-picker-title">
          <i className="icon-air"/>
          Change Date Range
        </div>
        <div>
          <DatePicker
            selected={this.state.startDate}
            onChange={this.handleStartChange}
            maxDate={this.state.endDate}
            className="input-inline"> </DatePicker>
          <DatePicker
            selected={this.state.endDate}
            onChange={this.handleEndChange}
            minDate={this.state.startDate}
            maxDate={moment()}
            className="input-inline"> </DatePicker>
        </div>
        <div className="sidebar-footer-button-container">
          <button type="submit" className="button secondary js-filter-submit">
            Filter By Date Range
          </button>
        </div>
      </form>
    );
  }
});