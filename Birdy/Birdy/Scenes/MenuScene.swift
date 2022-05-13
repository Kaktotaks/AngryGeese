//
//  MenuScene.swift
//  Birdy
//
//  Created by Леонід Шевченко on 05.04.2022.
//

import SpriteKit

class MenuScene: SKScene {
    
    var sceneManagerDelegate: SceneManagerDelegate?
    
    override func didMove(to view: SKView) {
        setupMenu()
    }

    func setupMenu() {
        let background = SKSpriteNode(imageNamed: "menuBackground")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.aspectScale(to: frame.size, width: true, multiplier: 1.0)
        background.zPosition = Zpositions.background
        addChild(background)
        
        
        let button = SpriteKitButton(defaultButtonImage: "playButton", action: goToLevelScene, index: 0)
        button.position = CGPoint(x: frame.midX, y: frame.midY * 0.8)
        button.aspectScale(to: frame.size, width: false, multiplier: 0.2)
        button.zPosition = Zpositions.hudLabel
        addChild(button)
        
        let levelBranch = SKSpriteNode(imageNamed: "levelBranch0")
        levelBranch.aspectScale(to: frame.size, width: false, multiplier: 0.15)
        levelBranch.position = CGPoint(x: frame.midX, y: frame.minY + levelBranch.frame.size.height)
        levelBranch.zPosition = Zpositions.hudLabel
            addChild(levelBranch)
        
            var levelFrames = [SKTexture]()
            let levelTextureAtlas = SKTextureAtlas(named: "levelBranch")

        for index in 0...LevelScene.shared.level {
                let textureName = "levelBranch" + String(index)
                levelFrames.append(levelTextureAtlas.textureNamed(textureName))
            }
            levelBranch.run(SKAction.repeat((SKAction.animate(with: levelFrames, timePerFrame: 0.3)), count: 1))
    }
    
    func goToLevelScene(_: Int) {
        sceneManagerDelegate?.presentLevelScene()
    }
}
