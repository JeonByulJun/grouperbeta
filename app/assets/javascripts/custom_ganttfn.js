function ganttfn(){
  (function(document) {
    var _bars = [].slice.call(document.querySelectorAll('.bar-innerday'));
    _bars.map(function(bar, index) {
      setTimeout(function() {
        var b = bar.dataset.date * 100/10;
        if(b>=99){
        	b=100;
        }
        b+=8;
        b+="%";
        bar.style.width = b;
      }, 1);
    });
  })(document)
}