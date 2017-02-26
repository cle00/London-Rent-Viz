let LineChart = {
  render: function(element, data) {
    if (data.length > 0) {
      // Set the dimensions of the canvas / graph
      let margin = {top: 30, right: 20, bottom: 30, left: 50},
          width = 600 - margin.left - margin.right,
          height = 200 - margin.top - margin.bottom;

      data.forEach((d) => d.inserted_at = new Date(d.inserted_at))

      // Set the ranges
      let x = d3.time.scale().range([0, width]);
      let y = d3.scale.linear().range([height, 0]);

      // Define the axes
      let xAxis = d3.svg.axis().scale(x)
          .orient("bottom").ticks(5);

      let yAxis = d3.svg.axis().scale(y)
          .orient("left").ticks(5);

      // Define the line
      let valueline = d3.svg.line()
          .x(function(d) { return x(d.inserted_at); })
          .y(function(d) { return y(d.price); });

      // Adds the svg canvas
      let svg = d3.select(element)
          .append("svg")
              .attr("width", width + margin.left + margin.right)
              .attr("height", height + margin.top + margin.bottom)
          .append("g")
              .attr("transform",
                    "translate(" + margin.left + "," + margin.top + ")");


      // Scale the range of the data
      x.domain(d3.extent(data, function(d) { return d.inserted_at; }));
      y.domain([0, d3.max(data, function(d) { return d.price; })]);

      // Add the valueline path.
      svg.append("path")
          .attr("class", "line")
          .attr("d", valueline(data));

      // Add the X Axis
      svg.append("g")
          .attr("class", "x axis")
          .attr("transform", "translate(0," + height + ")")
          .call(xAxis);

      // Add the Y Axis
      svg.append("g")
          .attr("class", "y axis")
          .call(yAxis);

    }
    return element
  }
}

export default LineChart
