var DateItem = React.createClass({
  render: function() {
    var tempNodes = this.props.intervals.map(function(intervalObj) {
      var temp = intervalObj.temperature;
      if (temp.hasOwnProperty("gap")) {
        return (
          <GapItem key={temp.created_at} created={temp.created_at} gap={temp.gap} />
        );
      } else {
        return (
          <TemperatureItem key={temp.id} created={temp.created_at} temperature={temp.temperature} />
        );
      }
    });

    return (
      <div className="date-item">
        <div className="date-title">{this.props.date}</div>
        <ul className="temperature-list">
          {tempNodes}
        </ul>
      </div>
    );
  }
});