import Foundation
import SpriteKit

extension GameScene {
    
    //Пузырьки на экране
    func waterBubbleEmitter() {
        //создаем слой воды
        //путь к файлу
        let bubblePath = Bundle.main.path(forResource: "water", ofType: "sks")!
        let bubbleEmitter = NSKeyedUnarchiver.unarchiveObject(withFile: bubblePath) as! SKEmitterNode
        bubbleEmitter.zPosition = 0
        bubbleEmitter.position = CGPoint(x: frame.midX, y: -frame.height)
        bubbleEmitter.particlePositionRange.dx = frame.width + 90
        bubbleEmitter.advanceSimulationTime(20)
        bubbleLayer = SKNode()
        
        bubbleLayer.zPosition = 1
        addChild(bubbleLayer)
        bubbleLayer.addChild(bubbleEmitter)
    }
    
    //Пузырьки после героя
    func bubbleAfterHero(positionX: CGFloat, positionY: CGFloat, forResource: String) {
        let bubblePath = Bundle.main.path(forResource: forResource, ofType: "sks")!
        let bubbleEmitter = NSKeyedUnarchiver.unarchiveObject(withFile: bubblePath) as! SKEmitterNode
        bubbleEmitter.zPosition = -40
        bubbleEmitter.position.x = positionX
        bubbleEmitter.position.y = positionY
        bubbleEmitter.advanceSimulationTime(20)
        bubbleEmitter.targetNode = self
        fishLayer.addChild(bubbleEmitter)
    }

}
