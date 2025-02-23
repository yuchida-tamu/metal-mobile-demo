//
//  ReflectionViewModifier.swift
//  metal-mobile-demo
//
//  Created by Yuta Uchida on 2025/02/23.
//

import SwiftUI

struct ReflectionViewModifier: ViewModifier {
    var offset: CGSize

    func body(content: Content) -> some View {
        content
            .colorEffect(
                ShaderLibrary.imageFilterShader(
                    .float(offset.width), .float(offset.height))
            )
    }
}
