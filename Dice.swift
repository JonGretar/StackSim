import SwiftUI
import SceneKit

class Dice : SCNNode {
    override init() {
        super.init()
        
        let vertices: [SCNVector3] = [
            SCNVector3(0, 1, 0),
            SCNVector3(-0.5, 0, 0.5),
            SCNVector3(0.5, 0, 0.5),
            SCNVector3(0.5, 0, -0.5),
            SCNVector3(-0.5, 0, -0.5),
            SCNVector3(0, -1, 0),
        ]
        
        let source = SCNGeometrySource(vertices: vertices)
        
        let indices: [UInt16] = [
            0, 1, 2,
            2, 3, 0,
            3, 4, 0,
            4, 1, 0,
            1, 5, 2,
            2, 5, 3,
            3, 5, 4,
            4, 5, 1
        ]
    
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangles)
        let geometry = SCNGeometry(sources: [source], elements: [element])
        
        let physics = SCNPhysicsBody(
            type: .dynamic, 
            shape: SCNPhysicsShape(geometry: geometry, options: [:])
        )
        
        self.geometry = geometry
        self.physicsBody = physics
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
