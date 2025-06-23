/*
1 - INDEX para otimizar buscas em oferecimentos a partir
de quando ele foi lecionado:
    - (InicioPeriodoLetivo)
*/
CREATE INDEX OfferPorPeriodoLetivo ON Oferecimento (InicioPeriodoLetivo);

/*
2 - INDEX para otimizar as buscas em matrículas e ver quais
os status de seus pagamentos
    - (StatusMatricula, StatusPagamento)
*/
CREATE INDEX StatusMatricula ON Matricula USING HASH (StatusPagamento);

/*
3 - INDEX para otimizar o JOIN entre os oferecimentos e os
professores, já que é comum querer saber disciplinas que
um professor lecionou
    - FK de Oferecimento (NomeProf, SobrenomeProf, TelefoneProf)
*/
CREATE INDEX OferecimentoJoinProfessor ON Oferecimento USING btree (NomeProf, SobrenomeProf, TelefoneProf);