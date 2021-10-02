//
//  JarScene.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 30/09/21.
//

import Foundation
import SpriteKit

class JarScene: SKScene {
    
    func add(gratitude: GratitudeModel) {
        if children.contains(where: { $0.name == gratitude.id }) || children.count > 75 { return }
        let node = SKSpriteNode(imageNamed: gratitude.gratitudeColor.foldedImage)
        node.position = CGPoint(x: 0, y: 320)
        node.name = gratitude.id
        let body = SKPhysicsBody(rectangleOf: node.size)
        body.restitution = 0.5
        node.physicsBody = body
        self.addChild(node)
    }
    
    func update(gratitude: GratitudeModel) {
        if let node = children.first(where: { $0.name == gratitude.id }) as? SKSpriteNode {
            node.texture = SKTexture(imageNamed: gratitude.gratitudeColor.foldedImage)
        }
    }
    
    func delete(gratitudeId: String) {
        if let node = children.first(where: { $0.name == gratitudeId }) as? SKSpriteNode {
            node.removeFromParent()
        }
    }
    
    func has(gratitude: GratitudeModel) -> Bool {
        if children.count > 75 { return true }
        
        for child in children { if child.name == gratitude.id { return true } }
        return false
    }
    
    func onMotion(_ vector: CGVector) {
#if targetEnvironment(simulator)
        return
#else
        self.physicsWorld.gravity = vector
#endif
    }
}
