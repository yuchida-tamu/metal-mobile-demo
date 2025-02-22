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
    @State var images: [UIImage] = []

    var body: some View {
        VStack{
            PhotosPicker(selection: $selectedImages, matching: .images){
                Text("Pick Image")
            }

            ScrollView(.horizontal){
                HStack{
                    ForEach(images, id: \.self){ image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 300)
                    }
                }
            }
            
        }
        .onChange(of: selectedImages){
            Task {
                images = []
                for item in selectedImages {
                    guard let data = try await item.loadTransferable(type: Data.self) else {return}
                    guard let uiImage = UIImage(data: data) else { return }
                    images.append(uiImage)
                }
                
            }
        }
    }
}

#Preview {
    PlaygroundView()
}
