//
//  File.swift
//  ios-test-level-map-1
//
//  Created by Louie on 10/3/18.
//  Copyright © 2018 Louis Foster. All rights reserved.
//

import Foundation
import SceneKit

func createCubeObject(color: UIColor, size: CGFloat) -> SCNNode {
    
    return SCNNode(geometry: createCubeGeometry(color: color, size: size))
}

func createCubeGeometry(color: UIColor, size: CGFloat) -> SCNBox {
    
    let boxGeometry = SCNBox(width: size, height: size, length: size, chamferRadius: 0)
    let boxMaterial = SCNMaterial()
    boxMaterial.diffuse.contents = color
    boxGeometry.firstMaterial = boxMaterial
    
    return boxGeometry
}

func createPlaneObject() -> SCNNode {
    
    return SCNNode(geometry: createPlaneGeometry())
}

func createPlaneGeometry() -> SCNPlane {
    
    let planeGeometry = SCNPlane(width: 1, height: 1)
    let planeMaterial = SCNMaterial()
    planeMaterial.diffuse.contents = UIImage(named: "art.scnassets/texture.png")
    planeMaterial.diffuse.wrapS = .repeat
    planeMaterial.diffuse.wrapT = .repeat
    planeGeometry.firstMaterial = planeMaterial
    
    return planeGeometry
}
