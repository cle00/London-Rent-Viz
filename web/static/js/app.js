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

const obsSummaryStore = new SummaryStore();

Underground.init("#map", "api/underground_stations/1", obsSummaryStore);


ReactDOM.render(
  <Summary store = {obsSummaryStore}/>,
  document.getElementById('summary')
);

$("input").click(function(d) {
  const no_bedrooms = $(this).val();
  Underground.update("#map", `api/underground_stations/${no_bedrooms}`);
});
