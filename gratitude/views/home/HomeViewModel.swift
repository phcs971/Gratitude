//
//  HomeViewModel.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 29/09/21.
//

import Foundation
import Combine
import SwiftUI

enum HomeState {
    case Normal
    case Add
    case Read
}

class HomeViewModel: ObservableObject {
    
    @Published var gratitudeRepository = GratitudeRepository.instance
    @Published var state: HomeState = .Normal {
        willSet {
            if newValue == .Add {
                newGratitudeViewModel = GratitudeViewModel(GratitudeModel())
            } else if newValue == .Read {
                gratitudeRepository.read()
                guard gratitudeRepository.loaded && !gratitudeRepository.gratitudes.isEmpty else { return self.setHomeState(.Normal) }
                showGratitudeViewModel = GratitudeViewModel(gratitudeRepository.gratitudes.randomElement()!)
            }
        }
    }
    
    @Published var newGratitudeViewModel = GratitudeViewModel(GratitudeModel())
    @Published var showGratitudeViewModel = GratitudeViewModel(GratitudeModel())
    @Published var rippedColor: GratitudeColor = .White
    
    @Published var canShowGratitude = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func setHomeState(_ state: HomeState) {
        if self.state == state { return }
        withAnimation {
            self.state = state
            updateRippedColor()
            updateShowGratitude()
        }
    }
    
    func createGratitude() {
        if (!newGratitudeViewModel.text.isEmpty) {
            setHomeState(.Normal)
            gratitudeRepository.create(newGratitudeViewModel.gratitude)
        }
    }
    
    func updateShowGratitude() {
        DispatchQueue.main.async { self.canShowGratitude = self.isState(.Normal) && !self.gratitudeRepository.gratitudes.isEmpty }
    }
    
    func updateRippedColor() {
        switch state {
        case .Normal:
            self.rippedColor = .White
        case .Add:
            self.rippedColor = newGratitudeViewModel.color
        case .Read:
            self.rippedColor = showGratitudeViewModel.color
        }
    }
    
    func isState(_ state: HomeState ) -> Bool { self.state == state }
    
    func setNewColor(_ color: GratitudeColor) {
        withAnimation {
            newGratitudeViewModel.gratitude.gratitudeColor = color
            updateRippedColor()
        }
    }
    
    init() {
        gratitudeRepository.$gratitudes.sink { _ in self.updateShowGratitude() }.store(in: &cancellables)
        self.updateShowGratitude()
    }
}
