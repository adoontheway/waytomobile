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
        this._isRed = isRed;
        super();
    }

    public setType(value:number):void
    {
        //_ox _oy _tx _ty
        this._type = value;
        var resname:string = (this._isRed ? 0 : 1) + "_" + this._type;
        this._shape = new egret.Bitmap();
        var texture:egret.Texture = RES.getRes(resname);
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

    public reset():void
    {
        //todo
    }
}