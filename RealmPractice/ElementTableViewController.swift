//
//  ElementTableViewController.swift
//  RealmPractice
//
//  Created by User on 9/1/17.
//  Copyright © 2017 MACSpencer.Bell. All rights reserved.
//

import UIKit

class ElementTableViewController: UITableViewController {
    
    var elementList: [RemoteElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ElementCenter.getElements{list in
            self.elementList = list
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return elementList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath)
        
        guard let eleCell = cell as? ElementTableViewCell else {
            return cell
        }
        
        let element = elementList[indexPath.row]
        eleCell.configureWith(element: element)
        
        return eleCell
    }
}
