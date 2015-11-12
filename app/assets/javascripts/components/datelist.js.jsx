var DateList = React.createClass({
  render: function() {
    console.log(this.props.data)

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