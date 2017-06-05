//
//  MenuScene.swift
//  Fear The Dead
//
//  Created by Morten Faarkrog on 12/09/15.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {

  var soundToPlay: String?
  
  var msg = "輸了！按一下重玩"
  var levelFileName = ""
    
  init(size: CGSize, won: Bool, currentLevelSceneName: String) {
    super.init(size: size)
    
    if won == true {
      let nextLevelNumber = String(Int(getLevel(currentLevelSceneName))! + 1)
      msg = "第\(nextLevelNumber)關"
      self.levelFileName = "Level\(nextLevelNumber)"
    }
    else {
      msg = msg + "第\(getLevel(currentLevelSceneName))關"
      self.levelFileName = currentLevelSceneName
    }
  }
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMove(to view: SKView) {
    self.backgroundColor = SKColor(red: 0, green:0, blue:0, alpha: 1)
    
    // Setup label
    let label = SKLabelNode(text: self.msg)
    label.fontName = "AvenirNext-Bold"
    label.fontSize = 65
    label.fontColor = UIColor.white
    label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
    
    // Play sound
    if let soundToPlay = soundToPlay {
      self.run(SKAction.playSoundFileNamed(soundToPlay, waitForCompletion: false))
    }
    
    self.addChild(label)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    let gameScene = GameScene(fileNamed: self.levelFileName)
    let transition = SKTransition.flipVertical(withDuration: 1.0)
    let skView = self.view as SKView!
    gameScene?.scaleMode = .aspectFill
    skView?.presentScene(gameScene!, transition: transition)
  }

  func getLevel(_ level: String) -> String {
    var result = level
    let start = level.startIndex
    let end = level.index(start, offsetBy: 5)
    let range = Range(start..<end)
    result.removeSubrange(range)
    return result
  }
}
