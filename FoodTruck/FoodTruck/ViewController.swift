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
    
    //현재 위치를 표시해주는 레이블
    @IBOutlet var currentLocation: UILabel!
    //MapKit을 이용한 지도표시
    @IBOutlet var myMapView: MKMapView!
    //카카오내비 실행 버튼
    @IBOutlet var kakaoNaviButton: UIView!
    //슬라이드메뉴를 여는 버튼
    @IBOutlet var openSlideMenu: UIBarButtonItem!
    @IBOutlet var openRightSlide: UIBarButtonItem!
    
    //지도를 보여주기위한 메니져상수
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //슬라이드메뉴 열기
        openSlideMenus()
        customizeNavBar()
        
        //첫 화면 지도 셋팅
        mapSettings()
       
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapSettings(){
         //지도
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //위치정확도 최고
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMapView.showsUserLocation = true
        setAnnotation(latitude: 33.322511, longitude: 126.84186799999998, delta: 1, title: "표선민속촌", subtitle: "서귀포시 표선면 민속해안로 631-34")
    }
    
    //위도와 경도로 원하는 위치 표시하기
    func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delat span : Double) -> CLLocationCoordinate2D  {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpanMake(span, span)
        let pRegion = MKCoordinateRegionMake(pLocation, spanValue)
        myMapView.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    
    //원하는 위치에 핀 설치하기
    func setAnnotation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span : Double, title strTitle: String, subtitle strSubtitle:String)  {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitude: latitudeValue, longitude: longitudeValue, delat: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMapView.addAnnotation(annotation)
    }
    
    //현재 위치 확대해서 보여주기
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
            openSlideMenu.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            
            openRightSlide.target = revealViewController()
            openRightSlide.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }
        
        
    }
    
       
    //네비게이션 바 바탕색(주황)
    func customizeNavBar(){
        
        navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 255/255, green: 87/255, blue: 35/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }
    
    @IBAction func openKakaoMap(_ sender: Any) {
        var destination: KNVLocation
        var options: KNVOptions
        var params: KNVParams
        var error: NSError?
        
        //목적지 - 표선민속촌
        destination = KNVLocation(name: "표선민속촌", x: 126.841867, y: 33.322511)
        options = KNVOptions()
        options.coordType = KNVCoordType.WGS84
        params = KNVParams(destination: destination, options: options)
        KNVNaviLauncher.shared().navigate(with: params, error: &error)
    
        //실행 불가시 에러
        if error != nil {
            let alert = UIAlertController(title: self.title!, message: error?.localizedFailureReason, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
        
    
}
