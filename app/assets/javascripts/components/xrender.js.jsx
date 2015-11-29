ReactDOM.render(
  <GraphBox url="/api/temperature" pollInterval={10000}/>,
  document.getElementById('graph-box')
);

ReactDOM.render(
  <DatePickerForm/>,
  document.getElementById('sidebar-form')
);

ReactDOM.render(
  <DatePickerForm/>,
  document.getElementById('overlay-date-form')
);
