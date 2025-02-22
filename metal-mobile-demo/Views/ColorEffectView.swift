//
//  PlaygroundView.swift
//  metal-mobile-demo
//
//  Created by Yuta Uchida on 2025/02/22.
//

import PhotosUI
import SwiftUI

struct ColorEffectView: View {
    @State var selectedImage: PhotosPickerItem? = nil
    @State var image: UIImage? = nil

    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedImage, matching: .images) {
                Text("Pick Image")
            }

            ImageCard(image: image)
                .shadow(
                    color: Color(.sRGBLinear, white: 0, opacity: 0.33),
                    radius: 8.0,
                    x: 0,
                    y: 0
                )

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
    ColorEffectView()
}
