//
//  ContentView.swift
//  metal-mobile-demo
//
//  Created by Yuta Uchida on 2025/02/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("ColorEffect"){
                    ColorEffectView()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
