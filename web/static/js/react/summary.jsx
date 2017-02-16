import React from "react";
import {observer} from "mobx-react";

@observer
class Summary extends React.Component {
  render() {
    const store = this.props.store
    if (store.selected == true) {
      return (
        <div className="col-sm-12">
          <div className="col-sm-4">
            <h4 id="stop"> Stop: {store.stop}</h4>
          </div>
          <div className="col-sm-4">
            <h4 id="avg_px"> Avg PX: {store.avg_px}</h4>
          </div>
          <div className="col-sm-4">
            <h4 id="count"> Count: {store.count}</h4>
          </div>
        </div>
      )
    } else {
      return (<div></div>)
    }
  }
}

export default Summary
