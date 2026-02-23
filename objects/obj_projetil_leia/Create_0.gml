

destruindo_projetil = function()
{
    //if x = obj_turnos.alvo_atual.heroi.x
    //{
        //show_message("Destuido!")
    //}
    var x_alvo = obj_turnos.alvo_atual.heroi.x
    var y_alvo = obj_turnos.alvo_atual.heroi.y
    var alvo = obj_turnos.alvo_atual.heroi
    var dano = place_meeting(x - 20, y, obj_turnos.alvo_atual.heroi)
    if dano
    {
        //show_message("Destruido")
        
        instance_destroy()
        
    }
}

