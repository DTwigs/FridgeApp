var TemperatureItem = React.createClass({
  render: function() {
    var tempClass = fridgeApp.getTemperatureItemClass(this.props.temperature),
      barHeight = fridgeApp.getBarHeightString(this.props.temperature);
    return (
      <li className={tempClass}>
        <div className="temperature-infobox">
          <div className="temperature-reading">{this.props.temperature}°F</div>
          <span className="temperature-created">{moment(this.props.created).format("h:mm A")}</span>
          <div className="temperature-infobox-triangle"></div>
        </div>
        <div className="temperature-bar" style={barHeight}></div>
      </li>
    );
  }
});