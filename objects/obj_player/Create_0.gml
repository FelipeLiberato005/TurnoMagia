mana = 20

itens = [
{nome: "cura", quantidade: 2},
{nome: "manah", quantidade: 1},
{nome: "dano", quantidade: 2}
]


pega_itens = function()
{
    for (var i = 0; i < array_length(itens); i++)
    {
        var p = itens[i]
        
        array_push(global.itens, p)
    }
}

pega_itens()