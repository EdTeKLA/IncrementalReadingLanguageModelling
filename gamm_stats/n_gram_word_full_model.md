# N-gram Word Full Model GAMM Stats

##English
|                               | **Estimate** |    ***SE*** | ***t*** | ***p*** |
|-------------------------------|-------------:|------------:|--------:|--------:|
| Intercept                     |        5.735 |       0.035 |  164.67 |   <.001 |
| SentPos                       |        0.006 |       0.006 |    1.06 |    .291 |
| SentPos:NgramWordSurp         |        0.003 |       0.001 |    3.11 |    .002 |
|                               |              |             |         |         |
|                               |  **Eff. df** | **Ref. df** | ***F*** | ***p*** |
| s(Participant)                |         30.0 |        30.0 | 1075.31 |   <.001 |
| s(Trial)                      |         61.4 |        62.0 |  230.79 |   <.001 |
| s(Word)                       |        495.9 |       687.0 |    3.64 |   <.001 |
| s(VocabAdjPerf)               |          1.0 |         1.0 |    6.69 |    .010 |
| s(ReadingCompAdjPerf)         |          1.0 |         1.0 |    0.01 |    .936 |
| s(WordPos)                    |          7.9 |         8.5 |   17.96 |   <.001 |
| s(LogWordFreq)                |          1.0 |         1.0 |    2.11 |    .146 |
| s(WordLength)                 |          1.0 |         1.0 |    0.57 |    .451 |
| ti(LogWordFreq,WordLength)    |          1.0 |         1.0 |   13.25 |   <.001 |
| s(NgramWordSurp)              |          1.0 |         1.0 |    0.15 |    .698 |
| ti(NgramWordSurp,WordLength)  |          7.4 |         8.6 |    3.33 |    .001 |
| ti(NgramWordSurp,LogWordFreq) |          1.0 |         1.0 |    2.00 |    .157 |
| ti(NgramWordSurp,WordPos)     |          8.7 |        10.4 |    1.94 |    .018 |

##Chinese
|                               | **Estimate** |    ***SE*** | ***t*** | ***p*** |
|-------------------------------|-------------:|------------:|--------:|--------:|
| Intercept                     |        5.903 |       0.050 |  118.71 |   <.001 |
| SentPos                       |       -0.049 |       0.007 |   -6.88 |   <.001 |
| SentPos:NgramWordSurp         |        0.002 |       0.001 |    2.41 |    .016 |
|                               |              |             |         |         |
|                               |  **Eff. df** | **Ref. df** | ***F*** | ***p*** |
| s(Participant)                |         32.0 |        32.0 | 1724.65 |   <.001 |
| s(Trial)                      |         61.1 |        62.0 |  184.59 |   <.001 |
| s(Word)                       |        447.4 |       687.0 |    2.60 |   <.001 |
| s(VocabAdjPerf)               |          1.0 |         1.0 |    0.04 |    .852 |
| s(ReadingCompAdjPerf)         |          1.0 |         1.0 |    0.44 |    .505 |
| s(WordPos)                    |          6.1 |         7.0 |   51.71 |   <.001 |
| s(LogWordFreq)                |          1.0 |         1.0 |    0.06 |    .811 |
| s(WordLength)                 |          1.0 |         1.0 |   30.92 |   <.001 |
| ti(LogWordFreq,WordLength)    |          2.5 |         2.9 |    1.62 |    .182 |
| s(NgramWordSurp)              |          1.0 |         1.0 |    0.05 |    .826 |
| ti(NgramWordSurp,WordLength)  |          3.7 |         3.9 |    7.85 |   <.001 |
| ti(NgramWordSurp,LogWordFreq) |          1.0 |         1.0 |    0.60 |    .440 |
| ti(NgramWordSurp,WordPos)     |          1.0 |         1.0 |    0.00 |   1.000 |


##Korean
|                               | **Estimate** |    ***SE*** | ***t*** | ***p*** |
|-------------------------------|-------------:|------------:|--------:|--------:|
| Intercept                     |        5.714 |       0.053 |  107.77 |   <.001 |
| SentPos                       |       -0.029 |       0.007 |   -3.87 |   <.001 |
| SentPos:NgramWordSurp         |        0.003 |       0.001 |    3.52 |   <.001 |
|                               |              |             |         |         |
|                               |  **Eff. df** | **Ref. df** | ***F*** | ***p*** |
| s(Participant)                |         25.0 |        25.0 | 1391.40 |   <.001 |
| s(Trial)                      |         54.9 |        62.0 |   20.65 |   <.001 |
| s(Word)                       |        309.5 |       687.0 |    1.26 |   <.001 |
| s(VocabAdjPerf)               |          1.0 |         1.0 |    0.00 |    .963 |
| s(ReadingCompAdjPerf)         |          1.0 |         1.0 |    0.20 |    .655 |
| s(WordPos)                    |          6.1 |         7.0 |   18.04 |   <.001 |
| s(LogWordFreq)                |          1.0 |         1.0 |    0.14 |    .710 |
| s(WordLength)                 |          1.0 |         1.0 |    5.19 |    .023 |
| ti(LogWordFreq,WordLength)    |          1.0 |         1.0 |    0.07 |    .794 |
| s(NgramWordSurp)              |          1.0 |         1.0 |    3.41 |    .065 |
| ti(NgramWordSurp,WordLength)  |          2.9 |         3.3 |    2.09 |    .092 |
| ti(NgramWordSurp,LogWordFreq) |          1.0 |         1.0 |    1.47 |    .225 |
| ti(NgramWordSurp,WordPos)     |          1.0 |         1.0 |    0.08 |    .778 |



##Spanish
|                               | **Estimate** |    ***SE*** | ***t*** | ***p*** |
|-------------------------------|-------------:|------------:|--------:|--------:|
| Intercept                     |        5.764 |       0.050 |  115.44 |   <.001 |
| SentPos                       |       -0.010 |       0.006 |   -1.72 |    .086 |
| SentPos:NgramWordSurp         |        0.003 |       0.001 |    3.59 |   <.001 |
|                               |              |             |         |         |
|                               |  **Eff. df** | **Ref. df** | ***F*** | ***p*** |
| s(Participant)                |         41.0 |        41.0 | 2803.52 |   <.001 |
| s(Trial)                      |         61.5 |        62.0 |  671.88 |   <.001 |
| s(Word)                       |        489.3 |       687.0 |    3.35 |   <.001 |
| s(VocabAdjPerf)               |          1.0 |         1.0 |    0.00 |    .978 |
| s(ReadingCompAdjPerf)         |          1.0 |         1.0 |    7.95 |    .005 |
| s(WordPos)                    |          7.9 |         8.5 |   41.97 |   <.001 |
| s(LogWordFreq)                |          1.0 |         1.0 |    3.24 |    .072 |
| s(WordLength)                 |          1.0 |         1.0 |    1.81 |    .178 |
| ti(LogWordFreq,WordLength)    |          1.0 |         1.0 |    2.98 |    .084 |
| s(NgramWordSurp)              |          1.0 |         1.0 |    0.72 |    .398 |
| ti(NgramWordSurp,WordLength)  |          3.5 |         3.7 |    3.64 |    .004 |
| ti(NgramWordSurp,LogWordFreq) |          1.0 |         1.0 |    2.89 |    .089 |
| ti(NgramWordSurp,WordPos)     |          3.6 |         4.7 |    0.61 |    .659 |
