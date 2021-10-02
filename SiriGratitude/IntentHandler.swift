//
//  IntentHandler.swift
//  SiriGratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 01/10/21.
//

import Intents

class AddGratitudeIntentHandler: NSObject, AddGratitudeIntentHandling {
    func confirm(intent: AddGratitudeIntent, completion: @escaping (AddGratitudeIntentResponse) -> Void) {
        if let _ = intent.gratitude {
            completion(AddGratitudeIntentResponse(code: .ready, userActivity: nil))
        } else {
            completion(AddGratitudeIntentResponse(code: .failure, userActivity: nil))
        }
    }
    
    func handle(intent: AddGratitudeIntent, completion: @escaping (AddGratitudeIntentResponse) -> Void) {
        if let text = intent.gratitude {
            let gratitude = GratitudeModel(text: text)
            GratitudeRepository.instance.create(gratitude) {
                completion(AddGratitudeIntentResponse(code: .success, userActivity: nil))
            } onError: {
                completion(AddGratitudeIntentResponse(code: .failure, userActivity: nil))
            }

        }
    }
    
    
    func resolveGratitude(for intent: AddGratitudeIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let text = intent.gratitude {
            completion(.success(with: text))
        }
    }
}

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is AddGratitudeIntent else { fatalError("Unhandled intent.") }
        return AddGratitudeIntentHandler()
    }
    
}
