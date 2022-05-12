//
//  LevelScene.swift
//  Birdy
//
//  Created by Леонід Шевченко on 05.04.2022.
//

import SpriteKit

class LevelScene: SKScene {
    
    static var shared = LevelScene()
    
    var sceneManagerDelegate: SceneManagerDelegate?
    
    public var level: Int {
        return UserDefaults.standard.integer(forKey: "levelCount")
    }
    
    override func didMove(to view: SKView) {
        setupLevelSelection()
        
    }
    
    func setupLevelSelection() {
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.aspectScale(to: frame.size, width: true, multiplier: 1.1)
        background.zPosition = Zpositions.background
        addChild(background )
        
        let levelButton = SpriteKitButton(defaultButtonImage: "levelButton", action: goToGameSceneFor, index: level + 1)
        levelButton.position = CGPoint(x: frame.midX, y: frame.midY)
        levelButton.zPosition = Zpositions.hudBackground
        addChild(levelButton)
        levelButton.aspectScale(to: frame.size, width: false, multiplier: 0.3)
        
        let levelLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        levelLabel.fontSize = 200.0
        levelLabel.verticalAlignmentMode = .center
        levelLabel.text = "\(level + 1)"
        levelLabel.aspectScale(to: levelButton.size, width: false, multiplier: 0.3)
        levelLabel.zPosition = Zpositions.hudLabel
        levelButton.addChild(levelLabel)
        
        if level >= 8 {
            if iAPManager.shared.paymentStatus == 0 {
                let finalLevelBoxButton = SpriteKitButton(defaultButtonImage: "finalLevel", action: goToGameSceneFor, index: 9)
                
                finalLevelBoxButton.position = CGPoint(x: frame.midX, y: frame.midY)
                finalLevelBoxButton.zPosition = Zpositions.hudBackground
                finalLevelBoxButton.aspectScale(to: levelButton.size, width: false, multiplier: 1.0)
                levelButton.removeFromParent()
                addChild(finalLevelBoxButton)
            } else {
                let finalLevelBoxButtonPurchased = SpriteKitButton(defaultButtonImage: "finalLevelPurchased", action: goToGameSceneFor, index: 9)
                
                finalLevelBoxButtonPurchased.position = CGPoint(x: frame.midX, y: frame.midY)
                finalLevelBoxButtonPurchased.zPosition = Zpositions.hudBackground
                finalLevelBoxButtonPurchased.aspectScale(to: levelButton.size, width: false, multiplier: 1.0)
                levelButton.removeFromParent()
                addChild(finalLevelBoxButtonPurchased)
                
            }
            
            let playFromBeginningButton = SpriteKitButton(defaultButtonImage: "playFromBeginningButton", action: playFromBeginning, index: 1)
            playFromBeginningButton.position = CGPoint(x: frame.midX, y: frame.midY - levelButton.frame.size.width * 1.2)
            playFromBeginningButton.zPosition = Zpositions.hudBackground
            addChild(playFromBeginningButton)
            playFromBeginningButton.aspectScale(to: frame.size, width: false, multiplier: 0.15)
        }
    }
    
    func goToGameSceneFor(level: Int) {
        sceneManagerDelegate?.presentGameSceneFor(level: level)
    }
    
    func playFromBeginning(level: Int) {
        sceneManagerDelegate?.presentGameSceneFor(level: 1)
    }
}
