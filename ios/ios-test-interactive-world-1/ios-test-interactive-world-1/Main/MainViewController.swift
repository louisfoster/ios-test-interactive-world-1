//
//  MainViewController.swift
//  ios-test-interactive-world-1
//
//  Created by Louie on 15/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import UIKit
import SceneKit

class MainViewController: UIViewController {

    @IBOutlet
    private var sceneView: SCNView?
    
    private var scene: SCNScene?
    private var inputIntent: InputIntent?
    private var map: Map?
    private var gestureInterface: GestureInterface?
    private var avatar: Avatar?
    private var camera: Camera?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.scene = SCNScene()
        
        self.map = Map()
        self.avatar = Avatar()
        self.avatar?.position.x = 0
        self.avatar?.position.z = 0
        self.inputIntent = InputIntent()
        
        if let m = self.map, let a = self.avatar {
            
            self.scene?.rootNode.addChildNode(m)
            self.scene?.rootNode.addChildNode(a)
            self.camera = Camera(target: a, inputIntent: self.inputIntent)
        }
        
        if let s = self.sceneView {
            
            self.gestureInterface = GestureInterface(sceneView: s)
        }
        
        self.sceneView?.showsStatistics = true
        self.sceneView?.backgroundColor = UIColor.black
        self.sceneView?.scene = scene
    }
}
