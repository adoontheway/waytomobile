#include "GameMainScene.h"
#include "cocos2d.h"
#include "cocos-ext.h"

USING_NS_CC;
USING_NS_CC_EXT;

CCScene * GameMain::scene()
{
	CCScene *scene = CCScene::create();
	GameMain *layer = GameMain::create();
	scene->addChild(layer);
	return scene;
}

bool GameMain::init()
{
	if( !CCLayer::init())
	{
		return false;
	}
	bg = CCSprite::create("battle.png");
	bg->setPosition(ccp(0,0));
	addChild(bg);
	sceneName = CCLabelTTF::create("场景1","Arial",24);
	sceneName->setPosition(ccp(100,100));
	this->addChild(sceneName);
	return true;
}