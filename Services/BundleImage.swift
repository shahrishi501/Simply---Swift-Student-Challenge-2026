//
//  BundleImage.swift
//  Simply
//
//  Created by Rishi Shah on 08/02/26.
//


import SwiftUI
import PDFKit

extension Image {

    static func fromBundle(_ name: String) -> Image {

        // Try PNG
        if let pngURL = Bundle.main.url(forResource: name, withExtension: "png"),
           let pngImage = UIImage(contentsOfFile: pngURL.path) {
            return Image(uiImage: pngImage)
        }

        // Try PDF
        if let pdfURL = Bundle.main.url(forResource: name, withExtension: "pdf"),
                   let document = PDFDocument(url: pdfURL),
                   let page = document.page(at: 0) {

                    let pageRect = page.bounds(for: .mediaBox)

                    let renderer = UIGraphicsImageRenderer(size: pageRect.size)

                    let img = renderer.image { ctx in
                        UIColor.clear.set()
                        ctx.fill(pageRect)
                        ctx.cgContext.translateBy(x: 0, y: pageRect.size.height)
                        ctx.cgContext.scaleBy(x: 1, y: -1)
                        page.draw(with: .mediaBox, to: ctx.cgContext)
                    }

                    return Image(uiImage: img)
                }

        return Image(systemName: "photo")
    }
}


