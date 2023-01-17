//
//  DataSource.swift
//  CTIS480_Fall2223_HW3
//
//  Created by Syed Ali on 12/2/22.
//  Copyright © 2022 CTIS. All rights reserved.
//

import Foundation

class DataSource {
    var mNewsList: [News] = []
    var sources: [String] = []
    
    
    func numbeOfItemsInEachCategory(index: Int) -> Int {
        return itemsInCategory(index: index).count
    }
    
    func numberOfCategories() -> Int {
        return sources.count
    }
    
    func getCategoryLabelAtIndex(index: Int) -> String {
        return sources[index]
    }
    
    // MARK: - Populate Data from files
    func populate(category: String) {
            if let mURL = URL(string: "https://newsapi.org/v2/top-headlines?country=tr&category=" + category + "&apiKey=61659194c8454a10b1d9c865a96e45af") {
                print("MRUL", mURL)
                if let data = try? Data(contentsOf: mURL) {
                    
                    // https://www.dotnetperls.com/guard-swift
                    guard let json = try? JSON(data: data) else {
                        print("Error with JSON")
                        return
                    }
                    //print(json)
                    
                    for index in 0..<json["articles"].count {
                        let source = json["articles"][index]["source"]["name"].string!
                        let author = json["articles"][index]["author"].string ?? ""
                        let title = json["articles"][index]["title"].string!
                        let url = json["articles"][index]["url"].string!
                        let publishedDate = json["articles"][index]["publishedAt"].string!
                        
                        let description = json["articles"][index]["description"].string ?? ""
                        let urlToImage = json["articles"][index]["urlToImage"].string ?? ""
                        let dateFormatter = ISO8601DateFormatter()
                        let date = dateFormatter.date(from:publishedDate)!
                        
                        let mRecord = News(source: source, title: title, url: url, publishedDate: date, author: author, description: description, urlToImage: urlToImage)
                        mNewsList.append(mRecord)
                       
                        
                        if !sources.contains(source) {
                            sources.append(source)
                          
                        }
                    }
                }
                else {
                    print("Data error")
                }
            }
    }

        
        // MARK: - itemsForEachGroup
    func itemsInCategory(index: Int) -> [News] {
        let item = sources[index]
        
        // See playground6 for Closure
        // http://locomoviles.com/uncategorized/filtering-swift-array-dictionaries-object-property/
        
        let filteredItems = mNewsList.filter { (new: News) -> Bool in
            return new.source == item
        }
        return filteredItems
    }
    }
