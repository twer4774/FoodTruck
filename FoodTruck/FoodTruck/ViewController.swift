//
//  ViewController.swift
//  FoodTruck
//
//  Created by WonIk on 2017. 8. 30..
//  Copyright © 2017년 WonIk. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var openSlideMenu: UIBarButtonItem!
    @IBOutlet var openRightSlide: UIBarButtonItem!
    @IBOutlet var myMapView: MKMapView!
    @IBOutlet var currentLocation: UILabel!
    @IBOutlet var goalLocation: UILabel!
    
    //지도 보여주기
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        openSlideMenus()
        customizeNavBar()
        
        //지도
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //위치정확도 최고
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMapView.showsUserLocation = true
        setAnnotation(latitude: 33.322511, longitude: 126.84186799999998, delta: 1, title: "표선민속촌", subtitle: "서귀포시 표선면 민속해안로 631-34")
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //위도와 경도로 원하는 위치 표시하기
    func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delat span : Double) -> CLLocationCoordinate2D  {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpanMake(span, span)
        let pRegion = MKCoordinateRegionMake(pLocation, spanValue)
        myMapView.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    //원하는 핀 설치하기
    func setAnnotation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span : Double, title strTitle: String, subtitle strSubtitle:String)  {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitude: latitudeValue, longitude: longitudeValue, delat: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMapView.addAnnotation(annotation)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        goLocation(latitude: (pLocation?.coordinate.latitude)!, longitude: (pLocation?.coordinate.longitude)!, delat: 0.01)//작을수록 확대, 여기서는 100배
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placeMarks, error) -> Void in
            let pm = placeMarks!.first
            let country = pm!.country
            var address:String = country!
            if pm!.locality != nil{
                address += "  "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {
                address += "  "
                address += pm!.thoroughfare!
            }
            
            self.currentLocation.text = address
            
        })
        
        /* 위도, 경도로 표시 */
        //        if let coor = manager.location?.coordinate{
        //            currentLocation.text = "latitude" + String(coor.latitude) + "/ longitude" + String(coor.longitude)
        //
        //        }
        locationManager.stopUpdatingLocation()
    }
    
    
    func openSlideMenus(){
        if revealViewController() != nil{
            openSlideMenu.target = revealViewController()
            openSlideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            
            openRightSlide.target = revealViewController()
            openRightSlide.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }
        
        
    }
    
    func customizeNavBar(){
        
        navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 255/255, green: 87/255, blue: 35/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }
    
    @IBAction func openKakaoMap(_ sender: UIButton) {
        if let kakaomaps = URL(string : "kakaomaps://"){
            if UIApplication.shared.canOpenURL(kakaomaps){
                UIApplication.shared.open(kakaomaps)
            }
            
        }
        
        
        
        //  if UIApplication.sharedApplication().canOpenURL(navermapsURL!) {
        //            UIApplication.sharedApplication().openURL(navermapsURL!)
        //
        //        }
        //
        //        else {
        //
        //            print("No kakaostory installed.")
        //
        //        }
        
    }
    
    
    
}

//        let urlString = "navermaps://?menu=route&routeType=4&elat=\(pLocation?.coordinate.latitude)&elng=\(pLocation?.coordinate.longitude)&etitle=\(title)"
//        let textEncode = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
//        if let encode = textEncode {
//            if let url = NSURL.init(string: encode) {
//                UIApplication.sharedApplication().openURL(url)
//            }
//        }
