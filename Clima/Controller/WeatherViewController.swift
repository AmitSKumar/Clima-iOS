//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController   {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherMaanager = WeatherManager()
    var locatonManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locatonManager.delegate = self
        locatonManager.requestWhenInUseAuthorization()
        locatonManager.requestLocation()
        searchTextField.delegate = self
        weatherMaanager.delegate = self
    }
    @IBAction func locationPressed(_ sender: UIButton) {
        
        locatonManager.requestLocation()
    }
    
}


//MARK: - weather manger delegate
extension WeatherViewController : UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else {
            textField.placeholder = "type something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherMaanager.fethcWether(cityName: city)
            
        }
        searchTextField.text = ""
    }
}

extension WeatherViewController :  WeatherMangerDelegate {
    func didUpdateWeather(_ weatherManager:WeatherManager ,weather : WeatherModel){
        self.temperatureLabel.text = weather.temperatureString
        self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        self.cityLabel.text = weather.cityName
    }
    func didfailWithError(error: Error) {
        print(error)
    }
}
extension WeatherViewController :CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locations = locations.last{
            locatonManager.stopUpdatingLocation()
            let lat = locations.coordinate.latitude
            let long = locations.coordinate.longitude
            print(lat)
            print(long)
            weatherMaanager.fethcWeather(latitude: lat,longitude : long )
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
