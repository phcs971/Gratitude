//
//  SettingsService.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 01/10/21.
//

import Foundation
import Combine

struct LanguageModel: Identifiable {
    var id: String
    var language: String
}

class SettingsService: ObservableObject {
    private init() {
        self.loadVariables()
        $language
            .compactMap { id in self.availableLanguages.first(where: { $0.id == id }) }
            .assign(to: \.currentLanguage, on: self)
            .store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    static let instance = SettingsService()
    
    private func loadVariables() {
        self.showNotifications = UserDefaults.standard.value(forKey: "showNotification") as? Bool ?? true
        self.language = UserDefaults.standard.value(forKey: "language") as? String ?? "pt"
    }
    
    @Published var language: String = "pt" { didSet { UserDefaults.standard.set(language, forKey: "language") } }
    
    @Published var currentLanguage: LanguageModel = LanguageModel(id:"pt",language: "Português")
    
    
    @Published var showNotifications: Bool = true {
        didSet {
            UserDefaults.standard.set(showNotifications, forKey: "showNotification")
            if !showNotifications { NotificationService.instance.deleteAll() }
        }
    }
    
    func setLanguage(_ language: LanguageModel) {
        self.language = language.id
    }
    
    let availableLanguages = [
        LanguageModel(id:"pt",language: "Português"),
        LanguageModel(id:"en",language: "English")
    ]
}
