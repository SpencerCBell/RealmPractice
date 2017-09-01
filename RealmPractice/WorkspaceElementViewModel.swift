//
//  WorkspaceElementViewModel.swift
//  RealmPractice
//
//  Created by User on 9/1/17.
//  Copyright © 2017 MACSpencer.Bell. All rights reserved.
//

import Foundation
import RxSwift

protocol FavoriteElementDelegate: class {
    
    func refreshElements()
}

class WorkspaceElementViewModel : ElementServiceInjection
{
    weak var delegate: FavoriteElementDelegate?
    
    
    private(set) var favoriteElements = Variable<[Element]>([])
    
    private let disposeBag = DisposeBag()
    init() {
        fetchElements()
    }
    
    func fetchElements() {
        elementService
            .getElement()
            .subscribe(onNext: { newElement in
                self.favoriteElements.value = newElement
            }).addDisposableTo(disposeBag)
    }
}
