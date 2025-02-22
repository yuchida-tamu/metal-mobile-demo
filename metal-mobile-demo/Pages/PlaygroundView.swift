//
//  PlaygroundView.swift
//  metal-mobile-demo
//
//  Created by Yuta Uchida on 2025/02/22.
//

import PhotosUI
import SwiftUI

struct PlaygroundView: View {
    @State var selectedImages: [PhotosPickerItem] = []

    var body: some View {
        PhotosPicker(selection: $selectedImages, matching: .images){
            Text("Pick Image")
        }
    }
}

#Preview {
    PlaygroundView()
}
