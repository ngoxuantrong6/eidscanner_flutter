import UIKit

class DashboardCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak private var _mainContainerView: UIView!
    @IBOutlet weak private var _iconImgView: UIImageView!
    @IBOutlet weak private var _titleLbl: UILabel!
    
    // --------------------------------------
    // MARK: Class
    // --------------------------------------
    
    static var height: CGFloat = 110.0
        
    // --------------------------------------
    // MARK: Private
    // --------------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _mainContainerView.layer.cornerRadius = kCornerRadius
        Graphics.dropShadow(self, color: ColorBrand.gtelBrandDarkGray, opacity: kShadowOpacity, radius: kShadowRadius, offset: kShadowOffset)
    }
    
    // --------------------------------------
    // MARK: Public
    // --------------------------------------

    func setup(title: String?, iconImageName: String?) {
        _titleLbl.text = !Utils.stringIsNullOrEmpty(title) ? title : "-"
        _iconImgView.image = UIImage(named: iconImageName ?? "")
    }

}
