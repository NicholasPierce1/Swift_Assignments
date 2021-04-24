//
//  HeroesAndLaureates.swift
//  SuperHeroesAndLaureates
//
//  Created by Nick Pierce on 4/13/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import Foundation

// retrieves heroes and laureates and passes to corresponding viewControllers

// renders the notifications necessary for across-app communication
extension Notification.Name{
    // enumerates static variables for new notifications
    static let heroesLoaded = Notification.Name(rawValue: "heroes are loaded")
    static let lauSomethingLoaded = Notification.Name(rawValue: "laus are loaded")
}

// struct to contain the Super Hero Squad
internal struct SuperHeroSquad: Codable{
    
    // enumerates properties
    let squadName: String!
    let homeTown: String!
    let formed: Int!
    let secretBase: String!
    let activeMembers: Bool!
    
    // holds all current memebers
    let members: [SuperHero]?
}

// defines a super hero
internal struct SuperHero: Codable{
    
    // enumerates properties for a hero
    let name: String!
    let age: Int!
    let secretIdentity: String!
    let powers: [String]!
}

// retrieves heroes/laureates and broadcast notification
internal class Retriever{
    
    // singleton instance
    static internal let shared = Retriever()
    
    // holds URLs needed for dataTask
    private let superHero: URL? = URL(string: "https://www.dropbox.com/s/wpz5yu54yko6e9j/squad.json?dl=1")
    private let laureteURL: URL? = URL(string: "https://dropbox.com/s/7dhdrygnd4khgj2/laureates.json?dl=1")
    
    // holds decoder for SuperHeroSquad
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    // defines error counter for loading Laureates
    private lazy var errorCounter: Int = 0
    
    private init(){
    
    }
    
    // retrieves all heroes and passes it SuperHeroTableViewController
    internal func callingAllHeros() -> Void {
        
        // instigates URL Session and passes in
        URLSession.shared.dataTask(with: superHero!){ (data: Data?, response: URLResponse?, error: Error?) -> Void in
            // decodes data and invokes notification
            
            do{
                let ourHeroes: SuperHeroSquad = try self.jsonDecoder.decode(SuperHeroSquad.self, from: data!)
                //invokes notification
                NotificationCenter.default.post(name: Notification.Name.heroesLoaded, object: self, userInfo: ["ourHeroes...": ourHeroes.members!])
                
            }
            catch let error as Error{  // ignore warning: used for demonstration
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    // retrieves all Laureates and passes it to LaureateTableView
    internal func callingAllLaureates() -> Void {
        
        // invokes URL Sesssion to retrieve data
        URLSession.shared.dataTask(with: laureteURL!){[weak self] (data, response, error) in
            // serializes JSON data
            guard let laureateList: [[String: Any]] = try? JSONSerialization.jsonObject(with: data! , options: JSONSerialization.ReadingOptions.allowFragments) as! [[String: Any]] else{
                
                // increments fault counter
                self?.errorCounter+=1
                
                // prints error
                print(error != nil ? error!.localizedDescription : "could not parse data")
                
                // attempts to reload if amount of attempts is less than 4 ( 3 tries )
                if self!.errorCounter <= 3 {
                    self!.callingAllLaureates()
                }
                
                // attempts greater than three, abort process
                return
            }
            
            // invokes notification and passes laureate list
            NotificationCenter.default.post(name: Notification.Name.lauSomethingLoaded, object: self, userInfo: ["ourHonorablePeople...": laureateList])
        }.resume()
    }
    
}
