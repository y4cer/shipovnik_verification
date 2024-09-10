План работ по диплому (на несколько месяцев вперёд)

1. Дописать tree-sitter для Jasmin (работа ведётся в https://github.com/y4cer/tree-sitter-jasmin) - done
2. Сформулировать свойства Шиповника, которые мы хотим доказать
3. Реализовать Шиповник на Jasmin
   1. Реализовать алгоритм генерации ключа
   2. Подумать, можно ли (а если да, то как?) связать готовую реализацию хеш-функции Streebog с реализацией на Jasmin
   3. Реализовать схему подписи
   4. Реализовать схему проверки подписи
4. Доказать свойства Шиповника на EasyCrypt, реализацию модулей для EasyCrypt можно получить путём транспиляции Jasmin в EasyCrypt
5. сравнение с другими пост-квантовыми алгоритмами
6. сравнение с формализациями других криптографических алгоритмов через Jasmin+EasyCrypt
7. сравнение с другими подходами к формализации

## What we want to prove
1. Correctness. Given the message, we generate a key pair, then sign and
   validate the signature. Validation must be successfull.
2. Security against EUF-CMA. Given the signature scheme S = (KGen, Sign, Ver)
   and the adversary F that upon receiving the public key for S and given
   oracle (i.e. query) access to the Scheme, which produces signatures given the
   message cannot craft a valid signature for the freshly given message

В общем, хочется доказать, что стойкость схемы действительно сводится к
стойкосте синдромного декодирования кодов при предположении, что streebog
невзламываем. А это можно предположить, т.к. у нас будет просто модуль H,
который и будет отвечать за хеш функцию

## Videos on Jamsin & EC verification of the encryption scheme
https://www.youtube.com/watch?v=vEE84uuOX_Q - part1
https://www.youtube.com/watch?v=CStaNMsaot4 - part2

## Articles
https://eprint.iacr.org/2023/246.pdf - hard one, formalization of CRYSTALS-Dilithium
https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=9505217 - The thing I want to prove but for the DH problem
https://eprint.iacr.org/2004/332 - Sequences of games: a tool for taming complexity in security proofs
https://crypto.stanford.edu/~dabo/cryptobook/BonehShoup_0_6.pdf - A graduate Course in Applied Cryptography

## Side-notes
I want to prove Existensial Unforgeability in Shipovnik
Sequences of games is a game winner


### Sequences of games: a tool for taming complexity in security proofs
- Security for cryptograptic primitives is typically defined as an attack game
played between an adversary and some benign entity, which we call the
challenger.
- From experience, it seems that transitions between successive games can be
restricted to one of three types:
1. Transitions based on indistinguishability
Если внутри игры есть какая-то штука, по которой можно отличить игру S_i от
S_{i+1}, то тогда игры можно отличить. Если мы переходим от одной игры к другой
по принципу "неотличимости", то это означает, что значение |S_i - S_{i+1}|
околонулевое
2. Transitions based on failure events
3. Bridging steps
