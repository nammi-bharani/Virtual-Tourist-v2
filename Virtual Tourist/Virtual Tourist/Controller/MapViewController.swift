//
//  ViewController.swift
//  Virtual Tourist
//
//  Created by Bharani Nammi on 7/16/20.
//  Copyright © 2020 Bharani Nammi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var pins: [Pin] = []
    var dataController:DataController!
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //get the location of the pin and place the pins
        
         let fetchRequest:NSFetchRequest<Pin> = Pin.fetchRequest()
        
         if let result = try? dataController.viewContext.fetch(fetchRequest){
            pins = result
         }
         print(pins[0])
        
        
        print(Flickr.Endpoints.getPart1.stringValue)
        print(Flickr.Endpoints.getPart2.stringValue)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        var annotations = [MKPointAnnotation]()
        
        print("Printing latitude")
        print(Flickr.latAndLonAndUrl.latitude)

        
        
        let coordinate = CLLocationCoordinate2D(latitude: Flickr.latAndLonAndUrl.latitude, longitude:  Flickr.latAndLonAndUrl.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        //need to create the url for the photo
        //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
        
        
        
        
        annotation.subtitle = "https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg"
        annotations.append(annotation)
        
        for pin in pins{
            
            let coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude:  pin.longitude)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            //need to create the url for the photo
            //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
            
            
            annotation.subtitle = "https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg"
            annotations.append(annotation)

        }
        
        
        self.mapView.addAnnotations(annotations)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            
            //go to the new controller view where it displays the photo
            
            //
            performSegue(withIdentifier: "PhotoView", sender: nil)
            
            
        }
    }
    

}

