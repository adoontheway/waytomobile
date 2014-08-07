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
    auto scene = Scene::create();
    auto layer = GameMenu::create();
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
    bg->setScale(0.5f);
	bg->retain();
    bg->setPosition( Vec2(size.width/2, size.height/2) );
    this->addChild(bg, 0,0);
	
    //按钮
    auto newGameItem = MenuItemImage::create("newGameA.png", "newGameB.png",CC_CALLBACK_1(GameMenu::menuNewGameCallback,this));
	newGameItem->setScale(0.5f);
	newGameItem->setPosition(Vec2(size.width / 2 + 40,size.height / 2 - 20));
	newGameItem->setEnabled(false);
    auto continueItem = MenuItemImage::create("continueA.png", "continueB.png",CC_CALLBACK_1(GameMenu::menuContinueCallback,this));
    continueItem->setPosition(Vec2(size.width / 2 + 40,size.height / 2 - 60));
    continueItem->setEnabled(false);
	continueItem->setScale(0.5f);
	auto aboutItem = MenuItemImage::create("aboutA.png", "aboutB.png",CC_CALLBACK_1(GameMenu::menuAboutCallback,this));
    aboutItem->setPosition(Vec2(size.width / 2 + 40,size.height / 2 - 100));
    aboutItem->setEnabled(false);
    aboutItem->setScale(0.5f);
	soundItem = MenuItemImage::create("sound-on-A.png", "sound-on-B.png",CC_CALLBACK_1(GameMenu::menuSoundCallback,this));
    soundItem->setEnabled(false);
    soundItem->setPosition(Vec2(40,40));
	soundItem->setScale(0.5f);
	Menu* mainmenu = Menu::create(newGameItem,continueItem,aboutItem,soundItem,NULL);
	mainmenu->alignItemsVertically();
    mainmenu->setPosition(Vec2(0,0));
    this->addChild(mainmenu,1,3);
    issound = true;
    //初始化声音
	SimpleAudioEngine::getInstance()->preloadBackgroundMusic( std::string( FileUtils::getInstance()->fullPathFromRelativeFile("background.mp3",".")).c_str() );
    SimpleAudioEngine::getInstance()->setBackgroundMusicVolume(0.5);
    SimpleAudioEngine::getInstance()->playBackgroundMusic(std::string( FileUtils::getInstance()->fullPathFromRelativeFile("background.mp3",".")).c_str(), true);
	return true;
}
void GameMenu::onEnter(){
	Layer::onEnter();
    //入场动作
    auto size =Director::getInstance()->getVisibleSize();
	auto mainmenu = this->getChildByTag(3);
    mainmenu->setScale(0);
	mainmenu->runAction(Sequence::create(ScaleTo::create(0.5,1),CallFuncN::create(CC_CALLBACK_1(GameMenu::menuEnter,this)),nullptr));
	}
void GameMenu::menuEnter(Node* node){
    auto mainmenu = this->getChildByTag(3);
	auto temp = mainmenu->getChildren();
    for(int i = 0;i < (int)(temp.size());i ++)
        ((MenuItemImage *)temp.at(i))->setEnabled(true);
}
void GameMenu::onExit(){
    Layer::onExit();
}
void GameMenu::menuNewGameCallback(Ref* pSender)
{
   Director::getInstance()->setDepthTest(true);
   Director::getInstance()->replaceScene(TransitionPageTurn::create(0.5,GameMain::createScene(), false));
}
void GameMenu::menuContinueCallback(Ref* pSender)
{
   Director::getInstance()->setDepthTest(true);
   Director::getInstance()->replaceScene(TransitionPageTurn::create(0.5,GameMain::createScene(), false));
}
void GameMenu::menuAboutCallback(Ref* pSender)
{
   Director::getInstance()->setDepthTest(true);
   Director::getInstance()->replaceScene(TransitionPageTurn::create(0.5,GameAbout::createScene(), false));
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
		SimpleAudioEngine::getInstance()->playBackgroundMusic(std::string(FileUtils::getInstance()->fullPathForFilename("background.mp3")).c_str(), true);
       issound = true;
    }else{
        soundItem->setNormalImage(Sprite::create("sound-off-A.png"));
        soundItem->setDisabledImage(Sprite::create("sound-off-B.png"));
        SimpleAudioEngine::getInstance()->stopBackgroundMusic();
       issound = false;
    }
}

bool GameMenu::onTouchBegan(Touch *touch, Event *event)
{
	log("Touch Began...");
	return true;
}

void GameMenu::onTouchMoved(Touch *touch, Event *event)
{
	
}

void GameMenu::onTouchEnded(Touch *touch, Event *event)
{
	
}

void GameMenu::onTouchCancelled(Touch *touch, Event *event)
{
	
}