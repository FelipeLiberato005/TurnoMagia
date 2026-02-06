if sprite_index != idle
{
    if image_index >= image_number - 1
    {
        sprite_index = idle
        global.fim_animacao = false
    }
}