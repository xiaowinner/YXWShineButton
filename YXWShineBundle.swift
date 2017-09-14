import UIKit

struct YXWShineBundle {
    
    // 当前的bundle
    static var bundle: Bundle {
        let bundle = Bundle(for: YXWShineButton.self)
        return bundle
    }
    
    // 存放资源的bundle
    static var YXWBundle: Bundle {
        let bundle = Bundle(path: self.bundle.path(forResource: "YXWShineButton", ofType: "bundle")!)
        return bundle!
    }
    
    static func imageFromBundle(_ imageName: String) -> UIImage? {
        let bundle = Bundle(path: YXWBundle.bundlePath + "/resource")
        if let path = bundle?.path(forResource: imageName, ofType: "png") {
            let image = UIImage(contentsOfFile: path)
            return image
        }
        return nil
    }
}

extension UIColor {
    public convenience init(rgb: (r: CGFloat, g: CGFloat, b: CGFloat)) {
        self.init(red: rgb.r/255, green: rgb.g/255, blue: rgb.b/255, alpha: 1.0)
    }
}
