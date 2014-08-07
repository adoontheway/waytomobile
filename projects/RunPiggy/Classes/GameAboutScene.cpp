//
//  GameAboutScene.cpp
//  example12-1
//
//  Created by shuoquan man on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#include "GameAboutScene.h"
#include "GameMenuScene.h"

using namespace cocos2d;

Scene* GameAbout::createScene()
{
    Scene *scene = Scene::create();
    
    GameAbout *layer = GameAbout::create();
    
    scene->addChild(layer);
    
    return scene;
}
bool GameAbout::init()
{
    if ( !Layer::init() )
    {
        return false;
    }
    
    Size size =Director::getInstance()->getVisibleSize();    
    
    Sprite* bg = Sprite::create("back_1.png");
    bg->setScale(0.6f);
    bg->setPosition( Vec2(size.width/2, size.height/2) );
    this->addChild(bg, 0,0);
    Sprite *kuang = Sprite::create("tb.png");
    kuang->setScale(0.5);
    kuang->setRotation(90);
    kuang->setPosition(Vec2(size.width/2, size.height/2));
    this->addChild(kuang,2,2);

    char inf[256];
    sprintf(inf,"name:loli run\n\n program:shuoquan man\n\n art design:zuyi li\n\n company:hz books\n\n    powered by cocos2D-x");
	Label *myjineng = Label::createWithTTF(inf,"Marker Felt",20,Size(400,400),TextHAlignment::LEFT);
    myjineng->setAnchorPoint(Vec2(0,1));
	myjineng->setColor(Color3B(0,0,0));
    myjineng->setPosition(Vec2(100,260));
    this->addChild(myjineng);
    //关于标签
    Sprite* abouttitle = Sprite::create("about.png");
    abouttitle->setScale(0.5);
	abouttitle->setPosition(Vec2(size.width/2, size.height - 20));
    this->addChild(abouttitle,3,3);
    //返回
	MenuItemImage *back = MenuItemImage::create("backA.png", "backB.png",CC_CALLBACK_1(GameAbout::menuBackCallback,this));
    back->setScale(0.5);
    back->setPosition(Vec2(size.width - 20,size.height - 20));
    back->setEnabled(false);
    Menu* mainmenu = Menu::create(back);
    mainmenu->setPosition(Vec2(0,0));
    this->addChild(mainmenu,3,4);
    return true;
}
void GameAbout::menuBackCallback(Ref* pSender){
   Director::getInstance()->setDepthTest(true);
   Director::getInstance()->replaceScene(TransitionPageTurn::create(0.5,GameMenu::createScene(), true));
}
void GameAbout::onEnterTransitionDidFinish()
{
    Layer::onEnterTransitionDidFinish();
   Director::getInstance()->setDepthTest(false);
}

void GameAbout::onExitTransitionDidStart()
{
    Layer::onExitTransitionDidStart();
}
void GameAbout::onExit(){
    Layer::onExit();
}
void GameAbout::onEnter(){
    Layer::onEnter();
	Node* mainmenu = this->getChildByTag(4);
    Vector<Node*> temp = mainmenu->getChildren();
    ((MenuItemImage *)temp.at(0))->setEnabled(true);
}