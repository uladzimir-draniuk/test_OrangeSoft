//
//  RealmAdds.swift
//  test_api
//
//  Created by elf on 04.10.2021.
//

import Foundation
import RealmSwift

class RealmAdds {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func save<T: Object>(
        item: T,
        configuration: Realm.Configuration = deleteIfMigration,
        update: Realm.UpdatePolicy
    ) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(item, update: update)
        }
    }
    
    static func save<T: Object>(
        item: T,
        configuration: Realm.Configuration = deleteIfMigration
    ) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(item)
        }
    }
}
