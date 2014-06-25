#include "HelloWorldScene.h"
#include "GameMain.h"
USING_NS_CC;

Scene* HelloWorld::createScene()
{
    // 'scene' is an autorelease object
    auto scene = Scene::create();
    
    // 'layer' is an autorelease object
    auto layer = HelloWorld::create();

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
    if ( !Layer::init() )
    {
        return false;
    }
	auto size = Director::getInstance()->getVisibleSize();
	auto bg = Sprite::create("bg.png");
	bg->setPosition(250, 250);
	addChild(bg);
	auto title = Sprite::create("title.png");
	title->setPosition(150,size.height - title->getContentSize().height);
	addChild(title);
    Size visibleSize = Director::getInstance()->getVisibleSize();
    Vec2 origin = Director::getInstance()->getVisibleOrigin();
	
	CCTexture2D::PVRImagesHavePremultipliedAlpha(true);
	
	auto *itemImage0 = MenuItemImage::create("pingju.png","pingju.png",CC_CALLBACK_1(HelloWorld::addAnimation,this));
	auto *itemImage1 = MenuItemImage::create("shengli.png","shengli.png",CC_CALLBACK_1(HelloWorld::nextScene,this));
	auto *itemImage2 = MenuItemImage::create("shibai.png","shibai.png",CC_CALLBACK_1(HelloWorld::menuCloseCallback,this));
	Menu *menu = Menu::create(itemImage0,itemImage1,itemImage2, NULL);
	menu->alignItemsVerticallyWithPadding(5);
	menu->setPosition( visibleSize.width-150, visibleSize.height/2);

	this->addChild(menu);
    return true;
}

void HelloWorld::addAnimation(Ref* pSender)
{
	
}
	
void HelloWorld::nextScene(Ref* pSender)
{
	Scene * s = GameMain::createScene();
	Director::getInstance()->replaceScene(TransitionMoveInL::create(1.5, s ));
}

void HelloWorld::menuCloseCallback(Ref* pSender)
{
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WP8) || (CC_TARGET_PLATFORM == CC_PLATFORM_WINRT)
	MessageBox("You pressed the close button. Windows Store Apps do not implement a close button.","Alert");
    return;
#endif

    Director::getInstance()->end();

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    exit(0);
#endif
}
