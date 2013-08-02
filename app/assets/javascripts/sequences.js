// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// Your beautiful D3 code will go here
      var width = 1200,
      height = 800;
      
      var color = d3.scale.category20();
      
      var force = d3.layout.force()
    .charge(-100) 
    .linkDistance( function(d) { return (1 / Math.pow(d.rsqr,1.5)) / 1.5 ; } ) // in pt size? its relative to "r"
    .linkStrength( function(d) { return 0.1; } )
    .size([width, height]);
    
    var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height);
    
    d3.json("{
"nodes":[
{"header":"sequence 1","group":"query"},
{"header":"sequence 83","group":"query"},
{"header":"sequence 2","group":"result"},
{"header":"sequence 3","group":"result"},
{"header":"sequence 4","group":"result"},
{"header":"sequence 5","group":"result"},
{"header":"sequence 6","group":"result"},
{"header":"sequence 7","group":"result"},
{"header":"sequence 8","group":"result"},
{"header":"sequence 9","group":"result"},
{"header":"sequence 10","group":"result"},
{"header":"sequence 11","group":"result"}
],
"links":[
{"source":0,"target":2,"rsqr":0.95,"p":100},
{"source":1,"target":3,"rsqr":0.85,"p":100},
{"source":0,"target":4,"rsqr":0.75,"p":100},
{"source":1,"target":4,"rsqr":0.685,"p":100},
{"source":1,"target":5,"rsqr":0.65,"p":100},
{"source":0,"target":6,"rsqr":0.55,"p":100},
{"source":1,"target":7,"rsqr":0.45,"p":100},
{"source":0,"target":8,"rsqr":0.35,"p":100},
{"source":1,"target":9,"rsqr":0.25,"p":100},
{"source":0,"target":10,"rsqr":0.15,"p":100},
{"source":1,"target":11,"rsqr":0.05,"p":100}
]}", function(error, graph) {
	force
	    .nodes(graph.nodes)
	    .links(graph.links)
	    .start();
	
	var link = svg.selectAll(".link")
	    .data(graph.links)
	    .enter().append("line")
	    .attr("class", "link")
	    .style("stroke-width", 2);
	
	var node = svg.selectAll(".node")
	    .data(graph.nodes)
	    .enter().append( "circle" )
	    .attr("class", "node")
	    .attr("r", function(d) { if (d.group=="query")
				     { return 17.5; }
				     else 
				     { return 10; }
				   })
	    .style("fill", function(d) { return color(d.group); })
	
	    .call(force.drag)
				  
	node.append("title")
	    .text(function(d) { return d.header; });
	
	
	force.on("tick", function() {
	    link.attr("x1", function(d) { return d.source.x; })
		.attr("y1", function(d) { return d.source.y; })
		.attr("x2", function(d) { return d.target.x; })
		.attr("y2", function(d) { return d.target.y; });
	    
	    node.attr("cx", function(d) { return d.x; })
		.attr("cy", function(d) { return d.y; });
	});
    });