var DatePicker = React.createClass({
  handleSubmit: function(e) {
    e.preventDefault();
    var startDate = this.refs.startDate.value.trim();
    var endDate = this.refs.endDate.value.trim();

    if (!endDate || !startDate) {
      return;
    }
    this.props.onPickerSubmit({start_date: startDate, end_date: endDate});
    this.refs.startDate.value = '';
    this.refs.endDate.value = '';
    return;
  },
  render: function() {
    return (
      <form className="date-picker-container" onSubmit={this.handleSubmit}>
        <input placeholder="Start Date" type="text" ref="startDate" />
        <input placeholder="End Date" type="text" ref="endDate" />
        <button type="submit" className="button right"> Filter By Date Range</button>
      </form>
    );
  }
});