//
//  Map.swift
//  ios-test-level-map-1
//
//  Created by Louie on 9/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation
import SceneKit

protocol MapProtocol {
    
    var map: Array<Int> { get }
    var mapWidth: Int { get }
    var mapHeight: Int { get }
    
    func mapToTileNodes()
}

/**
 * The coordinate orientation appears to be (with the right hand rule):
 * positive x is the back vector,
 * positive y is the up vector,
 * positive z is the left vector
 *
 * To be implemented
 * - point to node (hit test): requires gesture component
 * - proper data model for tile-type ids
 */
class Map: SCNNode, MapProtocol {
    
    // Properties
    
    private(set) var map: Array<Int>
    private(set) var mapWidth: Int
    private(set) var mapHeight: Int
    
    // MARK: Initialiser
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        
        self.map = [
        
            0, 1, 0, 0, 0,
            0, 0, 1, 0, 0,
            0, 0, 0, 1, 0,
            0, 0, 0, 1, 0,
            0, 0, 0, 0, 0
        
        ]
        
        self.mapWidth = 5
        self.mapHeight = 5
        
        super.init()
        
//        self.position = SCNVector3(x: 0.5, y: 0, z: 0.5)
        self.mapToTileNodes()
    }
    
    func mapToTileNodes() {
        
        for row in 0..<self.mapHeight {
            
            for column in 0..<self.mapWidth {
                
                let dataId = self.map[column + (row * self.mapWidth)]
                let tile = Tile(dataId: dataId)
                tile.position.x = Float(row)
                tile.position.z = Float(column)
                self.addChildNode(tile)
            }
        }
    }
}
