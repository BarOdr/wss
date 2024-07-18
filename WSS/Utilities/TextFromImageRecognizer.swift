//
//  TextFromImageRecognizer.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 14/07/2024.
//

import Foundation
import SwiftUI
import Vision

protocol TextFromImageRecognizing {

}

final class TextFromImageRecognizer: TextFromImageRecognizing {
    func detectTextInImage(cgImage: CGImage) async -> [String] {
        await withCheckedContinuation { continuation in
            let request = VNRecognizeTextRequest { (request, error) in
                guard let observations = request.results as? [VNRecognizedTextObservation] else {
                    continuation.resume(returning: [])
                    return
                }

                let detectedStrings = observations.compactMap { $0.topCandidates(1).first?.string }
                continuation.resume(returning: detectedStrings)
            }
            request.recognitionLanguages = ["pl"]

            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            DispatchQueue.global(qos: .userInitiated).async {
                try? handler.perform([request])
            }
        }
    }

    func loadCGImage() -> CGImage? {
        // Replace with your method to load a CGImage
        guard let url = Bundle.main.url(forResource: "kartaKontrast", withExtension: "png"),
              let imageSource = CGImageSourceCreateWithURL(url as CFURL, nil),
              let cgImage = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) else {
            return nil
        }
        return cgImage
    }
}
