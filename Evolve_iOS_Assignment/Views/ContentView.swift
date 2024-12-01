//
//  ContentView.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 29/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @FocusState var isFocused : Bool
    
    @State var searchText: String = ""
    @State var problemsList: [String] = []
    @StateObject var networkManager = NetworkManager()
    
    let chips: [String] = ["All","🌻 Self-love","🌈 LGBTQIA+","🧠 Neurodiversity","❤️ Relationships","💼 Work","🌸 Sexual health","💵 Finance"]
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            HStack {
                Text("Explore")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                ToolBarItems()
            }
            
            VStack(alignment: .leading) {
                Text("Discover")
                    .font(.title2)
                    .fontWeight(.bold)
                    .onTapGesture {
                        networkManager.fetchData()
                    }
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.gray.opacity(0.5))
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom,-2)
                        .padding(.leading)
                    TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                        
                    }, onCommit: {
                        networkManager.fetchDataWithTitle(title: searchText)
                    })
                    .padding(.bottom,-2)
                    .focused($isFocused)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .foregroundColor(.primary)
                    
                    
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                    }
                    .padding(.trailing, 5)
                    
                }
                .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color.gray.opacity(0.4))
                .cornerRadius(20.0)
                
                
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack {
                        ForEach(chips,id:\.self) { chipText in
                            
                            ChipView(chipNameText: chipText,problemsList: $problemsList)
                        }
                    }
                }
                .padding(.top,6)
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(networkManager.items, id: \.id) { item in
                            GridCellView(name: item.title)
                        }
                        if networkManager.currentPage < 4 {
                            ForEach(0...1,id: \.self) { _ in
                                GridCellViewShimmer()
                            }
                                .onAppear {
                                    if networkManager.currentPage != 1 {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                                            print("Current Page before - \(networkManager.currentPage)")
                                            networkManager.fetchData()
                                            print("Current Page after - \(networkManager.currentPage)")
                                            if networkManager.currentPage == 3 {
                                                networkManager.currentPage = 4
                                            }
                                        })
                                        
                                    }
                                }
                        }
                    }
                    .padding(.top)
                }
            }
            .padding(.top,52)
            Spacer()
        }
        .onChange(of: self.problemsList, perform: { newValue in
            if problemsList.isEmpty {
                networkManager.items.removeAll()
                networkManager.fetchData()
            } else {
                //networkManager.filterListOnProblems(problemsList: newValue)
            }
        })
        .ignoresSafeArea(edges: [.bottom])
        .navigationBarHidden(true)
        .padding([.top,.leading,.trailing])
    }
}

#Preview {
    ContentView()
}

//struct ToolBarItems: View {
//    
//    @Environment(\.colorScheme) var colorScheme
//    
//    var body: some View {
//        HStack(spacing: 4) {
//            Image(systemName: "heart.fill")
//                .resizable()
//                .frame(width: 20, height: 17)
//                .padding(10)
//                .background(Color.gray.opacity(0.45))
//                .clipShape(Circle())
//                .contentShape(Circle())
//                .foregroundStyle(colorScheme == .light ? .black : .white)
//            
//            Image("music_icon")
//                .resizable()
//                .frame(width: 16, height: 16)
//                .padding(10)
//                .background(Color.gray.opacity(0.45))
//                .clipShape(Circle())
//                .contentShape(Circle())
//                .foregroundStyle(colorScheme == .light ? .black : .white)
//        }
//    }
//}

//struct ChipView: View {
//    
//    let chipNameText: String
//    @Binding var problemsList: [String]
//    
//    var body: some View {
//        Text(chipNameText)
//            .font(.system(size:15))
//            .foregroundStyle(.white)
//            .padding(.vertical,12)
//            .padding(.horizontal,20)
//            .background(Color.gray.opacity(0.4),in: .capsule)
//            .onTapGesture {
//                problemsList.append(chipNameText)
//            }
//    }
//}
