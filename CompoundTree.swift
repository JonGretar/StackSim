import SwiftUI
import SceneKit

class CompoundTree : SCNNode {
    override init() {
        super.init()
        
        let topRadius = CGFloat.random(in: 0.20..<0.30)
        let bottomRadius = CGFloat.random(in: 0.20..<0.30)
        let height = CGFloat.random(in: 3.5..<4.1)
        
        //create material for box geometry
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.brown
        material.lightingModel = .phong
        
        let topGeo = SCNCylinder(radius: topRadius, height: height/2)
        topGeo.materials = [material]
        let top = SCNNode(geometry: topGeo)
        
        top.position = SCNVector3Make(0, 1, 0)
        
        let bottomGeo = SCNCylinder(radius: bottomRadius, height: height/2)
        bottomGeo.materials = [material]
        
        let bottom = SCNNode(geometry: bottomGeo)
        bottom.position = SCNVector3Make(0, -0.9, 0)
        bottom.localRotate(by: SCNQuaternion(x: 0, y: 0, z: 0.1, w: 0.1))
        
        self.addChildNode(top)
        self.addChildNode(bottom)
        
        let treePhysics = SCNPhysicsBody(
            type: .dynamic, 
            shape: SCNPhysicsShape(node: self, options: [:])
        )
        
        treePhysics.mass = 100
        treePhysics.rollingFriction = 0.7
        treePhysics.friction = 1.0
        treePhysics.restitution = 0.5
        treePhysics.angularDamping = 0.1
        treePhysics.damping = 0.8
        treePhysics.mass = 40
        treePhysics.angularRestingThreshold = 1
        treePhysics.linearRestingThreshold = 1
        treePhysics.momentOfInertia = SCNVector3(1, 0, 0)
        
        self.physicsBody = treePhysics
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
