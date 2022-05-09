//
//  LevelScene.swift
//  Birdy
//
//  Created by Леонід Шевченко on 05.04.2022.
//

import SpriteKit

class LevelScene: SKScene {
    
    var sceneManagerDelegate: SceneManagerDelegate?
    
    override func didMove(to view: SKView) {
        setupLevelSelection()
    }
    
    func setupLevelSelection() {
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.aspectScale(to: frame.size, width: true, multiplier: 1.1)
        background.zPosition = Zpositions.background
        addChild(background )
        
        
        var level = 1
        let columnStartingPoint = frame.midX/2
        let rowStartingPoint = frame.midY + frame.midY/2
        
        for row in 0..<3 {
            for column in 0..<3 {
                
                let levelButton = SpriteKitButton(defaultButtonImage: "levelButton", action: goToGameSceneFor, index: level)
                levelButton.position = CGPoint(x: columnStartingPoint + CGFloat(column) * columnStartingPoint, y: rowStartingPoint - CGFloat(row) * frame.midY/2)
                levelButton.zPosition = Zpositions.hudBackground
                addChild(levelButton)
                
                let levelLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
                levelLabel.fontSize = 200.0
                levelLabel.verticalAlignmentMode = .center
                levelLabel.text = "\(level)"
                levelLabel.aspectScale(to: levelButton.size, width: false, multiplier: 0.5)
                levelLabel.zPosition = Zpositions.hudLabel
                levelButton.addChild(levelLabel)
                levelButton.aspectScale(to: frame.size, width: false, multiplier: 0.2)
                level += 1
                
                if level == 10 {
                    
                    if iAPManager.shared.paymentStatus == 0 {
                        let finalLevelBoxButton = SpriteKitButton(defaultButtonImage: "finalLevel", action: goToGameSceneFor, index: 9)
                        
                        finalLevelBoxButton.position = CGPoint(x: columnStartingPoint + CGFloat(column) * columnStartingPoint, y: rowStartingPoint - CGFloat(row) * frame.midY/2)
                        finalLevelBoxButton.zPosition = Zpositions.hudBackground
                        finalLevelBoxButton.aspectScale(to: levelButton.size, width: false, multiplier: 1.0)
                        levelButton.removeFromParent()
                        addChild(finalLevelBoxButton)
                    } else {
                        let finalLevelBoxButtonPurchased = SpriteKitButton(defaultButtonImage: "finalLevelPurchased", action: goToGameSceneFor, index: 9)
                        
                        finalLevelBoxButtonPurchased.position = CGPoint(x: columnStartingPoint + CGFloat(column) * columnStartingPoint, y: rowStartingPoint - CGFloat(row) * frame.midY/2)
                        finalLevelBoxButtonPurchased.zPosition = Zpositions.hudBackground
                        finalLevelBoxButtonPurchased.aspectScale(to: levelButton.size, width: false, multiplier: 1.0)
                        levelButton.removeFromParent()
                        addChild(finalLevelBoxButtonPurchased)
                        
                    }
                }
            }
        }
    }
    
    func goToGameSceneFor(level: Int) {
        sceneManagerDelegate?.presentGameSceneFor(level: level)
    }
}
