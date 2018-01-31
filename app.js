var myElement = document.getElementById('music');
var swipeElement = document.getElementById('swipe');
//var music = new Hammer(myElement);
var list = [['music', 'photo', 'video', 'press','contact'],
			['music2', 'photo2', 'video2', 'press2','contact2']];
var listBtn = [['music_btn', 'photo_btn', 'video_btn', 'press_btn','contact_btn'],
				['music_btn2', 'photo_btn2', 'video_btn2', 'press_btn2','contact_btn2']];
var listLength = list[0].length;
var listLength2 = list[1].length;
var getId = 0;
var x = 0;
var y = 0;

/*document.addEventListener("touch", function{
	console.log("touch detected");
});*/

//music.on("swipe tap press",//swipe(event));
function mdown(ev) {
	if (ev.type == "mousedown")
	{
		x = ev.clientX;
		y = ev.clientY;
	} else if (ev.type == "touchstart") {
		x = ev.changedTouches[0].pageX;
		y = ev.changedTouches[0].pageY;
	}
	/*console.log(ev.type);
	console.log("\nx: " + x + ", y: " + y);
	console.log("event type: " + ev.type);*/
}
function mup(ev) {
	if (ev.type == "mouseup")
	{
		var newX = ev.clientX;
		var newY = ev.clientY;
	} else if (ev.type == "touchend") {
		var newX = ev.changedTouches[0].pageX;
		var newY = ev.changedTouches[0].pageY;
	}
	var dX = x - newX;
	var dY = y - newY;
	/*console.log("event type: " + ev.type);
	console.log("new x: " + newX + ", new y: " + newY);
	console.log("dx: " + dX + ", dy: " + dY);*/
	for (var i=0; i<listLength2; i++)
	{
		if(document.getElementById(list[1][i]) == myElement)
		{ getId = i; /*console.log(list[i]);*/ }
	}
	if (dX!=0 && Math.abs(dY/dX) < 1)
	{
		if (dX < 0)
		{
			if(getId == 0)
			{ getId = listLength2 - 1;} 
			else 
			{ getId = getId-1; }
			myElement = list[1][getId]
			loadContent(myElement, 1);
		}
		if (dX > 0)
		{
			if(getId == listLength2 - 1)
			{ getId = 0; } 
			else 
			{ getId = getId+1; }
			myElement = list[1][getId]
			loadContent(myElement, 1);
		}
		/*console.log("element num: " + getId);
		console.log("element name: " + myElement);//*/
	}
	var menu = document.getElementById('menu');
	var changed = false;
	if(menu.classList.contains('show') && !changed)
	{
		menu.classList.remove('show');
		menu.classList.add('hide');
		changed = true;
	}
}


function loadContent(name, num) {
	for (var i=0; i<listLength2; i++) {
		if(list[num][i] == name) {
			document.getElementById(list[num][i]).classList.remove('hide');
			document.getElementById(list[num][i]).classList.add('show');
			document.getElementById(listBtn[num][i]).classList.add('on-focus');
			//myElement = document.getElementById(list[i]);
			//mc = Hammer(myElement);
			//console.log(i);
		} else {
			document.getElementById(list[num][i]).classList.remove('show');
			document.getElementById(list[num][i]).classList.add('hide');
			document.getElementById(listBtn[num][i]).classList.remove('on-focus');
		}
	}
}


function hamburger() {
	var menu = document.getElementById('menu');
	var changed = false;
		if(menu.classList.contains('show') && !changed)
		{
			menu.classList.remove('show');
			menu.classList.add('hide');
			changed = true;
		} else if (menu.classList.contains('hide') && !changed) {
			menu.classList.remove('hide');
			menu.classList.add('show');
			changed = true;
		}
}

