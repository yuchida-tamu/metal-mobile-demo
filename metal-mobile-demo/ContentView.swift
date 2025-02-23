//
//  ContentView.swift
//  metal-mobile-demo
//
//  Created by Yuta Uchida on 2025/02/22.
//

import SwiftUI
import GameplayKit

struct ContentView: View {
    var body: some View {
        TabView{
            ColorEffectView(voronoi: makeVoronoi())
                .tabItem{
                    Image(systemName: "square.grid.2x2")
                    Text("gallery")
                }
            
            SettingsView()
                .tabItem{
                    Image(systemName: "gearshape")
                    Text("settings")
                }
        }
    }
    func makeVoronoi() -> Image {
        let voronoiNoiseSource = GKVoronoiNoiseSource(frequency: 20, displacement: 1, distanceEnabled: false, seed: 555)
        let noise = GKNoise(voronoiNoiseSource)
        let noiseMap = GKNoiseMap(noise, size: .init(x: 1, y: 1), origin: .zero, sampleCount: .init(x: 900, y: 900), seamless: true)
        let texture = SKTexture(noiseMap: noiseMap)
        let cgImage = texture.cgImage()
        return Image(cgImage, scale: 1, label: Text(""))
    }
}

#Preview {
    ContentView()
}
