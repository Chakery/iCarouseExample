//
//  ViewController.swift
//  carouseExample
//
//  Created by Chakery on 2017/3/8.
//  Copyright © 2017年 Chakery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var carousel: iCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carousel = iCarousel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 300))
        carousel.type = .custom
        carousel.delegate = self
        carousel.dataSource = self
        carousel.isPagingEnabled = true
        carousel.backgroundColor = .green
        view.addSubview(carousel)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController: iCarouselDelegate {
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        print("click \(index)")
    }
}

extension ViewController: iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 10
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let w = carousel.bounds.width - 60
        let itemView = UIView(frame: CGRect(x: 0, y: 0, width: w, height: 300))
        itemView.layer.cornerRadius = 8.0
        itemView.backgroundColor = .blue
        
        let label = UILabel(frame: itemView.bounds)
        label.text = "\(index)"
        label.textColor = UIColor.white
        label.textAlignment = .center
        itemView.addSubview(label)
        
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, itemTransformForOffset offset: CGFloat, baseTransform transform: CATransform3D) -> CATransform3D {
        let maxScale: CGFloat = 1.0
        let minScale: CGFloat = 0.9
        var transform: CATransform3D = transform
        if offset <= 1 && offset >= -1 {
            let tempScale = offset < 0 ? 1 + offset : 1 - offset
            let slope = (maxScale - minScale) / 1
            let scale = minScale + slope * tempScale
            transform = CATransform3DScale(transform, scale, scale, 1)
        } else {
            transform = CATransform3DScale(transform, minScale, minScale, 1)
        }
        return CATransform3DTranslate(transform, offset * carousel.itemWidth * 1.1, 0.0, 0.0)
    }
    
    func translationy(offset: CGFloat) -> CGFloat {
        if offset >= 0 && offset < 1 {
            return offset - 0.5
        } else if offset < 0 {
            return offset * 0.5 - 0.5
        }
        return 0.5 + (offset - 1.0) * 0.5 / 12.0
    }
}

