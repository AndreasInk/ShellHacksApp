//
//  SceneView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

#if os(iOS)
import SwiftUI
import SceneKit
import SceneKit.ModelIO
struct SceneView: UIViewRepresentable {
   
   @State var animations = [String: CAAnimation]()
    
    var options: [Any]
 
    var view = SCNView()
@State var alreadyBaad = false
    @State var alreadyGood = false
    func makeUIView(context: Context) -> SCNView {
//        let tempAudioSource = SCNAudioSource(fileNamed: "fireplace.mp3")!
//        tempAudioSource.volume = 0.5
//        tempAudioSource.rate = 0.1
//        tempAudioSource.loops = true
//        tempAudioSource.isPositional = true
//        tempAudioSource.shouldStream = false
//        tempAudioSource.load()            //loads audio data and prepares it for playing...
//        let player = SCNAudioPlayer(source: tempAudioSource)
       
        // Instantiate the SCNView and setup the scene
        view.scene = SCNScene(named: "Idlev2.scn")!
        //view.scene = SCNScene(named: "trophy.dae")!
        ///view.scene?.rootNode.addAudioPlayer(player)
        view.scene?.rootNode.scale = SCNVector3(x: 0.8, y: 0.8, z: 0.8)
        view.scene?.fogColor = UIColor.clear
        view.backgroundColor = UIColor.clear
        view.autoenablesDefaultLighting = true
        view.scene?.background.contents = [UIColor.clear]
        view.scene?.rootNode.position = SCNVector3(x: -55, y: 0, z: 0)
        //view.scene?.rootNode.animationPlayer(forKey: "<untitled animation>")?.stop()
       // view.scene?.rootNode.childNode(withName: "gold_trophie_01-2-1-obj-cleaner-materialmerger-gles", recursively: true)?.runAction(SCNAction.rotateBy(x: 10, y: 0.1, z: 5, duration: TimeInterval(120)))
        //loadAnimations()
       
        //loadAnimation(withKey: "Wavingv2-1", sceneName: "Wavingv2", animationIdentifier: "Wavingv2-1")
        var lastAnimationType = AnimationType.None
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if lastAnimationType != animationType {
            switch animationType {
            case .Walking:
               
                loadAnimation(withKey: "Climbingv2-1", sceneName: "Climbingv2", sceneType: "dae", animationIdentifier: "Climbingv2-1", loop: false)
               
               
                //view.scene?.rootNode.runAction( SCNAction.move(to: SCNVector3(x: 0, y: 0, z: 0), duration: TimeInterval(2.2)))
                lastAnimationType = .Walking
                break
            case .Cheering:
                
                
                loadAnimation(withKey: "Cheeringv2-1", sceneName: "Cheeringv2", sceneType: "dae", animationIdentifier: "Cheeringv2-1", loop: false)
                lastAnimationType = .Cheering
                
                break
            case .PointBackwards:
               
                loadAnimation(withKey: "Pointingv2-1", sceneName: "Pointingv2", sceneType: "dae", animationIdentifier: "Pointingv2-1", loop: false)
                lastAnimationType = .PointBackwards
                
                break
            case .ThumbsUp:
               
                loadAnimation(withKey: "ThumbsUpv2-1", sceneName: "ThumbsUpv2", sceneType: "dae", animationIdentifier: "ThumbsUpv2-1", loop: false)
                lastAnimationType = .ThumbsUp
                
                break
            case .Waving:
             
                loadAnimation(withKey: "Wavingv2-1", sceneName: "Wavingv2", sceneType: "dae", animationIdentifier: "Wavingv2-1", loop: false)
                lastAnimationType = .Waving
                
                break
            case .Sitting:
               
                loadAnimation(withKey: "Sittingv2-1", sceneName: "Sittingv2", sceneType: "dae", animationIdentifier: "Sittingv2-1", loop: false)
                lastAnimationType = .Sitting
                
                break
            case .None:
                break
            }
            }
        }
        
        return view
    }
    func getDocumentsDirectory() -> URL {
            // find all possible documents directories for this user
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
            // just send back the first one, which ought to be the only one
            return paths[0]
        }
    func updateUIView(_ view: SCNView, context: Context) {
        
    }
