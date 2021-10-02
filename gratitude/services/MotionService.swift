//
//  MotionManager.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 30/09/21.
//

import Foundation
import Combine
import SpriteKit
import CoreMotion

class MotionService: ObservableObject {

    private var motionManager: CMMotionManager
    
    @Published var vector: CGVector = CGVector.zero


    init() {
        self.motionManager = CMMotionManager()
        self.motionManager.accelerometerUpdateInterval = 1/30
        self.motionManager.startAccelerometerUpdates(to: .main) { data, error in
            guard let data = data, error == nil else { return print(error!.localizedDescription) }
            self.vector = CGVector(dx: data.acceleration.x * 30, dy: data.acceleration.y * 30)
        }
    }
}
