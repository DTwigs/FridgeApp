var TemperatureItem = React.createClass({
  render: function() {
    var tempClass = fridgeApp.getTemperatureItemClass(this.props.temperature);
    return (
      <li className={tempClass}>
      </li>
    );
  }
});