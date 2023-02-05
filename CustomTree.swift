import SwiftUI
import SceneKit

class CustomTree : SCNNode {
    override init() {
        super.init()
        
        // Define the number of sides of the cylinder
        let sides = 64
        let height = 3.0
        let bottomRadius = 0.5
        let topRadius = 0.4
        
        // Create an array to store the cylinder's vertices
        var vertexData = [SCNVector3]()
        
        // Generate the bottom vertex
        for i in 0...sides {
            let angle = Double(i) / Double(sides) * Double.pi * 2.0
            let x = bottomRadius * cos(angle)
            let y = bottomRadius * sin(angle)
            vertexData.append(SCNVector3(x, y, 0))
        }
        
        // Generate the top vertex
        for i in 0...sides {
            let angle = Double(i) / Double(sides) * Double.pi * 2.0
            let x = topRadius * cos(angle)
            let y = topRadius * sin(angle)
            vertexData.append(SCNVector3(x, y, height))
        }
        
        // Create an array to store the cylinder's indices
        var indexData = [UInt16]()
        
        // Generate the indices for the bottom and top faces
        for i in 0..<sides {
            indexData.append(UInt16(i))
            indexData.append(UInt16((i + 1) % sides))
            indexData.append(UInt16(sides + (i + 1) % sides))
            
            indexData.append(UInt16(i))
            indexData.append(UInt16(sides + (i + 1) % sides))
            indexData.append(UInt16(sides + i))
        }
        
        // Generate the indices for the side faces
        for i in 0..<sides {
            let ui = UInt16(i)
            let usides = UInt16(sides)
            indexData.append(ui)
            indexData.append(UInt16((ui + UInt16(1) ) % usides))
            indexData.append(UInt16((ui + UInt16(1)) % usides) + usides)
            
            indexData.append(UInt16(ui))
            indexData.append(UInt16((ui + UInt16(1)) % usides) + usides)
            indexData.append(UInt16(ui) + usides)
        }
        
        let vertexSource = SCNGeometrySource(vertices: vertexData)
        let indexElement = SCNGeometryElement(indices: indexData, primitiveType: .triangles)
        let treeGeometry = SCNGeometry(sources: [vertexSource], elements: [indexElement])
        
        
        let treePhysicsShape = SCNPhysicsShape(geometry: treeGeometry, options: [
            .collisionMargin: 0.0,
            .keepAsCompound: true
        ])
                                               
        let treePhysics = SCNPhysicsBody(
            type: .dynamic, 
            shape: treePhysicsShape
        )
        
        treePhysics.rollingFriction = 1.0
        //        treephys.friction = 1.0
        //        treephys.restitution = 0.0
        //        treephys.angularDamping = 1.0
        //        treephys.damping = 0.8
        treePhysics.mass = 100
        treePhysics.angularRestingThreshold = 1
        treePhysics.linearRestingThreshold = 1
        
        let bark = UIImage(named: "bark.jpg")
        let barkMaterial = SCNMaterial()
        barkMaterial.diffuse.contents = bark
        barkMaterial.diffuse.wrapS = SCNWrapMode.repeat
        barkMaterial.diffuse.wrapT = SCNWrapMode.repeat
        barkMaterial.lightingModel = .phong
        treeGeometry.materials = [barkMaterial]
        
        
        self.geometry = treeGeometry
        self.physicsBody = treePhysics
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
