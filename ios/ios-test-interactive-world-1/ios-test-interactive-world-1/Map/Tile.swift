//
//  Tile.swift
//  ios-test-level-map-1
//
//  Created by Louie on 10/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation
import SceneKit

protocol TileProtocol {
    
    var dataId: Int { get }
}

class Tile: SCNNode, TileProtocol {
    
    // MARK: Properties
    
    private(set) var dataId: Int
    
    // MARK: Initialisers
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    init(dataId _dataId: Int) {
        
        self.dataId = _dataId
        
        super.init()
        
        if self.dataId == 0 {
            
            self.geometry = createPlaneGeometry()
            let rotateBy = -90 / 180 * Double.pi // Angle to make plane flat
            self.rotation = SCNVector4(1, 0, 0, rotateBy)
        }
        else {
            
            self.geometry = createCubeGeometry(color: UIColor.blue, size: 1)
            self.position.y = 0.5
        }
    }
}
