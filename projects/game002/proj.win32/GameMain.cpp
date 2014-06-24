#include "GameMain.h"

USING_NS_CC;

GameMain::GameMain(void)
{
	
}

Scene* GameMain::createScene()
{
	auto scene = Scene::create();
	auto layer = GameMain::create();
	scene->addChild(layer);
	return scene;
}

bool GameMain::init()
{
	if( !Layer::init())
		return false;
	Size visibleSize = CCDirector::getInstance()->getVisibleSize();
	bg = Sprite::create("battle.png");
	bg->setPosition(visibleSize.width/2, visibleSize.height/2);
	addChild(bg);

	auto listener = EventListenerTouchOneByOne::create();
	listener->onTouchBegan = CC_CALLBACK_2(GameMain::onTouchBegan, this);
	_eventDispatcher->addEventListenerWithSceneGraphPriority(listener, this );

	//me = Sprite::create();
	auto batchNode = SpriteBatchNode::create("huangfeihu.png",100);
	SpriteFrameCache::getInstance()->addSpriteFramesWithFile("huangfeihu.plist");
	SpriteFrameCache::getInstance()->addSpriteFramesWithFile("wujibati/wujibati.plist");
	
	Vector<SpriteFrame*> hfhFrames(35);
	Vector<SpriteFrame*> effectFrames(35);
	char str[18] = {0};
	for( int i = 0; i < 35; i++ )
	{
		sprintf(str, "huangfeihu%d.png",i);
		auto frame = SpriteFrameCache::getInstance()->getSpriteFrameByName(str);
		if( frame != NULL )
			hfhFrames.pushBack(frame);

		sprintf(str, "image %d.png",2*i+1);
		auto frame1 = SpriteFrameCache::getInstance()->getSpriteFrameByName(str);
		if( frame1 != NULL )
			effectFrames.pushBack(frame1);
	}

	//for( int j = 0; j < 1000; j++ )
	//{
		me = Sprite::createWithSpriteFrameName("huangfeihu0.png");
		auto anim = Animation::createWithSpriteFrames( hfhFrames,0.05f );
		me->runAction(RepeatForever::create( Animate::create(anim)));
		me->setPosition(visibleSize.width*rand()/RAND_MAX, visibleSize.height*rand()/RAND_MAX);
		
		auto effect = Sprite::createWithSpriteFrameName("image 1.png");
		auto anim1 = Animation::createWithSpriteFrames( effectFrames, 0.1f );
		effect->runAction(RepeatForever::create( Animate::create(anim1)));
		effect->setPosition(80, 80);
		me->addChild(effect,1);
		addChild(me);
		//batchNode->addChild(me);
	//}
	//this->addChild(batchNode);
	return true;
}

bool GameMain::onTouchBegan(Touch *touch, Event *unused_event)
{
	if( me->getActionByTag(100) != NULL )
	{
		me->stopActionByTag(100);
	}
	auto pos = touch->getLocation();
	auto action = MoveTo::create(2,pos);
	action->setTag(100);
	me->runAction( action );
	return true;
}

GameMain::~GameMain(void)
{
}
