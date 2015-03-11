class Config{
    /** 单位长度 **/
    public static Unit:number = 53;

    public static  MaxPosX:number = 8;

    public static  MaxPosY:number = 9;

    public static StartX:number = 0;

    public static StartY:number = 0;

    public static StoneConfig:Array = [
        {type:EnumStoneType.TypeBing, isRed:true,posY:3, posX:0},
        {type:EnumStoneType.TypeBing, isRed:true,posY:3, posX:2},
        {type:EnumStoneType.TypeBing, isRed:true,posY:3, posX:4},
        {type:EnumStoneType.TypeBing, isRed:true,posY:3, posX:6},
        {type:EnumStoneType.TypeBing, isRed:true,posY:3, posX:8},
        {type:EnumStoneType.TypeChe, isRed:true,posY:0, posX:0},
        {type:EnumStoneType.TypeChe, isRed:true,posY:0, posX:8},
        {type:EnumStoneType.TypeMa, isRed:true,posY:0, posX:1},
        {type:EnumStoneType.TypeMa, isRed:true,posY:0, posX:7},
        {type:EnumStoneType.TypePao, isRed:true,posY:2, posX:1},
        {type:EnumStoneType.TypePao, isRed:true,posY:2, posX:7},
        {type:EnumStoneType.TypeShi, isRed:true,posY:0, posX:3},
        {type:EnumStoneType.TypeShi, isRed:true,posY:0, posX:5},
        {type:EnumStoneType.TypeXiang, isRed:true,posY:0, posX:2},
        {type:EnumStoneType.TypeXiang, isRed:true,posY:0, posX:6},
        {type:EnumStoneType.TypeShuai, isRed:true,posY:0, posX:4},

        {type:EnumStoneType.TypeBing, isRed:false,posY:6, posX:0},
        {type:EnumStoneType.TypeBing, isRed:false,posY:6, posX:2},
        {type:EnumStoneType.TypeBing, isRed:false,posY:6, posX:4},
        {type:EnumStoneType.TypeBing, isRed:false,posY:6, posX:6},
        {type:EnumStoneType.TypeBing, isRed:false,posY:6, posX:8},
        {type:EnumStoneType.TypeChe, isRed:false,posY:9, posX:0},
        {type:EnumStoneType.TypeChe, isRed:false,posY:9, posX:8},
        {type:EnumStoneType.TypeMa, isRed:false,posY:9, posX:1},
        {type:EnumStoneType.TypeMa, isRed:false,posY:9, posX:7},
        {type:EnumStoneType.TypePao, isRed:false,posY:7, posX:1},
        {type:EnumStoneType.TypePao, isRed:false,posY:7, posX:7},
        {type:EnumStoneType.TypeShi, isRed:false,posY:9, posX:3},
        {type:EnumStoneType.TypeShi, isRed:false,posY:9, posX:5},
        {type:EnumStoneType.TypeXiang, isRed:false,posY:9, posX:2},
        {type:EnumStoneType.TypeXiang, isRed:false,posY:9, posX:6},
        {type:EnumStoneType.TypeShuai, isRed:false,posY:9, posX:4}
    ];
}