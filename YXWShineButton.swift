import UIKit


@objc public class YXWShineButton: UIControl {
    
    /// 更多的配置参数
    public var params: YXWShineParams {
        didSet {
            clickLayer.animDuration = params.animDuration/3
            shineLayer.params       = params
        }
    }
    
    /// 未点击的颜色
    public var color: UIColor = UIColor.lightGray {
        willSet {
            clickLayer.color = newValue
        }
    }
    
    /// 点击后的颜色
    public var fillColor: UIColor   = UIColor(rgb: (255, 102, 102)) {
        willSet {
            clickLayer.fillColor = newValue
            shineLayer.fillColor = newValue
        }
    }
    
    /// button的图片
    public var image: YXWShineImage = .heart {
        willSet {
            clickLayer.image = newValue
            
        }
    }
    
    /// 是否点击的状态
    public override var isSelected:Bool {
        
        didSet {
            clickLayer.clicked = isSelected
        }
        
    }
    
    public var currentSelected:Bool = false {
        
        willSet {
            clickLayer.clicked = currentSelected
        }
        
    }
    
    private var clickLayer = YXWShineClickLayer()
    
    private var shineLayer = YXWShineLayer()
    
    //MARK: Initial Methods
    public init(frame: CGRect, params: YXWShineParams) {
        self.params = params
        super.init(frame: frame)
        initLayers()
    }
    
    public override init(frame: CGRect) {
        params = YXWShineParams()
        super.init(frame: frame)
        initLayers()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        params = YXWShineParams()
        super.init(coder: aDecoder)
        layoutIfNeeded()
        initLayers()
    }
    
    
    public override func sendActions(for controlEvents: UIControlEvents) {
        
        super.sendActions(for: controlEvents)
        
        weak var weakSelf = self
        
        if clickLayer.clicked == false {
            shineLayer.endAnim = { Void in
                weakSelf?.clickLayer.clicked = !(weakSelf?.clickLayer.clicked ?? false)
                weakSelf?.clickLayer.startAnim()
                weakSelf?.currentSelected = weakSelf?.clickLayer.clicked ?? false
            }
            shineLayer.startAnim()
        }else {
            clickLayer.clicked = !clickLayer.clicked
            currentSelected = clickLayer.clicked
        }
        
    }
    
    //MARK: Override
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        weak var weakSelf = self
        
        if clickLayer.clicked == false {
            shineLayer.endAnim = { Void in
                weakSelf?.clickLayer.clicked = !(weakSelf?.clickLayer.clicked ?? false)
                weakSelf?.clickLayer.startAnim()
                weakSelf?.currentSelected = weakSelf?.clickLayer.clicked ?? false
            }
            shineLayer.startAnim()
        }else {
            clickLayer.clicked = !clickLayer.clicked
            currentSelected = clickLayer.clicked
        }
    }
    
    //MARK: Privater Methods
    private func initLayers() {
        clickLayer.animDuration = params.animDuration/3
        shineLayer.params       = params
        clickLayer.frame = bounds
        shineLayer.frame = bounds
        layer.addSublayer(clickLayer)
        layer.addSublayer(shineLayer)
        
    }
    
    
}
