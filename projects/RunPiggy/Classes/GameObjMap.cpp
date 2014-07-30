//
//  GameObjMap.cpp
//  example12-1
//
//  Created by shuoquan man on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#include "GameObjMap.h"
#include "GameConst.h"
#include "GameObjStar.h"

GameObjMap::GameObjMap(){
    
}

GameObjMap::~GameObjMap(){
    
}
void GameObjMap::bg1change(){
    //运动出屏幕重设位置，运动
    Sprite * bg = (Sprite *)this->getChildByTag(0);
    bg->setPosition(Vec2(480,320));
	bg->runAction(Sequence::create(MoveBy::create(20,Vec2(-960,0)),CallFunc::create(CC_CALLBACK_0(GameObjMap::bg1change,this))));
    for(int i = 0;i < 5;i ++){
        ((GameObjStar *)stars1->at(i))->set_visable(true);
    }
}
void GameObjMap::bg2change(){
    //运动出屏幕重设位置，运动
    Sprite * bg = (Sprite *)this->getChildByTag(1);
    bg->setPosition(Vec2(480,320));
    bg->runAction(Sequence::create(MoveBy::create(20,Vec2(-960,0)),CallFunc::create(CC_CALLBACK_0(GameObjMap::bg2change,this))));
    for(int i = 0;i < 5;i ++){
        ((GameObjStar *)stars2->at(i))->set_visable(true);
    }
}
void GameObjMap::onEnter(){
    Node::onEnter();
	Size size = Director::getInstance()->getWinSize();
    this->setContentSize(Size(960,320));
    Sprite* bg1 = Sprite::create("back_1.png");
    bg1->setScale(0.5);
    bg1->setAnchorPoint(Vec2(0,1));
    bg1->setPosition(Vec2(0, size.height) );
    this->addChild(bg1,0,0);
    Sprite* bgdi1 = Sprite::create("back_5.png");
    bgdi1->setAnchorPoint(Vec2(0,0));
    bgdi1->setPosition(Vec2(0,-124) );
    bg1->addChild(bgdi1,1);
    Sprite* bg2 = Sprite::create("back_1.png");
    bg2->setScale(0.5);
    bg2->setAnchorPoint(Vec2(0,1));
    bg2->setPosition(Vec2(size.width, size.height) );
    this->addChild(bg2,0,1);
    Sprite* bgdi2 = Sprite::create("back_5.png");
    bgdi2->setAnchorPoint(Vec2(0,0));
    bgdi2->setPosition(Vec2(0,-124) );
    bg2->addChild(bgdi2,1);
    bg1->runAction(Sequence::create(MoveBy::create(10,Vec2(-480,0)),CallFunc::create( CC_CALLBACK_0(GameObjMap::bg1change,this))));
    bg2->runAction(Sequence::create(MoveBy::create(20,Vec2(-960,0)),CallFunc::create( CC_CALLBACK_0(GameObjMap::bg2change,this))));
   // stars1 = CCArray::create(5);
   // stars2 = CCArray::create(5);
	stars1=new Vector<GameObjStar*>(5);
	stars2=new Vector<GameObjStar*>(5);
    for(int i = 0;i < 5;i ++){
        GameObjStar* obj = new GameObjStar();
        obj->setPosition(Vec2(172 + 192 * i,350));
        stars1->insert(i,obj);
        bg1->addChild(obj,3);
        obj = new GameObjStar();
        obj->setPosition(Vec2(172 + 192 * i,350));
        stars2->insert(i,obj);
        bg2->addChild(obj,3);
    }
    //stars1->retain();
    //stars2->retain();
    //星星，植物等大图素的添加
    for(int i = 0;i < 7;i ++){
        Sprite* roaddi;
        Sprite* plant;
        if(bg1shu[i] != -1){
           Sprite* road;
           switch(bg1shu[i]){
            case 0:
                plant = Sprite::create("back_2.png");
                plant->setAnchorPoint(Vec2(0.5,0));
                plant->setPosition( Vec2(128 * i + 64,117) );
                bg1->addChild(plant,1);
                road = Sprite::create("road_2.png");
                road->setAnchorPoint(Vec2(0,0));
                road->setPosition( Vec2(128 * i,0) );
                roaddi = Sprite::create("road_3.png");
                roaddi->setAnchorPoint(Vec2(0,1));
                roaddi->setPosition( Vec2(128 * i,0) );
                bg1->addChild(roaddi,1);
                break;
            case 1:
                road = Sprite::create("road_1.png");
                road->setAnchorPoint(Vec2(0,0));
                road->setPosition( Vec2(26 + 128 * i,0) );
                roaddi = Sprite::create("road_4.png");
                
                roaddi->setAnchorPoint(Vec2(0,1));
                roaddi->setPosition( Vec2(26 + 128 * i,0) );
                bg1->addChild(roaddi,1);
                break;
            case 2:
                plant = Sprite::create("enemy.png");
                plant->setAnchorPoint(Vec2(0.5,0));
                plant->setPosition( Vec2(128 * i + 64,112) );
                bg1->addChild(plant,1);
                road = Sprite::create("road_1.png");
                road->setFlippedX(true);
                road->setAnchorPoint(Vec2(0,0));
                road->setPosition( Vec2(128 * i,0) );
                roaddi = Sprite::create("road_4.png");
                roaddi->setFlippedX(true);
                roaddi->setAnchorPoint(Vec2(0,1));
                roaddi->setPosition( Vec2(128 * i,0) );
                bg1->addChild(roaddi,1);
                break;
            case 3:
                road = Sprite::create("road_5.png");
                road->setAnchorPoint(Vec2(0,0));
                road->setPosition( Vec2(128 * i,0) );
                break;
            
           }
           bg1->addChild(road,1);
        }
        if(bg2shu[i] != -1){
           Sprite* road1;
           switch(bg2shu[i]){
            case 0:
                road1 = Sprite::create("road_2.png");
                road1->setAnchorPoint(Vec2(0,0));
                road1->setPosition( Vec2(128 * i,0) );
                roaddi = Sprite::create("road_3.png");
                
                roaddi->setAnchorPoint(Vec2(0,1));
                roaddi->setPosition( Vec2(128 * i,0) );
                bg2->addChild(roaddi,1);
                break;
            case 1:
                plant = Sprite::create("back_3.png");
                plant->setAnchorPoint(Vec2(0.5,0));
                plant->setPosition( Vec2(128 * i + 128,117) );
                bg2->addChild(plant,1);
                road1 = Sprite::create("road_1.png");
                road1->setAnchorPoint(Vec2(0,0));
                road1->setPosition( Vec2(26 + 128 * i,0) );
                roaddi = Sprite::create("road_4.png");
                
                roaddi->setAnchorPoint(Vec2(0,1));
                roaddi->setPosition( Vec2(26 + 128 * i,0) );
                bg2->addChild(roaddi,1);
                break;
            case 2:
                road1 = Sprite::create("road_1.png");
                road1->setFlippedX(true);
                road1->setAnchorPoint(Vec2(0,0));
                road1->setPosition( Vec2(128 * i,0) );
                roaddi = Sprite::create("road_4.png");
                roaddi->setFlippedX(true);
                roaddi->setAnchorPoint(Vec2(0,1));
                roaddi->setPosition( Vec2(128 * i,0) );
                bg2->addChild(roaddi,1);
                break;
            case 3:
                road1 = Sprite::create("road_5.png");
                road1->setAnchorPoint(Vec2(0,0));
                road1->setPosition( Vec2(128 * i,0) );
                break;
                
            }
            bg2->addChild(road1,1);
        }
    }
    state = 0;
}

void GameObjMap::onExit(){
    Node::onExit();
}