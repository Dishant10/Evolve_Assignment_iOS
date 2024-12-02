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
    @Published var completeItemsList: [Item] = []
    private let itemsKey = "itemsKey"
    @Published var cachedItemsList: [Item] = []
    
    let problems: [Problem] = [Problem(title: "All"), Problem(title: "🌻 Self-love"), Problem(title: "🌈 LGBTQIA+"), Problem(title: "🧠 Neurodiversity"), Problem(title: "❤️ Relationships"), Problem(title: "💼 Work"), Problem(title: "🌸 Sexual health"), Problem(title: "💵 Finance") ]
    
    @Published var problemsList: [Problem] = []
    
    var currentPage: Int = 1
    
    let baseURL: String = "http://localhost:3000/data"
    
    
    func filterListOnProblems(problemsList: [Problem]) {
                
        if !problemsList.isEmpty {
            var filteredItems = [Item]()
            print("Problems List: \(problemsList)")
            print("Items: \(self.completeItemsList)")
            filteredItems = self.completeItemsList.filter { item in
                item.problems.contains { problem in
                    problemsList.contains(where: {$0.title == problem })
                }
            }
            print("Filtered Items: \(filteredItems)")
            if !filteredItems.isEmpty {
                self.items = filteredItems
                self.state = .success
            }
        }
    }

}



extension NetworkManager {
    
    func fetchDataInPages() {
        state = .loading
        var urlString: String {
            return "\(baseURL)?_page=\(currentPage)"
        }
        
        guard let url = URL(string: urlString) else {
            self.state = .error(.invaildURL("Invalid URL"))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.state = .error(.serverError(error.localizedDescription))
                    return
                }
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
                    DispatchQueue.main.async(execute: {
                        self.state = .error(.invalidData(error.localizedDescription))
                    })
                    
                }
            } else {
                DispatchQueue.main.async(execute: {
                    self.state = .error(.unknown(error?.localizedDescription ?? "Response data is invalid"))
                })
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
            self.state = .error(.invaildURL("Invalid URL"))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.state = .error(.serverError(error.localizedDescription))
                    return
                }

            }
            
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
                    DispatchQueue.main.async(execute: {
                        self.state = .error(.unknown(error.localizedDescription))
                    })
                    
                }
            } else {
                self.state = .error(.invalidData(error?.localizedDescription ?? "Response data is invalid"))
                return
            }
        }.resume()
    }

    
    func fetchData() {
        var urlString: String {
            return "\(baseURL)"
        }
        
        guard let url = URL(string: urlString) else {
            self.fetchDataFromUserDefaults()
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                self.fetchDataFromUserDefaults()
            }
            if let data = data {
                print(data)
                do {
                    let decodedData = try JSONDecoder().decode([Item].self, from: data)
                    DispatchQueue.main.async {
                    if decodedData.isEmpty {
                    } else {
                        self.completeItemsList.removeAll()
                        self.completeItemsList = decodedData
                        self.saveDataToUserDefaults(items: self.completeItemsList)
                        print(decodedData)
                    }
                    }
                } catch {
                    print("Error")
                }
            } else {
                self.fetchDataFromUserDefaults()
                return
            }
        }.resume()
    }

}

extension NetworkManager {
    
    
    func saveDataToUserDefaults(items: [Item]) {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: itemsKey)
        }
        catch {
            print("Failed to save data to UserDefaults: \(error)")
        }
    }
        
    
    func fetchDataFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: itemsKey) {
            do {
                let items = try JSONDecoder().decode([Item].self, from: data)
                if items.isEmpty {
                    DispatchQueue.main.async(execute:  {
                        self.state = .error(.unknown("Failed to fetch data from UserDefaults: \(error)"))
                    })
                }
                else {
                    DispatchQueue.main.async(execute:  {
                        self.cachedItemsList = items
                    })
                    
                }
            } catch {
                DispatchQueue.main.async(execute:  {
                    self.state = .error(.unknown("Failed to fetch data from UserDefaults: \(error)"))
                })
            }
        } else {
            self.state = .empty
        }
    }

    
}
