//
//  Save+CoreDataProperties.swift
//  BerfinDoksoz_Project
//
//  Created by berfin doksöz on 25.12.2022.
//
//

import Foundation
import CoreData


extension Save {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Save> {
        return NSFetchRequest<Save>(entityName: "Save")
    }

    @NSManaged public var source: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var author: String?
    @NSManaged public var publishedDate: String?
    @NSManaged public var descriptionCore: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var isSaved: Bool

}

extension Save : Identifiable {

}
