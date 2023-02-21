//
//  CoreDataManager.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/18/23.
//

import CoreData
import UIKit

protocol CoreDataManagerInterface {
    func save(model: GameResult)
    func fetch() -> [Games]
    func delete(model: GameResult)
    func deleteAll()
    func getItemCount() -> Int
    func deleteFavorites(model: Games)
    func simplySave()
}
//MARK: - CoreDataManagerInterface Methods
@available(iOS 13.0, *)
final class CoreDataManager: CoreDataManagerInterface {
    //MARK: - Components
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func deleteFavorites(model: Games) {
        context?.delete(model)
        try? context?.save()
       }
    func save(model: GameResult) {
        let games = Games(context: context!)
        games.name = model.name
        games.image = model.background_image
        let genresArray = model.genres.map {$0.name}
        games.genre = genresArray as NSObject
        games.metacritic = Int32(model.metacritic!)
        games.id = String(model.id)
        do {
            try context?.save()
        } catch {
            print("failed")
        }
    }
    func fetch() -> [Games] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
        do {
            let fetchedGames = try context?.fetch(request) as! [Games]
            return fetchedGames.reversed()
        } catch {
            return []
        }
    }
    func delete(model: GameResult) {
        let savedNews = fetch()
        var newsDelete: Games!
        for savedNew in savedNews {
            if savedNew.name == model.name {
                newsDelete = savedNew
            }
        }
        context?.delete(newsDelete)
        do {
            try context?.save()
        } catch {
            print(error.localizedDescription)
    }
        }
    func deleteAll() {
        let savedGames = fetch()
        for savedGame in savedGames {
            context?.delete(savedGame)
        }
        do {
            try context?.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    func getItemCount() -> Int {
            let context = self.context
            let request: NSFetchRequest<Games> = Games.fetchRequest()
            let count = try? context?.count(for: request)
            return count ?? 0
        }
    func simplySave() {
        do {
            try context?.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
