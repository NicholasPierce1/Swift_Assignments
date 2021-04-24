import Cocoa

// part two of Ab Fab: Classes

class Shape: CustomStringConvertible {
    // enumerates stored properties
    var centerX: Double; var centerY: Double
    var isSolid: Bool
    
    // defines computed type read-only
    var quadrant: Int {  // postulating centers don't lie on axis grids
        if centerX == 0 || centerY == 0 {
            return -1
        }
        else if centerX > 0 && centerY > 0 {
            return 0 // quadrant 0
        }
        else if centerX > 0 { // centerY is less than 0
            return 3 // quadrant three
        }
        else if centerY > 0 { // centerX is less than 0
            return 1
        }
        else{
            return 2  // both centers are negative
        }
    }
    
    var description: String {
        return("centerX: \(centerX) centerY: \(centerY) isSolid: \(isSolid)")
    }
    
    // denoting inits
    init(centerX: Double, centerY: Double, isSolid: Bool){
        self.centerX = centerX
        self.centerY = centerY
        self.isSolid = isSolid
    }
    
    convenience init(centerX: Double, centerY: Double){
        self.init(centerX: centerX, centerY: centerY, isSolid: false)
    }
    
    convenience init(){
        self.init(centerX: 0.0, centerY: 0.0, isSolid: false)
    }
    
    // defining functionality
    
    // func to print out "I am a shape"
    func draw(){
        print("I am a shape")
    }
    
    // function to amend the values of the centerpoint
    func translate(deltaX: Int, deltaY: Int) { // doesn't need mutating for its a reference type
        centerX += Double(deltaX)
        centerY += Double(deltaY)
    }
    
    // function to flip center point according to referenced axis
    func flip(axis: Character) {
        if axis == "x" || axis == "X"{  // flip on x-axis
            centerY *= Double(-1)
        }
        else if axis == "y" || axis == "Y"{ // flip on y-axis
            centerX *= Double(-1)
        }
        else{ // invalid char inputted
            return
        }
    }
    
    // function to return perimeter
    func perimeter() -> Double {
        return 0.0
    }
    
    // function to return area
    func area() -> Double {
        return 0.0
    }
}


// defining a subclass Rectangle
class Rectangle: Shape{
    
    // enumerating stored properties
    var width: Double; var height: Double
    
    // defining read only computed properties
    var isSquare: Bool {
        return width == height ? true : false
    }
    
    override var description: String { // don't need to reconform to protocol, just override
        return "\(super.description) width: \(width) height: \(height)"
    }
    
    // inits defined
    init(centerX: Double, centerY: Double, isSolid: Bool, height: Double, width: Double){
        self.height = height
        self.width = width
        super.init(centerX: centerX, centerY: centerY, isSolid: isSolid)
    }
    
    convenience init(height: Double, width: Double){
        self.init(centerX: 0.0, centerY: 0.0, isSolid: false, height: height, width: width)
    }
    
    convenience init(){
        self.init(centerX: 0.0, centerY: 0.0, isSolid: false, height: 0.0, width: 0.0)
    }
    
    // listing various behaviours of Rectangle
    
    // overriden method to print state
    override func draw(){
        print("I am a rectangle \(super.draw())")
    }
    
    // function to determine if set of coordinates reside within rectangle
    func contains(x: Double, y: Double) -> Bool{
        return abs(centerX - x).isLessThanOrEqualTo(width) && abs(centerY - y).isLessThanOrEqualTo(height) ? true : false
    }
    
    // function to return perimeter
    override func perimeter() -> Double {
        return (width*2) + (height*2)
    }
    
    // function to return area
    override func area() -> Double {
        return width * height
    }
    
    
}


// declared an array of shapes
var sketchpad: [Shape] = [Shape(), Shape(centerX:25.0, centerY: 25.0), Shape(centerX: 30, centerY: -15.0, isSolid: true), Rectangle(), Rectangle(height: 100.0, width: 50.0), Rectangle(centerX: -25.0, centerY: -35.0, isSolid: true, height: 250.0, width: 250.0)]

// function to print out average perimeter
func averagePerimeter(shapeCollection: [Shape]) {
    var averagePer: Double = 0
    
    for shape in shapeCollection {
        averagePer += shape.perimeter()
    }
    print(averagePer/Double(shapeCollection.count))
}
averagePerimeter(shapeCollection: sketchpad)

func smallestArea(shapeCollection: [Shape]) {
    var smallestArea: Double = 0
    for i in stride(from: 2, to: sketchpad.count, by: 2){
        if i == 2{
            smallestArea = sketchpad[i].area()
        }
        else if smallestArea > sketchpad[i].area() {
            smallestArea = sketchpad[i].area()
        }
    }
    print("smallest area is: \(smallestArea)")
}

smallestArea(shapeCollection: sketchpad)

func translation(shapeCollection: [Shape]){
    for i in 0 ..< shapeCollection.count{
        if i <= 2 {
            shapeCollection[i].flip(axis: "x")
        }
        else{
            shapeCollection[i].flip(axis: "y")
        }
    }
}

translation(shapeCollection: sketchpad)

func firstLastQuadrant(shapeCollection: [Shape]) {
    print("First element's quadrant: \(shapeCollection[0].quadrant). Last element's quadrant: \(shapeCollection[shapeCollection.count - 1].quadrant)")
}

firstLastQuadrant(shapeCollection: sketchpad)

func randomShift(shapeCollection: [Shape]) {
    print("\nBefore shift")
    for shape in shapeCollection.reversed(){
        print("new locations X: \(shape.centerX) Y: \(shape.centerY)")
    }
    
    for shape in shapeCollection{
        shape.centerX += Double.random(in: -100...100)
        shape.centerY += Double.random(in: -100...100)
    }
    
    print("\nAfter shift")
    for shape in shapeCollection.reversed(){
        print("new locations X: \(shape.centerX) Y: \(shape.centerY)")
    }
}
randomShift(shapeCollection: sketchpad)

