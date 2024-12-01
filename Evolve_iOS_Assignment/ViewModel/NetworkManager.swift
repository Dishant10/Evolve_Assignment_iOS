//
//  NetworkManager.swift
//  Evolve_iOS_Assignment
//
//  Created by Dishant Nagpal on 01/12/24.
//

import Foundation


class NetworkManager: ObservableObject {
    
    @Published var state: ViewState = .loading
    @Published var items: [Item] = []
    
    var currentPage: Int = 1
    
    let baseURL: String = "http://localhost:3000/data"
    
}



extension NetworkManager {
    
    func fetchData() {
        state = .loading
        var urlString: String {
            return "\(baseURL)?_page=\(currentPage)"
        }
        
        guard let url = URL(string: urlString) else {
            self.state = .error("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                self.state = .error(error.localizedDescription)
                return
            }
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        if decodedData.data.isEmpty {
                            self.state = .empty
                        } else {
                            self.items.append(contentsOf: decodedData.data)
                            self.state = .success
                            if self.currentPage < 3 {
                                self.currentPage += 1
                            }
                        }
                    }
                } catch {
                    self.state = .error(error.localizedDescription)
                }
            } else {
                self.state = .error("No data received")
                return
            }
        }.resume()
    }
    
    func fetchDataWithTitle(title: String) {
        state = .loading
        var urlString: String {
            return "\(baseURL)?title=\(title)"
        }
        
        guard let url = URL(string: urlString) else {
            self.state = .error("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Item].self, from: data)
                    DispatchQueue.main.async {
                    if decodedData.isEmpty {
                        self.state = .empty
                    } else {
                        
                        self.state = .success
                        self.items.removeAll()
                        self.items.append(contentsOf: decodedData)
                            print("Decoded Data: \(decodedData)")
                            self.currentPage = 1
                        }
                    }
                } catch {
                    self.state = .error(error.localizedDescription)
                }
            } else {
                self.state = .error("No data received")
                return
            }
        }.resume()
    }

    
//    func filterListOnProblems(problemsList: [String]) {
//        if !problemsList.isEmpty {
//            var filteredItems = [Item]()
//            for problem in problemsList {
//                filteredItems = items.filter { $0.problems.contains(where: { $0.localizedCaseInsensitiveContains(problem) }) }
//            }
//            if !filteredItems.isEmpty {
//                items = filteredItems
//            }
//        }
//    }
    
    
    
}
