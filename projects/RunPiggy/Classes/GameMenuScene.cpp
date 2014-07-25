//
//  GameMenuScene.cpp
//  example12-1
//
//  Created by shuoquan man on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#include "GameMenuScene.h"
#include "GameMainScene.h"
#include "GameAboutScene.h"
#include "SimpleAudioEngine.h"

using namespace cocos2d;
using namespace CocosDenshion;

Scene* GameMenu::createScene()
{
    auto *scene = Scene::create();
    
    auto *layer = GameMenu::create();
    
    scene->addChild(layer);
    
    return scene;
}
bool GameMenu::init()
{
    if ( !Layer::init() )
    {
        return false;
    }
    
	Size size = Director::getInstance()->getVisibleSize();    
    //菜单背景
    Sprite* bg = Sprite::create("MainMenu.png");
    bg->setScale(0.5);
    bg->setPosition( ccp(size.width/2, size.height/2) );
    this->addChild(bg, 0,0);
    //按钮
    MenuItemImage *newGameItem = MenuItemImage::create("newGameA.png", "newGameB.png",CC_CALLBACK_1(GameMenu::menuNewGameCallback,this));
    newGameItem->setScale(0.5);
    newGameItem->setPosition(ccp(size.width / 2 + 40,size.height / 2 - 20));
    newGameItem->setEnabled(false);
    MenuItemImage *continueItem = MenuItemImage::create("continueA.png", "continueB.png",CC_CALLBACK_1(GameMenu::menuContinueCallback,this));
    continueItem->setScale(0.5);
    continueItem->setPosition(ccp(size.width / 2 + 40,size.height / 2 - 60));
    continueItem->setEnabled(false);
    MenuItemImage *aboutItem = MenuItemImage::create("aboutA.png", "aboutB.png",CC_CALLBACK_1(GameMenu::menuAboutCallback,this));
    aboutItem->setScale(0.5);
    aboutItem->setPosition(ccp(size.width / 2 + 40,size.height / 2 - 100));
    aboutItem->setEnabled(false);
    soundItem = MenuItemImage::create("sound-on-A.png", "sound-on-B.png",CC_CALLBACK_1(GameMenu::menuSoundCallback,this));
    soundItem->setScale(0.5);
    soundItem->setEnabled(false);
    soundItem->setPosition(ccp(40,40));
    Menu* mainmenu = Menu::create(newGameItem,continueItem,aboutItem,soundItem,NULL);
    mainmenu->setPosition(ccp(0,0));
    this->addChild(mainmenu,1,3);
    issound = true;
    //初始化声音
	SimpleAudioEngine::sharedEngine()->preloadBackgroundMusic( std::string( FileUtils::getInstance()->fullPathFromRelativeFile("background.mp3",".")).c_str() );
    SimpleAudioEngine::sharedEngine()->setBackgroundMusicVolume(0.5);
    SimpleAudioEngine::sharedEngine()->playBackgroundMusic(std::string( FileUtils::getInstance()->fullPathFromRelativeFile("background.mp3",".")).c_str(), true);
    return true;
}
void GameMenu::onEnter(){
    Layer::onEnter();
    //入场动作
    auto size =Director::getInstance()->getVisibleSize();
    auto* mainmenu = this->getChildByTag(3);
    mainmenu->setScale(0);
    mainmenu->runAction(CCSequence::create(CCScaleTo::create(0.5,1),CCCallFunc::create(this, callfunc_selector(GameMenu::menuEnter)),NULL));
}
void GameMenu::menuEnter(){
    auto* mainmenu = this->getChildByTag(3);
	Vector<Node*> temp = mainmenu->getChildren();
    for(int i = 0;i < (int)(temp->size());i ++)
        ((MenuItemImage *)temp->objectAtIndex(i))->setEnabled(true);
}
void GameMenu::onExit(){
    Layer::onExit();
}
void GameMenu::menuNewGameCallback(Ref* pSender)
{
   Director::getInstance()->setDepthTest(true);
   Director::getInstance()->replaceScene(CCTransitionPageTurn::create(0.5,GameMain::scene(), false));
}
void GameMenu::menuContinueCallback(Ref* pSender)
{
   Director::getInstance()->setDepthTest(true);
   Director::getInstance()->replaceScene(CCTransitionPageTurn::create(0.5,GameMain::scene(), false));
}
void GameMenu::menuAboutCallback(Ref* pSender)
{
   Director::getInstance()->setDepthTest(true);
   Director::getInstance()->replaceScene(CCTransitionPageTurn::create(0.5,GameAbout::scene(), false));
}
void GameMenu::onEnterTransitionDidFinish()
{
    Layer::onEnterTransitionDidFinish();
   Director::getInstance()->setDepthTest(false);
}

void GameMenu::onExitTransitionDidStart()
{
    Layer::onExitTransitionDidStart();
}
void GameMenu::menuSoundCallback(Ref* pSender)
{
    //设置声音
    if(! issound){
        soundItem->setNormalImage(Sprite::create("sound-on-A.png"));
        soundItem->setDisabledImage(Sprite::create("sound-on-B.png"));
        SimpleAudioEngine::sharedEngine()->playBackgroundMusic(std::string(CCFileUtils::sharedFileUtils()->fullPathFromRelativePath("background.mp3")).c_str(), true);
       issound = true;
    }else{
        soundItem->setNormalImage(Sprite::create("sound-off-A.png"));
        soundItem->setDisabledImage(Sprite::create("sound-off-B.png"));
        SimpleAudioEngine::sharedEngine()->stopBackgroundMusic();
       issound = false;
    }
}