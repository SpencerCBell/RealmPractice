//
//  WorkspaceViewController.swift
//  RealmPractice
//
//  Created by User on 9/1/17.
//  Copyright © 2017 MACSpencer.Bell. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WorkspaceViewController: UIViewController {
    
    @IBOutlet weak var workspaceTableView: UITableView!
    
    var index: Int = 0
    
    var viewModel = WorkspaceElementViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        
        viewModel
            .favoriteElements
            .asObservable()
            .bind(to: workspaceTableView
                .rx
                .items(cellIdentifier: "workspaceCell",
                       cellType: WorkspaceTableViewCell.self)) { row, element, cell in
                        
                        cell.configureWith(element: element, index: row)
                        cell.delegate = self
            }
            .addDisposableTo(disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedElement = viewModel.favoriteElements.value[index]
        
        guard let vc = segue.destination as? ElementDetailViewController else {
            return
        }
        
        vc.element = selectedElement
        vc.index = index
        
    }
    /*
     @IBOutlet weak var symbolLabel: UILabel!
     @IBOutlet weak var numberLabel: UILabel!
     @IBOutlet weak var nameLabel: UILabel!
     @IBOutlet weak var categoryLabel: UILabel!
     @IBOutlet weak var phaseLabel: UILabel!
     @IBOutlet weak var summaryLabel: UILabel!
     */
    
}
extension WorkspaceViewController : WorkspaceTableViewCellDelegate {
    func setInt(index: Int) {
        self.index = index
    }
    func showDetail() {
        performSegue(withIdentifier: "showDetailSegue", sender: nil)
    }
}

extension WorkspaceViewController : FavoriteElementDelegate {
    func refreshElements() {
        DispatchQueue.main.async {
            self.workspaceTableView.reloadData()
        }
    }
}

