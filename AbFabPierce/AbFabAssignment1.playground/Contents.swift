import Cocoa

// Part one of Ab Fab Swift Class and Structs Assignment

// renders structure Country
struct Country: CustomStringConvertible{
    
    // enumerates stored properties
    var name: String
    var area: Double
    var population: Int
    
    // computed property pop-density (read only)
    var density: Double {
        if area < 0 {
            return -1
        }
        return Double(population)/area
    }
    
    // conformity to protocol
    var description: String {
        return "name: \(name) area: \(area) population: \(population) "
    }
    
    // initializers defined below- one convience (name defined only) and one designated
    
    init(name:String, area: Double, population: Int){
        self.name = name
        self.area = area
        self.population = population
    }
    
    init(name: String){ // convience init
        self.init(name: name, area: 0, population: 0)
    }
    
    // function that indicates if a country's population is large (exceeds 1_000_000)
    func hasLargePopulation() -> Bool {
        return population > 1_000_000 ? true : false
    }
    
    // returns true if invoking object's area is smaller than parameter's
    func smallerArea(than otherCountry: Country) -> Bool{
        return area > otherCountry.area ? true : false
    }
    
}

// type inference array atlas
var atlas = [Country(name: "The Bahamas", area: 5382, population: 313312), Country(name: "Croatia", area: 21831, population: 4483804), Country(name: "Maldives")]

// prints elements of atlas
for country in atlas{
    print(country)
}

// defines function meanPopulation to print the mean population
func meanPopulation(someCountries: Country...) -> Double {
    var mean: Double = 0
    
    for country in someCountries {
        mean += country.area
    }
    
    return(mean)
}

// invokes method
print(meanPopulation(someCountries: atlas[0], atlas[1], Country(name: "Macedonia")))

let serbia = Country(name:"Serbia", area:29_913, population:7_310_155)
let macedonia = Country(name:"Macedonia")
print(macedonia.smallerArea(than:serbia))
print(serbia.hasLargePopulation())
