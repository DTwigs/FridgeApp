var DateItem = React.createClass({
  // componentDidMount: function() {
  //   var tempData = this.props.temperatures,
  //     date = this.props.date;
  //   this.timedTemps = fridgeApp.getTimeIntervalTemps(date, tempData);
  // },
  render: function() {
    var tempNodes = this.props.temperatures.map(function(temp) {
      if (temp.hasOwnProperty("gap")) {
        return (
          <GapItem key={temp.created_at} time={temp.created_at} gap={temp.gap} />
        );
      } else {
        return (
          <TemperatureItem key={temp.id} time={temp.created_at} temperature={temp.temperature} />
        );
      }
    });

    return (
      <div className="date-item">
        <h3>Date: {this.props.date}</h3>
        <ul className="temperature-list">
          {tempNodes}
        </ul>
      </div>
    );
  }
});