//
//  JarViewModel.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 30/09/21.
//

import Foundation
import Combine
import SpriteKit

class JarViewModel: ObservableObject {
    @Published var gratitudeRepository = GratitudeRepository.instance
    @Published var motionService = MotionService()
    @Published var scene: JarScene
    
    private var cancellables = Set<AnyCancellable>()
    
    func handleGratitudes(_ gratitudes: [GratitudeModel]) {
        let toAdd = gratitudes.filter { !self.scene.has(gratitude: $0)}
        let toUpdate = gratitudes.filter { self.scene.has(gratitude: $0) }
        
        let toDelete = self.scene.children.filter{ node in
            let isSprite = node is SKSpriteNode
            let notBaseNodes = !["Jar", "Mask"].contains(node.name)
            let notOnDB = !gratitudes.map {$0.id}.contains(node.name)
            return isSprite && notBaseNodes && notOnDB
        }.map { $0.name! }
        
        for (index, gratitude) in toAdd.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1, execute: { self.scene.add(gratitude: gratitude) })
        }
        
        for gratitude in toUpdate { self.scene.update(gratitude: gratitude) }
        
        for gid in toDelete { self.scene.delete(gratitudeId: gid) }
    }
    
    
    init() {
        scene = SKScene(fileNamed: "JarScene")! as! JarScene
        scene.scaleMode = SKSceneScaleMode.aspectFit
        
        motionService.$vector.sink { self.scene.onMotion($0) }.store(in: &cancellables)
        
        gratitudeRepository.$gratitudes.sink(receiveValue: handleGratitudes(_ :)).store(in: &cancellables)
    }
}