//    func loadAnimations() {
//       // Load the character in the idle animation
//       let idleScene = SCNScene(named: "Sitting-2v2.scn")!
//
//       // This node will be parent of all the animation models
//       let node = SCNNode()
//
//       // Add all the child nodes to the parent node
//       for child in idleScene.rootNode.childNodes {
//         node.addChildNode(child)
//       }
//
//       // Set up some properties
//       //node.position = SCNVector3(0, -1, -2)
//       //node.scale = SCNVector3(0.5, 0.5, 0.5)
//
//       // Add the node to the scene
//        view.scene?.rootNode.addChildNode(node)
//        //view.scene?.rootNode.position = SCNVector3(x: 100, y: 0, z: 0)
//
//       // Load all the DAE animations
//       loadAnimation(withKey: "Sitting-3v2-1", sceneName: "Sitting-3v2", animationIdentifier: "Sitting-3v2-1")
//        playAnimation(key: "Sitting-3v2-1")
//     }
    func playAnimation(key: String) {
          // Add the animation to start playing it right away
        print(animations)
        if let scene = view.scene {
            scene.rootNode.addAnimation(animations[key]!, forKey: key)
        }
    }

    func loadAnimation(withKey: String, sceneName:String, sceneType: String, animationIdentifier:String, loop: Bool) {
        let sceneURL = Bundle.main.url(forResource: sceneName, withExtension: sceneType)
        let sceneSource = SCNSceneSource(url: sceneURL!, options: [.animationImportPolicy: SCNSceneSource.AnimationImportPolicy.doNotPlay])!
//print(sceneSource.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self))
        print(sceneSource)
        if let animationObject = sceneSource.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self) {
          // The animation will only play once
           
            animationObject.repeatCount = loop ? 2 : 0
            
       
          // To create smooth transitions between animations
            animationObject.fadeInDuration = CGFloat(0.5)
            animationObject.fadeOutDuration = CGFloat(0.5)
        animationObject.autoreverses =  false
        //view.scene?.rootNode.addAnimation(animationObject, forKey: withKey)
          // Store the animation for later use
          animations[withKey] = animationObject
            if let scene = view.scene {
                scene.rootNode.addAnimation(animationObject, forKey: withKey)
            }
        }
      }
    func makeCoordinator() -> Coordinator {
        Coordinator(view)
    }
    
    class Coordinator: NSObject {
        private let view: SCNView
        init(_ view: SCNView) {
            self.view = view
            
            super.init()
        }
        
        @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
            // check what nodes are tapped
            let p = gestureRecognize.location(in: view)
            let hitResults = view.hitTest(p, options: [:])
            
            // check that we clicked on at least one object
            if hitResults.count > 0 {
                
                // retrieved the first clicked object
               
                for result in hitResults.filter( { $0.node.name != "g0" }) {
                    result.node.removeFromParentNode()
                // get material for selected geometry element
                let material = result.node.geometry!.materials[(result.geometryIndex)]
                
                // highlight it
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                // on completion - unhighlight
                SCNTransaction.completionBlock = {
                    SCNTransaction.begin()
                    SCNTransaction.animationDuration = 0.5
                    
                   // material.emission.contents = UIColor.black
                  
                    SCNTransaction.commit()
                }
                material.emission.contents = UIColor.green
                SCNTransaction.commit()
                  
            }
        }
    }
    }
    func vertices(node:SCNNode) -> [SCNVector3] {
        let vertexSources = node.geometry?.sources(for: SCNGeometrySource.Semantic.vertex)
        if let vertexSource = vertexSources?.first {
            let count = vertexSource.data.count / MemoryLayout<SCNVector3>.size
            return vertexSource.data.withUnsafeBytes {
                [SCNVector3](UnsafeBufferPointer<SCNVector3>(start: $0, count: count))
            }
        }
        return []
    }
}
class Thing: ObservableObject {
    @Published var gestureOn: Bool = false
    @Published var scene: SCNScene = SCNScene()
    @Published var export: Bool = false
    @Published var nodes: [SCNNode] = [SCNNode]()
}

#elseif os(MacOS)
import SwiftUI
import SceneKit
import SceneKit.ModelIO
struct SceneView: NSViewRepresentable {
   
   @State var animations = [String: CAAnimation]()
    
    var options: [Any]
 
    var view = SCNView()
@State var alreadyBaad = false
    @State var alreadyGood = false
    func makeNSView(context: Context) -> SCNView {
        let tempAudioSource = SCNAudioSource(fileNamed: "fireplace.mp3")!
        tempAudioSource.volume = 0.5
        tempAudioSource.rate = 0.1
        tempAudioSource.loops = true
        tempAudioSource.isPositional = true
        tempAudioSource.shouldStream = false
        tempAudioSource.load()            //loads audio data and prepares it for playing...
        let player = SCNAudioPlayer(source: tempAudioSource)
       
        // Instantiate the SCNView and setup the scene
        view.scene = SCNScene(named: "Sitting-2v2.scn")!
        //view.scene = SCNScene(named: "trophy.dae")!
        view.scene?.rootNode.addAudioPlayer(player)
       
        view.scene?.fogColor = UIColor.clear
        view.backgroundColor = UIColor.clear
        view.autoenablesDefaultLighting = true
        view.scene?.background.contents = [UIColor.clear]
       
        //view.scene?.rootNode.animationPlayer(forKey: "<untitled animation>")?.stop()
       // view.scene?.rootNode.childNode(withName: "gold_trophie_01-2-1-obj-cleaner-materialmerger-gles", recursively: true)?.runAction(SCNAction.rotateBy(x: 10, y: 0.1, z: 5, duration: TimeInterval(120)))
        //loadAnimations()
       
        //loadAnimation(withKey: "Wavingv2-1", sceneName: "Wavingv2", animationIdentifier: "Wavingv2-1")
        
        let timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
//        if badPosture {
//            if !alreadyBaad {
//            loadAnimation(withKey: "Sitting-6v2-1", sceneName: "Sitting-6v2", sceneType: "dae", animationIdentifier: "Sitting-6v2-1")
//            alreadyBaad = true
//                alreadyGood = false
//            }
//        } else {
//            if !alreadyGood {
//            loadAnimation(withKey: "SittingIdlev2-1", sceneName: "SittingIdlev2", sceneType: "dae", animationIdentifier: "SittingIdlev2-1")
//            //view.scene!.rootNode.animationPlayer(forKey: "Sitting-6v2-1")?.stop()
//                alreadyBaad = false
//            alreadyGood  = true
//            }
//        }
        }
        
