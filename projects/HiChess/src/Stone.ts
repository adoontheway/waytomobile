class Stone extends egret.DisplayObjectContainer
{
    private _tx:number;
    private _ty:number;
    private _type:number;
    private _isAlive:boolean;
    private _isRed:boolean;
    private _shape:egret.Bitmap;
    public constructor(isRed:boolean)
    {
        super();
        this._isRed = isRed;
        this.touchEnabled = true;
    }

    public setType(value:number):void
    {
        //_ox _oy _tx _ty
        this._type = value;
        this.name = (this._isRed ? 0 : 1) + "_" + this._type;
        this._shape = new egret.Bitmap();
        var texture:egret.Texture = RES.getRes(this.name);
        this._shape.texture = texture;
        this._shape.x = -this._shape.width >> 1;
        this._shape.y = -this._shape.height >> 1;
        this.addChild(this._shape);
    }

    public setPos(vx:number,vy:number):void
    {
        this._tx = vx;
        this._ty = vy;
        this.x = this._tx * Config.Unit + Config.StartX;
        this.y = this._ty * Config.Unit + Config.StartY;
    }

    public getType():number
    {
        return this._type;
    }

    public isRed():boolean
    {
        return this._isRed;
    }

    public reset():void
    {
        //todo
    }
}