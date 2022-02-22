//
//  DataManager.swift
//  MarvelApp
//
//  Created by crodrigueza on 16/2/22.
//

import Foundation
import CoreData

protocol DataManagerProtocol {
    func saveFavorite(_ favorite: Character)
    func deleteFavorite(_ favorite: Character)
    func getFavorites() -> [Character]
}

class DataManager: DataManagerProtocol {
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "MarvelApp")
        persistentContainer.loadPersistentStores { _, error in
            print("\n[!] ERROR: \(error?.localizedDescription ?? "unknown error")")
        }

        return persistentContainer
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    // MARK: - Save, delete and fetch methods
    func saveFavorite(_ favorite: Character) {
        let marvelCharacter = MarvelCharacter(context: context)
        marvelCharacter.setValuesForKeys(["name": favorite.name, "desc": favorite.description, "thumbnailPath": favorite.thumbnail.path, "thumbnailExtension": favorite.thumbnail.imageExtension])
        do {
            try context.save()
        } catch let error {
            print("\n[!] ERROR: \(error.localizedDescription)")
        }
    }

    func deleteFavorite(_ favorite: Character) {
        let marvelCharacter = MarvelCharacter(context: context)
        marvelCharacter.setValuesForKeys(["name": favorite.name, "desc": favorite.description, "thumbnailPath": favorite.thumbnail.path, "thumbnailExtension": favorite.thumbnail.imageExtension])
        context.delete(marvelCharacter)
        do {
            try context.save()
        } catch let error {
            print("\n[!] ERROR: \(error.localizedDescription)")
        }
    }

    func getFavorites() -> [Character] {
        do {
            let fetchRequest = NSFetchRequest<MarvelCharacter>(entityName: "MarvelCharacter")
            let marvelCharacters = try context.fetch(fetchRequest)
            var favorites = [Character]()
            for marvelCharacter in marvelCharacters {
                let thumbnail = Thumbnail(path: marvelCharacter.thumbnailPath!, imageExtension: marvelCharacter.thumbnailExtension!)
                let favorite = Character(name: marvelCharacter.name!, description: marvelCharacter.desc!, thumbnail: thumbnail)
                favorites.append(favorite)
            }

            return favorites
        } catch let error {
            print("\n[!] ERROR: \(error.localizedDescription)")

            return []
        }
    }
}
