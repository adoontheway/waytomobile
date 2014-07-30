//
//  GameMark.h
//  example12-1
//
//  Created by shuoquan man on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef example15_1_GameMark_h
#define example15_1_GameMark_h

#include "cocos2d.h"
using namespace cocos2d;

class GameMark : public Layer
{
public:
    GameMark(void);
    virtual ~GameMark(void);
    virtual void onEnter();
    virtual void onExit();
    Vector<Sprite*> * bits;
    int mark;
    void addnumber(int var);
    Texture2D* ui;
};

#endif
