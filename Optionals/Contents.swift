//: Playground - noun: a place where people can play

import UIKit

// You can just answer the questions as is, but if you uncomment out the code between the ************ and work through it, Xcode will help you!


 
 // 0. Declare an Int variable, scovilleNumber that is an optional
var scovilleNumber: Int?
 
 // 1. Assign scovilleNumber the value 18
 scovilleNumber = 18
 
 // 2. Write a statement to double the value of scovilleNumber
 scovilleNumber = scovilleNumber! * 2
 
 // 3. In the if let below, what type is scoville?
// scoville inside the if is an Int. The value is unwrapped in the optional-binding
 
 if let scoville = scovilleNumber {
 print(scoville)
 } else {
 print("Alas, scovilleNumber is nil")
 }
 
 // 4. What will get printed in the code above?
 // 36

 // 5. Declare a Double variable, richterMagnitude, that is an implicitly unwrapped optional
var richterMagnitude: Double!
 // 6. Assign richterMagnitude the value 1.8
 richterMagnitude = 1.8
 // 7. Write a statement to double the value of richterMagnitude
 richterMagnitude *= 2
 // 8. What will get printed in the next if-else statement if scovilleNumber was 20 and richterMagnitude is nil?
 // "Now what you can say about richterMagnitude and/or scovilleNumber?"
 
 // 9. What would get printed in the next if-else statementif both scovilleNumber and richterMagnitude were non-nil
 //" What can you say about richertMagnitude and scovilleNumber?"
 
 if let richter = richterMagnitude, let scoville = scovilleNumber {
 print("What can you say about richterMagnitude and scovilleNumber?")
 } else {
 print("Now what you can say about richterMagnitude and/or scovilleNumber?")
 }
 
 // 10. What type is codie? (That's codie, not codie? ... these are really difficult to phrase!)
// String
 
 var coder:String?
 var codie = coder ?? "Nobody"
 
 // 11. What value is currently in coder, and what will the next print() statement print?
 // nil. "Anonymous person"
 
 // 12. What would get printed if coder had the value "Freddie"
 // "Hello, Freddie"
 print("Hello, \(coder ?? "Anonymous person")")
 
 // With respect to the code below,

 // 13. Why does the ! after text tell you about that text field property?
 // the textfield property is an optional -- not implicitly unwrapped
 
 // 14. What type is volume?
// Int?

 // 15. What type is volume51?
// Int
 
 var volumeTF = UITextField()
 volumeTF.text = "12.5"
 
var volume : Int! = Int("hello") //Int(volumeTF.text!)
 
 if let volume51 = Int(volumeTF.text!) {
 print("The volume is \(volume51)")
 }
 
 // 16. Write a function closeEnough(center:range:data:)that will be passed in a variable number of Ints, a center, and a range; and return an Int?, the number of elements that are within range units of the center, or if no elements are supplied, nil.
// func to determine how many varied elements supplied in data are within the inclusive range of (center +- range)
func closeEnough(center: Double, range: Double, data: Double...) -> Int? {
    // var to retain the aggregate amount of elements within the satisfiable range
    var withinRangeNum: Int = 0
    
    // test and return nil if range of data is 0
    if data.count == 0 {
        return nil
    }
    
    // for loop to iterate over the data elements
    for num in data {
        if num >= (center - range) && num <= (center + range){
            withinRangeNum += 1
        }
    }
    return withinRangeNum
}
 
 // For instance, closeEnough(center:5, range:3, data: 15, 6, 18, 8) would return 2, since 6 and 8 are within 3 units of 5)
 
// closeEnough(center:5, range:3) would return nil, since there are no elements provided
 
closeEnough(center: 5, range: 5, data: 0,5,99)
closeEnough(center: 5, range: 5)
