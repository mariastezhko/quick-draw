//
//  ViewController.swift
//  QuickDraw
//
//  Created by Maria Stezhko on 3/8/18.
//  Copyright © 2018 QuickDraw. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var rndNum = 0;
    var timer = Timer()
    var seconds = 0
    var timeRemaining = 7
    
    var startTime = Date().timeIntervalSince1970
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    var motionManager = CMMotionManager()
    let opQueue = OperationQueue()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if motionManager.isDeviceMotionAvailable {
            print("We can detect device motion")
            startReadingMotionData()
        }
        else {
            print("We cannot detect device motion")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func startClicked(_ sender: UIButton) {
        
        rndNum = Int(arc4random_uniform(11))
        
        startTime = Date().timeIntervalSince1970
        // 1512538946.5705 seconds
        
        // time passes (about 10 seconds)
        
        
        
        
        
        
    }
    
    @IBAction func stopClicked(_ sender: UIButton) {
        let endTime = Date().timeIntervalSince1970
        // 1512538956.57195 seconds
        let elapsedTime = endTime - startTime
        // 10.0014500617981 seconds
        resultLabel.text = "Time passed \(elapsedTime)"
        
    }
    
//    func delay(delay:Double, closure:()->()) {
//        dispatch_after(
//            dispatch_time( dispatch_time_t(DISPATCH_TIME_NOW), Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
//    }
//
//    func loginFunc() {
//
//        delay(10.0){
//            //time is up, show network error
//            //return should break out of the function (not tested)
//            return
//        }

    
    func startReadingMotionData() {
        // set read speed
        motionManager.deviceMotionUpdateInterval = 1
        // start reading
        motionManager.startDeviceMotionUpdates(to: opQueue) {
            (data: CMDeviceMotion?, error: Error?) in
            
            if let mydata = data {
                print("mydata", mydata.gravity)
                //                print("pitch raw", mydata.attitude.pitch)
                //                print("pitch", self.degrees(mydata.attitude.pitch))
            }
        }
    }
    
    
    func degrees(_ radians: Double) -> Double {
        return 180/Double.pi * radians
    }
    
}
