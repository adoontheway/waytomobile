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
	Size visibleSize = CCDirector::sharedDirector()->getVisibleSize();
	bg = Sprite::create("battle.png");
	bg->setPosition(visibleSize.width/2, visibleSize.height/2);
	addChild(bg);

	auto batchNode = SpriteBatchNode::create("huangfeihu.png",100);
	SpriteFrameCache::getInstance()->addSpriteFramesWithFile("huangfeihu.plist");
	
	Vector<SpriteFrame*> hfhFrames(24);
	char str[18] = {0};
	for( int i = 0; i < 24; i++ )
	{
		sprintf(str, "huangfeihu%d.png",i);
		auto frame = SpriteFrameCache::getInstance()->spriteFrameByName(str);
		if( frame != NULL )
			hfhFrames.pushBack(frame);
	}

	for( int j = 0; j < 1000; j++ )
	{
		auto hfh = Sprite::createWithSpriteFrameName("huangfeihu0.png");
		auto anim = Animation::createWithSpriteFrames( hfhFrames,0.05f );
		hfh->runAction(RepeatForever::create( Animate::create(anim)));
		hfh->setPosition(visibleSize.width*rand()/RAND_MAX, visibleSize.height*rand()/RAND_MAX);
		batchNode->addChild(hfh);
		
	}
	this->addChild(batchNode);
	return true;
}

GameMain::~GameMain(void)
{
}
