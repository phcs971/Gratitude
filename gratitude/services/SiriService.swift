//
//  SiriService.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 01/10/21.
//

import Foundation
import Intents

class SiriService {
    private init() { }
    
    static let instance = SiriService()
    
//    func requestAuthorization() { INPreferences.requestSiriAuthorization { status in } }
    
    func setAddInteraction() {
        INInteraction(intent: AddGratitudeIntent(), response: nil ).donate(completion: nil)
        
    }
}
