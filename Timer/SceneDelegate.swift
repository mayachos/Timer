//
//  SceneDelegate.swift
//  Timer
//
//  Created by maya on 2021/07/17.
//

import UIKit

//デリゲート用の変数、関数
protocol backgroundTimerDelegate: class {
    // 【変更】elapsedTimeをInt型からFloat型に変更
    func setCurrentTimer(_ elapsedTime:Float)
    func deleteTimer()
    func checkBackground()
    var timerIsBackground:Bool { set get }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    weak var delegate: backgroundTimerDelegate?
    let ud = UserDefaults.standard

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
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
        if delegate?.timerIsBackground == true {
                    let calender = Calendar(identifier: .gregorian)
                    let date1 = ud.value(forKey: "date1") as! Date
                    let date2 = Date()
                    let elapsedTime = calender.dateComponents([.second], from: date1, to: date2).second!
            // 【変更】elapsedTimeをFloat()で囲む
            delegate?.setCurrentTimer(Float(elapsedTime))
                }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        func sceneWillResignActive(_ scene: UIScene) {
                ud.set(Date(), forKey: "date1")
                delegate?.checkBackground()
                delegate?.deleteTimer()
            }
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

