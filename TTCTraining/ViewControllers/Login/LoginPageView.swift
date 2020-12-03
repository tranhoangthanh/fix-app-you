//
//  LoginPageView.swift
//  TTCTraining
//
//  Created by Apple on 10/30/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class LoginPageView: UIPageViewController{
    lazy var subviewControllers:[UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "DangNhap"),UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "DangKi")]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([subviewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    func didChangePage(_ page:Int) {
        setViewControllers([subviewControllers[page]], direction: .forward, animated: true, completion: nil)
    }
}
