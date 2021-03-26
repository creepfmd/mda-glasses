//
//  ContentView.swift
//  Glasses Try Out
//
//  Created by Сергей on 26.03.2021.
//

import ARKit
import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func createBox() -> Entity {
        let mesh = MeshResource.generateBox(size: 0.15)
        let entity = ModelEntity(mesh: mesh)
        return entity
    }
    
    func createCircle(x: Float = 0, y: Float = 0, z: Float = 0) -> Entity {
        let mesh = MeshResource.generateBox(size: 0.05, cornerRadius: 0.025)
        
        let material = SimpleMaterial(color: .blue, isMetallic: true)
        
        let entity = ModelEntity(mesh: mesh, materials: [material])
        entity.position = SIMD3(x, y, z)
        entity.scale.x = 1.1
        entity.scale.z = 0.01
        
        return entity
    }
    
    func createSphere(x: Float = 0, y: Float = 0, z: Float = 0, color: UIColor = .red, radius: Float = 0.05) -> Entity {
        let mesh = MeshResource.generateSphere(radius: radius)
        
        let material = SimpleMaterial(color: color, isMetallic: true)
        
        let entity = ModelEntity(mesh: mesh, materials: [material])
        entity.position = SIMD3(x, y, z)
        return entity
    }
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        guard ARFaceTrackingConfiguration.isSupported else {
            print("Your device doesn't support face recognition")
            return arView
        }
        
        // face tracking with front camera
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        arView.session.run(configuration, options: [])
        
        // face anchor
        let faceAnchor = AnchorEntity(.face)
        faceAnchor.addChild(createCircle(x: 0.035, y: 0.025, z: 0.06))
        faceAnchor.addChild(createCircle(x: -0.035, y: 0.025, z: 0.06))
        faceAnchor.addChild(createSphere(z: 0.06, radius: 0.025))
        
        arView.scene.anchors.append(faceAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
