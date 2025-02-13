//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Ислам on 11.02.2025.
//


import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Ошибка загрузки CoreData: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Ошибка сохранения: \(error)")
            }
        }
    }
    
    func saveFavoritePost(id: String, text: String, imageName: String?) {
        let favoritePost = FavoritePost(context: context)
        favoritePost.id = id
        favoritePost.text = text
        favoritePost.imageName = imageName
        saveContext()
    }
    
    func fetchFavoritePosts() -> [FavoritePost] {
        let fetchRequest: NSFetchRequest<FavoritePost> = FavoritePost.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Ошибка извлечения: \(error)")
            return []
        }
    }
}
