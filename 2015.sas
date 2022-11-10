%_eg_conditional_dropds(WORK.META4_2015);

PROC SQL;
   CREATE TABLE WORK.META4_2015 AS 
   SELECT t1.NU_ANO_CENSO, 
          t1.TP_SEXO, 
          t1.TP_COR_RACA, 
          t1.CO_REGIAO, 
          t1.CO_UF, 
          t1.CO_MUNICIPIO, 
          t1.TP_DEPENDENCIA, 
          t1.TP_LOCALIZACAO, 
          /* NUM_4B */
            (SUM(CASE 
               WHEN t1.IN_ESPECIAL_EXCLUSIVA = 0 THEN 1
               ELSE 0
            END)) AS NUM_4B, 
          /* NUM_4C */
            (SUM(t1.NU_DUR_AEE_MESMA_REDE>0 OR t1.NU_DUR_AEE_OUTRAS_REDES>0 OR t1.IN_ESPECIAL_EXCLUSIVA = 1)) AS NUM_4C, 
          /* DEN_4 */
            (SUM(1)) AS DEN_4, 
          /* NO_SEXO */
            (CASE 
               WHEN t1.TP_SEXO = 1 THEN 'Masculino'
               WHEN t1.TP_SEXO = 2 THEN 'Feminino'
            END) AS NO_SEXO, 
          /* NO_COR_RACA */
            (CASE 
               WHEN t1.TP_COR_RACA = 0 THEN 'Não declarada'
               WHEN t1.TP_COR_RACA = 1 THEN 'Branca'
               WHEN t1.TP_COR_RACA = 2 THEN 'Preta'
               WHEN t1.TP_COR_RACA = 3 THEN 'Parda'
               WHEN t1.TP_COR_RACA = 4 THEN 'Amarela'
               WHEN t1.TP_COR_RACA = 5 THEN 'Indígena'
            END) AS NO_COR_RACA, 
          /* NO_DEPENDENCIA */
            (CASE 
               WHEN t1.TP_DEPENDENCIA = 1 THEN 'Federal'
               WHEN t1.TP_DEPENDENCIA = 2 THEN 'Estadual'
               WHEN t1.TP_DEPENDENCIA = 3 THEN 'Municipal'
               WHEN t1.TP_DEPENDENCIA = 4 THEN 'Privada'
            END) AS NO_DEPENDENCIA, 
          /* NO_LOCALIZACAO */
            (CASE 
               WHEN t1.TP_LOCALIZACAO = 1 THEN 'Urbana'
               WHEN t1.TP_LOCALIZACAO = 2 THEN 'Rural'
            END) AS NO_LOCALIZACAO
      FROM DATADEED.BAS_MATRICULA t1
      WHERE t1.TP_TIPO_ATENDIMENTO_TURMA IN 
           (
           1,
           2
           ) AND t1.NU_IDADE_REFERENCIA BETWEEN 4 AND 17 AND t1.IN_NECESSIDADE_ESPECIAL = 1 AND t1.NU_ANO_CENSO = 2015
      GROUP BY t1.NU_ANO_CENSO,
               t1.TP_SEXO,
               t1.TP_COR_RACA,
               t1.CO_REGIAO,
               t1.CO_UF,
               t1.CO_MUNICIPIO,
               t1.TP_DEPENDENCIA,
               t1.TP_LOCALIZACAO,
               (CALCULATED NO_SEXO),
               (CALCULATED NO_COR_RACA),
               (CALCULATED NO_DEPENDENCIA),
               (CALCULATED NO_LOCALIZACAO);
QUIT;