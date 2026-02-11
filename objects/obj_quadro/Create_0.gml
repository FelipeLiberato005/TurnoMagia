turnos = []
alpha = 0
desenha_quadro_escolhas = function()
{
    var info = turnos[0]
    
    var _x = 0
    var _y = 0
    
    if instance_exists(info.heroi) && info.is_hero != false
    {
        _x = info.heroi.x
        _y = info.heroi.y - 10
        
        draw_set_color(make_colour_rgb(0,0,0))
        
        var valor_x1 = 0
        var valor_x2 = 0
        //draw_roundrect_colour(_x - 60, _y - 50, (_x + 55) - 55,(_y + 65) - 50, c_white, c_black, false)
        draw_rectangle(_x - 60, _y - 50, (_x + 55) - 55,(_y + 65) - 50, false)	
        draw_set_color(make_colour_rgb(255,255,255))
}
     
    if alpha < 1
    {
        alpha += 0.01
    }
}

turnos = ordena_val(global.batalha)