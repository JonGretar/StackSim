import SwiftUI
import SceneKit

class SegmentedTree : SCNNode {
    override init() {
        super.init()
        let subnode = SCNNode()
               
        for i in 0..<10 {
            let radius = 0.2 + (Double(i) / 200.0)
            let segment = Double(i) * 0.3 
            let cylinder = SCNCylinder(radius: radius, height: 0.5)
            let cylinderNode = SCNNode(geometry: cylinder)
            cylinderNode.position = SCNVector3(0, segment-1.5, 0)
            subnode.addChildNode(cylinderNode)
        }
        
        self.addChildNode(subnode)
        

        let treePhysics = SCNPhysicsBody(
            type: .dynamic, 
            shape: SCNPhysicsShape(node: subnode.flattenedClone(), options: [
                .collisionMargin: 0.0,
                .scale: SCNVector3(0.9, 0.95, 0.9),
                .keepAsCompound: true
            ])
        )
        treePhysics.mass = 100
        treePhysics.rollingFriction = 0.8
        treePhysics.friction = 1
        //treePhysics.centerOfMassOffset = SCNVector3(0,2,0)

        
        //self.geometry = node
        self.physicsBody = treePhysics
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
