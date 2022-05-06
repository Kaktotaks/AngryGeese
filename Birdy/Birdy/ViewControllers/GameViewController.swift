//
//  GameViewController.swift
//  Birds
//
//  Created by Леонід Шевченко on 28.03.2022.
//

import UIKit
import SpriteKit
import GameplayKit

protocol SceneManagerDelegate {
    func presentMenuScene()
    func presentLevelScene()
    func presentGameSceneFor(level: Int)
}

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentMenuScene()
    }
}


extension GameViewController: SceneManagerDelegate {
    func presentMenuScene() {
        let menuScene = MenuScene()
        menuScene.sceneManagerDelegate = self
        present(scene: menuScene)
    }
    
    func presentLevelScene() {
        let levelScene = LevelScene()
        levelScene.sceneManagerDelegate = self
        present(scene: levelScene)
    }
    
    func presentGameSceneFor(level: Int) {
        let sceneName = "GameScene\(level)"
        if let gameScene = SKScene(fileNamed: sceneName) as? GameScene {
            gameScene.sceneManagerDelegate = self
            gameScene.level = level
            
            if gameScene.level == 9 {
                let alert = UIAlertController(title:
"""
We ask you for help 🙏🏼
""",
                                              message:
"""
All funds from the purchase of the next level will be transferred as humanitarian aid to Ukrainian families affected by Russia's invasion of the territory of Ukraine.
Stay strong with Ukraine 🇺🇦
""",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Lets do it 🫶🏼",
                                              style: .cancel,
                                              handler: { action in
                    iAPManager.shared.purchase(completion: {
                        self.present(scene: gameScene)
                    })
                }))
                
                alert.addAction(UIAlertAction(title: "No thanks",
                                              style: .destructive,
                                              handler: { action in
                    self.dismiss(animated: true)
                }))
                
                present(alert, animated: true)
            } else {
                present(scene: gameScene)
            }
        }
    }
    
    func present(scene: SKScene) {
        if let view = self.view as! SKView? {
            if let gestureRecognizers = view.gestureRecognizers {
                for recognizer in gestureRecognizers {
                    view.removeGestureRecognizer(recognizer)
                }
            }
            scene.scaleMode = .resizeFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
        }
    }
}
