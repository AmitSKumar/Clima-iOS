//
//  WeatherManager.swift
//  Clima
//
//  Created by user243065 on 8/31/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation
protocol WeatherMangerDelegate {
    func didUpdateWeather(_ weatherManager:WeatherManager ,weather : WeatherModel)
    func didfailWithError(error :Error)
}

struct WeatherManager {
    let weatherurl = "https://api.openweathermap.org/data/2.5/weather?appid=88fc372c0e7ded2554515b9a08bc1b47&units=metric"
    var delegate : WeatherMangerDelegate?
    func fethcWether(cityName : String ){
        let urlString = "\(weatherurl)&q=\(cityName)"
        performRequest(stringurl: urlString)
    }
    func fethcWeather(latitude: CLLocationDegrees,longitude : CLLocationDegrees ){
        let urlString = "\(weatherurl)&lat=\(latitude)&lon=(\(longitude)"
        performRequest(stringurl: urlString)
    }
    

    func performRequest(stringurl: String){
        if let url = URL(string: stringurl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {data, response , error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        DispatchQueue.main.async {
                            self.delegate?.didUpdateWeather(self, weather: weather)
                        }
                        }
                }
            }
            task.resume()
        }
    }
   func  parseJSON(weatherData :  Data ) -> WeatherModel?{
       let decoder = JSONDecoder()
       do {
           
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
           let id = decodedData.weather[0].id
           let temp = decodedData.main.temp
           let name = decodedData.name
           let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
           return weather
       }catch {
           delegate?.didfailWithError(error: error)
           return nil
       }
    }
   
    
}