        return view
    }
    func getDocumentsDirectory() -> URL {
            // find all possible documents directories for this user
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
            // just send back the first one, which ought to be the only one
            return paths[0]
        }
    func updateNSView(_ view: SCNView, context: Context) {
        
    }
//    func loadAnimations() {
//       // Load the character in the idle animation
//       let idleScene = SCNScene(named: "Sitting-2v2.scn")!
//
//       // This node will be parent of all the animation models
//       let node = SCNNode()
//
//       // Add all the child nodes to the parent node
//       for child in idleScene.rootNode.childNodes {
//         node.addChildNode(child)
//       }
//
//       // Set up some properties
//       //node.position = SCNVector3(0, -1, -2)
//       //node.scale = SCNVector3(0.5, 0.5, 0.5)
//
//       // Add the node to the scene
//        view.scene?.rootNode.addChildNode(node)
//        //view.scene?.rootNode.position = SCNVector3(x: 100, y: 0, z: 0)
//
//       // Load all the DAE animations
//       loadAnimation(withKey: "Sitting-3v2-1", sceneName: "Sitting-3v2", animationIdentifier: "Sitting-3v2-1")
//        playAnimation(key: "Sitting-3v2-1")
//     }
    func playAnimation(key: String) {
          // Add the animation to start playing it right away
        print(animations)
        if let scene = view.scene {
            scene.rootNode.addAnimation(animations[key]!, forKey: key)
        }
    }

    func loadAnimation(withKey: String, sceneName:String, sceneType: String, animationIdentifier:String) {
        let sceneURL = Bundle.main.url(forResource: sceneName, withExtension: sceneType)
        let sceneSource = SCNSceneSource(url: sceneURL!, options: [.animationImportPolicy: SCNSceneSource.AnimationImportPolicy.doNotPlay])!
//print(sceneSource.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self))
        print(sceneSource)
        if let animationObject = sceneSource.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self) {
          // The animation will only play once
        animationObject.repeatCount = .infinity
          // To create smooth transitions between animations
          animationObject.fadeInDuration = CGFloat(1)
          animationObject.fadeOutDuration = CGFloat(1)
        animationObject.autoreverses = true
        //view.scene?.rootNode.addAnimation(animationObject, forKey: withKey)
          // Store the animation for later use
          animations[withKey] = animationObject
            if let scene = view.scene {
                scene.rootNode.addAnimation(animationObject, forKey: withKey)
            }
        }
      }
    func makeCoordinator() -> Coordinator {
        Coordinator(view)
    }
    
    class Coordinator: NSObject {
        private let view: SCNView
        init(_ view: SCNView) {
            self.view = view
            
            super.init()
        }
        
        @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
            // check what nodes are tapped
            let p = gestureRecognize.location(in: view)
            let hitResults = view.hitTest(p, options: [:])
            
            // check that we clicked on at least one object
            if hitResults.count > 0 {
                
                // retrieved the first clicked object
               
                for result in hitResults.filter( { $0.node.name != "g0" }) {
                    result.node.removeFromParentNode()
                // get material for selected geometry element
                let material = result.node.geometry!.materials[(result.geometryIndex)]
                
                // highlight it
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                // on completion - unhighlight
                SCNTransaction.completionBlock = {
                    SCNTransaction.begin()
                    SCNTransaction.animationDuration = 0.5
                    
                   // material.emission.contents = UIColor.black
                  
                    SCNTransaction.commit()
                }
                material.emission.contents = UIColor.green
                SCNTransaction.commit()
                  
            }
        }
    }
    }
    func vertices(node:SCNNode) -> [SCNVector3] {
        let vertexSources = node.geometry?.sources(for: SCNGeometrySource.Semantic.vertex)
        if let vertexSource = vertexSources?.first {
            let count = vertexSource.data.count / MemoryLayout<SCNVector3>.size
            return vertexSource.data.withUnsafeBytes {
                [SCNVector3](UnsafeBufferPointer<SCNVector3>(start: $0, count: count))
            }
        }
        return []
    }
}
#endif

