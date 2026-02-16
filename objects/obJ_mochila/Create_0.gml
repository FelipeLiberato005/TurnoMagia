aberto = false

abrir_inventario = function()
{
    
    if aberto = true
    {
        instance_create_layer(x, y, layer, obj_itens)
    }
    else {
        if instance_exists(obj_itens)
        {
            instance_destroy(obj_itens)
        }
        
    }
}