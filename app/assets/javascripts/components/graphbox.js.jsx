var GraphBox = React.createClass({
  loadDataFromServer: function() {
    $.ajax({
      url: this.props.url,
      data: {start_date: this.lastPollTime},
      dataType: 'json',
      success: function(newData) {
        this.lastPollTime = new Date();
        this.setState({data: this.appendData(newData)});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  appendData: function(newData) {
    var key = newData["temps"],
      self = this;

    for (var key in newData["temps"]) {
      if (this.state.data.hasOwnProperty(key)) {
        newData["temps"][key].forEach(function(item) {
          self.state.data[key].push(item);
        })
      } else {
        this.state.data[key] = newData["temps"][key];
      }
    }

    return this.state.data;
  },
  getInitialState: function() {
    this.lastPollTime = new Date();
    return { data: initialTempData };
  },
  componentDidMount: function() {
    setInterval(this.loadDataFromServer, this.props.pollInterval);
  },
  render: function() {
    return (
      <div className="graph-box">
        <h1>Graph Box</h1>
        {JSON.stringify(this.state.data)}
        <DateList data={this.state.data}/>
      </div>
    );
  }
});


