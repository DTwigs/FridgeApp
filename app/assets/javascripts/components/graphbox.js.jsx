var GraphBox = React.createClass({
  loadDataFromServer: function() {
    $.ajax({
      url: this.props.url,
      data: {start_date: this.lastPollTime},
      dataType: 'json',
      success: function(newData) {
        var fullData;
        this.lastPollTime = new Date();
        fullData = fridgeApp.appendNewData(newData, this.state.data);
        this.setState({data: fullData});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  getInitialState: function() {
    this.lastPollTime = new Date();
    for (var key in initialTempData) {
      initialTempData[key] = fridgeApp.interval.getTemps(key, initialTempData[key])
    }
    return { data: initialTempData };
  },
  componentDidMount: function() {
    // setInterval(this.loadDataFromServer, this.props.pollInterval);
  },
  render: function() {
    return (
      <div className="graph-box">
        <DateList data={this.state.data}/>
      </div>
    );
  }
});


