//
//  PlaygroundView.swift
//  metal-mobile-demo
//
//  Created by Yuta Uchida on 2025/02/22.
//

import GameplayKit
import PhotosUI
import SwiftUI

struct ColorEffectView: View {
    @State var selectedImage: PhotosPickerItem? = nil
    @State var image: UIImage? = nil
    @State var offset: CGSize = CGSize.zero
    var voronoi: Image

    private let date = Date()

    var rotation: Double {
        let xRotAbs = abs(offset.width)
        let capped = min(xRotAbs, 50.0)
        return capped / 50.0
    }

    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedImage, matching: .images) {
                Text("Pick Image")
            }

            Gesture3DTransformView(offset: $offset) {
                ImageCard(image: image)
                    .reflective(offset: offset)
                    .horographic(offset: offset, voronoi: voronoi)
                    .shadow(
                        color: Color(.sRGBLinear, white: 0, opacity: 0.33),
                        radius: 8.0,
                        x: 0,
                        y: 0
                    )
            }

        }
        .onChange(of: selectedImage, initial: false) {
            Task {
                image = nil
                guard
                    let data = try await selectedImage?.loadTransferable(
                        type: Data.self)
                else { return }
                guard let uiImage = UIImage(data: data) else { return }
                image = uiImage

            }
        }
    }

    init(voronoi: Image) {
        self.voronoi = voronoi
    }

}

#Preview {
    func makeVoronoi() -> Image {
        let voronoiNoiseSource = GKVoronoiNoiseSource(
            frequency: 20, displacement: 1, distanceEnabled: false, seed: 555)
        let noise = GKNoise(voronoiNoiseSource)
        let noiseMap = GKNoiseMap(
            noise, size: .init(x: 1, y: 1), origin: .zero,
            sampleCount: .init(x: 900, y: 900), seamless: true)
        let texture = SKTexture(noiseMap: noiseMap)
        let cgImage = texture.cgImage()
        return Image(cgImage, scale: 1, label: Text(""))
    }

    return ColorEffectView(voronoi: makeVoronoi())
}
