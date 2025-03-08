//
//  GeneratedImageView.swift
//  Diffusion
//
//  Created by Pedro Cuenca on 18/1/23.
//  See LICENSE at https://github.com/huggingface/swift-coreml-diffusers/LICENSE
//

import SwiftUI

struct GeneratedImageView: View {
    @Environment(GenerationContext.self) var generation

    var body: some View {
        switch generation.state {
        case .startup: return AnyView(Image("placeholder").resizable())
        case .running(let progress):
            guard let progress = progress, progress.stepCount > 0 else {
                // The first time it takes a little bit before generation starts
                return AnyView(ProgressView())
            }

            let step = Int(progress.step) + 1
            let fraction = Double(step) / Double(progress.stepCount)
            let label = "Step \(step) of \(progress.stepCount)"

            return AnyView(VStack {
                Group {
                    if let safeImage = generation.previewImage {
                        Image(safeImage, scale: 1, label: Text("generated"))
                            .resizable()
                            .frame(width: CGFloat(safeImage.width), height: CGFloat(safeImage.height))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                HStack {
                    ProgressView(label, value: fraction, total: 1).padding()
                    Button {
                        generation.cancelGeneration()
                    } label: {
                        Image(systemName: "x.circle.fill").foregroundColor(.gray)
                    }
                    .buttonStyle(.plain)
                }
            })
        case .complete(_, let image, _, _):
            guard let theImage = image else {
                return AnyView(Image(systemName: "exclamationmark.triangle").resizable())
            }
            
            return AnyView(
                    Image(theImage, scale: 1, label: Text("generated"))
                    .resizable()
                    .frame(width: CGFloat(theImage.width), height: CGFloat(theImage.height))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .contextMenu {
                        Button {
                            NSPasteboard.general.clearContents()
                            let nsimage = NSImage(cgImage: theImage, size: NSSize(width: theImage.width, height: theImage.height))
                            NSPasteboard.general.writeObjects([nsimage])
                        } label: {
                            Text("Copy Photo")
                        }
                    }
            )
        case .failed(_):
            return AnyView(Image(systemName: "exclamationmark.triangle").resizable())
        case .userCanceled:
            return AnyView(Text("Generation canceled"))
        }
    }
}


#Preview {
    @Previewable @State var generater =  GenerationContext()
    GeneratedImageView()
        .frame(width: 512, height: 512)
        .environment(generater)

}
