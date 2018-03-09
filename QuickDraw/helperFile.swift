//  HelperFunctions.swift
//  QuickDraw
//
//  Created by john bradley on 3/8/18.
//  Copyright © 2018 QuickDraw. All rights reserved.
//
import Foundation
func roundNum(double: Double, to: Int) -> Double {
    let scalar: Double = 1000.0 / Double(to)
    print("scalar: ", scalar)
    return Double(round(scalar*double)/scalar)
}
func DataStatement(roll: Double, pitch: Double, yaw: Double) -> String {
    return("The roll of your shot was \(roll), the pitch of your shot was \(pitch), the yaw of your shot was \(yaw)")
}
func StopMotion(x1: Double, y1: Double, z1: Double) -> [Double] {
    let roll = x1
    let pitch = y1
    let yaw = z1
    return[roll, pitch, yaw]
}
