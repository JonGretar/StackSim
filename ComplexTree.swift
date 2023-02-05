import SwiftUI
import SceneKit

class ComplexTree : SCNNode {
    override init() {
        super.init()
        
        let treeGeometry = SCNCone(
            topRadius: CGFloat.random(in: 0.20..<0.30),
            bottomRadius: CGFloat.random(in: 0.20..<0.30),
            height: CGFloat.random(in: 3.5..<4.1)
        )
            
        
        let bark = UIImage(named: "bark.jpg")
        let barkMaterial = SCNMaterial()
        barkMaterial.diffuse.contents = bark
        barkMaterial.diffuse.wrapS = SCNWrapMode.repeat
        barkMaterial.diffuse.wrapT = SCNWrapMode.repeat
        barkMaterial.lightingModel = .phong
        
        let wood = UIImage(named: "rings.jpg")
        let woodMaterial = SCNMaterial()
        woodMaterial.diffuse.contents = wood
        woodMaterial.lightingModel = .phong
        
        treeGeometry.materials = [barkMaterial, woodMaterial, woodMaterial]
        
        
        let treePhysics = SCNPhysicsBody(
            type: .dynamic, 
            shape: SCNPhysicsShape(geometry: treeGeometry, options: [:])
        )
        
        treePhysics.mass = 100
        treePhysics.rollingFriction = 1.0
        treePhysics.friction = 1.0
        //        treephys.restitution = 0.0
        //        treephys.angularDamping = 1.0
        //        treephys.damping = 0.8
        treePhysics.angularRestingThreshold = 1
        treePhysics.linearRestingThreshold = 1
        
        self.geometry = treeGeometry
        self.physicsBody = treePhysics
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
