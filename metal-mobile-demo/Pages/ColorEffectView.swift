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

            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 300)
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
    ColorEffectView()
}
