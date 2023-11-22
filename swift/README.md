# Swift(UI)

## 1. A Swift Tour

Launch XCode and create a new blank Playground for iOS (File > New > Playground). Name it `SwiftTour` and save it somewhere on your computer. A Playground is a great way to learn Swift because it allows you to write code and see the results immediately. It's also a great way to experiment with new ideas, without having to create a full-blown app.

Follow the [Swift Tour](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/guidedtour/) - make sure to use the latest XCode version - from the Swift documentation. You can copy and paste the code from the documentation into your Playground. You can also type the code yourself, which is a great way to learn. If you get stuck, you can always refer to the documentation for help.

## 2. SwiftUI

Watch the [Video: Introduction to SwiftUI](https://developer.apple.com/videos/play/wwdc2020/10119/).

We will build a small App in class, based upon the principles demonstrated in that video.

## 3. SceneKit

### Display a 3D model with baked textures

Using [SceneKit](https://developer.apple.com/documentation/scenekit) we will visualize one of our 3D models in SwiftUI.

1. Export one of your 3D models from Blender as a `.dae` file.
2. Create a regular SwiftUI project.
3. Import your model into your XCode project (File > Add Files to "ProjectName").
4. Import your baked texture image into your XCode project.
5. Select the imported model to open the 3D editor in XCode.
6. Fix the materials and textures in XCode. With baked textures, this means:
    1. Select an object in the scene.
    2. Go into the Materials side panel
    3. Change shading to "constant"
    4. Change diffuse to the imported baked texture image.
    5. Repeat this projecss until all materials have been updated and your model looks correct.

7. Import SceneKit into your ContentView.swift file, and create an SCNScene. Display this SCNScene using a SceneView:

    ```swift
    import SwiftUI
    import SceneKit

    struct ContentView: View {
        
        var myScene = SCNScene(named: "Room.dae")
        
        var body: some View {
            VStack {
                SceneView(scene: myScene)
                Text("Hello, world!")
            }
            .padding()
        }
    }

    #Preview {
        ContentView()
    }
    ```

    You should see a view of your model in the XCode preview window. However, the camera angle isn't what it's supposed to be.
8. Select your imported 3D file to open it in the 3D editor again. Use the `+` button in the top right corner to add a new camera. Select the camera and use the inspector to set the camera position and rotation to the desired values. You can toggle the 3D view to switch between camera positions in the editor, and preview what the camera sees.
9. Your app should now automatically display the model from the camera's perspective. You can add interactive camera control, by passing some options to the SceneView:

    ```swift
    SceneView(scene: myScene, options: [.allowsCameraControl])
    ```

    This will allow you to rotate and zoom the camera using the mouse.

### Use a custom shader as a texture

Shaders on the Apple platforms are written in [Metal Shading Language](https://developer.apple.com/metal/).

1. Create a new Metal File in your XCode project (File > New > File > Metal File). Name it `CustomShader.metal`.
2. Add the following shader code, which includes the bare minimum to get a shader to work in SceneKit:

    ```c++
    #include <metal_stdlib>
    using namespace metal;
    #include <SceneKit/scn_metal>

    struct NodeBuffer {
      float4x4 modelTransform;
      float4x4 modelViewProjectionTransform;
      float4x4 modelViewTransform;
      float4x4 normalTransform;
      float2x3 boundingBox;
      int time;
    };

    struct VertexInput {
      float3 position  [[attribute(SCNVertexSemanticPosition)]];
      float2 uv [[attribute(SCNVertexSemanticTexcoord0)]];
    };

    struct VertexOut {
      float4 position [[position]];
      float2 uv;
    };

    vertex VertexOut myVertexShaderFunction(VertexInput in [[ stage_in ]], constant NodeBuffer& scn_node [[buffer(1)]]) {
      VertexOut out;
      out.position = scn_node.modelViewProjectionTransform * float4(in.position, 1.0);
      out.uv = in.uv;
      return out;
    }

    fragment float4 myFragmentShaderFunction(VertexOut out [[ stage_in ]], constant SCNSceneBuffer& scn_frame [[buffer(0)]]) {
        float4 outputColor = float4(out.uv.x, out.uv.y, 0.0, 1.0);
        return outputColor;
    }
    ```
3. In the XCode 3D editor, make sure to give the object you want the shader to be applied on a unique Identity name (beware: use the Identity tab, not the Geometry tab)
4. In your ContentView, adjust the code creating the scene. Because we will create and assign a new material when creating the scene, we'll do it with a static function:

    ```swift
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
    ```

    This should display the custom shader on to the material of the object with the name "MonitorPlane" in your scene.

### Convert a WebGL shader to Metal

What if you want to use one of your webgl shaders? You'll need to convert it to Metal. This is not always straightforward, but there are some tools that can help you with this.

One tool I've used successfully is [MoltenGL](https://moltengl.com). Download the latest version and extract it some where on your computer.

In the extracted folder, you'll find a `Tools` folder, with a `MoltenGLShaderConverter` binary. As this is an unsigned binary, you'll need to allow it to run on your computer. You can do this by opening the Terminal, navigating to the `Tools` folder, and running the following command:

```bash
xattr -d com.apple.quarantine MoltenGLShaderConverter
```

You then should be able to run this binary from your Terminal. Let's convert a fragment shader file to metal (adjust the file path so it points to your own file):

```bash
./MoltenGLShaderConverter -g /Users/yourusername/Document/shaders/cyberFuji/fragment.glsl -t fragment
```

It won't be 100% plug and play, but it should give you a good starting point to get your shader to work in SceneKit.

For my particular shader I:

1. Copy pasted the contents of the fragment shader function of the converted file into my `myFragmentShaderFunction` in XCode.
2. Created a new variable `iResolution`:
  
      ```c++
      float2 iResolution = float2(16.0, 9.0);
      ```
3. Replaced some variables:
    1. _mtl_i.vUv -> out.uv
    2. _mtl_u.iTime -> scn_frame.time
    3. _mtl_u.iResolution -> iResolution
4. Return a float4 at the end, containing the correct color

## Further Resources

- [Landmarks Tutorial: Introducing SwiftUI](https://developer.apple.com/tutorials/SwiftUI)
- [Scrumdinger Tutorial: Apple - Develop apps for iOS](https://developer.apple.com/tutorials/app-dev-training/)
- [100 days of SwiftUI](https://www.hackingwithswift.com/100/swiftui)