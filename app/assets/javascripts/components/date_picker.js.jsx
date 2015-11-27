var DatePicker = React.createClass({
  handleSubmit: function(e) {
    e.preventDefault();
    var startDate = this.refs.startDate.value.trim();
    var endDate = this.refs.endDate.value.trim();

    if (!endDate || !startDate) {
      return;
    }

    // convert dates to string representing the beginning and end of each day
    startDate = moment(startDate).startOf('day').format("YYYY-MM-DD HH:mm:ss");
    endDate = moment(endDate).endOf('day').format("YYYY-MM-DD HH:mm:ss");

    // trigger an event that will tell the graphbox component to fetch data.
    $(document).trigger({type: 'FridgeApp::UpdateDateRange', dateParams: {start_date: startDate, end_date: endDate}});

    // clear form values
    this.refs.startDate.value = '';
    this.refs.endDate.value = '';
    return;
  },
  render: function() {
    return (
      <form className="date-picker-container" onSubmit={this.handleSubmit}>
        <div className="date-picker-title">
          <i className="icon-air"/>
          Change Date Range
        </div>
        <div>
          <input className="input-inline" placeholder="Start Date" type="text" ref="startDate" />
          <input className="input-inline" placeholder="End Date" type="text" ref="endDate" />
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