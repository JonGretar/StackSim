import SwiftUI
import SceneKit

class BasicTree : SCNNode {
    override init() {
        super.init()
        
        let treeGeometry = SCNCylinder(
            radius: CGFloat.random(in: 0.20..<0.30),
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
            shape: nil
        )
        treePhysics.rollingFriction = 0.6
        treePhysics.friction = 1.0
        //        treePhysics.restitution = 0.0
        //        treePhysics.angularDamping = 1.0
        treePhysics.damping = 0.3
        treePhysics.mass = 100
        treePhysics.angularRestingThreshold = 1
        treePhysics.linearRestingThreshold = 1
        
        self.geometry = treeGeometry
        self.physicsBody = treePhysics
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
