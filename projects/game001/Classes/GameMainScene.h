#ifndef __GAMEMAIN_SCENE_H__
#define __GAMEMAIN_SCENE_H__

#include "cocos2d.h"

class GameMain : public cocos2d::CCLayer
{
public:
	
    virtual bool init();  
	cocos2d::CCSprite * bg;
	cocos2d::CCLabelTTF * sceneName;
    
    static cocos2d::CCScene* scene();
	
    CREATE_FUNC(GameMain);
};
#endif