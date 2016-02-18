# Create a background
background = new BackgroundLayer
	backgroundColor: "#f7f7f7"

# This imports all the layers for "scroll" 
sketch = Framer.Importer.load("imported/scroll")

#creat scroll component
scroll = ScrollComponent.wrap(sketch.content)

#define scrollble area
scroll.scrollHorizontal = false
scroll.x = 0
scroll.y = 150
scroll.width = 750
scroll.height = 1100
sketch.bottom.y = 1240

#capture the scroll interaction
originScrollY = 0
currentScrollY = 0
diffScrollY = currentScrollY-originScrollY
#listen to the event, and print out if the scroll is happening
scroll.on Events.ScrollStart,() ->
	#print("scroll start: " + scroll.scrollY)
	originScrollY = scroll.scrollY
	
scroll.on Events.Scroll, () ->
	#print("is scrolling: " + scroll.scrollY)
	currentScrollY = scroll.scrollY
	diffScrollY = currentScrollY-originScrollY
	diffScrollY = diffScrollY / 3000.0
	#detect scroll direction
	if diffScrollY > 1.0
		diffScrollY = 1.0
	if diffScrollY < -1.0
		diffScrollY = -1.0
	if (diffScrollY >= 0.0) and (button.states.current == "btnIn")
	#This is a function to figure out the path 
		button.rotation = btnInState.rotation + diffScrollY * (btnOutState.rotation - btnInState.rotation)
		button.x = btnInState.x + diffScrollY * (btnOutState.x - btnInState.x)
		button.y = btnInState.y + diffScrollY * (btnOutState.y - btnInState.y)

		#print("going out")
#swithing bettween two states
scroll.on Events.ScrollEnd, () ->
	#print("scroll end: " + scroll.scrollY)
	if (diffScrollY>0)
		button.states.switch("btnOut")
	else
		button.states.switch("btnIn")
	
#assign the button from sketch to the button
window.button = sketch.button

btnInState = {
	x:535 
	y:1020 
	rotation: 0	
} 

btnOutState = {
		x:1100 
		y:1300 
		rotation: 900	
}

# Create additional states
button.states.add
	btnIn: btnInState
	btnOut: btnOutState
	
button.states.switchInstant("btnIn")










