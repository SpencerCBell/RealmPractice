//
//  Element.swift
//  RealmPractice
//
//  Created by User on 9/1/17.
//  Copyright © 2017 MACSpencer.Bell. All rights reserved.
//

import Foundation
import RealmSwift

struct RemoteElement
{
    let name: String
    let symbol : String
    let category: String
    let phase : String
    let summary : String
    let number : Int
}

struct Element {
    
    let elementID : String
    var name: String
    var symbol: String
    var category: String
    var phase: String
    var summary: String
    var number: Int
    
    init(realmObj: RealmElement){
        
        self.elementID = realmObj.elementID
        self.name = realmObj.name
        self.category = realmObj.category
        self.symbol = realmObj.symbol
        self.phase = realmObj.phase
        self.summary = realmObj.summary
        self.number = realmObj.number
    }
    
}

class RealmElement: Object {
    
    dynamic var elementID = UUID().uuidString
    dynamic var name = ""
    dynamic var symbol = ""
    dynamic var category = ""
    dynamic var number = 0
    dynamic var phase = ""
    dynamic var summary = ""
    
    let periodicElements = LinkingObjects(fromType: RealmElementFavorite.self, property: "elementList")
    
    override static func primaryKey() -> String? {
        return "elementID"
    }
}
