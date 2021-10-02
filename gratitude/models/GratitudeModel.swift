//
//  gratitude.model.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 28/09/21.
//

import Foundation
import SwiftUI
import CloudKit

enum GratitudeColor: Int, CaseIterable, Identifiable {
    
    var id: Int { get { self.rawValue } }
    
    case White = 0
    case Green = 1
    case Red = 2
    case Purple = 3
    case Blue = 4
    case Yellow = 5
    
    var color: Color { get { [Color.paperWhite, Color.paperGreen, Color.paperRed, Color.paperPurple, Color.paperBlue, Color.paperYellow][self.rawValue] } }
    
    var foldedImage: String { get { ["WhiteFold", "GreenFold", "RedFold", "PurpleFold", "BlueFold", "YellowFold"][self.rawValue] } }
    
    func next() -> GratitudeColor {
        func getRawValue() -> Int {
            if (self.rawValue == 5) { return 0 }
            return self.rawValue + 1
        }
        
        return GratitudeColor(rawValue: getRawValue()) ?? .White
    }
}

struct GratitudeModel: Identifiable, Equatable {
    static func == (lhs: GratitudeModel, rhs: GratitudeModel) -> Bool { lhs.id == rhs.id }
    
    var id: String = UUID().uuidString
    var text: String = ""
    var gratitudeColor: GratitudeColor = .White
    
    var color: Color { get { gratitudeColor.color } }
    
    func toCKRecord() -> CKRecord {
        let record = CKRecord(recordType: "Gratitude", recordID: recordId)
        record.setValue(text, forKey: "text")
        record.setValue(gratitudeColor.rawValue, forKey: "gratitudeColor")
        record.setValue(id, forKey: "id")
        return record
    }
    
    var recordId: CKRecord.ID { CKRecord.ID(recordName: id) }
    
    func update(record: CKRecord) -> CKRecord {
        record.setValue(text, forKey: "text")
        record.setValue(gratitudeColor.rawValue, forKey: "gratitudeColor")
        return record
    }
    
    static func from(record: CKRecord) -> GratitudeModel {
        GratitudeModel(
            id: record.value(forKey: "id") as! String,
            text: record.value(forKey: "text") as! String,
            gratitudeColor: GratitudeColor(rawValue: record.value(forKey: "gratitudeColor") as? Int ?? 0)!
        )
    }
    
}
