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
        <div className="date-title">{moment(this.props.date).format("MMM Do YYYY")}</div>
        <div className="toggle-button-text js-bar-toggle pull-right">
          <div className="toggle-icon">+</div>
          <div className="toggle-icon-toggled">-</div>
          View As Bar Graph
        </div>
        <ul className="temperature-list">
          {tempNodes}
        </ul>
      </div>
    );
  }
});