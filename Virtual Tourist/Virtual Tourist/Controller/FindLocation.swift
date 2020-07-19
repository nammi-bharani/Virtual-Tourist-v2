//
//  FindLocation.swift
//  Virtual Tourist
//
//  Created by Bharani Nammi on 7/17/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CoreData

class FindLocation: UIViewController {
    
    
    var pins: [Pin] = []
    var dataController:DataController!
    
    
    @IBOutlet weak var location: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let fetchRequest:NSFetchRequest<DownloadedPhoto> = DownloadedPhoto.fetchRequest()
//
//        if let result = try? dataController.viewContext.fetch(fetchRequest){
//            downloadedPhoto = result
//        }
//        print(downloadedPhoto[0])
    }
    @IBAction func doneButton(_ sender: UIButton){
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func findLocationButton(_ sender: UIButton){
        
        //get the location that user typed and find the location
        //update the global variable and store
        let address = location.text!
        print(address)

        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
            else {
                print("location not found")
                return
            }
            
            Flickr.latAndLonAndUrl.latitude = location.coordinate.latitude
            //print(Flickr.latAndLonAndUrl.latitude)

            Flickr.latAndLonAndUrl.longitude = location.coordinate.longitude
            //print(Flickr.latAndLonAndUrl.longitude)
            
            let latAndLon = "&lat="+String(Flickr.latAndLonAndUrl.latitude)+"&lon="+String(Flickr.latAndLonAndUrl.longitude)
            
            Flickr.latAndLonAndUrl.fullUrl = Flickr.Endpoints.getPart1.stringValue+latAndLon+Flickr.Endpoints.getPart2.stringValue
            //Flickr.getTheUrl()
            
            
            //Instatiate a pin and save it
            
            let pin = Pin(context: self.dataController.viewContext)
            pin.latitude = location.coordinate.latitude
            print("Printitng pin latitude")
            print(pin.latitude)
            
            pin.longitude = location.coordinate.longitude
            print("Printitng pin longitutde")
            print(pin.latitude)
            
            
            
            
            
            try? self.dataController.viewContext.save()
            self.pins.insert(pin, at: 0)
            print(self.pins.count)
            
            
            
            
            //get request
            Flickr.getPhotos { (response, error) in
                print(response[0])
                
                
            //Instatiate a DownloadedPhoto and save it
                
                
                
                
                
                
                
                
                
                
            }
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MapView") as! MapViewController

            let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)

            navigationController.modalPresentationStyle = .overFullScreen
                
            self.present(navigationController, animated: true, completion: nil)
//
            //self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        //dismiss the view controller and go back to the map view scene
        
    }
    
}
