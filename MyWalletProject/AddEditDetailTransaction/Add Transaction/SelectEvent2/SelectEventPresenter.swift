//
//  SelectEventPresenter.swift
//  MyWalletProject
//
//  Created by BAC Vuong Toan (VTI.Intern) on 10/2/20.
//  Copyright © 2020 Vuong Vu Bac Son. All rights reserved.
//

import Foundation

protocol SelectEventPresenterDelegate: class{
    func getDataEvent(data: [Event])
}

class SelectEventPresenter {
    
    var delegate: SelectEventPresenterDelegate?
    var selectEventUserCase: SelectEventUserCase?
    
    init(delegate: SelectEventPresenterDelegate, usecase: SelectEventUserCase) {
        self.delegate = delegate
        self.selectEventUserCase = usecase
        self.selectEventUserCase?.delegate = self
    }
    
    func reponseDataEvent(){
        //process data
        selectEventUserCase?.GetListEvent()
    }
}

extension SelectEventPresenter: SelectEventUserCaseDelegate {
    func responseData(data: [Event]) {
        //data here
        //reload data
        delegate?.getDataEvent(data: data)
    }
}

