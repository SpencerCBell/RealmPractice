//
//  ElementTableViewCell.swift
//  RealmPractice
//
//  Created by User on 9/1/17.
//  Copyright © 2017 MACSpencer.Bell. All rights reserved.
//

import UIKit

class ElementTableViewCell: UITableViewCell, ElementServiceInjection {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var element: RemoteElement!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureWith(element: RemoteElement){
        
        self.element = element
        nameLabel.text = element.name
        symbolLabel.text = element.symbol
        
    }
    
    @IBAction func favoritePushed(_ sender: UIButton) {
        
        elementService.addFavorite(element: element)
    }
}
