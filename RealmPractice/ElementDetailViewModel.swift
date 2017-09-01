//
//  ElementDetailViewModel.swift
//  RealmPractice
//
//  Created by User on 9/1/17.
//  Copyright © 2017 MACSpencer.Bell. All rights reserved.
//

import Foundation
import RxSwift


class ElementDetailViewModel : ElementServiceInjection {
    
    let disposeBag = DisposeBag()
    private var index: Variable<Int>
    private let element: Variable<Element>
    private var favoriteElement = Variable<[Element]>([])
    
    var symbol: Observable<String> {
        return element.asObservable().map({ ele in
            ele.symbol
        })
    }
    
    var summary: Observable<String> {
        return element.asObservable().map({ ele in
            ele.summary
        })
    }
    
    var number: Observable<String> {
        return element.asObservable().map({ ele in
            String(ele.number)
        })
    }
    
    var elementName: Observable<String>{
        return element.asObservable().map({ ele in
            ele.name
        })
    }
    
    var category: Observable<String> {
        return element.asObservable().map({ ele in
            ele.category
        })
    }
    
    var phase: Observable<String> {
        return element.asObservable().map({ ele in
            ele.phase
        })
    }
    
    
    init(element: Element, index: Int){
        self.index = Variable(index)
        self.element = Variable(element)
        setUpObservables()
    }
    
    
    
    func setUpObservables(){
        elementService.getElement().subscribe(onNext: { [unowned self] newElement in
            self.favoriteElement.value = newElement
        }).addDisposableTo(disposeBag)
    }
    
    func leftButtonPressed(){
        if index.value <= 0 {
            index.value = favoriteElement.value.count-1
        } else {
            index.value -= 1
        }
        element.value = favoriteElement.value[index.value]
    }
    
    func rightButtonPressed() {
        if index.value >= favoriteElement.value.count-1 {
            index.value = 0
        } else {
            index.value += 1
        }
        element.value = favoriteElement.value[index.value]
    }
}
