function horild(){
    (function(document) {
      var _bars = [].slice.call(document.querySelectorAll('.bar-inner'));
      _bars.map(function(bar, index) {
        setTimeout(function() {
        	var b = parseInt(bar.dataset.percent)
        	if (b==10){
        		b+=9;
        	}
        	if (b==20){
        		b+=7;
        	}
        	if (b==30){
        		b+=5;
        	}
        	if (b==40){
        		b+=3;
        	}
        	if (b==50){
        		b+=1;
        	}
        	bar.style.width = b+"%";
        }, 1);
        
      });
    })(document)
}