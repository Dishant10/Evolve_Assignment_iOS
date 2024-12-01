//
//  ChipView.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 01/12/24.
//

import SwiftUI

struct ChipView: View {
    
    let problem: Problem
    let isSelected: Bool
    @Binding var problemsList: [String]
    
    var body: some View {
        HStack {
            Text(problem.title)
                .font(.system(size:15))
                .foregroundStyle(.white)
            if isSelected {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 12,height: 7.5)
            }
        }
        .padding(.vertical,12)
        .padding(.horizontal,20)
        .background(Color.gray.opacity(0.4),in: .capsule)
    }
}
