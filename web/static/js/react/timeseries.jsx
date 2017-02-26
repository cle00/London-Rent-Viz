import React from "react";
import ReactFauxDOM from "react-faux-dom";
import LineChart from "../linechart"
import {observer} from "mobx-react";

@observer
export default class Timeseries extends React.Component {
  render() {
    const store = this.props.store
    let div = LineChart.render(ReactFauxDOM.createElement('div'), store.gen_timeseries)
    return (
      div.toReact()
    )
  }
}
