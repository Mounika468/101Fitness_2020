//
//  LocationServices.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 28/04/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol LocationServiceDelegate {
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: NSError)
}

class LocationSingleton: NSObject,CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    var delegate: LocationServiceDelegate?
    var geocoder: CLGeocoder?
    var placemark: CLPlacemark?

    // here I am declaring the iVars for city and country to access them later

    var city: String?
    var country: String?
    var countryShortName: String?
    static let sharedInstance:LocationSingleton = {
        let instance = LocationSingleton()
        return instance
    }()
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.geocoder = CLGeocoder()
        guard let locationManagers=self.locationManager else {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManagers.requestAlwaysAuthorization()
            locationManagers.requestWhenInUseAuthorization()
        }
        if #available(iOS 9.0, *) {
//            locationManagers.allowsBackgroundLocationUpdates = true
        } else {
            // Fallback on earlier versions
        }
        locationManagers.desiredAccuracy = kCLLocationAccuracyBest
        locationManagers.pausesLocationUpdatesAutomatically = false
        locationManagers.distanceFilter = 0.1
        locationManagers.delegate = self
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.lastLocation = location
        updateLocation(currentLocation: location)
        // Here is the place you want to start reverseGeocoding
        geocoder!.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                       // always good to check if no error
                       // also we have to unwrap the placemark because it's optional
                       // I have done all in a single if but you check them separately
                       if error == nil, let placemark = placemarks, !placemark.isEmpty {
                           self.placemark = placemark.last
                       }
                       // a new function where you start to parse placemarks to get the information you need
                       self.parsePlacemarks()

                  })
        
    }
    func  parsePlacemarks() {
        // here we check if location manager is not nil using a _ wild card
        if let _ = self.lastLocation {
            // unwrap the placemark
            if let placemark = placemark {
                // wow now you can get the city name. remember that apple refers to city name as locality not city
                // again we have to unwrap the locality remember optionalllls also some times there is no text so we check that it should not be empty
                if let city = placemark.locality, !city.isEmpty {
                    // here you have the city name
                    // assign city name to our iVar
                    self.city = city
                }
               
                // the same story optionalllls also they are not empty
                if let country = placemark.country, !country.isEmpty {
                    
                    self.country = country
                }
                // get the country short name which is called isoCountryCode
                if let countryShortName = placemark.isoCountryCode, !countryShortName.isEmpty {
                    
                    self.countryShortName = countryShortName
                }
                
            }
            
            
        } else {
            // add some more check's if for some reason location manager is nil
        }
        
    }
    @nonobjc func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager?.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
            break
        case .authorizedAlways:
            locationManager?.startUpdatingLocation()
            break
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            break
        }
    }
    

    
    // Private function
    private func updateLocation(currentLocation: CLLocation){
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocation(currentLocation: currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: NSError) {
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocationDidFailWithError(error: error)
    }

    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
//        self.locationManager?.startMonitoringSignificantLocationChanges()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
    
    func startMonitoringSignificantLocationChanges() {
        self.locationManager?.startMonitoringSignificantLocationChanges()
    }
    
    // #MARK:   get the alarm time from date and time
}
