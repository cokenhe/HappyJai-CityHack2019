//
//  File.swift
//  HappyJai
//
//  Created by Tony Cheng on 26/1/2019.
//  Copyright © 2019 tychengaf. All rights reserved.
//

import UIKit

struct ChatMessage {
    let text: String
    let isIncoming : Bool
    let date: Date
}

class MessageBank {

    static let instance = MessageBank()
    
    var chatMessages = [ChatMessage]()
    init() {
//        chatMessages.append(ChatMessage(text: "Here's my very first Message", isIncoming: false, date: Date.dateFromCustomString(customString: "1/1/2017")))
//        chatMessages.append(ChatMessage(text: "Lorem ipsum dolor sit amet, munere similique theophrastus ius ut. In putant habemus democritum duo. Cu pri graeci meliore, nostrud bonorum vel ad. Eum an zril tacimates.", isIncoming: true, date: Date.dateFromCustomString(customString: "1/1/2017")))
//        chatMessages.append(ChatMessage(text: "Yo", isIncoming: false, date:  Date.dateFromCustomString(customString: "21/5/2017")))
//        chatMessages.append(ChatMessage(text: "Hey dude what's up! Long time no see la wor", isIncoming: true, date: Date.dateFromCustomString(customString: "21/5/2017")))
//        chatMessages.append(ChatMessage(text: "This is a message from the third section", isIncoming: false, date: Date.dateFromCustomString(customString: "22/5/2017")))
//        chatMessages.append(ChatMessage(text: "A Response", isIncoming: true, date: Date.dateFromCustomString(customString: "22/5/2017")))
//        chatMessages.append(ChatMessage(text: "A super super super super super super super super super super super super super super super super super super super super long message", isIncoming: true, date: Date.dateFromCustomString(customString: "22/5/2017")))
        chatMessages.append(ChatMessage(text: "I am very sad.", isIncoming: false, date: Date.dateFromCustomString(customString: "1/1/2017")))
        chatMessages.append(ChatMessage(text: "Why do you feel so sad?", isIncoming: true, date: Date.dateFromCustomString(customString: "1/1/2017")))
        chatMessages.append(ChatMessage(text: "I failed my exam today", isIncoming: false, date:  Date.dateFromCustomString(customString: "21/5/2017")))
        chatMessages.append(ChatMessage(text: "Why did you fail your exam?", isIncoming: true, date: Date.dateFromCustomString(customString: "21/5/2017")))
        chatMessages.append(ChatMessage(text: "I cannot answer most of the question.", isIncoming: false, date: Date.dateFromCustomString(customString: "22/5/2017")))
        chatMessages.append(ChatMessage(text: "Did you study properly", isIncoming: true, date: Date.dateFromCustomString(customString: "22/5/2017")))
        chatMessages.append(ChatMessage(text: "I am not sure, maybe not, I think.", isIncoming: false, date: Date.dateFromCustomString(customString: "22/5/2017")))
        chatMessages.append(ChatMessage(text: "See, that’s the problem.", isIncoming: true, date: Date.dateFromCustomString(customString: "1/1/2017")))
        chatMessages.append(ChatMessage(text: "What’s the problem? Can you tell me?", isIncoming: false, date: Date.dateFromCustomString(customString: "1/1/2017")))
        chatMessages.append(ChatMessage(text: "You are not sure about your effort.", isIncoming: true, date:  Date.dateFromCustomString(customString: "21/5/2017")))
        chatMessages.append(ChatMessage(text: "Oh I see, now I understand.", isIncoming: false, date: Date.dateFromCustomString(customString: "21/5/2017")))
        chatMessages.append(ChatMessage(text: "God. You should improve by trying your very best", isIncoming: true, date: Date.dateFromCustomString(customString: "22/5/2017")))
        chatMessages.append(ChatMessage(text: "Yes thanks a lot.", isIncoming: false, date: Date.dateFromCustomString(customString: "22/5/2017")))
        for message in chatMessages {
            if message.isIncoming == false{
                ClassificationService.instance.addMessage(text: message.text)
            }
        }

    }
    
    
}
