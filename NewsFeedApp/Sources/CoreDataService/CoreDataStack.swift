//
//  CoreDataStack.swift
//  NewsFeedApp
//
//  Created by APLKLAT279106 on 03/03/21.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    
    //--------------------------------------------------------------------------
    // MARK: - Public properties
    //--------------------------------------------------------------------------
    
    static let sharedInstance = CoreDataStack()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsFeedApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //--------------------------------------------------------------------------
    // MARK: - Public methods
    //--------------------------------------------------------------------------
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


extension CoreDataStack {
    func applicationDocumentsDirectory() {
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
}
