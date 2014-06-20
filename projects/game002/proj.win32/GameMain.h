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
	
	CREATE_FUNC(GameMain);

	virtual ~GameMain(void);
protected :
	Sprite * bg;
};

