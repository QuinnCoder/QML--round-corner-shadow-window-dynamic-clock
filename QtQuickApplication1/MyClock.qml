import QtQuick 2.6
import QtQuick.Window 2.2

Item {
visible: true
width: 740
height: 680
//title: qsTr("Hello World")
id:window

//color: "red";
Canvas
{
	id : canvas
	anchors.fill: parent
	width: 740
	height: 680
	//dradius: 10
	onPaint:
	{
		var ctx = getContext("2d");
		drawBack(ctx);
		drawDot(ctx);
		var date = new Date();
		var hours = date.getHours()
		hours = hours%12;
		var minutes = date.getMinutes()
		var seconds = date.getUTCSeconds();
		var timestr =date.toLocaleString("yyyy-MM-dd hh:mm:ss");
		//console.log(date.toLocaleString("yyyy-MM-dd hh:mm:ss"));
		drawSecond(seconds,ctx);
		drawHour(hours,minutes,ctx);
		drawMinute(minutes,seconds,ctx);
		drawSecond(seconds,ctx);
		var strTimestr = Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss");
		drawTimeText(ctx, strTimestr);
	}
}

function drawTimeText(ctx, strTimeText)
{
	var r = 200;
	ctx.clearRect(0,0,width,height/2 - r);

	var x = width/2;
	var y = height/2 - r - 20;
	ctx.save();
	ctx.beginPath(); //必须写
	ctx.font = "18px Arial";
	ctx.textAlign = "center";
	ctx.textBaseline = "middle";
	
	ctx.fillText(strTimeText,x,y);
	ctx.stroke();  //必须写（填充方式）
	ctx.restore();

}

function drawBack(ctx)
{
	var r = 200;
	ctx.save();
	ctx.beginPath();
	ctx.translate(width/2,height/2);
	ctx.clearRect(-r,-r,r*2,r*2);
	ctx.lineWidth = 10;
	ctx.arc(0,0,r-5,0,Math.PI*2,false); //外圆
	ctx.stroke();
	//画文本
	var numbers = [1,2,3,4,5,6,7,8,9,10,11,12];
	ctx.font = "18px Arial";
	ctx.textAlign = "center";
	ctx.textBaseline = "middle";
	for(var i = 0; i < 12; ++i)
	{
		var rad = 2*Math.PI/12*numbers[i]-3.14/2;
		var x = Math.cos(rad)*(r-30);
		var y = Math.sin(rad)*(r-30);
		ctx.fillText(numbers[i],x,y);
	}
	//画刻度
	ctx.lineWidth = 2;
	for (var i = 0; i <60; ++i)
	{
		ctx.beginPath();
		var rad = 2*Math.PI/60*i;
		var x = Math.cos(rad)*(r-15);
		var y = Math.sin(rad)*(r-15);
		var x2 = Math.cos(rad)*(r-10);
		var y2 = Math.sin(rad)*(r-10);
		//通过画线也可以
		if (i%5 === 0)
		{
			ctx.strokeStyle="#000000";
		}
		else
		{ 
			ctx.strokeStyle = "#989898";
		}
		ctx.moveTo(x,y);
		ctx.lineTo(x2,y2);
		ctx.stroke();
	}
	ctx.restore();
}

function drawHour(hour, minute, ctx)
{
	var r = 200;
	ctx.save();
	ctx.beginPath(); //必须写
	ctx.lineWidth = 7;
	ctx.lineCap = "round";
	ctx.translate(width/2,height/2);
	var rad = Math.PI*2/12*hour+Math.PI*2*minute/12/60-Math.PI;
	ctx.rotate(rad);
	ctx.moveTo(0,-10);
	ctx.lineTo(0,r/2-10);
	ctx.stroke();  //必须写（填充方式）
	ctx.restore();
}

function drawMinute(minute,second,ctx)
{
	var r = 200;
	ctx.save();
	ctx.beginPath(); //必须写
	ctx.lineWidth = 5;
	ctx.lineCap = "round";
	ctx.translate(width/2,height/2);
	var rad = Math.PI*2*minute/60 + Math.PI*2*second/60/60 -Math.PI;
	ctx.rotate(rad);
	ctx.moveTo(0,-10);
	ctx.lineTo(-10,r*3/5-10);
	ctx.stroke();  //必须写（填充方式）
	ctx.restore();
}

function drawSecond(second,ctx)
{
	var r = 200;
	ctx.save();
	ctx.beginPath(); //必须写
	ctx.lineWidth = 3;
	ctx.lineCap = "round";
	ctx.translate(width/2,height/2);
	ctx.strokeStyle="#ff0000";
	var rad = Math.PI*2*second/60-Math.PI;
	ctx.rotate(rad);
	ctx.moveTo(0,-20);
	ctx.lineTo(0,r*4/5-10);
	ctx.stroke();  //必须写（填充方式）
	ctx.restore();
}

function drawDot(ctx)
{
	ctx.save();
	ctx.beginPath(); //必须写
	ctx.translate(width/2,height/2);
	ctx.fillStyle="#ffffff";
	ctx.arc(0,0,3,0,Math.PI*2);
	ctx.fill();  //必须写（填充方式）
	ctx.restore();
}

//定时器
function startTimer()
{
	console.log("refresh \n");
	canvas.requestPaint();
}

 Timer {
		    interval: 1000; running: true; repeat: true
		    onTriggered: canvas.requestPaint();
	    }

}