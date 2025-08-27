//
//  SceneDelegate.swift
//  App
//
//

import Global
import GlobalUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var listCoordinator: ListViewCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        Theme.setup()

        GlobalContainer.reset()
        let manager = ModuleManager.shared
        manager.register(module: ForecastModule())
        manager.modules.forEach { $0.registerServices() }

        let window = UIWindow(windowScene: windowScene)

        // We keep a strong reference to the coordinator here and using as root coordinator for now.
        // Before is was created this way - ListViewCoordinator().start(window:),
        // and instance was immediately deallocated after start(),
        // and any weak self references inside its closures was nil.
        // By storing it in a property (listCoordinator), we ensure the
        // coordinator lives for the lifetime of the scene.

        let coordinator = ListViewCoordinator()
        coordinator.start(window: window)
        self.listCoordinator = coordinator

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
    }
}

