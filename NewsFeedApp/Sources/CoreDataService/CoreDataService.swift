//
//  CoreDataService.swift
//  NewsFeedApp
//
//  Created by APLKLAT279106 on 03/03/21.
//

import Foundation
import CoreData

class CoreDataService {
    
    //--------------------------------------------------------------------------
    // MARK: - Public methods
    //--------------------------------------------------------------------------
    
    func clearData() {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: NewsFeed.self))
        do {
            let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
            _ = objects.map{$0.map{context.delete($0)}}
            CoreDataStack.sharedInstance.saveContext()
        } catch let error {
            print("ERROR DELETING : \(error)")
        }
    }
    
    
    func createNewsEntityFrom(model: News) -> NSManagedObject? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        guard let newsEntity = NSEntityDescription.insertNewObject(forEntityName: "NewsFeed", into: context) as? NewsFeed else {
            return nil
        }
        newsEntity.author = model.author
        newsEntity.descriptions = model.newsDescription
        newsEntity.id = model.id
        newsEntity.image = model.image
        newsEntity.url = model.url
        newsEntity.published = model.published
        newsEntity.title = model.title
        return newsEntity
    }
    
    func fetchNewsData() -> [NewsFeed]? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: NewsFeed.self))
        do {
            let objects  = try context.fetch(fetchRequest) as? [NewsFeed]
            return objects
        } catch let error {
            print("ERROR fetching : \(error)")
        }
        return nil
    }
    
    func saveInCoreDataWith(model: NewsFeedModel) {
        _ = model.news.map{self.createNewsEntityFrom(model: $0)}
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
}
