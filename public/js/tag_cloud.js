var fill = d3.scale.category20();
var count = 0;
var text = "#{@keyword["content"][0]["attributes"]["keyword"].split("\n")[0]}";
text = text.replace(/&#39;/g, '"')
var obj = JSON.parse(text);

function makekeyword() {
  alert('請稍待5至10分鐘');
}

var processed_key = {};

$('#show').click(function() {
    console.log ($(this).val());
    console.log(processed_key[$(this).val()]);
    genWordCloud(JSON.parse(processed_key[$(this).val()]), '.hot_keyword');
    genWordCloud(JSON.parse(processed_cate[$(this).val()]), '.hot_cate');
  });

$.ajax({
      url: "/hotcloudkey",
      type: "GET",
      dataType: "json",
      success: function(response) {
        console.log(response);
        tmpRes = JSON.parse(response);
        processed_key = {};
        for (var i = 0, len = tmpRes.length; i < len; i++) {
          processed_key[tmpRes[i].time.split(' ')[0]] = tmpRes[i].key;
        }
        console.log(processed_key);
        $('.date-option').click();
      },
      error: function(response) {
        console.log(response);
        alert("ERROR!!!");
      },
    });

document.getElementById('show').onclick = function () {
  var keyword = [];
  for(var objs in obj){
    count++;
    keyword.push({'text': objs, 'size': obj[objs]});
  }
  addTagCloud(keyword);
};

var addTagCloud = function (keyword) {
  d3.layout.cloud().size([500, 300])
      .words(keyword)
      .rotate(function () { return ~~(Math.random() * 2) * 0; })
      .font('Impact')
      .fontSize(function (d) { return d.size; })
      .on('end', draw)
      .start();
};

function draw(words) {
  d3.select('#tag_vis').append('svg')
      .attr('width', 500)
      .attr('height', 300)
    .append('g')
      .attr('transform', 'translate(250,150)')
    .selectAll('text')
      .data(words)
    .enter().append('text')
      .style('font-size', function (d) { return d.size + 'px'; })
      .style('font-family', 'Impact')
      .style('fill', function (d, i) { return fill(i); })
      .attr('text-anchor', 'middle')
      .attr('transform', function (d) {
        return 'translate(' + [d.x, d.y] + ')rotate(' + d.rotate + ')';
      })
      .text(function (d) { return d.text; });
}
