var DatePicker = React.createClass({
  handleSubmit: function(e) {
    e.preventDefault();
    var startDate = this.refs.startDate.value.trim();
    var endDate = this.refs.endDate.value.trim();

    if (!endDate || !startDate) {
      return;
    }
    $(document).trigger({type: 'FridgeApp::UpdateDateRange', dateParams: {start_date: startDate, end_date: endDate}});
    // this.props.onPickerSubmit({start_date: startDate, end_date: endDate});
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