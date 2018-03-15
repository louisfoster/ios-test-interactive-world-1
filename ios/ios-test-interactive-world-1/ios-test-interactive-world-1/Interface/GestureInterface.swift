//
//  GestureInterface.swift
//  ios-test-input-system-1
//
//  Created by Louie on 11/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit
import SceneKit

class GestureInterface: SelectIntentSenderProtocol, HorizontalScrollIntentSenderProtocol {
    
    // MARK: Properties
    
    private(set) var sceneView: SCNView?
    
    // MARK: Initializers
    
    init(sceneView _sceneView: SCNView?) {
        
        self.sceneView = _sceneView
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(GestureInterface.handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.sceneView?.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(GestureInterface.handlePan(_:)))
        panGesture.maximumNumberOfTouches = 1
        self.sceneView?.addGestureRecognizer(panGesture)
    }
    
    // MARK: Actions
    
    @objc
    func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        let point = gestureRecognizer.location(in: self.sceneView)
        if let hitTestResults = self.sceneView?.hitTest(point, options: [:]) {
        
            self.sendSelectIntent(SelectIntentData(hitTestResults: hitTestResults))
        }
    }
    
    @objc
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: self.sceneView)
        
        self.sendHorizontalScrollIntent(HorizontalScrollIntentData(translation: Float(translation.x), gestureStateEnded: gestureRecognizer.state == UIGestureRecognizerState.ended))
    }
}
