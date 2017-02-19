import React from "react";
import JsonTable from 'react-json-table';
import {observer} from "mobx-react";

function TableRowFactory(props) {
  if (props.rows.length > 0) {
    const headerList = props.header.map((row, index) =>
      <th key={index}>{row}</th>
    );

    const rowList = props.rows.map(function(row, index){
      const indRow = props.keys.map((key, idx) =>
        <td key={key}>{row[key]}</td>
      )
      return (
        <tr key={index}>
          {indRow}
        </tr>
      )
    });

    return (
      <table id="summary_table_output" className="table table-striped">
        <thead>
          <tr >
            {headerList}
          </tr>
        </thead>
        <tbody>
          {rowList}
        </tbody>
      </table>
    )
  } else {
    return (
      <div></div>
    )
  }
}

@observer
class SummaryTable extends React.Component {

  render() {
    const store = this.props.store;
    if (store.selected == true) {
      return (
        <TableRowFactory rows={store.filter_results}
          keys={['title', 'avg_monthly_price', 'datasource_name']}
          header={['Description', 'Avg Monthly Price (GBP)', 'Source']}
        />
      )
    } else {
      return (<div></div>)
    }
  }
}

export default SummaryTable
