//
//  MapViewController.swift
//  MotionEffect
//
//  Created by Sai Raghu Varma Kallepalli on 2/11/19.
//  Copyright © 2019 Training. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var userSpeedImg: UIImageView!
    
    @IBOutlet weak var speedLimitImg: UIImageView!
    
    
    
    var locationMgr: CLLocationManager = CLLocationManager()
    var focusLocation = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -37.815338, longitude: 144.963226), latitudinalMeters: 2500, longitudinalMeters: 2500)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSpeedCircles()
        mapKitInitializers()
        
        
    }
    
    func mapKitInitializers() {
        mapView.delegate = self
        locationMgr.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationMgr.distanceFilter = 10
        locationMgr.delegate = self
        locationMgr.requestAlwaysAuthorization()
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        mapView.setRegion(focusLocation, animated: true)
        locationMgr.startUpdatingLocation()
    }
    
    func createSpeedCircles()
    {
        UIView.animate(withDuration: 1, animations: {
            self.userSpeedImg.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.userSpeedImg.layer.cornerRadius = (self.userSpeedImg.frame.size.width)/2
            self.userSpeedImg.layer.borderWidth = 10
            self.userSpeedImg.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.userSpeedImg.clipsToBounds = true
        })
        
        UIView.animate(withDuration: 1, animations: {
            self.speedLimitImg.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.speedLimitImg.layer.cornerRadius = (self.speedLimitImg.frame.size.width)/2
            self.speedLimitImg.layer.borderWidth = 7
            self.speedLimitImg.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            self.speedLimitImg.clipsToBounds = true
        })
        updateSppedLimit(latitude: 0, longitude: 0)
        
    }
        
        //Updates location coordinates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location: CLLocation = locations.last!
        
        updateSppedLimit(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        focusLocation = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), latitudinalMeters: 50, longitudinalMeters: 50)
        let cam = MKMapCamera()
        cam.centerCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        cam.pitch = 80
        cam.altitude = 100
        cam.heading = 0
        mapView.setRegion(focusLocation, animated: true)
        mapView.setCamera(cam, animated: true)
        
    }
    
    func updateSppedLimit(latitude: Double, longitude: Double)
    {
        var url = URL(string: "https://geocoder.api.here.com/6.2/geocode.json?app_id=kJcJidNfXQFNl0HDdYn8&app_code=QI_V3nUsFDxT4WKjhtIUVg&searchtext=425+W+Randolph+Chicago")
        
        URLSession.shared.dataTask(with: url!) { data, _, _ in
            if let data = data {
                print(data)
                
                /*
                let resp = try? JSONDecoder().decode(JsonResponse.self, from: data)
                let d: Double = round((resp?.main.temp)!)
                let intTemp = Int(d)
                self.apiTemperature = intTemp
                DispatchQueue.main.async {
                    self.makeGetRequestImage(icon: (resp?.weather[0].icon)!)
                    self.apiLocationName.text = resp?.name
                    self.apiDescLabel.text = resp?.weather[0].description
                    self.apiTemp.text = String(format: "%i", intTemp - 273) + " °C"
                }
                */
            }
            }.resume()
    }
}

