#include "HelloWorldScene.h"
#include <iostream>
#include "cocos-ext.h"

using namespace std;
USING_NS_CC;
USING_NS_CC_EXT;

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
	CCDirector::sharedDirector()->getTouchDispatcher()->addTargetedDelegate(this,0,true);
	
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
	bg = CCSprite::create("bg.jpg");
	this->addChild(bg);
	scheduler->scheduleSelector(SEL_SCHEDULE(&HelloWorld::updateByFrame),this,0,false);

	
	//使用plist作为动画
	CCTexture2D::PVRImagesHavePremultipliedAlpha(true);
	CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("feiyunan.plist");
	CCSpriteFrameCache::sharedSpriteFrameCache()->addSpriteFramesWithFile("huangfeihu.plist");

	player = CCSprite::create("feiyunan.png");
	hfh = CCSprite::create("huangfeihu.png");
	player->setPosition(ccp(300.0f,400.0f));
	hfh->setPosition(ccp(100,100));
	this->addChild(player);
	this->addChild(hfh);

	CCArray* animFrames = CCArray::createWithCapacity(15);
	CCArray* hfhFrames = CCArray::createWithCapacity(24);
	char str[100] = {0};
	for(int i=0; i<24; i++)
	{
		sprintf(str,"feiyu%d.png",i);
		CCSpriteFrame* frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(str);
		if( frame != NULL )
			animFrames->addObject( frame );

		sprintf(str,"huangfeihu%d.png",i);
		frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(str);
		if( frame != NULL )
			hfhFrames->addObject( frame );
	}
		
	CCAnimation *animation = CCAnimation::createWithSpriteFrames( animFrames,0.1f );
	CCAnimation *hfhAnimation = CCAnimation::createWithSpriteFrames( hfhFrames,0.05f );
	hfhAnimation->setLoops(-1);
	animation->setLoops(-1);
	player->runAction(CCAnimate::create(animation));
	hfh->runAction(CCAnimate::create(hfhAnimation));
	CCArmatureDataManager::sharedArmatureDataManager()->addArmatureFileInfo("Zombie.png","Zombie.plist","Zombie.xml");
	CCArmature *armature = CCArmature::create("Zombie_balloon");
	armature->getAnimation()->playByIndex(0);
	armature->getAnimation()->setSpeedScale(0.5);
	/**
	armature->setScaleX(-0.5f);
	armature->setScaleY(0.5f);**/
	armature->setPosition(ccp(visibleSize.width/2,visibleSize.height/2));
	addChild(armature);
	armature->getAnimation()->play("anim_eat");
    return true;
}

void HelloWorld::updateByFrame(float value)
{
	
}

bool HelloWorld::ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent)
{
	hfh->stopActionByTag(100);
	CCPoint tPoint = CCPoint(pTouch->getLocation());
	if( tPoint.x > hfh->getPositionX())
	{
		hfh->setScaleX(1);
	}else
	{
		hfh->setScaleX(-1);
	}
	CCMoveTo *action = CCMoveTo::create(2,tPoint);
	action->setTag(100);
	hfh->runAction(action);
	return false;
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
