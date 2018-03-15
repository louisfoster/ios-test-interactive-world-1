//
//  Camera.swift
//  ios-test-interactive-world-1
//
//  Created by Louie on 15/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation
import SceneKit

class Camera: HorizontalScrollIntentObserverProtocol {
    
    var id: Int
    private var target: SCNNode
    private var camera: SCNNode
    private var harness: Harness
    private(set) var inputIntent: InputIntent?
    
    init(target _target: SCNNode, inputIntent _inputIntent: InputIntent?) {
        
        self.id = 0
        
        self.target = _target
        self.inputIntent = _inputIntent
        
        self.camera = SCNNode()
        self.camera.camera = SCNCamera()
        
        self.harness = Harness(master: self.target, slave: self.camera)
        
        self.registerHorizontalScrollIntentObserver()
    }
    
    func onHorizontalScrollIntent(horizontalScrollIntentData: HorizontalScrollIntentData) {
        
        // Set the rotation transform to the new matrix
        let x = horizontalScrollIntentData.translation
        let anglePan = abs(x) * (Float.pi / 180.0)
        // Invert due to screen/camera/harness/target relationship
        self.harness.transform = SCNMatrix4MakeRotation(anglePan, 0, -x, 0)
        
        // Preserve the pivot and transformation after pan has ended
        if horizontalScrollIntentData.gestureStateEnded {
            
            let currentPivot = self.harness.pivot
            let changePivot = SCNMatrix4Invert(self.harness.transform)
            self.harness.pivot = SCNMatrix4Mult(changePivot, currentPivot)
            self.harness.transform = SCNMatrix4Identity
        }
    }
}
