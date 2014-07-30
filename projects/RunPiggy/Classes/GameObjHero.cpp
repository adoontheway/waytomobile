//
//  GameObjHero.cpp
//  example12-1
//
//  Created by shuoquan man on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#include "GameObjHero.h"
#include "GameMainScene.h"
GameObjHero::GameObjHero(void)
{
}

GameObjHero::~GameObjHero(void)
{
}
Rect GameObjHero::rect()
{
    Size s = Size(100,125);
    return Rect(-s.width / 2, -s.height / 2, s.width, s.height);
}
void GameObjHero::touchDelegateRetain()
{
    this->retain();
}

void GameObjHero::touchDelegateRelease()
{
    this->release();
}
void GameObjHero::onEnter()
{
    Node::onEnter();
    this->setContentSize(Size(85,90));
	Director* pDirector = CCDirector::getInstance();

	auto listener = EventListenerTouchOneByOne::create();
    listener->onTouchBegan = CC_CALLBACK_2(GameObjHero::onTouchBegan, this);
   // _eventDispatcher->addEventListenerWithSceneGraphPriority(listener, this );

	pDirector->getEventDispatcher()->addEventListenerWithSceneGraphPriority(listener,this);

    Sprite * obj = Sprite::create("s_hurt.png");
    hurt = obj->getTexture();
    obj = Sprite::create("s_jump.png");
    jump = obj->getTexture();
    mainsprite = Sprite::create("s_1.png");
    //动画
    Animation * animation = Animation::create();
    animation->addSpriteFrameWithFile("s_1.png");
    animation->addSpriteFrameWithFile("s_2.png");
    animation->addSpriteFrameWithFile("s_3.png");
    animation->addSpriteFrameWithFile("s_4.png");
    animation->addSpriteFrameWithFile("s_5.png");
    animation->addSpriteFrameWithFile("s_6.png");
    animation->setDelayPerUnit(0.1f);
    animation->setRestoreOriginalFrame(true);
    //运行奔跑动画
    mainsprite->runAction(RepeatForever::create(Animate::create(animation)));
    state = 0;
    addChild(mainsprite);
}
void GameObjHero::setState(short var){
    if(state == var)
        return;
    state = var;
    switch(state){
        case 1://跳跃
            this->stopAllActions();
            mainsprite->stopAllActions();
            mainsprite->setTexture(jump);
			this->runAction(Sequence::create(JumpBy::create(2.5,Vec2(0,0),100,1),CallFunc::create(CC_CALLBACK_0(GameObjHero::jumpend ,this))));
            break;
        case 2://受伤
            this->stopAllActions();
            mainsprite->stopAllActions();
            mainsprite->setTexture(hurt);
            this->runAction(Sequence::create(Blink::create(3, 10),CallFunc::create(CC_CALLBACK_0(GameObjHero::hurtend,this))));
            ((GameMain *)this->getParent())->setover();
            break;
        case 0://奔跑动画
            this->stopAllActions();
            mainsprite->stopAllActions();
            Animation * animation = Animation::create();
            animation->addSpriteFrameWithFile("s_1.png");
            animation->addSpriteFrameWithFile("s_2.png");
            animation->addSpriteFrameWithFile("s_3.png");
            animation->addSpriteFrameWithFile("s_4.png");
            animation->addSpriteFrameWithFile("s_5.png");
            animation->addSpriteFrameWithFile("s_6.png");
            animation->setDelayPerUnit(0.1f);
            animation->setRestoreOriginalFrame(true);
            mainsprite->runAction(RepeatForever::create(Animate::create(animation)));
            break;
    }
}
void GameObjHero::jumpend(){
    setState(0);
}
void GameObjHero::hurtend(){
    setState(0);
}
void GameObjHero::onExit()
{
	Director* pDirector = Director::getInstance();
	pDirector->getEventDispatcher()->removeEventListenersForTarget(this);
    Node::onExit();
}    
bool GameObjHero::containsTouchLocation(Touch* touch)
{
    //return CCRect::CCRectContainsPoint(rect(), convertTouchToNodeSpaceAR(touch));
	return rect().containsPoint(convertTouchToNodeSpaceAR(touch));
}
bool GameObjHero::onTouchBegan(Touch* touch, Event* event)
{
    if(((GameMain *)this->getParent())->isover)
        return false;
    //设置运动状态
    setState(1);
    return true;   
}
void GameObjHero::onTouchMoved(Touch* touch, Event* event)
{
}
void GameObjHero::onTouchEnded(Touch* touch, Event* event)
{
}