//
//  BadgeView.swift
//  Simply
//
//  Created by Rishi Shah on 11/02/26.
//

import SwiftUI

struct BadgeView: View {

    let imageName: String
    let isUnlocked: Bool

    var body: some View {

        Image.fromBundle(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 90, height: 90)
            .grayscale(isUnlocked ? 0 : 1)
            .opacity(isUnlocked ? 1 : 0.4)
    }
}

