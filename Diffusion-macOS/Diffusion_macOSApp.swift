//
//  Diffusion_macOSApp.swift
//  Diffusion-macOS
//
//  Created by Cyril Zakka on 1/12/23.
//  See LICENSE at https://github.com/huggingface/swift-coreml-diffusers/LICENSE
//

import SwiftUI

@main
struct Diffusion_macOSApp: App {
    @State var generationContext = GenerationContext()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(generationContext)
        }
    }
}
