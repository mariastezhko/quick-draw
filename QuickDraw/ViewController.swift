//
//  ViewController.swift
//  QuickDraw
//
//  Created by Maria Stezhko on 3/8/18.
//  Copyright © 2018 QuickDraw. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation


class ViewController: UIViewController {
    var bool = false
    var rndNum = 0;
    var timer = Timer()
    var seconds = 0
    var timeRemaining = 7
    var myAudioPlayer = AVAudioPlayer()
    var resultTime = 0.0
    var statement = ""

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
        bool = false
        rndNum = Int(arc4random_uniform(11))
        startTime = Date().timeIntervalSince1970
       
        let playbackDelay = 5.0

        guard let url = Bundle.main.url(forResource: "shortbuzz", withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            myAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            
            myAudioPlayer.play(atTime: myAudioPlayer.deviceCurrentTime+playbackDelay)
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    @IBAction func stopClicked(_ sender: UIButton) {
        bool = true
        let endTime = Date().timeIntervalSince1970
        let elapsedTime = endTime - startTime
        print("statement at stopClicked:", statement)
        resultLabel.text = "Time passed \(elapsedTime) Shot: \(statement)"
        
        resultTime = elapsedTime - 5
        
        
        // Add more conditions here for the draw evaluation
        if resultTime <= 2 {
            // Good job!
            guard let url = Bundle.main.url(forResource: "gunshot", withExtension: "wav") else { return }
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                
                
                myAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
                
                myAudioPlayer.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        else {
            
            // You failed!
            // Replace "gunshot" with a "failure" sound
            
            guard let url = Bundle.main.url(forResource: "gunshot", withExtension: "wav") else { return }
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                
                
                myAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
                
                myAudioPlayer.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
    }
    

    
    func startReadingMotionData() {
        // set read speed
        motionManager.deviceMotionUpdateInterval = 1
        // start reading
        motionManager.startDeviceMotionUpdates(to: opQueue) {
            (data: CMDeviceMotion?, error: Error?) in
            
            if let mydata = data {
                print("mydata", mydata.gravity)
                let x = mydata.gravity.x
                print("x: ", roundNum(double: x, to: 3))
                // x approx 0.02
                //                x 0.02
                let y = mydata.gravity.y
                print("y: ", roundNum(double: y, to: 3))
                //                y approx 0.02
                //                y approx 1
                let z = mydata.gravity.z
                print("z: ", roundNum(double: z, to: 3))
                //z approx -1
                //                z approx0.03
                if self.bool {
                    self.statement = "The roll of your shot was \(x), the pitch of your shot was \(y), the yaw of your shot was \(z)"
                    let endTime = Date().timeIntervalSince1970
                    let elapsedTime = endTime - self.startTime
                    print("statement at stopClicked:", self.statement)
                    self.resultLabel.text = "Time passed \(elapsedTime) Shot: \(self.statement)"
                    print("STATEMENT: ", self.statement)
                    print(StopMotion(x1: x, y1: y, z1: z))
                }
                else {
                      self.statement = ""
                    }

                //                print("pitch raw", mydata.attitude.pitch)
                //                print("pitch", self.degrees(mydata.attitude.pitch))
            }
        }
    }
    
    
    func degrees(_ radians: Double) -> Double {
        return 180/Double.pi * radians
    }
    
}
func degrees(_ radians: Double) -> Double {
    return 180/Double.pi * radians
}
//Inplement handleDeviceMotionUpdate function
func handleDeviceMotionUpdate(deviceMotion:CMDeviceMotion) {
    print("MOTION FUNCTION")
    var attitude = deviceMotion.attitude
    var roll = degrees(attitude.roll)
    var pitch = degrees(attitude.pitch)
    var yaw = degrees(attitude.yaw)
}

