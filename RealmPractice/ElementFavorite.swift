//
//  ElementFavorite.swift
//  RealmPractice
//
//  Created by User on 9/1/17.
//  Copyright © 2017 MACSpencer.Bell. All rights reserved.
//

import Foundation
import RealmSwift

class ElementFavorite {
    
    let favoriteID: String
    var name: String
    
    init(realmObj: RealmElementFavorite)
    {
        self.favoriteID = realmObj.favoriteID
        self.name = realmObj.name
    }
}

class RealmElementFavorite : Object {
    
    dynamic var favoriteID = UUID().uuidString
    dynamic var name = ""
    
    var elementList = List<RealmElement>()
    
    override static func primaryKey() -> String?{
        return "favoriteID"
    }
}
