//
//  DependencyInjection.swift
//  RealmPractice
//
//  Created by User on 9/1/17.
//  Copyright © 2017 MACSpencer.Bell. All rights reserved.
//

import Foundation

struct InjectionMap {
    
    static var elementService : ElementService = ElementManager()
}

protocol ElementServiceInjection { }

extension ElementServiceInjection {
    
    var elementService: ElementService {
        get {
            return InjectionMap.elementService
        }
    }
}
