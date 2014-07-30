//
//  GameObjHero.h
//  example12-1
//
//  Created by shuoquan man on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef example15_1_GameObjHero_h
#define example15_1_GameObjHero_h
#include "cocos2d.h"
using namespace cocos2d;

class GameObjHero : public Layer
{
public:
    Sprite *mainsprite;
    Texture2D *hurt;
    Texture2D *jump;
    Point offset;
    short state;//0:正常 1：跳跃 2：受伤
    bool iscontrol;
    GameObjHero(void);
    virtual ~GameObjHero(void);
    void setState(short var);
    Rect rect();
    virtual void onEnter();
    virtual void onExit();
    void jumpend();
    void hurtend();
    bool containsTouchLocation(Touch* touch);
    virtual bool onTouchBegan(Touch* touch, Event* event);
    virtual void onTouchMoved(Touch* touch, Event* event);
    virtual void onTouchEnded(Touch* touch, Event* event);
    
    virtual void touchDelegateRetain();
    virtual void touchDelegateRelease();
    
};


#endif
