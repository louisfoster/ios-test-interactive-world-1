//
//  Harness.swift
//  ios-test-camera-harness-1
//
//  Created by Louie on 10/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation
import SceneKit

protocol HarnessProtocol {
    
    var tracking: SCNNode { get }
    var subject: SCNNode { get }
}

class Harness: SCNNode {
    
    // centre tracking position of a given node
    // subject given max x,y distance from centre
    // input rotates centre
    // harness reacts to barriers, shrinking x distance from centre
    // lowers to side view, decreasing x,y from centre
    // enters first person...
    
    private(set) var tracking: SCNNode
    private(set) var subject: SCNNode
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    init(master _tracking: SCNNode, slave _subject: SCNNode) {
        
        self.tracking = _tracking
        self.subject = _subject
        
        super.init()
        
        self.addChildNode(self.subject)
        self.subject.position = SCNVector3(3.0, 8.0, 0)
        self.subject.look(at: self.tracking.position)
        
        self.tracking.addChildNode(self)
    }
    
    func runHelpers() {
        
        // Helper to prove attachment of subject to harness
        self.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: -1, z: 0, duration: 2)))
    }
}
