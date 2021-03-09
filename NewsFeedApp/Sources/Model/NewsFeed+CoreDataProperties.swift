//
//  NewsFeed+CoreDataProperties.swift
//  NewsFeedApp
//
//  Created by APLKLAT279106 on 03/03/21.
//
//

import Foundation
import CoreData


extension NewsFeed {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsFeed> {
        return NSFetchRequest<NewsFeed>(entityName: "NewsFeed")
    }
    
    @NSManaged public var author: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var url: String?
    @NSManaged public var published: String?
    @NSManaged public var title: String?
    
}

extension NewsFeed : Identifiable {
    
}
