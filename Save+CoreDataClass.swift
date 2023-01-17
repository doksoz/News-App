//
//  Save+CoreDataClass.swift
//  BerfinDoksoz_Project
//
//  Created by berfin doksöz on 25.12.2022.
//
//

import Foundation
import CoreData

@objc(Save)
public class Save: NSManagedObject {
    class func createInManagedObjectContext(_ context: NSManagedObjectContext, source: String, title: String, url: String, publishedDate: String, author: String, descriptionCore: String, urlToImage: String, isSaved: Bool) -> Save {
        let saveObject = NSEntityDescription.insertNewObject(forEntityName: "Save", into: context) as! Save
        saveObject.source = source
        saveObject.title = title
        saveObject.url = url
        saveObject.publishedDate = publishedDate
        saveObject.author = author
        saveObject.descriptionCore = descriptionCore
        saveObject.urlToImage = urlToImage
        saveObject.isSaved = isSaved
        return saveObject
    }
}
