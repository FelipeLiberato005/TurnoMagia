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



#region Controles

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
    

    for (var i = 0; i < array_length(global.itens); i++)
    {
        var itens = global.itens[i].spr
        _x = 20 + (i * 50) + tam_celula
        _y = inv_y + tam_celula
        _x1 = tam_celula / 2
        _y1 = tam_celula / 2
        
            
        draw_sprite_stretched(spr_quadro,0, _x,_y,tam_celula,tam_celula)
        draw_sprite_stretched(itens, 0, _x + tam_celula / 4, _y + tam_celula / 4, _x1, _y1)
    }
    //for (var i = 0; i < linhas; i++)
    //{
        //for (var j = 0; j < colunas; j++)
        //{
            //var _marg = marg
            //var _x = _marg + j * tam_celula + _marg * j + 35
            //var _y = inv_y + _marg + i * tam_celula + _marg * i
            //var _x1 = _x + tam_celula
            //var _y1 = _y + tam_celula
           //
            ////draw_rectangle(_x, _y, _x1, _y1, true)
            //draw_sprite_stretched(spr_quadro,0, _x,_y,tam_celula,tam_celula)
            ////draw_sprite(spr_itens, 0, _x, _y)
                //var itens = global.itens[i]
            //draw_sprite_stretched(itens.spr, 0, _x + tam_celula / 4 , _y + tam_celula / 4, tam_celula / 2, tam_celula / 2)
            ////draw_text(_x, _y, "Oi")
        //}
    //}
//}
}


#endregion

