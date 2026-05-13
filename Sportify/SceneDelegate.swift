//
//  SceneDelegate.swift
//  Sportify
//
//  Created by Mina on 05/05/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


//    func scene(
//            _ scene: UIScene,
//            willConnectTo session: UISceneSession,
//            options connectionOptions:
//            UIScene.ConnectionOptions
//        ) {
//
//            guard let windowScene =
//                    (scene as? UIWindowScene)
//            else {
//                return
//            }
//
//            let window =
//            UIWindow(windowScene: windowScene)
//
//            let onboarding =
//            AppRouterImpl.createOnboardingModule()
//
//            let navigationController =
//            UINavigationController(
//                rootViewController: onboarding
//            )
//
//            navigationController
//                .navigationBar
//                .prefersLargeTitles = true
//
//            window.rootViewController =
//            navigationController
//
//            self.window = window
//
//            window.makeKeyAndVisible()
//        }
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let windowScene =
                (scene as? UIWindowScene)
        else {
            return
        }

        let window = UIWindow(
            windowScene: windowScene
        )

        // MARK: - Storyboard

        let storyboard = UIStoryboard(
            name: "Main",
            bundle: nil
        )

        // MARK: - Team Details Screen

        let vc =
        storyboard.instantiateViewController(
            withIdentifier: "teamEvents"
        ) as! teamDetailsViewController

        // MARK: - Dummy Team

        let dummyTeam = Team(
            id: 96,
            name: "Liverpool",
            logoURL: URL(
                string: "https://logos-world.net/wp-content/uploads/2020/06/Liverpool-Logo.png"
            ),
            players: [

                Player(
                    id: 1,
                    name: "Alisson Becker",
                    number: 1,
                    imageURL: URL(
                        string: "https://resources.premierleague.com/premierleague/photos/players/250x250/p116535.png"
                    ),
                    position: .goalkeeper
                ),

                Player(
                    id: 2,
                    name: "Virgil van Dijk",
                    number: 4,
                    imageURL: URL(
                        string: "https://resources.premierleague.com/premierleague/photos/players/250x250/p97032.png"
                    ),
                    position: .defender
                ),

                Player(
                    id: 3,
                    name: "Trent Alexander-Arnold",
                    number: 66,
                    imageURL: URL(
                        string: "https://resources.premierleague.com/premierleague/photos/players/250x250/p169187.png"
                    ),
                    position: .defender
                ),

                Player(
                    id: 4,
                    name: "Alexis Mac Allister",
                    number: 10,
                    imageURL: URL(
                        string: "https://resources.premierleague.com/premierleague/photos/players/250x250/p146941.png"
                    ),
                    position: .midfielder
                ),

                Player(
                    id: 5,
                    name: "Dominik Szoboszlai",
                    number: 8,
                    imageURL: URL(
                        string: "https://resources.premierleague.com/premierleague/photos/players/250x250/p220566.png"
                    ),
                    position: .midfielder
                ),

                Player(
                    id: 6,
                    name: "Mohamed Salah",
                    number: 11,
                    imageURL: URL(
                        string: "https://resources.premierleague.com/premierleague/photos/players/250x250/p118748.png"
                    ),
                    position: .forward
                ),

                Player(
                    id: 7,
                    name: "Darwin Núñez",
                    number: 9,
                    imageURL: URL(
                        string: "https://resources.premierleague.com/premierleague/photos/players/250x250/p447203.png"
                    ),
                    position: .forward
                )
            ]
        )

        // MARK: - Dependencies

        let remoteDataSource =
        SportifyRemoteDataSourceImpl()

        let repository =
        TeamDetailsRepositoryImpl(
            remoteDataSource: remoteDataSource
        )

        let router = AppRouterImpl()

        let presenter =
        TeamDetailsPresenterImpl(
            view: vc,
            repository: repository,
            router: router
        )

        // MARK: - Configure Presenter

        presenter.teamId = dummyTeam.id
        presenter.sport = .football

        // MARK: - Inject

        vc.presenter = presenter
        vc.selectedTeam = dummyTeam

        // MARK: - Navigation

        let navigationController =
        UINavigationController(
            rootViewController: vc
        )

        navigationController
            .navigationBar
            .prefersLargeTitles = true

        window.rootViewController =
        navigationController

        self.window = window

        window.makeKeyAndVisible()
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

