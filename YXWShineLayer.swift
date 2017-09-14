import UIKit

@objc public class YXWShineLayer: CALayer, CAAnimationDelegate {
    
    let shapeLayer =  CAShapeLayer()
    
    var fillColor: UIColor = UIColor(rgb: (255, 102, 102)) {
        willSet {
            shapeLayer.strokeColor = newValue.cgColor
        }
    }
    
    var params: YXWShineParams = YXWShineParams()
    
    var displaylink: CADisplayLink?
    
    var endAnim: (()->Void)?
    
    //MARK: Public Methods
    func startAnim() {
        let anim = CAKeyframeAnimation(keyPath: "path")
        anim.duration = params.animDuration * 0.1
        let size = frame.size
        let fromPath = UIBezierPath(arcCenter: CGPoint.init(x: size.width/2, y: size.height/2), radius: 1, startAngle: 0, endAngle: CGFloat(Double.pi) * 2.0, clockwise: false).cgPath
        let toPath = UIBezierPath(arcCenter: CGPoint.init(x: size.width/2, y: size.height/2), radius: size.width/2 * CGFloat(params.shineDistanceMultiple), startAngle: 0, endAngle: CGFloat(Double.pi) * 2.0, clockwise: false).cgPath
        anim.delegate = self
        anim.values = [fromPath, toPath]
        anim.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        anim.isRemovedOnCompletion = false
        anim.fillMode = kCAFillModeForwards
        shapeLayer.add(anim, forKey: "path")
        if params.enableFlashing {
            startFlash()
        }
    }
    
    
    //MARK: Initial Methods
    override init() {
        super.init()
        initLayers()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        initLayers()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Privater Methods
    private func initLayers() {
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = fillColor.cgColor
        shapeLayer.lineWidth = 1.5
        addSublayer(shapeLayer)
    }
    
    private func startFlash() {
        displaylink = CADisplayLink(target: self, selector: #selector(flashAction))
        if #available(iOS 10.0, *) {
            displaylink?.preferredFramesPerSecond = 6
        }else {
            displaylink?.frameInterval = 10
        }
        displaylink?.add(to: .current, forMode: .commonModes)
    }
    
    @objc private func flashAction() {
        let index = Int(arc4random()%UInt32(params.colorRandom.count))
        shapeLayer.strokeColor = params.colorRandom[index].cgColor
    }
    
    //MARK: CAAnimationDelegate
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            displaylink?.invalidate()
            displaylink = nil
            shapeLayer.removeAllAnimations()
            let angleLayer = YXWShineAngleLayer(frame: bounds, params: params)
            addSublayer(angleLayer)
            angleLayer.startAnim()
            endAnim?()
        }
    }
}
