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
	sceneName = CCLabelTTF::create("场景1","Maker Felt",24);
	sceneName->setPosition(ccp(100,100));
	this->addChild(sceneName);

	CCTexture2D::PVRImagesHavePremultipliedAlpha(true);
	CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("nvwares.plist");
	CCSprite * nvwa = CCSprite::create("nvwares.png");
	this->addChild(nvwa);
	nvwa->setPosition(ccp(150,150));
	CCArray* hfhFrames = CCArray::createWithCapacity(10);
	char str[25] = {0};
	for(int i=0; i<10; i++)
	{
		/**
		sprintf(str,"0009-5ae6d51-0000%d.png",i);
		
		sprintf(str,"0087-3dac290b-0000%d.png",i);
		
		
		sprintf(str,"0090-3f6e1130-0000%d.png",i);**/
		sprintf(str,"0178-799965c4-0000%d.png",i);
		/**sprintf(str,"0283-c7f51159-0000%d.png",i);
		sprintf(str,"0326-ec6f79f4-0000%d.png",i);
		sprintf(str,"0341-fe35fa3c-0000%d.png",i);
		**/
		CCSpriteFrame* frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(str);
		if( frame != NULL )
			hfhFrames->addObject( frame );
	}
	CCAnimation *animation = CCAnimation::createWithSpriteFrames( hfhFrames,0.2f );
	animation->setLoops(-1);
	nvwa->runAction(CCAnimate::create(animation));
	return true;
}