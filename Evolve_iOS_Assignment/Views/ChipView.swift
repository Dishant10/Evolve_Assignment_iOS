//
//  ChipView.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 01/12/24.
//

import SwiftUI

struct ChipView: View {
    
    let chipNameText: String
    @Binding var problemsList: [String]
    
    var body: some View {
        Text(chipNameText)
            .font(.system(size:15))
            .foregroundStyle(.white)
            .padding(.vertical,12)
            .padding(.horizontal,20)
            .background(Color.gray.opacity(0.4),in: .capsule)
            .onTapGesture {
                problemsList.append(chipNameText)
            }
    }
}
