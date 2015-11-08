ReactDOM.render(
  <GraphBox url="/api/temperature" pollInterval={10000}/>,
  document.getElementById('graph-box')
);