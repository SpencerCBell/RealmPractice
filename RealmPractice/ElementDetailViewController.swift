//
//  ElementDetailViewController.swift
//  RealmPractice
//
//  Created by User on 9/1/17.
//  Copyright © 2017 MACSpencer.Bell. All rights reserved.
//

import UIKit
import RxSwift

class ElementDetailViewController: UIViewController {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var phaseLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    
    var index : Int!
    var element: Element!
    var viewModel: ElementDetailViewModel!
    
    var disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ElementDetailViewModel(element: element, index: index)
        setupBindings()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBindings(){
        
        rightButton
            .rx
            .tap
            .subscribe(onNext: {[weak self] _ in
                self?.viewModel.rightButtonPressed()
            })
            .addDisposableTo(disposeBag)
        
        leftButton.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.viewModel.leftButtonPressed()
        })
            .addDisposableTo(disposeBag)
        
        viewModel
            .number
            .bind(to: numberLabel
                .rx
                .text)
            .addDisposableTo(disposeBag)
        
        viewModel
            .symbol
            .bind(to: symbolLabel
                .rx
                .text)
            .addDisposableTo(disposeBag)
        
        viewModel
            .elementName
            .bind(to: nameLabel
                .rx
                .text)
            .addDisposableTo(disposeBag)
        
        viewModel
            .category
            .bind(to: categoryLabel
                .rx
                .text)
            .addDisposableTo(disposeBag)
        
        viewModel
            .summary
            .bind(to: summaryLabel
                .rx
                .text)
            .addDisposableTo(disposeBag)
        
        viewModel
            .phase
            .bind(to: phaseLabel
                .rx
                .text)
            .addDisposableTo(disposeBag)
        
    }    
}

