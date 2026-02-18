updates = [
    " 13/02/2026 -> Agora a personagem cura 20% de seu ataque",
    "13/02/2026 -> Dano inimigo aumentado, para equilibrio do jogo",
    "15/02/2026 -> Sistema de escolha da formação",
    "17/02/2026 -> inventario",
    "18/02/2026 -> primeiro Item (Cura) agora disponivel"
]


desenha_info_updates = function()
{
    
    for (var i = 0; i < array_length(updates);i++)
    {
        _x = 20
        _y = 20 + (i * 20)
        draw_set_font(fnt_info_updates)
        draw_text(_x, _y, updates[i])
        draw_set_font(-1)
    }
}


voltar_menu = function(){
    if keyboard_check_released(vk_escape)
    {
        room_goto(rm_inicio)
    }
}