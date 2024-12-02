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
    @StateObject var viewModel = ViewModel()
    
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
                        ForEach(viewModel.problems) { problem in
                            
                            ChipView(problem: problem, isSelected: problem.isSelected)
                                .onTapGesture {
                                    if problem.title == "All" {
                                        networkManager.problemsList.removeAll()
                                    } else {
                                        if let index = networkManager.problemsList.firstIndex(where: { $0.id == problem.id}){
                                            networkManager.problemsList.remove(at: index)
                                        } else {
                                            networkManager.problemsList.append(problem)
                                        }
                                    }
                                    viewModel.toggleSelection(for: problem)
                                    
                                }
                        }
                    }
                }
                .padding(.top,6)
                    if networkManager.state == .loading {
                        GridShimmer()
                            
                    } else if networkManager.state == .empty {
                        EmptyStateView()
                    }
                        
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(networkManager.items, id: \.id) { item in
                                    GridCellView(name: item.title, mins: item.mins, promoText: item.promoText)
                                }
                                
                                if networkManager.currentPage < 4 && searchText.isEmpty && networkManager.problemsList.count == 0 {
                                    ForEach(0...1,id: \.self) { _ in
                                        GridCellViewShimmer()
                                    }
                                    .onAppear {
                                        if networkManager.currentPage != 1  {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                                                print("Current Page before - \(networkManager.currentPage)")
                                                    networkManager.fetchDataInPages()
                                                print("Current Page after - \(networkManager.currentPage)")
                                                if networkManager.currentPage == 3 {
                                                    networkManager.currentPage = 4
                                                }
                                            })
                                        }
                                    }
                                }
                            }
                            .padding(.vertical)
                        }
                        .contentTransition(.interpolate)
                        .frame(maxHeight: networkManager.state != .success ? .zero : .infinity)
            }
            .padding(.top,52)
            //Spacer()
        }
        .onAppear(perform: {
            withAnimation {
                networkManager.state = .loading
                networkManager.currentPage = 1
            }
            networkManager.fetchData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9, execute: {
                    networkManager.fetchDataInPages()
            })
        })
        .onChange(of: searchText, perform: { newValue in
            if newValue.isEmpty {
                networkManager.currentPage = 1
                networkManager.state = .loading
                networkManager.items.removeAll()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9, execute: {
                    networkManager.fetchDataInPages()
                })
            }
        })
        .onChange(of: networkManager.problemsList, perform: { newValue in
            print("Problems List \(networkManager.problemsList)")
            if networkManager.problemsList.isEmpty {
                networkManager.items.removeAll()
                networkManager.state = .loading
                networkManager.currentPage = 1
                networkManager.fetchDataInPages()
            } else {
                print("YES")
                networkManager.filterListOnProblems(problemsList: newValue)
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

