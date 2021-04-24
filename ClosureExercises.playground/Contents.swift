import UIKit

// Answer each question in the space that follows it. Most of these questions involve closures, a few are just to test verify your knowledge of other subjects.


// 0. Write a Void function, fillIt(n:min:max:data:) with 4 parameters, n, min, max and data. The first 3 will be Ints, the 4th an [Int]. It will cause the 4th parameter to be filled with n Ints, between min and max inclusive, generated at random. Hint: For a parameter to changer its value, as data does, it must include a keyword that we talked about in the first 2 weeks or so of class.

func fillIt(n: Int, min: Int, max: Int, data:inout [Int]){
    // assigns the data parameter as a mutable
    
    // bool control to verify the min < max
    if min >= max || min < 0 || max < 0 {
        print("Bad instruction.")
        return
    }
    
    // renders for loop to execute n times
    for _ in 0 ..< n{
        // assigns a random numbers to data
        data.append(Int(arc4random_uniform(UInt32(max-(min-1)))) + min)
    }
}



// 1. Invoke fillIt() with values 15, 5, 10 -- and pass in data as well
var data : [Int] = []
fillIt(n: 15, min: 5, max: 10, data: &data)
print(data)



// 2. Create a struct, Mouse, with stored properties for x, y, and batteryLife, all Doubles. x and y can have any value, batteryLife should print a warning message if the value being assigned is outside the range 0.0-5.0 inclusive (hint: look at at the Restaurant class covered in class on 26 Feb). Mouse should adhere to the Equatable and CustomStringConvertible protocols. Two Mice are equal if they have the same property values. Implement CustomStringConvertible so it prints out a String that looks like the following (replace numbers with actual values, to 1 decimal, and use "Good" if battery life is at least 2.5, "Poor" otherwise:

struct Mouse: CustomStringConvertible, Equatable{
    // enumerates stored values
    var x : Double
    var y : Double
    var batteryLife: Double {
        willSet{
            if newValue > 5.0 || newValue < 0.0{
                print("Warning: battery life bounds infract on limits")
            }
        }
    }
    
    var description: String {
        return String(format:"Position:(%.1f, %.1f)" , self.x, self.y) + " Battery Life: \(self.batteryLife >= 2.5 ? "Good" : "Poor")"
    }
    
    // willSet not invoke automatically, must explicitly render constructor and invoke method to reassigned itself (outside of init) for willSet to be applicable
    init(x: Double, y: Double, batteryLife: Double) {
        self.x = x
        self.y = y
        self.batteryLife = batteryLife
        
        setBattery()
    }
    
    // private method to force the init to be applicable to the willSet property of batteryLife
    private mutating func setBattery(){
        self.batteryLife = self.batteryLife
    }
    
    static func ==(lhs:Mouse, rhs: Mouse) -> Bool{
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.batteryLife == rhs.batteryLife
    }
}
//  Position: (5.0, 3.0), Battery Life: Good


// 3. Store three Mice in an array, cage (sorry, Mice). Make the first and third elements equal, with a batteryLife == 5.0, the middle one with a value 2.0

var cage = [Mouse(x: 5, y: 3, batteryLife: 3.0), Mouse(x: 6, y: 3, batteryLife: 9.0), Mouse(x: 5, y: 3, batteryLife: 3.0)]

// 4. See if cage contains a Mouse with the same values as cage[1] -- print out true if it does, false otherwise. Hint: Remember that arrays define the contains() method ... it's that easy!
print(cage.contains(cage[1]))



// 5. Write a function, quadrant(mouse:) to return a String "NE", "NW", "SE", "SW" or "ON AXIS" depending on where a Mouse is positioned relative to the origin. (e.g., if it is in the top-right quadrant, return "NE"; top-left quadrant, "NW"; bottom-left quadrant, "SW"; bottom-right quadrant, "SE". [You have already done a question like this.]
func quadrant(mouse: Mouse) -> String{
    // prints which quadrant the mouse is in
    switch((mouse.x > 0, mouse.y > 0)){
    case(_,_) where mouse.x == 0 || mouse.y == 0: return("On Axis")
    case (false,true): return("NW")
    case (false, false): return("SW")
    case (true, true): return("NE")
    case (true, false): return("SE")
    }
}

//quadrant(mouse: Mouse(x: 0, y: 9, batteryLife: 1))


// 6. Assign new values to cage so its first Mouse is in NE, second in NW, third in SW, fourth in SE and 5th on an axis
cage[0].x = 1; cage[0].y = 1
cage[1].x = -1; cage[1].y = 1
cage[2].x = -1; cage[2].y = -1
cage.append(Mouse(x: 1, y: -1, batteryLife: 5.0))
cage.append(Mouse(x: 0, y: 10, batteryLife: 5.0))




// 7. Map cage using quadrant, and print out the resulting array. [Hint: look at the map() function examples that you did in class on 28 Feb]
print(cage.map({ quadrant(mouse: $0)}))



// 8. Sort the elements of cage in increasing order of batteryLife, and print out the result. [Hint: See the sort(by:) example done in class on 28 Feb]
cage.sort(by: { $0.batteryLife < $1.batteryLife})
for mouse in cage {
    print(mouse.batteryLife)
}


// 9. Write a method, splitter(data:classifier:) that will take an array of Ints, data, and a closure, classifier, that accepts an Int and returns a Bool. It will return a new array in whch all the elements for which the closure returned false will precede those elements for which the closure returned true.

// For example, if data were [10, 15, 20, 23], and classifier returned true if an element were *even*, then splitter() would return (15, 23, 10, 20)

// Only use basic Swift programming constructs. Do not use any other function calls other than classsifier() and append()

func splitter(data: [Int], classifier: (Int)-> Bool) -> [Int]{
    var container : [Int] = []
    
    for num in data{
        if !classifier(num){  // false go first
            container.append(num)
        }
    }
    
    for num in data{
        if classifier(num){
            container.append(num)
        }
    }
    
    return container
}






// 10. Invoke splitter(), using data = [10, 15, 20, 23] and a classifier that returns true if an element is even. Print out the returned result.
print(splitter(data: [10,15,20,23], classifier: {$0 % 2 == 0}))




// 11. Write a function, palindromic(num:) that will return true if its parameter, an Int, is palindromic (it reads the same backwards as forwards). For example "1221" is palindromic, whereas "1223" is not. [Hint: Convert an Int into a String. Then reverse it, and see if the two are equal.]
func palindromic(num: Int) -> Bool{
  return String(num) == String(String(num).reversed())
}



// 12. Fill an array, aThou, with the numbers 1 ... 500 inclusive
var aThou: [Int] = []
aThou.append(contentsOf: 1...500)




// 13. Use filter to return those values that are palindromic
print(aThou.filter({palindromic(num: $0)}))

