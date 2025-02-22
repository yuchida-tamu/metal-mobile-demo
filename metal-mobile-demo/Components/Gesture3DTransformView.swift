//
//  GestureTransformView.swift
//  metal-mobile-demo
//
//  Created by Yuta Uchida on 2025/02/22.
//

import SwiftUI

struct Gesture3DTransformView<Content: View>: View {
    var content: () -> Content
    @State var offset: CGSize = CGSize.zero

    var body: some View {

        content()
            .rotation3DEffect(.degrees(20.0), axis: (x: offset.height, y: offset.width, z: 0))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        if abs(offset.width) > 100 {
                            // remove the card
                        } else {
                            offset = .zero
                        }
                    })

    }

    init(content: @escaping () -> Content) {
        self.content = content
    }
}

#Preview {
    struct PreviewContent: View {

        var body: some View {
            VStack {
                Gesture3DTransformView {
                    ImageCard()
                }
            }
        }
    }

    return PreviewContent()
}
