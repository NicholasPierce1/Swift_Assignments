//
//  Schools.swift
//  TheBestKCProgrammingContest
//
//  Created by Nick Pierce on 3/13/19.
//  Copyright © 2019 SmartShopperTeam. All rights reserved.
//

import Foundation
import UIKit

// defines the notifcations
extension Notification.Name{
    static let reloadSchools = Notification.Name(rawValue: "reload schools")
    static let reloadTeams = Notification.Name(rawValue: "reload teams")
}

// defines composite types to be used for Schools

//  class containing information for Team
@objcMembers
internal class Team: NSObject{
    
    // enuemrates attributes
    internal var name: String!
    internal var students: [String] = []
    
    // backendless can't hold arrays... SO we are going store the students name as composite properties
    internal var student1: String?
    internal var student2: String?
    internal var student3: String?
    
    // holds objectId
    internal var objectId: String?
    
    // final init
    internal init(name: String?, students: [String]?){
        self.name = name
        self.students = students ?? []
        
        if self.students.count != 0{
             self.student1 = self.students[0]
            self.student2 = self.students[1]
            self.student3 = self.students[2]
            return
        }
        
        self.student1 = ""
        self.student2 = ""
        self.student3 = ""
    }
    
    // publicly accessible init
    public convenience override init(){
        self.init(name: nil, students: nil)
    }
}

// class containing information about a School - which retains Teams
@objcMembers
internal class School: NSObject{
    
    // enumerates attributes
    internal var name: String!
    internal var coach: String!
    internal var teams: [Team] // new instances don't have any teams assigned yet
    
    // holds the object Id
    internal var objectId: String?
    
    // init
    internal init(name: String?, coach: String?, teams: [Team]?){
        self.name = name ?? ""
        self.coach = coach ?? ""
        self.teams = teams ?? []
    }
    
    // publicly accessible init
    public convenience override init(){
        self.init(name: nil, coach: nil, teams: nil)
    }
    
    // specifies when two instances are equal (name)
    internal static func ==(lhs: School, rhs: School) -> Bool {
        return lhs.name == rhs.name
    }
}

// Struct to holds all participating Schools
internal struct Schools{
    
    // internal singleton for VCs to utilized
    internal static var shared: Schools = Schools()
    
    // holds Backendless singleton
    fileprivate let backendless: Backendless = (UIApplication.shared.delegate as! AppDelegate).backendless
    
    // defines relations to be applied by Schools
    private var schoolTable: IDataStore!
    private var teamTable: IDataStore!
    
    // private init for singleton
    private init(){
        // initializes relations
        self.schoolTable = self.backendless.data.of(School.self)
        self.teamTable = self.backendless.data.of(Team.self)
        
        // invokes the saving and retrieval of initial data
        self.appendInitialData()
    }
    
    //appends initial data, if no data has been integrated
    private func appendInitialData(){
        
        // dispatches work to background thread for concurrency
        DispatchQueue.global(qos: .userInteractive).async{
            Types.tryblock({
                // NOTE: table does NOT exist until an object is saved, add data, check if object count !=1, remove an instance if so
                
                // appends initial data
                let school = self.schoolTable.save(self.schools[0]) as! School  // first school
                let team = self.teamTable.save(self.teams[0]) as! Team  // first team
                //print(team.student3!)
                
                // coalesces initial team and school
                self.schoolTable.addRelation("teams:Team:n", parentObjectId: school.objectId, childObjects: [team.objectId!])
                
                // checks for redudant initial data, remove if so
                
                // query builder to find all objects that have same name as initial data entry "Kearney"
                let query = DataQueryBuilder()
                query?.setWhereClause("name = '\(school.name!)'")
                
                if self.schoolTable.find(query!).count != 1 { // duplicate data
                    self.schoolTable.remove(school)
                    self.teamTable.remove(team)
                }
            },
                           catchblock: {
                            print(($0 as! Fault).debugDescription)
            })
            
            // broadcast notification for schools to reload, passing in the aggregate schools
            
            // acquires school listing w/ team objects
            let query = DataQueryBuilder()
            query?.setRelated(["teams"])
            
            self.schoolTable.find(query!, response: {
                // broadcast notification and pass school array in
                NotificationCenter.default.post(name: Notification.Name.reloadSchools, object: self, userInfo: ["schools": $0 as! [School]])},
                                  error: {print($0!.debugDescription)})
        }
        }

    
    // private collection of Schools
    private var schools: [School] = [School(name: "Kearney", coach: "coachHere", teams: nil)]
    
    // private collection of Teams
    private var teams: [Team] = [Team(name: "team0", students: ["0", "1", "2"])]
    
    /* returns number of schools
    internal func numSchools() -> Int {
        return Schools.shared.schools.count
    }
    
     subcript to acquire a specific school
    internal subscript(i: Int) -> School{
        return Schools.shared.schools[i]
    }*/
    
    // adds a school (no thread, called in a background-thread)
    internal func addSchool(school: School){
        
        // appends school to collection (posutlates that they aren't equal)
        Types.tryblock({
            
            // appends School object to school relation
            self.schoolTable.save(school)
            
            // creates data query to retrieve all related objects for team
            let query: DataQueryBuilder? = DataQueryBuilder()
            query?.setRelated(["teams"])
            
            // broadcast notification for reload
            NotificationCenter.default.post(name: Notification.Name.reloadSchools, object: self, userInfo: ["schools": self.schoolTable.find(query!) as! [School]])
        },
            catchblock: {(print(($0 as! Fault).debugDescription))})
    }
    
    // removes a school
    internal func delete(school: School){
        
        // removes schools per checking equality between instances (surmising no duplicate instances per equality and instance exist)
        Types.tryblock({self.schoolTable.remove(school)}, catchblock: {print(($0 as! Fault).debugDescription)})
    }
    
    // adds a Team to the Team relation and sets it to corresponding School
    // NOTE: no dispatching background thread, called in background thread
    internal func addTeam(forSchool school: School, withTeam: Team) -> Void {
        Types.tryblock( {
            // save to team relation
            let newTeam = self.teamTable.save(withTeam) as! Team
            
            // appends to corresponding school's relation
            self.schoolTable.addRelation("teams:Team:n", parentObjectId: school.objectId, childObjects: [newTeam.objectId!])
            
            // post notification of new teams for that school
            
            // builds data query
            let query: DataQueryBuilder? = DataQueryBuilder()
            query?.setRelated(["teams"])
            query?.setWhereClause("objectId = '\(school.objectId!)'")
            
            NotificationCenter.default.post(name: Notification.Name.reloadTeams, object: self, userInfo: ["teams": (self.schoolTable.find(query!) as! [School])[0].teams])
           
        },
                        catchblock: {print(($0 as! Fault).debugDescription)} )
    }
}
