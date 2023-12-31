//
//  WeatherModel.swift
//  Clima
//
//  Created by user243065 on 9/1/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId :Int
    let cityName :String
    let temperature : Double
    var temperatureString :String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName : String {
        switch conditionId {
        case 200...232 :
            return "cloud.bolt"
        case 300...321 :
            return "cloud.drizzle"
        case 500...512 :
            return "cloud.rain"
            
        case 600...622 :
            return "cloud.snow"
        case 701...781 :
            return "cloud.fog"
        case 800 :
            return "cloud.bolt"
        case 801...804 :
            return "cloud.bolt"
        default : return "cloud"
        }
    }
}
