//
//  WorkspaceTableViewCell.swift
//  RealmPractice
//
//  Created by User on 9/1/17.
//  Copyright © 2017 MACSpencer.Bell. All rights reserved.
//

import UIKit

protocol WorkspaceTableViewCellDelegate{
    func showDetail()
    func setInt(index: Int)
}

class WorkspaceTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var index: Int = 0;
    var delegate: WorkspaceTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureWith(element: Element, index: Int){
        nameLabel.text = element.name
        symbolLabel.text = element.symbol
        self.index = index
    }
    
    
    @IBAction func detailPushed(_ sender: UIButton) {
        delegate?.setInt(index: index)
        delegate?.showDetail()
    }
    
}

