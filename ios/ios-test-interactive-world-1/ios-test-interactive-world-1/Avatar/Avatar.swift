//
//  Avatar.swift
//  ios-test-camera-harness-1
//
//  Created by Louie on 10/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation
import SceneKit

class Avatar: SCNNode {
    
    // MARK: Properties
    
    var model: SCNNode
    
    // MARK: Initialisers
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        
        let boxGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        
        // Assign a colour material for each side of the box
        let colors = [UIColor.green, // front
            UIColor.red, // right
            UIColor.blue, // back
            UIColor.yellow, // left
            UIColor.purple, // top
            UIColor.gray] // bottom
        
        let sideMaterials = colors.map { color -> SCNMaterial in
            let material = SCNMaterial()
            material.diffuse.contents = color
            material.locksAmbientWithDiffuse = true
            return material
        }
        
        boxGeometry.materials = sideMaterials
        
        self.model = SCNNode(geometry: boxGeometry)
        self.model.position.y = 0.5
        
        super.init()
        
        self.addChildNode(self.model)
    }
    
    func runHelpers() {
        
        // Helper for proof of decoupling from avatar's model
        self.model.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
        
        // Helper for proof of tracking
        self.runAction(
            SCNAction.repeatForever(
                SCNAction.sequence([
                    SCNAction.move(by: SCNVector3(3, 0, 3), duration: 4),
                    SCNAction.move(by: SCNVector3(-3, 0, -3), duration: 4)
                    ])
            )
        )
    }
}
