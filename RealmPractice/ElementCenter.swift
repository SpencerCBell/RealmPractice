//
//  ElementCenter.swift
//  RealmPractice
//
//  Created by User on 9/1/17.
//  Copyright © 2017 MACSpencer.Bell. All rights reserved.
//

import Foundation
import Alamofire

let elementURL = "https://raw.githubusercontent.com/Bowserinator/Periodic-Table-JSON/master/PeriodicTableJSON.json"

class ElementCenter {
    
    class func getElements(completion: @escaping ([RemoteElement])->Void){
        
        Alamofire.request(elementURL).responseJSON{response in
            
            guard let json = response.result.value as? [String : Any],
                let results = json["elements"] as? [[String: Any]] else {
                    print("Yo Dawg this wasn't an array of dictionaries")
                    return
            }
            
            var elementArray: [RemoteElement] = []
            for result in results {
                
                guard let name = result["name"] as? String,
                    let symbol = result["symbol"] as? String,
                    let category = result["category"] as? String,
                    let phase = result["phase"] as? String,
                    let summary = result["summary"] as? String,
                    let number = result["number"] as? Int else
                {
                    print("Error parsing data")
                    return
                }
                
                let element = RemoteElement(name: name, symbol: symbol, category: category, phase: phase, summary: summary, number: number)
                elementArray.append(element)
            }
            completion(elementArray)
        }
    }
}
