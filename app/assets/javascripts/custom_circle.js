function circle(canvas, sum, cnt){
   	var ctx = canvas.getContext("2d");
    //dimensions
    var W = canvas.width;
    var H = canvas.height;
    //lets draw a 200degree arc. we need to specify degrees in radians
    
    //variables
    var degrees = 0;
    var color = "lightgreen";
    var bgcolor = "#F3F3F3";
    var text;
    var difference = 0;
    var animation_loop, redraw_loop;
  
    function init(){
     	//clear the canvas everytime a chart is drawn
      	ctx.clearRect(0, 0, W, H);
      
		//Background 360 degree arc
		ctx.beginPath();
		ctx.strokeStyle= bgcolor;
		ctx.lineWidth=29;
		//ctx.arc(x,y,radius,start_angle,end_angle,clockwise?);//you can see the arc now
		ctx.arc(W/2,H/2,100,0,Math.PI*2,false);
		ctx.stroke();

		//gauge will be a simple arc

		//Angle in radians = angle in degrees*PI/180
		var radians = degrees*Math.PI/180;
		ctx.beginPath();
		ctx.strokeStyle = color;
		ctx.lineWidth=30;
		//ctx.arc(x,y,radius,start_angle,end_angle,clockwise?);//you can see the arc now

		//The arc starts from the right most end. If we deduct 90 degrees from the angles
		//the arc will start from the topmost end
		ctx.arc(W/2,H/2,100,0-90*Math.PI/180,radians-90*Math.PI/180,false);
		ctx.stroke();

		//Lets add the text
		ctx.fillStyle = color;
		ctx.font = "50px arial";//"50px arial"
		text = Math.floor(degrees/360*100)+ '%';
		//Lets center the text
		//deducting half of text width from postion x
		text_width = ctx.measureText(text).width;
		//adding manual value to position y since the height of the text cannot
		//be measured easily. there are hacks but we will keep it manual
		//ctx.fillText(the_text, x, y)
		ctx.fillText(text, W/2-text_width/2, H/2 + 15);
		ctx.font = "20px arial";
		text = '평균 성취도';
		text_width = ctx.measureText(text).width;
		ctx.fillText(text, W/2-text_width/2, 0.3*H/2);
    }
  
    function draw(arrival){
		//cancel any movement animation if a new chart is requested
		if(typeof animation_loop != undefined)
		clearInterval(animation_loop);
		//lets draw a 200 degree arc. we need to specify degrees in radians
		new_degrees = arrival*360/100;
		difference = new_degrees - degrees;
		//This will animate the gauge to new positions
		//The animation will take 1 second
		//
		setTimeout(function(){ },7000);
		animation_loop = setInterval(animate_to,1000/difference);
    }
    
    //function to make the chart move to new degrees
    function animate_to(){
		//if(degrees == new_degrees)  //clear animation loop if degrees reaches to new_degrees
		//  clearInterval(animation_loop);
		if(degrees < new_degrees)
			degrees++;
		else
			clearInterval(animation_loop);
		//else
		//  degrees--;

		init();
    }

    draw(sum/cnt);
    //redraw_loop = setInterval(draw,2000); //Draw a new chart every 2seconds
}

    