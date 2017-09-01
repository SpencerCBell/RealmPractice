//
//  ElementManager.swift
//  RealmPractice
//
//  Created by User on 9/1/17.
//  Copyright © 2017 MACSpencer.Bell. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

protocol ElementService {
    func addElementToFavoriteList(element: Element, favorite: ElementFavorite)
    func addFavorite(element: RemoteElement)
    func updateElement(element: Element)
    func getElement() -> Observable<[Element]>
    func getElement(completion: @escaping ([Element]) -> Void)
}

class ElementManager : ElementService {
    
    
    private let selfRealm = try! Realm()
    
    
    
    func addElementToFavoriteList(element: Element, favorite: ElementFavorite) {
        do {
            let realm = try Realm()
            
            let element = realm.object(ofType: RealmElement.self, forPrimaryKey: element.elementID)
            
            let favoriteElements = realm.object(ofType: RealmElementFavorite.self, forPrimaryKey: favorite.favoriteID)
            
            guard let rlmElement = element, let realmFavorite = favoriteElements else {
                return
            }
            
            try realm.write {
                realmFavorite.elementList.append(rlmElement)
                realm.add(realmFavorite, update: true)
            }
            
        } catch {
            print("UGH OH, SPAGHETTI OHS")
        }
    }
    
    func addFavorite(element: RemoteElement) {
        
        do{
            let realm = try Realm()
            let rlmElement = RealmElement()
            rlmElement.name = element.name
            rlmElement.category = element.category
            rlmElement.number = element.number
            rlmElement.phase = element.phase
            rlmElement.summary = element.summary
            rlmElement.symbol = element.symbol
            
            try realm.write {
                realm.add(rlmElement)
            }
            
        }catch {
            print("error adding to favorites")
        }
    }
    
    func updateElement(element: Element) {
        do {
            
            let realm = try Realm()
            
            guard let rlmElement = realm.object(ofType: RealmElement.self, forPrimaryKey: element.elementID) else {
                return
            }
            
            try realm.write {
                rlmElement.name = element.name
                rlmElement.category = element.category
                rlmElement.number = element.number
                rlmElement.phase = element.phase
                rlmElement.summary = element.summary
                rlmElement.symbol = element.symbol
                
                realm.add(rlmElement, update: true)
            }
            
            
        } catch  {
            
        }
    }
    
    
    private let disposeBag = DisposeBag()
    
    private lazy var element: Results<RealmElement> = {
        return self.selfRealm.objects(RealmElement.self).sorted(byKeyPath: "number", ascending: true)
    }()
    
    func getElement() -> Observable<[Element]> {
        return Observable.create({ observer -> Disposable in
            Observable.array(from: self.element).subscribe(onNext: { result in
                observer.onNext(result.map({
                    Element(realmObj: $0) }))
            }, onError: { error in
                observer.onError(error)
            }).addDisposableTo(self.disposeBag)
            return Disposables.create()
            
        })
    }
    
    func getElement(completion: @escaping ([Element]) -> Void) {
        
        DispatchQueue.global(qos: .default).async {
            let realm = try! Realm()
            
            let results = Array(realm.objects(RealmElement.self).sorted(byKeyPath: "number", ascending: true)).map({ Element(realmObj: $0) })
            
            completion(results)
        }
    }
    
}
