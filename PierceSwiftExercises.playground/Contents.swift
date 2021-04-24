//: Playground - noun: a place where people can play
// Nick Pierce
import Cocoa

/* Problems 0-2 require you write a function. Write it in the space below the question, and then invoke it -- just print out the results -- using the arguments provided in the example. The examples also show you what the return result, what should be printed.

If you need help, please consult your instructor or GA -- *not* Professor Google.
*/



/*
 0. Oh, no, you've been caught speeding. You will write a function, travelling(), that will be passed in your speed, the speed limit, whether it is your birthday, and then return the amount of the fine.
 
 If you are 1 ... 10  mph over the speedlimit, return 100; 11 ... 20, return 200; > 20 return 500. If it is your birthday, you get an extra 5 mph (e.g., 6 ... 15, return 100; 16 ... 25, return 200; > 25, return 500).
 
 
 travelling(at:50, speedLimit:60, isBirthday:false) -> 0
 travelling(at:50, speedLimit:55, isBirthday:false) -> 100
 travelling(at:50, speedLimit:35, isBirthday:false) -> 200
 travelling(at:50, speedLimit:35, isBirthday:true) -> 100
 */

func traveling( at: Int, speedLimit: Int, isBirthDay: Bool) -> Int {
    // to denote speed difference
    let difference:Int
    if isBirthDay{
        difference = (at - speedLimit) - 5
    }
    else{
        difference = at - speedLimit
    }
    
    // switch to handle fine
    switch difference{
        case 1...10: return 100
        case 11...20: return 200
        default: return 500
    }
}
print(traveling(at: 21, speedLimit: 0, isBirthDay: true))




 
 /* 1. Write a function, lucky13() that is passed in an array, and returns true if it contains no 1's and no 3's, false otherwise.
 
    lucky13([5, 10, 15]) -> false
    lucky13([ ]) -> false
    lucky13([1, 10, 15]) -> true
    lucky13([1, 3, 10, 15]) -> true
 
  Just use a for-in loop, subscripts, and basic logic to solve this problem, don't look for any magic framework method to solve it

*/
func lucky13(_ intArray: [Int]) -> Bool{
    for num in intArray{
        if num == 1 || num == 3 {
            return false
        }
    }
    return true
}
print(lucky13([2,3,4,4,4]))




/* 2. Write a function, numDaysIn(month:year:), that will be passed in the month and year, and return the number of days in it. Use a switch statement as part of your solution.
 
 // numDaysIn(month:"September", year:2018) -> 30
 // numDaysIn(month:"January", year: 2016) -> 31
 // numDaysIn(month:"February", year: 2016) -> 29
 // numDaysIn(month:"February", year: 2015) -> 28
 
Note that February has 28 or 29 days -- the latter if it is a leap year (divisible by 4 *and* not a century year or a multiple of 400).
 
 Leap years between 1600-2152 are: 1600 1604 1608 1612 1616 1620 1624 1628 1632 1636 1640 1644 1648 1652 1656 1660 1664 1668 1672 1676 1680 1684 1688 1692 1696 1704 1708 1712 1716 1720 1724 1728 1732 1736 1740 1744 1748 1752 1756 1760 1764 1768 1772 1776 1780 1784 1788 1792 1796 1804 1808 1812 1816 1820 1824 1828 1832 1836 1840 1844 1848 1852 1856 1860 1864 1868 1872 1876 1880 1884 1888 1892 1896 1904 1908 1912 1916 1920 1924 1928 1932 1936 1940 1944 1948 1952 1956 1960 1964 1968 1972 1976 1980 1984 1988 1992 1996 2000 2004 2008 2012 2016 2020 2024 2028 2032 2036 2040 2044 2048 2052 2056 2060 2064 2068 2072 2076 2080 2084 2088 2092 2096 2104 2108 2112 2116 2120 2124 2128 2132 2136 2140 2144 2148 2152 
 */

func numDaysIn(month: String, year: Int) -> Int{
    // switch statement to denote the days composed in the month
    switch month.localizedLowercase{
    case "january", "march", "may", "july", "august", "october", "december":
        return 31
    
    case "february":
        if year % 4 == 0 && year % 400 == 0 || year % 10 != 0 { // leap year
            return 29
        }
        return 28
        
    default:  // other months that are always 30
        return 30
    }
    
}
print(numDaysIn(month: "February", year: 1700))







/* 3. Study the following function, write a brief comment explaining what it does, and come up with a better function name */

func middleThree(_ data:[Int]) -> [Int] {
    
    if data.count >= 3 && data.count % 2 == 1 {
        return [data[data.count/2 - 1], data[data.count/2], data[data.count/2 + 1]]
    } else {
        return [ ]
    }
    
    
}

// the function determines if the inputted array is odd and greater/equal to 3 then returns ann array of the middle three elements
// ex: when count = 5 then the array will consist of the middle three elements [data[2],data[3],data[4]]
 
