-- Llista quants productes de categoria 'Begudes' s'han venut en una determinada localitat.
SELECT COUNT(Categories_id_categoria) total_begudes FROM comandes c
JOIN productes_has_comandes pc ON c.id_comanda = pc.Comandes_id_comanda
JOIN productes p ON pc.Productes_id_producte = p.id_producte
JOIN botigues b ON c.Botigues_id_botiga = b.id_botiga
JOIN localitats l ON b.Localitats_id_localitat = l.id_localitat
WHERE Categories_id_categoria = 1 && l.nom = 'Calella';

-- Llista quantes comandes ha efectuat un determinat empleat/da.
SELECT COUNT(ed.id_domicilis) total_entregues FROM entrega_domicilis ed
JOIN empleats e ON ed.Empleats_id_empleat = e.id_empleat
WHERE e.id_empleat = 2;