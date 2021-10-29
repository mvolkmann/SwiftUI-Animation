import SwiftUI

enum EasingType: String, CaseIterable {
    case forever, linear, easeIn, easeOut, easeInOut, spring
}

struct ContentView: View {
    @State private var borderColor: Color = .red
    @State private var color = false
    @State private var easingType: EasingType = .linear
    @State private var on = false
    @State private var opacity = false
    @State private var rotate = false
    @State private var scale = false
    
    private var easingFunction: Animation {
        let duration = 1.0
        switch easingType {
        case .linear: return Animation.linear(duration: duration)
        case .forever: return Animation
                .linear(duration: duration)
                .repeatForever(autoreverses: false)
        case .easeIn: return Animation.easeIn(duration: duration)
        case .easeOut: return Animation.easeOut(duration: duration)
        case .easeInOut: return Animation.easeInOut(duration: duration)
        case .spring: return Animation.spring(dampingFraction: 0.5).speed(0.3)
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("First Line")
                Text("Second Line")
                Text("🎉").font(.largeTitle)
            }
            .padding()
            .border(borderColor, width: 10)
            .opacity(!opacity || on ? 1 : 0)
            .scaleEffect(!scale || on ? 1 : 0)
            .rotationEffect(.degrees(!rotate || on ? 0 : 360))
            .animation(easingFunction) // implicit animation
            
            NavigationView { // Picker will be disabled without this.
                Form {
                    Toggle("Animate Color", isOn: $color)
                    Toggle("Animate Opacity", isOn: $opacity)
                    Toggle("Animate Rotation", isOn: $rotate)
                    Toggle("Animate Scale", isOn: $scale)
                    Picker("Easing Function", selection: $easingType) {
                        ForEach(EasingType.allCases, id: \.self) { easingType in
                            Text("\(easingType.rawValue)").tag(easingType)
                        }
                    }
                    Button("Toggle") {
                        if color {
                            borderColor = borderColor == .red ? .blue : .red
                        }
                        on.toggle()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
