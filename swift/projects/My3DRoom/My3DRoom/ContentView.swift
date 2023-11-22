//
//  ContentView.swift
//  My3DRoom
//
//  Created by Wouter Verweirder on 22/11/2023.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    
    static func createScene() -> SCNScene? {
        let scene = SCNScene(named: "Room.dae")
        if let plane = scene?.rootNode.childNode(withName: "MonitorPlane", recursively: true) {
            let material = SCNMaterial()
            let program = SCNProgram()
            program.vertexFunctionName = "myVertexShaderFunction"
            program.fragmentFunctionName = "myFragmentShaderFunction"
            material.program = program
            plane.geometry?.firstMaterial = material
        }
        return scene
    }
    
    var myScene = createScene()
    
    var body: some View {
        VStack {
            SceneView(scene: myScene, options: [.allowsCameraControl, .rendersContinuously])
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
