//
//  Town.swift
//  test_api
//
//  Created by elf on 26.09.2021.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Town {
    
    let name: String
    let code: String
    let temp: Int
    
    init(name: String, code: String, temp: Int ) {
        self.name = name
        self.code = code
        self.temp = temp
    }
}

class TownNew: Object {
    @Persisted var temperature: Double = 0
    @Persisted var date = Date()
    @Persisted (primaryKey: true) var city: String = ""
    @Persisted var code: String = ""
    var iconUrl: URL? { URL(string: "https://openweathermap.org/img/wn/\(iconString)@2x.png") }
    @Persisted private var iconString: String = ""
    
    convenience init(json: SwiftyJSON.JSON, city: String) {
        self.init()
        
        let containerDate = json["list"].arrayValue.first
        self.date = Date()
        self.temperature = containerDate?["main"]["temp"].doubleValue ?? 0
        self.city = city
        self.code = json["city"]["country"].stringValue
        let weatherJson = containerDate?["weather"].arrayValue.first
        self.iconString = weatherJson?["icon"].stringValue ?? ""
    }
}
