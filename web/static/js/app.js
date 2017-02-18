// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import ReactDOM from "react-dom";
import Summary from "./react/summary";
import React from "react";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
import Underground from "./underground"
import SummaryStore from "./summary_store"
import SummaryTable from "./react/summary_table"

const obsSummaryStore = new SummaryStore();

const getJSON = function(url, callback) {
  const xhr = new XMLHttpRequest();
  xhr.open("get", url, true);
  xhr.responseType = "json";
  xhr.onload = function() {
    var status = xhr.status;
    if (status == 200) {
      callback(null, xhr.response);
    } else {
      callback(status);
    }
  };
  xhr.send();
};

getJSON("/api/nestoria_results/1",
  function(err, results) {
    if (err != null) {
      return "Error: " + err
    } else {
      obsSummaryStore.results = results
    }
  }
);

Underground.init("#map", "api/underground_stations/1", obsSummaryStore);

ReactDOM.render(
  <Summary store = {obsSummaryStore}/>,
  document.getElementById('summary')
);

ReactDOM.render(
  <SummaryTable store = {obsSummaryStore}/>,
  document.getElementById('summary_table')
);

$("input").click(function(d) {
  const no_bedrooms = $(this).val() || 1;
  Underground.update("#map", `api/underground_stations/${no_bedrooms}`);
});
