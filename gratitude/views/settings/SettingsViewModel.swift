//
//  SettingsViewModel.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 29/09/21.
//

import Foundation
import Combine
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var gratitudeRepository = GratitudeRepository.instance
    @Published var gratitudes = [GratitudeViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
//        gratitudeRepository.read()
        gratitudeRepository.$gratitudes
            .compactMap{ $0.map { GratitudeViewModel($0) } }
            .assign(to: \.gratitudes, on: self)
            .store(in: &cancellables)
    }
    
    func delete(at offsets: IndexSet) { for index in offsets { gratitudeRepository.delete(gratitudes[index].gratitude) } }
    
    func deleteAll() { for vm in gratitudes { gratitudeRepository.delete(vm.gratitude) } }
}
