/* TECNICA 1 PARA ORACLE 11g
*/

SELECT * FROM (
  SELECT a.*, ROWNUM rnum FROM (
    SELECT * FROM tabela_enorme ORDER BY campo_indexado
  ) a WHERE ROWNUM <= 61200
) WHERE rnum >= 61000;

/* TECNICA 2 PARA ORACLE 11g

   Esta tecnica usa Window Functions, e possibilita uma leitura melhor
*/
SELECT * FROM (
  SELECT row_number() OVER (ORDER BY campo_indexado) linha, p.* FROM tabela_enorme p
) WHERE linha BETWEEN 91000 AND 91200;

-- Reescrita para audit_vdp

SELECT * FROM (
  SELECT row_number() OVER (ORDER BY cod_empresa, num_pedido) linha, a.* FROM audit_vdp a
) WHERE linha BETWEEN 91000 AND 91200
;

-- Reescrita apenas para facilitar leitura (processou com o mesmo desempenho do anterior)
-- Este pode comando pode ser utilizad ate o Oracle 11g, visto que no 12g ha recursos para melhorar ainda mais esta escrita

WITH determina_linha AS
  ( SELECT row_number() OVER (ORDER BY cod_empresa, num_pedido) linha, a.* FROM audit_vdp a )

SELECT *
  FROM determina_linha
WHERE linha BETWEEN 91000 AND 91199
;
