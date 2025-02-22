//
//  GestureTransformView.swift
//  metal-mobile-demo
//
//  Created by Yuta Uchida on 2025/02/22.
//

import SwiftUI

struct GestureTransformView<Content: View>: View {
    var content: () -> Content
    @Binding var offset: CGSize

    var body: some View {

        content()
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

    init(offset: Binding<CGSize>, content: @escaping () -> Content) {
        self.content = content
        self._offset = offset
    }
}

#Preview {
    struct PreviewContent: View {
        @State var offset = CGSize.zero
        var body: some View {
            VStack {
                GestureTransformView(offset: $offset) {
                    ImageCard()
                }

                Text("\(offset)")
            }
        }
    }

    return PreviewContent()
}
