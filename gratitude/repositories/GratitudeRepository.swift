//
//  GratitudeRepository.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 29/09/21.
//

import Foundation
import Intents
import CloudKit

class GratitudeRepository: ObservableObject {
    private init() {  }
    
    static let instance = GratitudeRepository()
    
    var loaded = false
    var busy = false
    
    let db = CKContainer(identifier: "iCloud.com.phcs.gratitude").privateCloudDatabase
    
    @Published var gratitudes = [GratitudeModel]()
    
    func create(_ gratitude: GratitudeModel, onSuccess: (() -> Void)? = nil, onError: (() -> Void)? = nil) {
        let record = gratitude.toCKRecord()
        self.gratitudes.append(gratitude)

        self.db.save(record) { record, error in
            guard let _ = record, error == nil else { onError?(); return print(error!.localizedDescription) }
            onSuccess?()
            NotificationService.instance.add(gratitude)
            INInteraction(intent: AddGratitudeIntent(), response: nil ).donate(completion: nil)
        }
    }
    
    func read() {
        if busy { return }
        busy = true
        let query = CKQuery(recordType: "Gratitude", predicate: NSPredicate(value: true))
        self.db.perform(query, inZoneWith: nil) { records, error in
            guard let records = records, error == nil else { return print(error!.localizedDescription) }
            DispatchQueue.main.async {
                self.gratitudes = records.compactMap { GratitudeModel.from(record: $0) }
                self.loaded = true
                self.busy = false
            }
        }
    }
    
    func update(_ gratitude: GratitudeModel) {
        self.db.fetch(withRecordID: gratitude.recordId) { record, error in
            guard var record = record, error == nil else { return print(error!.localizedDescription) }
            record = gratitude.update(record: record)
            self.db.save(record) { record, error in
                guard let _ = record, error == nil else { return print(error!.localizedDescription) }
                
                DispatchQueue.main.async {
                    let index = self.gratitudes.firstIndex(of: gratitude)
                    if let index = index { self.gratitudes[index] = gratitude }
                }
            }
        }
    }
    
    func delete(_ gratitude: GratitudeModel) {
        self.gratitudes.removeAll { $0.id == gratitude.id }
        self.db.delete(withRecordID: gratitude.recordId) { recordId, error in
            guard let _ = recordId, error == nil else { return print(error!.localizedDescription) }
            NotificationService.instance.delete(gratitude)
        }
    }
    
    func deleteAll() {
        self.gratitudes = []
        NotificationService.instance.deleteAll()
        for gratitude in gratitudes {
            self.db.delete(withRecordID: gratitude.recordId) { recordId, error in
                guard let _ = recordId, error == nil else { return print(error!.localizedDescription) }
            }
        }
    }
    
}
