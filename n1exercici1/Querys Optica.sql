-- SELECT COUNT(id_factura) total_factures FROM factures WHERE Clients_id_client = 1 && data_venda BETWEEN '2023-08-01' AND '2023-12-31';
/*SELECT DISTINCT m.nom FROM marques m
JOIN ulleres u ON m.id_marca = u.Marques_id_marca
JOIN ulleres_has_factures uf ON u.id_ullera = uf.Ulleres_id_ullera
JOIN factures f ON uf.Ulleres_id_ullera = f.id_factura
WHERE Empleats_id_empleat = 3 && YEAR(f.data_venda) = 2023;*/
SELECT DISTINCT p.nom FROM proveidors p
JOIN marques m ON p.id_proveidor = m.Proveidors_id_proveidor
JOIN ulleres u ON m.id_marca = u.Marques_id_marca
JOIN ulleres_has_factures uf ON u.id_ullera = Ulleres_id_ullera;