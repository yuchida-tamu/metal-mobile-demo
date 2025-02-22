//
//  ImageCard.swift
//  metal-mobile-demo
//
//  Created by Yuta Uchida on 2025/02/22.
//

import SwiftUI

struct ImageCard: View {
    var image: UIImage? = nil

    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8.0)
                    )
                    .frame(width: 250)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .frame(width: 250, height: 150)
                        .foregroundStyle(.gray)
                    
                    Text("NO DATA")
                        .foregroundStyle(.white)
                }
            }

        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
        .shadow(
            color: Color(.sRGBLinear, white: 0, opacity: 0.33),
            radius: 8.0,
            x: 0,
            y: 0
        )
    }

    init(image: UIImage? = nil) {
        self.image = image
    }
}

#Preview {
    ImageCard()
}
