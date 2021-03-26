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
    
    func createSphere(x: Float = 0, y: Float = 0, z: Float = 0) -> Entity {
        let mesh = MeshResource.generateSphere(radius: 0.07)
        let entity = ModelEntity(mesh: mesh)
        entity.position = SIMD3(x, y, z)
        return entity
    }
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        guard ARFaceTrackingConfiguration.isSupported else {
            return arView
        }
        
        // face tracking with front camera
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        arView.session.run(configuration, options: [])
        
        // face anchor
        let faceAnchor = AnchorEntity(.face)
        faceAnchor.addChild(createSphere(y: 0.25))
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
