//
//  Target.swift
//  ARPlebShooter
//
//  Created by Brent Piephoff on 7/26/17.
//  Copyright © 2017 Brent Piephoff. All rights reserved.
//

import UIKit
import SceneKit

// Floating boxes that appear around you
class Target: SCNNode {
    override init() {
        super.init()
        var geometry:SCNGeometry
        
        let scale: CGFloat=5.0
        switch ShapeType.random() {
        case .Box:
            geometry = SCNBox(width: 0.05*scale, height: 0.05*scale, length: 0.05*scale, chamferRadius: 0.0)
        case .Sphere:
            geometry = SCNSphere(radius: 0.025*scale)
        case .Capsule:
            geometry = SCNCapsule(capRadius: 0.015*scale, height: 0.035*scale)
        case .Cylinder:
            geometry = SCNCylinder(radius: 0.02*scale, height: 0.05*scale)
        case .Pyramid:
            geometry = SCNPyramid(width: 0.05*scale, height: 0.05*scale, length: 0.05*scale)
        case .Torus:
            geometry = SCNTorus(ringRadius: 0.02*scale, pipeRadius: 0.01*scale)
        case .Cone:
            geometry = SCNCone(topRadius: 0.01*scale, bottomRadius: 0.02*scale, height: 0.05*scale)
        case .Tube:
            geometry = SCNTube(innerRadius: 0.01*scale, outerRadius: 0.02*scale, height: 0.05*scale)
        }

        
        self.geometry = geometry
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        self.physicsBody?.isAffectedByGravity = false
        self.physicsBody?.charge = -0.5
        self.physicsBody?.categoryBitMask = CollisionCategory.target.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.bullets.rawValue
        self.physicsBody?.collisionBitMask = CollisionCategory.target.rawValue
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "abstract")
        self.geometry?.materials  = [material, material, material, material, material, material]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public enum ShapeType:Int {
    case Box = 0
    case Sphere
    case Capsule
    case Cylinder
    
    static func random() -> ShapeType {
        let maxValue = Cylinder.rawValue
        let rand = arc4random_uniform(UInt32(maxValue+1))
        return ShapeType(rawValue: Int(rand))!
    }
}
