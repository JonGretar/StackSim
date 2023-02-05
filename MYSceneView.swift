import SwiftUI
import SceneKit

struct MYSceneView: View {
    
    let ezscene = EZScene() //creates the scene, camera and viewOptions
    @State private var boxDistance: Double = 7
    
    @StateObject var coordinator = SceneCoordinator()
    
    var body: some View {
        VStack {
            
            SceneView(
                scene: ezscene.scene,
                pointOfView: ezscene.camera,
                options: ezscene.viewOptions,
                delegate: coordinator
            )
            
            HStack { //manipulate the scene
                Button("Clear Trees") {
                    // ezscene.scene.rootNode.geometry = nil
                    ezscene.treeScene.childNodes.forEach { node in
                        node.removeFromParentNode()
                    }
                }
                Spacer()
                Button("BasicTree") {
                    // ezscene.scene.rootNode.geometry = nil
                    for _ in 1..<10 {
                        ezscene.createAndPutTreeOnRoot(BasicTree())
                    }
                }
                Button("SegmentedTree") {
                    for _ in 1..<10 {
                        ezscene.createAndPutTreeOnRoot(SegmentedTree())
                    }
                }
                Button("CompoundTree") {
                    for _ in 1..<10 {
                        ezscene.createAndPutTreeOnRoot(CompoundTree())
                    }
                }
                Button("ComplexTree") {
                    for _ in 1..<10 {
                        ezscene.createAndPutTreeOnRoot(ComplexTree())
                    }
                }
                Spacer()
                Button("Add Box") {
                    ezscene.addBox(zpos: -Float(boxDistance))
                    ezscene.addBox(zpos: Float(boxDistance))
                }
            }
            Slider(value: $boxDistance, in: 5...50)
        }
    }
    
}



class EZScene {
    
    let scene: SCNScene
    let camera: SCNNode
    let viewOptions: SceneView.Options
    let treeScene: SCNNode
    
    init() {
        
        //create the stuff for SceneView
        scene = SCNScene()
        treeScene = SCNNode()
        
        camera = SCNNode()
        camera.camera = SCNCamera()
        camera.position = SCNVector3(x: 0, y: 3, z: 15)
        
        viewOptions = [
            .allowsCameraControl,
            .autoenablesDefaultLighting,
            .temporalAntialiasingEnabled
        ]
        
        //set up the scene object
        scene.background.contents = UIColor.blue
        
        // Set up child scene for trees.
        scene.rootNode.addChildNode(treeScene)
        
        
        //createAndPutBoxOnRoot()
        createPlane()
    }
    
    func createPlane() {
        
        let grass = UIImage(named: "grass.jpeg")
        let material = SCNMaterial()
        material.diffuse.contents = grass
        material.lightingModel = .phong
        material.diffuse.contentsTransform = SCNMatrix4MakeScale(100.0, 100.0, 1)
        material.diffuse.wrapS = SCNWrapMode.repeat
        material.diffuse.wrapT = SCNWrapMode.repeat
        
        let floor = SCNFloor()
        floor.reflectionFalloffEnd = 10
        floor.reflectivity = 0.05
        floor.materials = [material]
        
        let floorNode = SCNNode(geometry: floor)
        floorNode.position = SCNVector3(x: 0, y: -0.1, z: 0)
        
        let physics = SCNPhysicsBody(
            type: .static, 
            shape: SCNPhysicsShape(geometry: SCNBox(width:1000, height:0.2, length:1000, chamferRadius: 0))
        )
        physics.rollingFriction = 1.0
        physics.friction = 1.0
        
        floorNode.physicsBody = physics
        
        scene.rootNode.addChildNode(floorNode)
        
    }
    
    func addBox(zpos: Float) {
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.systemGreen
        material.lightingModel = .phong
        material.transparency = 0.1
        
        let box1 = SCNBox(width: 4.0, height: 2.0, length: 2.0, chamferRadius: 0.1)
        box1.materials = [material]
        
        let box1Node = SCNNode()
        box1Node.geometry = box1
        box1Node.position = SCNVector3(x:0, y:0, z:zpos)
        
        box1Node.physicsBody = SCNPhysicsBody(
            type: .static, 
            shape: nil
        )
        
        scene.rootNode.addChildNode(box1Node)
    }
    
    func createAndPutTreeOnRoot(_ node: SCNNode ) {
        
        let newNode = node
        
        newNode.position = SCNVector3(
            x:0, 
            y:highestPoint() + 1,
            z:Float.random(in: -4.0..<4.0)
        )
        newNode.localRotate(by: SCNQuaternion(x: 0, y: 0, z: 0.7071, w: 0.7071))
        
        treeScene.addChildNode(newNode)
    }
    
    func highestPoint() -> Float {
        print("Enumerating Positions")
        var highest = Float(0.0)
        self.treeScene.enumerateChildNodes({ (node, umPoint) in
            if (node.presentation.position.y > highest) {
                highest = node.presentation.position.y
            }
            //print("Poisiton: ", node.presentation.position.y )
        })
        return highest
    }
    
}


class SceneCoordinator: NSObject, SCNSceneRendererDelegate, ObservableObject {
    
    var showsStatistics: Bool = true
    var debugOptions: SCNDebugOptions = [
        .showPhysicsShapes,
        .showPhysicsFields
    ]
    
    lazy var theScene: SCNScene = {
        // create a new scene
        let scene = SCNScene()
        
        //...
        
        return scene
    }()
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        renderer.showsStatistics = self.showsStatistics
        renderer.debugOptions = self.debugOptions
    }
}
