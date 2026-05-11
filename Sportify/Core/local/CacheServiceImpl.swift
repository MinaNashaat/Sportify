//
//  CacheServiceProtocol.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//

import UIKit
import CoreData

class CacheServiceImpl: CacheService {

    static let shared = CacheServiceImpl()

        private var context: NSManagedObjectContext!

        private init() {

            let appDelegate =
            UIApplication.shared.delegate as! AppDelegate

            context =
            appDelegate.persistentContainer.viewContext
        }

        private func save() {

            let appDelegate =
            UIApplication.shared.delegate as! AppDelegate

            appDelegate.saveContext()
        }

        func insertLeague(
            league: FavouriteLeague
        ) {

            let entity =
            NSEntityDescription.entity(
                forEntityName: "FavouriteLeague",
                in: context
            )!

            let newLeague =
            NSManagedObject(
                entity: entity,
                insertInto: context
            )

            newLeague.setValue(
                Int32(league.leagueId),
                forKey: "leagueId"
            )

            newLeague.setValue(
                league.leagueTitle,
                forKey: "leagueTitle"
            )

            newLeague.setValue(
                league.leagueImage,
                forKey: "leagueImage"
            )

            save()
        }

        func fetchLeagues()
        -> [FavouriteLeague] {

            let request =
            NSFetchRequest<NSManagedObject>(
                entityName: "FavouriteLeague"
            )

            do {

                let result =
                try context.fetch(request)

                return result.map { object in

                    FavouriteLeague(
                        leagueId:
                            Int(
                                object.value(
                                    forKey: "leagueId"
                                ) as? Int32 ?? 0
                            ),

                        leagueTitle:
                            object.value(
                                forKey: "leagueTitle"
                            ) as? String ?? "",

                        leagueImage:
                            object.value(
                                forKey: "leagueImage"
                            ) as? String ?? ""
                    )
                }

            } catch {

                print(error)
                return []
            }
        }

        func deleteLeague(
            leagueId: Int
        ) {

            let request =
            NSFetchRequest<NSManagedObject>(
                entityName: "FavouriteLeague"
            )

            request.predicate =
            NSPredicate(
                format: "leagueId == %d",
                leagueId
            )

            do {

                let result =
                try context.fetch(request)

                result.forEach {
                    context.delete($0)
                }

                save()

            } catch {

                print(error)
            }
        }

        func isFavourite(
            leagueId: Int
        ) -> Bool {

            let request =
            NSFetchRequest<NSManagedObject>(
                entityName: "FavouriteLeague"
            )

            request.predicate =
            NSPredicate(
                format: "leagueId == %d",
                leagueId
            )

            do {

                let result =
                try context.fetch(request)

                return !result.isEmpty

            } catch {

                return false
            }
        }
}
