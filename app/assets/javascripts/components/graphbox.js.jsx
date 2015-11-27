var GraphBox = React.createClass({
  loadDataFromServer: function(dateParams, isPolling) {
    isPolling = isPolling || false;
    $.ajax({
      url: this.props.url,
      data: dateParams,
      dataType: 'json',
      success: function(newData) {
        var fullData;
        this.lastPollTime = new Date();
        if (isPolling) {
          // fullData = fridgeApp.appendNewData(newData, this.state.data);
        } else {
          fullData = this.parseServerData(newData.temps);
        }
        console.log(fullData);
        this.setState({data: fullData});

      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  pollServerForNewest: function() {
    this.loadDataFromServer({start_date: this.lastPollTime}, true);
  },
  parseServerData: function(data) {
    for (var key in data) {
      data[key] = fridgeApp.interval.getTemps(key, data[key]);
    }
    return data;
  },
  getInitialState: function() {
    this.lastPollTime = new Date();
    initialTempData = this.parseServerData(initialTempData);
    console.log(initialTempData)
    return { data: initialTempData };
  },
  componentDidMount: function() {
    var self = this;
    $(document).on('FridgeApp::UpdateDateRange', function(e) {
      self.loadDataFromServer(e.dateParams);
    });
    // setInterval(this.pollServerForNewest, this.props.pollInterval);
  },
  render: function() {
    return (
      <div className="graph-box">
        <DateList data={this.state.data}/>
      </div>
    );
  }
});


