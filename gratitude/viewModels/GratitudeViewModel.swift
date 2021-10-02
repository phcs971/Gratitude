//
//  GratitudeViewModel.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 29/09/21.
//

import Foundation
import Combine

class GratitudeViewModel: ObservableObject, Identifiable {
    @Published var gratitudeRepository = GratitudeRepository.instance
    @Published var gratitude: GratitudeModel
    
    var id = ""
    
    @Published var text = ""
    @Published var color: GratitudeColor = .White
    
    private var cancellables = Set<AnyCancellable>()
    
    init(_ gratitude: GratitudeModel) {
        self.gratitude = gratitude
        
        $gratitude.compactMap { $0.id }.assign(to: \.id, on: self).store(in: &cancellables)
        $gratitude.compactMap { $0.text }.assign(to: \.text, on: self).store(in: &cancellables)
        $gratitude.compactMap { $0.gratitudeColor }.assign(to: \.color, on: self).store(in: &cancellables)
    }
    
    func update(colorUpdate: Bool = false) {
        if !text.isEmpty {
            gratitudeRepository.update(self.gratitude)
            if !colorUpdate {
                NotificationService.instance.update(gratitude)
            }
        }
        else { delete() }
    }
    
    func delete() { gratitudeRepository.delete(gratitude) }
    
    func toggleColor() {  gratitude.gratitudeColor = gratitude.gratitudeColor.next(); update(colorUpdate: true) }
}
