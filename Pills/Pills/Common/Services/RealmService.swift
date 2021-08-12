//
//  RealmService.swift
//  Pills
//
//  Created by aprirez on 7/26/21.
//

import RealmSwift

class RealmService {
    
    static let shared = RealmService()
    let realm = try? Realm()

    private init() { }
    
    func create<T: Object>(_ object: T) {
        do {
            try realm?.write {
                realm?.add(object)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func get<T: Object>(_ type: T.Type) -> [T] {
        guard let realm = realm else {return []}
        let objects = realm.objects(type)
        return Array(objects)
    }

    func update(_ block: () -> Void) {
        do {
            try realm?.write {
                block()
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
 
    func delete<T: Object>(_ object: T) {
        do {
            try realm?.write {
                realm?.delete(object)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
