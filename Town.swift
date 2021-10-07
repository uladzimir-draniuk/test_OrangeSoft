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

/*

 base = stations;
 clouds =     {
     all = 70;
 };
 cod = 200;
 coord =     {
     lat = "53.9";
     lon = "27.5667";
 };
 dt = 1632776338;
 id = 625144;
 main =     {
     "feels_like" = "7.49";
     "grnd_level" = 1001;
     humidity = 80;
     pressure = 1027;
     "sea_level" = 1027;
     temp = "8.859999999999999";
     "temp_max" = "8.859999999999999";
     "temp_min" = "8.74";
 };
 name = Minsk;
 sys =     {
     country = BY;
     id = 8939;
     sunrise = 1632801963;
     sunset = 1632844478;
     type = 1;
 };
 timezone = 10800;
 visibility = 10000;
 weather =     (
             {
         description = "broken clouds";
         icon = 04n;
         id = 803;
         main = Clouds;
     }
 );
 wind =     {
     deg = 40;
     gust = "5.94";
     speed = "2.48";
 };
}
 
 */

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
