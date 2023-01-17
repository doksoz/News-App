//
//  Fruit.swift
//  TableViewMVC
//
//  Created by Syed Ali on 4/08/21.
//  Copyright © 2021 CTIS. All rights reserved.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

class News {
    var source: String
    var title: String
    var url: String
    var publishedDate: Date
    var author: String?
    var description: String?
    var urlToImage: String?
    var isSaved: Bool?
    
    init(source: String, title: String, url:String, publishedDate: Date, author:String, description: String, urlToImage: String) {
        self.source = source
        self.title = title
        self.url = url
        self.publishedDate = publishedDate
        self.author = author
        self.description = description
        self.urlToImage = urlToImage
        self.isSaved = false
    }
    
    init(){
        self.source = ""
        self.title = ""
        self.url = ""
        self.publishedDate = Date()
        self.author = ""
        self.description = ""
        self.urlToImage = ""
        self.isSaved = false
    }
    
    var authorText: String {
        author ?? ""
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var captionText: String {
        "\(source) ‧ \(relativeDateFormatter.localizedString(for: publishedDate, relativeTo: Date()))"
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
}
