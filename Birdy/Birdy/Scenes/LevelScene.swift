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
                
                let levelClosedButton = SpriteKitButton(defaultButtonImage: "levelButton", action: goToGameSceneFor, index: level)
                levelClosedButton.position = CGPoint(x: columnStartingPoint + CGFloat(column) * columnStartingPoint, y: rowStartingPoint - CGFloat(row) * frame.midY/2)
                levelClosedButton.zPosition = Zpositions.hudBackground
                addChild(levelClosedButton)
                
                let levelLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
                levelLabel.fontSize = 200.0
                levelLabel.verticalAlignmentMode = .center
                levelLabel.text = "\(level)"
                levelLabel.aspectScale(to: levelClosedButton.size, width: false, multiplier: 0.5)
                levelLabel.zPosition = Zpositions.hudLabel
                levelClosedButton.addChild(levelLabel)
                levelClosedButton.aspectScale(to: frame.size, width: false, multiplier: 0.2)
                level += 1
                
                if level == 10 {
                    let finalLevelBoxButton = SpriteKitButton(defaultButtonImage: "finalLevel", action: goToFinalLevel, index: 9)

                    finalLevelBoxButton.position = CGPoint(x: columnStartingPoint + CGFloat(column) * columnStartingPoint, y: rowStartingPoint - CGFloat(row) * frame.midY/2)
                    finalLevelBoxButton.zPosition = Zpositions.hudBackground
                    finalLevelBoxButton.aspectScale(to: levelClosedButton.size, width: false, multiplier: 1.0)
                    levelClosedButton.removeFromParent()
                    addChild(finalLevelBoxButton)
                }
            }
        }
    }
    
    func goToGameSceneFor(level: Int) {
        sceneManagerDelegate?.presentGameSceneFor(level: level)
    }
    
    func goToFinalLevel(level: Int) {
        iAPManager.shared.purchase(completion: {
            self.sceneManagerDelegate?.presentGameSceneFor(level: level)
        })
    }


}
