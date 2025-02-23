//
//  PlaygroundView.swift
//  metal-mobile-demo
//
//  Created by Yuta Uchida on 2025/02/22.
//

import GameplayKit
import PhotosUI
import SwiftUI

struct PhotoGalleryView: View {
    @EnvironmentObject var photoGalleryViewModel: PhotoGalleryViewModel
    @State var selectedImage: PhotosPickerItem? = nil
    @State var image: UIImage? = nil
    @State var offset: CGSize = CGSize.zero

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
                    .horographic(offset: offset, voronoi: photoGalleryViewModel.horographicImage )
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
}

#Preview {
    PhotoGalleryView()
        .environmentObject(PhotoGalleryViewModel())
}
