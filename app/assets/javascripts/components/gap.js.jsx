var GapItem = React.createClass({
  render: function() {
    return (
      <li className="gap-item">
        gap: {this.props.gap},
      </li>
    );
  }
});