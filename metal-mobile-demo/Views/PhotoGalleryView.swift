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
    @State var selectedImages: [PhotosPickerItem] = []
    @State var loadedImages: [UIImage] = []
    @State var offset: CGSize = CGSize.zero

    private let date = Date()

    var rotation: Double {
        let xRotAbs = abs(offset.width)
        let capped = min(xRotAbs, 50.0)
        return capped / 50.0
    }

    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedImages, matching: .images) {
                Image(systemName: "photo.badge.plus.fill")
                Text("Add Images")
            }

            ScrollView {
                LazyVGrid(
                    columns: [GridItem(spacing: 8), GridItem(spacing: 8), GridItem(spacing: 8)],
                    spacing: 8
                ) {
                    ForEach(loadedImages, id: \.self) { image in
                        ImageCard(image: image)
                            .horographic(
                                offset: offset,
                                voronoi: photoGalleryViewModel.horographicImage
                            )
                            .shadow(
                                color: Color(.sRGBLinear, white: 0, opacity: 0.33),
                                radius: 4.0,
                                x: 0,
                                y: 0
                            )
                    }
                }
            }

        }
        .onChange(of: selectedImages, initial: false) {
            Task {
                loadedImages = []

                for image in selectedImages {
                    guard
                        let data = try await image.loadTransferable(
                            type: Data.self)
                    else { return }
                    guard let uiImage = UIImage(data: data) else { return }
                    loadedImages.append(uiImage)
                }

            }
        }
    }
}

#Preview {
    PhotoGalleryView()
        .environmentObject(PhotoGalleryViewModel())
}
