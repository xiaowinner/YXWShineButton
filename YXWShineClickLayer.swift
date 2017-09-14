import UIKit

@objc public class YXWShineClickLayer: CALayer {
    
    var color: UIColor = UIColor.lightGray
    
    var fillColor: UIColor = UIColor(rgb: (255, 102, 102))
    
    var image: YXWShineImage = .heart {
        didSet {
            maskLayer.contents = image.getImage()?.cgImage
        }
    }
    
    var animDuration: Double = 0.5
    
    var clicked: Bool = false {
        didSet {
            if clicked {
                backgroundColor = fillColor.cgColor
            }else {
                backgroundColor = color.cgColor
            }
        }
    }
    
    let maskLayer = CALayer()
    
    //MARK: Public Methods
    func startAnim() {
        let anim = CAKeyframeAnimation(keyPath: "transform.scale")
        anim.duration  = animDuration
        anim.values = [0.4, 1, 0.9, 1]
        anim.calculationMode = kCAAnimationCubic
        maskLayer.add(anim, forKey: "scale")
    }
    
    //MARK: Override
    override public func layoutSublayers() {
        
        maskLayer.frame = bounds
        
        if clicked {
            
            backgroundColor = fillColor.cgColor
            
        }else {
            
            backgroundColor = color.cgColor
            
        }
        
        maskLayer.contents = image.getImage()?.cgImage
        
    }
    
    
    //MARK: Initial Methods
    override init() {
        
        super.init()
        
        mask = maskLayer
        
        
    }
    
    override init(layer: Any) {
        
        super.init(layer: layer)
        
        if mask == nil {
            
            mask = maskLayer
            
        }
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
