//
//  ToolBarItems.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 01/12/24.
//

import SwiftUI

struct ToolBarItems: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 20, height: 17)
                .padding(10)
                .background(Color.gray.opacity(0.45))
                .clipShape(Circle())
                .contentShape(Circle())
                .foregroundStyle(colorScheme == .light ? .black : .white)
            
            Image("music_icon")
                .resizable()
                .frame(width: 16, height: 16)
                .padding(10)
                .background(Color.gray.opacity(0.45))
                .clipShape(Circle())
                .contentShape(Circle())
                .foregroundStyle(colorScheme == .light ? .black : .white)
        }
    }
}
