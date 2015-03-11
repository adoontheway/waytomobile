var __extends = this.__extends || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
var Stone = (function (_super) {
    __extends(Stone, _super);
    function Stone(isRed) {
        _super.call(this);
        this._isRed = isRed;
        this.touchEnabled = true;
    }
    Stone.prototype.setType = function (value) {
        //_ox _oy _tx _ty
        this._type = value;
        this.name = (this._isRed ? 0 : 1) + "_" + this._type;
        this._shape = new egret.Bitmap();
        var texture = RES.getRes(this.name);
        this._shape.texture = texture;
        this._shape.x = -this._shape.width >> 1;
        this._shape.y = -this._shape.height >> 1;
        this.addChild(this._shape);
    };
    Stone.prototype.setPos = function (vx, vy) {
        this._tx = vx;
        this._ty = vy;
        this.x = this._tx * Config.Unit + Config.StartX;
        this.y = this._ty * Config.Unit + Config.StartY;
    };
    Stone.prototype.getType = function () {
        return this._type;
    };
    Stone.prototype.reset = function () {
        //todo
    };
    return Stone;
})(egret.DisplayObjectContainer);
Stone.prototype.__class__ = "Stone";
