tam_celula    = 32
colunas       = 0
linhas        = 0
inv_y         = 0
marg          = 20

surf_w       = 250
surf_h      = 144
surf_x      = 100
surf_y      = 20
surf = noone
inv_y_max   = (linhas * tam_celula) + marg + marg * linhas - surf_h

aberto = false
abrir = noone

#region Controles
controle = function()
{
    abrir = keyboard_check_pressed(ord("A"))
}
#endregion

#region Metodos e Funções

desenha_surface = function()
{
    
    if surface_exists(surf)
    {
         surface_set_target(surf)
        draw_clear_alpha(c_black, 0)
        var _margem = 3
        //draw_rectangle_colour(0, 0, surf_w, surf_h, c_aqua, c_blue, c_green, c_red, false)
        draw_sprite_stretched(spr_fundo_inven, 0, 0, 0, surf_w, surf_h)
        desenha_inventario()
        
        surface_reset_target()
        draw_surface(surf, surf_x, surf_y)
        draw_sprite_stretched(spr_caixa, 0, surf_x - _margem, surf_y - _margem, surf_w + _margem * 2, surf_h + _margem * 2)
        
    }
    else 
    {
        surf = surface_create(surf_w, surf_h)   
    }
}

desenha_inventario = function()
{
    colunas = array_length(global.itens)
    linhas = array_length(global.itens)
    inv_y_max   = (linhas * tam_celula) + marg + marg * linhas - surf_h
    if (mouse_wheel_up()) inv_y -= 8
        
    if (mouse_wheel_down()) inv_y += 8
        
    inv_y = clamp(inv_y, -inv_y_max, 0)
    
   
    for (var i = 0; i < linhas; i++)
    {
        for (var j = 0; j < colunas; j++)
        {
            var _marg = marg
            var _x = _marg + j * tam_celula + _marg * j
            var _y = inv_y + _marg + i * tam_celula + _marg * i
            var _x1 = _x + tam_celula
            var _y1 = _y + tam_celula
           
            //draw_rectangle(_x, _y, _x1, _y1, true)
            draw_sprite_stretched(spr_quadro,0, _x,_y,tam_celula,tam_celula)
            //draw_sprite(spr_itens, 0, _x, _y)
            draw_sprite_stretched(spr_itens, 0, _x + tam_celula / 4 , _y + tam_celula / 4, tam_celula / 2, tam_celula / 2)
            //draw_text(_x, _y, "Oi")
        }
    }
}


desenha_mochila = function()
{ 
    _x = 1
    _y = 1
    //draw_sprite(spr_mochila, 0, x, y)  
    if keyboard_check(ord("A")) 
    {
        var _x = clamp(_x, 1.3, 1.6)
        var _y = clamp(_y, 1.3, 1.6)
    }
    draw_sprite_ext(spr_mochila, 0, x, y, _x, _y, image_angle, image_blend, 1)
    draw_set_font(fnt_herois)
    draw_text(x - 28, y + 20, "Aperte (a)")
    draw_set_font(-1)
}
#endregion