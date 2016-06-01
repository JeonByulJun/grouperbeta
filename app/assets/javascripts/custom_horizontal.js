function horild(){
    (function(document) {
      var _bars = [].slice.call(document.querySelectorAll('.bar-inner'));
      _bars.map(function(bar, index) {
        setTimeout(function() {
        	var b = parseInt(bar.dataset.percent)
        	if (b==10){
        		b+=11;
        	}
        	else if (b==20){
        		b+=9;
        	}
        	else if (b==30){
        		b+=7;
        	}
        	else if (b==40){
        		b+=5;
        	}
        	else if (b==50){
        		b+=3;
        	}
        	bar.style.width = b+"%";
        }, 1);
        
      });
    })(document)
}