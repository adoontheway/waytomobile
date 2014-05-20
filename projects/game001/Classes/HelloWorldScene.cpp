#include "HelloWorldScene.h"
#include <iostream>

using namespace std;

USING_NS_CC;

CCScene* HelloWorld::scene()
{
    // 'scene' is an autorelease object
    CCScene *scene = CCScene::create();
    
    // 'layer' is an autorelease object
    HelloWorld *layer = HelloWorld::create();

    // add layer as a child to scene
    scene->addChild(layer);

    // return the scene
    return scene;
}

// on "init" you need to initialize your instance
bool HelloWorld::init()
{
    //////////////////////////////
    // 1. super init first
    if ( !CCLayer::init() )
    {
        return false;
    }
    
    CCSize visibleSize = CCDirector::sharedDirector()->getVisibleSize();
    CCPoint origin = CCDirector::sharedDirector()->getVisibleOrigin();

    /////////////////////////////
    // 2. add a menu item with "X" image, which is clicked to quit the program
    //    you may modify it.

    // add a "close" icon to exit the progress. it's an autorelease object
    CCMenuItemImage *pCloseItem = CCMenuItemImage::create(
                                        "CloseNormal.png",
                                        "CloseSelected.png",
                                        this,
                                        menu_selector(HelloWorld::menuCloseCallback));
    
	pCloseItem->setPosition(ccp(origin.x + visibleSize.width - pCloseItem->getContentSize().width/2 ,
                                origin.y + pCloseItem->getContentSize().height/2));

    // create menu, it's an autorelease object
    CCMenu* pMenu = CCMenu::create(pCloseItem, NULL);
    pMenu->setPosition(CCPointZero);
    this->addChild(pMenu, 1);

    /////////////////////////////
    // 3. add your codes below...

    // add a label shows "Hello World"
    // create and initialize a label
    
    CCLabelTTF* pLabel = CCLabelTTF::create("Hello COCOS", "Arial", 24);
    
    // position the label on the center of the screen
    pLabel->setPosition(ccp(origin.x + visibleSize.width/2,
                            origin.y + visibleSize.height - pLabel->getContentSize().height));

    // add the label as a child to this layer
    this->addChild(pLabel, 1);
    times = 0;
	CCScheduler *scheduler = CCDirector::sharedDirector()->getScheduler();
	sprite = CCSprite::create("bl_24.png");
	sprite->setPosition(ccp(50.0f,50.0f));
	this->addChild(sprite, 0);
	scheduler->scheduleSelector(SEL_SCHEDULE(&HelloWorld::updateByFrame),this,0,false);

	
	//Ê¹ÓÃplist×÷Îª¶¯»­
	CCTexture2D::PVRImagesHavePremultipliedAlpha(true);
	CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("poison_fog.plist");

	CCSprite* sp = CCSprite::create("poison_fog.png");
	sp->setPosition(ccp(300.0f,400.0f));
	this->addChild(sp);

	CCArray* animFrames = CCArray::createWithCapacity(25);
	char str[100] = {0};
	for(int i=0; i<30; i++)
	{
		sprintf(str,"image %d.png",i*2+i);
		CCSpriteFrame* frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(str);
		if( frame != NULL )
			animFrames->addObject( frame );
	}
		
	CCAnimation *animation = CCAnimation::createWithSpriteFrames( animFrames,0.1f );
	animation->setLoops(-1);
	sp->runAction(CCAnimate::create(animation));
	
	CCSpriteFrameCache::sharedSpriteFrameCache()->removeSpriteFrameByName("poison_fog.plist");
    return true;
}

void HelloWorld::updateByFrame(float value)
{
	times++;
	float targetX = 50.0f + times; 
	sprite->setPosition(ccp(targetX, 50.0f));
}

void HelloWorld::menuCloseCallback(CCObject* pSender)
{
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WINRT) || (CC_TARGET_PLATFORM == CC_PLATFORM_WP8)
	CCMessageBox("You pressed the close button. Windows Store Apps do not implement a close button.","Alert");
#else
    CCDirector::sharedDirector()->end();
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    exit(0);
#endif
#endif
}
