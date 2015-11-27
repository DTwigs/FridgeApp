ReactDOM.render(
  <GraphBox url="/api/temperature" pollInterval={10000}/>,
  document.getElementById('graph-box')
);

ReactDOM.render(
  <DatePicker/>,
  document.getElementById('sidebar-form')
);

ReactDOM.render(
  <DatePicker/>,
  document.getElementById('overlay-date-form')
);
