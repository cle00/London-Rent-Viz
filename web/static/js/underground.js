let Underground = {
  init(element){
    if(!element){ return }
    d3.csv('/csv/stations.csv', function(stationsA) {
      d3.csv('/csv/lines.csv', function(connections1) {
        d3.csv('/csv/routes.csv', function(routes) {

          var getJSON = function(url, callback) {
            var xhr = new XMLHttpRequest();
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

          getJSON("api/underground_stations",
            function(err, stationsZ) {
              if (err != null) {
                return "Error: " + err
              } else {
                gen_chart(element, stationsZ, connections1, routes, routes)
              }
            }
          );

          function gen_chart(element, stations, connections, routes, data) {
            var margin = {top: 20, right: 20, bottom: 30, left: 40},
              w = Math.max(760, window.innerWidth) - margin.left - margin.right,
              h = Math.max(700, window.innerHeight) - margin.top - margin.bottom,
              stationsById = {};

            /*
              Organising data
            */

            // Organising stations
            stations.forEach(function(s) {
              s.id = parseInt(s.id)
              stationsById[s.id] = s;
              s.conns = [];
              s.display_name = (s.display_name == 'NULL') ? null : s.display_name;
              s.rail = parseInt(s.rail,10);
              s.totalLines = parseInt(s.total_lines,10);
              s.latitude = parseFloat(s.latitude);
              s.longitude = parseFloat(s.longitude);
            });

            // Linking lines
            connections.forEach(function(c) {
              c.station1 = stationsById[parseInt(c.station1)];
              c.station2 = stationsById[parseInt(c.station2)];
              c.station1.conns.push(c);
              c.station2.conns.push(c);
              c.time = parseInt(c.time,10);
            });

            // Organizing lines
            var routesById = {};
            routes.forEach(function(r) {
              routesById[r.line] = r;
            });

            /*
              Setting up D3
            */

            // Find min and max long and lat
            var minLat = d3.min(stations, function(d) {return d.latitude});
            var minLon = d3.min(stations, function(d) {return d.longitude});
            var maxLat = d3.max(stations, function(d) {return d.latitude});
            var maxLon = d3.max(stations, function(d) {return d.longitude});

            // Set up the scales
            var x = d3.scale.linear()
              .domain([minLon, maxLon])
              .range([0, w]);
            var y = d3.scale.linear()
              .domain([minLat, maxLat])
              .range([h, 0]);

            // Set up what will happen when zooming
            var zoom = d3.behavior.zoom()
              .x(x)
              .y(y)
              .scaleExtent([1, 10])
              .on("zoom", zoomed);

            /*
              Drawing from now on
            */

            // Setting up the canvas
            var vis = d3.select(element)
              .append("div")
              .classed("svg-container", true)
              .append("svg")
              .attr("preserveAspectRatio", "xMinYMin meet")
              .attr("viewBox", "0 0 600 600")
              //class to make it responsive
              .classed("svg-content-responsive", true)
              //.attr("width", w + margin.left + margin.right)
              // .attr("height", h + margin.top + margin.bottom)
              .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

            // Make sure it is zoomable
            d3.select("#map svg")
              .call(zoom);

            // Define the div for the tooltip
            var div = d3.select(element).append("div")
                .attr("class", "tooltip")
                .style("opacity", 0);

            // Drawing lines between stations
            var route = vis.selectAll("line.route")
              .data(connections)
              .enter().append("svg:line")
                .attr("class", "route")
                .attr("stroke", function(d) { return '#'+routesById[d.line].colour; })
                .attr("stroke-linecap", 'round')
                .attr("x1", function(d) { return x(d.station1.longitude); })
                .attr("y1", function(d) { return y(d.station1.latitude); })
                .attr("x2", function(d) { return x(d.station2.longitude); })
                .attr("y2", function(d) { return y(d.station2.latitude); })

            // Striped stations (see official map)
            var stripe = vis.selectAll("line.stripe")
              .data(connections.filter(function(d) { return routesById[d.line].stripe != "NULL"; }))
              .enter().append("svg:line")
                .attr("class", "stripe")
                .attr("stroke", function(d) { return '#'+routesById[d.line].stripe; })
                .attr("stroke-linecap", 'round')
                .attr("x1", function(d) { return x(d.station1.longitude); })
                .attr("y1", function(d) { return y(d.station1.latitude); })
                .attr("x2", function(d) { return x(d.station2.longitude); })
                .attr("y2", function(d) { return y(d.station2.latitude); })

            // Points with more stations
            var connect = vis.selectAll("circle.connect")
              .data(stations.filter(function(d) { return d.totalLines - d.rail > 1; }))
              .enter().append("svg:circle")
                .attr("class", "connect")
                .attr("cx", function(d) { return x(d.longitude); })
                .attr("cy", function(d) { return y(d.latitude); })
                .style("fill", 'white')
                .style("stroke", 'black')

            // Drawing all the stations
            var station = vis.selectAll("circle.station")
              .data(stations)
              .enter().append("svg:circle")
                .attr("class", "station")
                .attr("id", function(d) { return 'station'+d.id })
                .attr("cx", function(d) { return x(d.longitude); })
                .attr("cy", function(d) { return y(d.latitude); })
                .attr("data-cx", function(d) { return d.longitude; })
                .attr("data-cy", function(d) { return d.latitude; })
                .attr("title", function(d) { return d.name })
                .style("stroke", 'gray')
                .style("fill", '#ffffff')
                .style("opacity", 0.3)
                .on('mouseover', function(d,i) {
                  div.transition()
                    .duration(200)
                    .style("opacity", .9);
                  div	.html("GBP"+Math.round(d.avg_monthly_price)+"pcm"
                   + "<br/>"  + d.station_name)
                      .style("left", (d3.event.pageX) + "px")
                      .style("top", (d3.event.pageY - 50) + "px");
                  d3.selectAll('#station'+d.id)
                    .transition()
                      .duration(25)
                      .attr("r", 4 / zoom.scale())
                      .style("stroke", 'black')
                      .style("stroke-width", 0.5 / zoom.scale())
                      .style('opacity', 1);
                })
                .on('mouseout', function(d,i) {
                  d3.selectAll('#station'+d.id)
                    .transition()
                      .attr("r", 3.5 / zoom.scale())
                      .duration(25)
                      .style("stroke-width", 0.5 / zoom.scale())
                      .style("stroke", 'gray')
                      .style('opacity', 0.3);
                })

            zoomed()

            function zoomed() {
              // Rescale circles
              vis.selectAll("circle")
                .attr("transform", "translate(" + zoom.translate() + ")scale(" + zoom.scale() + ")")
                .style("stroke-width", 0.5 / zoom.scale())
                .attr("r", 2.5 / zoom.scale());

              // Rescale lines
              vis.selectAll("line.route, line.stripe")
                .attr("transform", "translate(" + zoom.translate() + ")scale(" + zoom.scale() + ")")

              vis.selectAll("line.route")
                .attr("stroke-width", 5 / (zoom.scale()))

              vis.selectAll("line.stripe")
                .attr("stroke-width", 4 / (zoom.scale()))
            }
          }
        }); // load routes
      }); // load lines
    }); // load stations
  }
}
export default Underground
