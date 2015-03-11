var __extends = this.__extends || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
var Stone = (function (_super) {
    __extends(Stone, _super);
    function Stone(isRed) {
        this._isRed = isRed;
        _super.call(this);
    }
    Stone.prototype.setType = function (value) {
        //_ox _oy _tx _ty
        this._type = value;
        var resname = (this._isRed ? 0 : 1) + "_" + this._type;
        this._shape = new egret.Bitmap();
        var texture = RES.getRes(resname);
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
    Stone.prototype.reset = function () {
        //todo
    };
    return Stone;
})(egret.DisplayObjectContainer);
Stone.prototype.__class__ = "Stone";
