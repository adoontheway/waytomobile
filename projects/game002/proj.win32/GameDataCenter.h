#pragma once
class GameDataCenter
{
public:
	GameDataCenter * instance;
	static GameDataCenter GameDataCenter::sharedInstance();
	GameDataCenter(void);
	~GameDataCenter(void);
};

