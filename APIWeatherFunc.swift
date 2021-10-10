//
//  APIWeatherFunc.swift
//  test_api
//
//  Created by elf on 27.09.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import MapKit


class ApiWeatherFunc {
    
    private let scheme = "https://"
    private let host = "api.openweathermap.org"
    private let appId = "eba47effea88b18d5b67eae531209447"
    
    func loadCity(cityName: String, code: String, completion: @escaping ((Result<TownNew, Error>) -> Void)) {
        
        let params = cityName + "," + code
        let parameters: Parameters = [
            "q": params,
            "units": "metric",
            "appid": appId
        ]
        
        let path = "/data/2.5/forecast"
        
        AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
            switch response.result {
            case let .failure( error):
                completion(.failure(error))
            case let .success(data):
                guard let data = data,
                      let json = try? JSON(data: data) else { return }
                let town = TownNew.init(json: json, city: cityName)
                print(town)
                completion(.success(town))
            }
        }
    }
    
    func dataByLocation (location: CLLocation,  completion: @escaping ((Result<TownNew, Error>) -> Void)) {
        
//        let lat = Int(location.coordinate.latitude)
//        let long = Int(location.coordinate.longitude)
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        
        let parameters: Parameters = [
            "lat": lat,
            "lon": long,
            "units": "metric",
            "appid": appId
        ]
        
        let path = "/data/2.5/forecast"
        
        AF.request(scheme + host + path, method: .get, parameters: parameters).response { response in
            switch response.result {
            case let .failure( error):
                completion(.failure(error))
            case let .success(data):
                guard let data = data,
                      let json = try? JSON(data: data) else { return }
                let place = TownNew.init(json: json, city: "none")
                print(place)
                completion(.success(place))
            }
        }
    }
    
    
    }



