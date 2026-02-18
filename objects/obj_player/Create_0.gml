mana = 20
abrir = noone

itens = [
{nome: "Cura", quantidade: 2, spr: spr_itens_cura, valor: 30},
{nome: "Manah", quantidade: 1, spr: spr_itens_mana, valor: 10},
{nome: "Dano", quantidade: 2, spr: spr_itens_dano, valor: 15}
]


controle_mochila = function()
{
    abrir = keyboard_check_pressed(ord("A"))
    
  
}

pega_itens = function()
{   
    
    for (var i = 0; i < array_length(itens); i++)
    {
        var p = itens[i]
        if !array_contains(global.itens, itens[i])
        {
        array_push(global.itens, p)
        }
        else {
        exit
        }
    }
}

desenha_mochila = function()
{ 
    _x = 0.5
    _y = 0.5
    //draw_sprite(spr_mochila, 0, x, y)  
    if keyboard_check(ord("A")) 
    {
        var _x = clamp(_x, 0.6, 0.9)
        var _y = clamp(_y, 0.6, 0.9)
    }
    draw_sprite_ext(spr_mochila, 0, x, y, _x, _y, image_angle, image_blend, 1)
    draw_set_font(fnt_opcoes)
    draw_text(x - 20, y + 13, "Aperte (a)")
    draw_set_font(-1)
}


abrir_inve = function()
{
      if keyboard_check_released(ord("A"))
{
    global.aberto = !global.aberto
}
}


deleta_item = function()
{
    var qtd = array_length(global.itens)
    for (var i = 0; i < qtd; i++)
    {
        var item = global.itens[i]
           if item.quantidade <= 0
        {
            show_message("acabou!")
            show_message(global.itens)
            array_delete(global.itens, i, 0)
            exit
        }
    }
    
}


//oshow_debug_message(global.itens)