#pragma once
#include "cocos2d.h"
USING_NS_CC;

class GameMain :
	public cocos2d::Layer
{
public:
	GameMain(void);

	virtual bool init(); 

	static Scene* createScene();
	
	virtual bool onTouchBegan(Touch *touch, Event *unused_event); 

	CREATE_FUNC(GameMain);

	virtual ~GameMain(void);
protected :
	Sprite * bg;
	Sprite * me;
};

