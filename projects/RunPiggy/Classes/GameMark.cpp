//
//  GameMark.cpp
//  example12-1
//
//  Created by shuoquan man on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#include "GameMark.h"
GameMark::GameMark(void)
{
}

GameMark::~GameMark(void)
{
}
void GameMark::onExit()
{
    Node::onExit();
}
void GameMark::onEnter()
{
    Node::onEnter();
    Size size = Director::getInstance()->getWinSize(); 
    this->setContentSize(size);
   // bits = CCArray::create(5);
	bits = new Vector<Sprite*>(5);
	Sprite *title= Sprite::create("score.png");
    title->setPosition(Vec2(size.width/2 + 120,size.height - 15));
    title->setScale(0.5);
    addChild(title);
    for(int i = 0;i < 5;i ++){
        Sprite * shu = Sprite::create("shu.png");
        ui = shu->getTexture();
        shu->setScale(0.5);
        shu->setTextureRect(Rect(234,0,26,31));
        shu->setPosition(Vec2(size.width - 15 - i * 15,size.height - 15));
		bits->insert(i,shu);
        addChild(shu);
		shu->retain();
    }
    mark = 0;
}
void GameMark::addnumber(int var){
    //按位设置数字
    mark += var;
    int temp = mark % 10;
    if(temp > 0){
        ((Sprite *)bits->at(0))->setTexture(ui);
        ((Sprite *)bits->at(0))->setTextureRect(Rect((temp - 1) * 26,0,26,31)); 
    }else{
        ((Sprite *)bits->at(0))->setTexture(ui);
        ((Sprite *)bits->at(0))->setTextureRect(Rect(234,0,26,31)); 
    }
    temp = (mark % 100) / 10;
    if(temp > 0){
        ((Sprite *)bits->at(0))->setTexture(ui);
        ((Sprite *)bits->at(1))->setTextureRect(Rect((temp - 1) * 26,0,26,31));  
 
    }else{
        ((Sprite *)bits->at(0))->setTexture(ui);
        ((Sprite *)bits->at(1))->setTextureRect(Rect(234,0,26,31)); 
    }
    temp = (mark % 1000) / 100;
    if(temp > 0){
        ((Sprite *)bits->at(0))->setTexture(ui);
        ((Sprite *)bits->at(2))->setTextureRect(Rect((temp - 1) * 26,0,26,31)); 
 
    }else{
        ((Sprite *)bits->at(0))->setTexture(ui);
        ((Sprite *)bits->at(2))->setTextureRect(Rect(234,0,26,31));
    }
    temp = (mark % 10000) / 1000;
    if(temp > 0){
        ((Sprite *)bits->at(0))->setTexture(ui);
        ((Sprite *)bits->at(3))->setTextureRect(Rect((temp - 1) * 26,0,26,31)); 
 
    }else{
        ((Sprite *)bits->at(0))->setTexture(ui);
        ((Sprite *)bits->at(3))->setTextureRect(Rect(234,0,26,31)); 
    }
    temp = mark / 10000;
    if(temp > 0){
        ((Sprite *)bits->at(0))->setTexture(ui);
        ((Sprite *)bits->at(4))->setTextureRect(Rect((temp - 1) * 26,0,26,31));  
 
    }else{
        ((Sprite *)bits->at(0))->setTexture(ui);
        ((Sprite *)bits->at(4))->setTextureRect(Rect(234,0,26,31));
    }
}