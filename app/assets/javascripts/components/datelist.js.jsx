var DateList = React.createClass({
  render: function() {
    var dateNodes = [];
    for(var key in this.props.data) {
      dateNodes.push( <DateItem key={key} date={key} intervals={this.props.data[key]}/> )
    }

    return (
      <div className="date-list">
        {dateNodes.reverse()}
      </div>
    );
  }
});