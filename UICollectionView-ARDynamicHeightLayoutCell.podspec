Pod::Spec.new do |s|
  s.name         = "UICollectionView-ARDynamicHeightLayoutCell"
  s.version      = "1.0.3"
  s.summary      = "Automatically UICollectionViewCell size calculating."
  s.homepage     = "https://github.com/AugustRush/UICollectionView-ARDynamicHeightLayoutCell"
  s.license      = "MIT"
  s.author             = { "August" => "819373341@qq.com" }
  s.authors            = { "August" => "819373341@qq.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/AugustRush/UICollectionView-ARDynamicHeightLayoutCell.git", :tag => "1.0.3" }
  s.source_files  = "UICollectionView+ARDynamicHeightLayoutCell", "UICollectionView+ARDynamicHeightLayoutCell/**/*.{h,m}"
  s.exclude_files = "UICollectionView+ARDynamicHeightLayoutCell/Exclude"
  s.public_header_files = "UICollectionView+ARDynamicHeightLayoutCell/*.h"
  s.framework  = "UIKit"
  s.frameworks = "UIKit", "Foundation"
  s.requires_arc = true
end