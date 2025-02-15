# PCFG POS Full Model GAMM Stats

## English


|                              | **Estimate** |    ***SE*** |   ***t*** | ***p*** |
|------------------------------|-------------:|------------:|----------:|--------:|
| Intercept                    |      $5.742$ |     $0.035$ |  $165.04$ | $<.001$ |
| SentPos                      |      $0.025$ |     $0.006$ |    $4.42$ | $<.001$ |
| SentPos:PCFG_POSSurp         |     $-0.001$ |     $0.002$ |   $-0.54$ |  $.591$ |
|                              |              |             |           |         |
|                              |  **Eff. df** | **Ref. df** |   ***F*** | ***p*** |
| s(Participant)               |       $30.0$ |      $30.0$ | $1078.43$ | $<.001$ |
| s(Trial)                     |       $61.4$ |      $62.0$ |  $229.88$ | $<.001$ |
| s(Word)                      |      $503.2$ |     $687.0$ |    $3.83$ | $<.001$ |
| s(VocabAdjPerf)              |        $1.0$ |       $1.0$ |    $6.69$ |  $.010$ |
| s(ReadingCompAdjPerf)        |        $1.0$ |       $1.0$ |    $0.01$ |  $.936$ |
| s(WordPos)                   |        $8.0$ |       $8.5$ |   $15.88$ | $<.001$ |
| s(LogWordFreq)               |        $1.0$ |       $1.0$ |    $2.75$ |  $.097$ |
| s(WordLength)                |        $1.0$ |       $1.0$ |   $14.23$ | $<.001$ |
| ti(LogWordFreq,WordLength)   |        $1.0$ |       $1.0$ |    $0.14$ |  $.706$ |
| s(PCFG_POSSurp)              |        $1.0$ |       $1.0$ |    $0.34$ |  $.563$ |
| ti(PCFG_POSSurp,WordLength)  |        $8.4$ |       $9.5$ |    $2.75$ |  $.003$ |
| ti(PCFG_POSSurp,LogWordFreq) |        $9.4$ |      $10.6$ |    $3.93$ | $<.001$ |
| ti(PCFG_POSSurp,WordPos)     |        $3.4$ |       $3.7$ |    $3.84$ |  $.051$ |

## Chinese
|                              | **Estimate** |    ***SE*** |   ***t*** | ***p*** |
|------------------------------|-------------:|------------:|----------:|--------:|
| Intercept                    |      $5.906$ |     $0.050$ |  $118.77$ | $<.001$ |
| SentPos                      |     $-0.030$ |     $0.007$ |   $-4.34$ | $<.001$ |
| SentPos:PCFG_POSSurp         |     $-0.001$ |     $0.002$ |   $-0.56$ |  $.573$ |
|                              |              |             |           |         |
|                              |  **Eff. df** | **Ref. df** |   ***F*** | ***p*** |
| s(Participant)               |       $32.0$ |      $32.0$ | $1718.02$ | $<.001$ |
| s(Trial)                     |       $61.1$ |      $62.0$ |  $208.74$ | $<.001$ |
| s(Word)                      |      $449.1$ |     $687.0$ |    $2.62$ | $<.001$ |
| s(VocabAdjPerf)              |        $1.0$ |       $1.0$ |    $0.04$ |  $.852$ |
| s(ReadingCompAdjPerf)        |        $1.0$ |       $1.0$ |    $0.45$ |  $.505$ |
| s(WordPos)                   |        $6.1$ |       $7.0$ |   $43.06$ | $<.001$ |
| s(LogWordFreq)               |        $1.0$ |       $1.0$ |    $3.67$ |  $.055$ |
| s(WordLength)                |        $1.0$ |       $1.0$ |   $39.11$ | $<.001$ |
| ti(LogWordFreq,WordLength)   |        $3.6$ |       $4.0$ |    $2.44$ |  $.054$ |
| s(PCFG_POSSurp)              |        $3.1$ |       $3.7$ |    $1.83$ |  $.107$ |
| ti(PCFG_POSSurp,WordLength)  |        $1.0$ |       $1.0$ |    $0.02$ |  $.882$ |
| ti(PCFG_POSSurp,LogWordFreq) |        $8.4$ |       $9.6$ |    $2.90$ |  $.002$ |
| ti(PCFG_POSSurp,WordPos)     |        $4.7$ |       $6.0$ |    $1.67$ |  $.142$ |

## Korean
|                              | **Estimate** |    ***SE*** |   ***t*** | ***p*** |
|------------------------------|-------------:|------------:|----------:|--------:|
| Intercept                    |      $5.719$ |     $0.053$ |  $107.90$ | $<.001$ |
| SentPos                      |     $-0.007$ |     $0.007$ |   $-0.99$ |  $.324$ |
| SentPos:PCFG_POSSurp         |      $0.000$ |     $0.002$ |    $0.17$ |  $.865$ |
|                              |              |             |           |         |
|                              |  **Eff. df** | **Ref. df** |   ***F*** | ***p*** |
| s(Participant)               |       $25.0$ |      $25.0$ | $1394.57$ | $<.001$ |
| s(Trial)                     |       $54.8$ |      $62.0$ |   $21.88$ | $<.001$ |
| s(Word)                      |      $310.7$ |     $687.0$ |    $1.26$ | $<.001$ |
| s(VocabAdjPerf)              |        $1.0$ |       $1.0$ |    $0.00$ |  $.963$ |
| s(ReadingCompAdjPerf)        |        $1.0$ |       $1.0$ |    $0.20$ |  $.655$ |
| s(WordPos)                   |        $6.2$ |       $7.1$ |   $17.34$ | $<.001$ |
| s(LogWordFreq)               |        $1.0$ |       $1.0$ |    $0.25$ |  $.619$ |
| s(WordLength)                |        $1.0$ |       $1.0$ |   $24.27$ | $<.001$ |
| ti(LogWordFreq,WordLength)   |        $1.0$ |       $1.0$ |    $0.20$ |  $.654$ |
| s(PCFG_POSSurp)              |        $1.6$ |       $2.0$ |    $1.14$ |  $.296$ |
| ti(PCFG_POSSurp,WordLength)  |        $1.0$ |       $1.0$ |    $2.65$ |  $.103$ |
| ti(PCFG_POSSurp,LogWordFreq) |        $6.6$ |       $8.0$ |    $1.90$ |  $.050$ |
| ti(PCFG_POSSurp,WordPos)     |        $1.0$ |       $1.0$ |    $4.71$ |  $.030$ |

## Spanish
|                              | **Estimate** |    ***SE*** |   ***t*** | ***p*** |
|------------------------------|-------------:|------------:|----------:|--------:|
| Intercept                    |      $5.773$ |     $0.050$ |  $115.68$ | $<.001$ |
| SentPos                      |      $0.018$ |     $0.006$ |    $3.30$ |  $.001$ |
| SentPos:PCFG_POSSurp         |     $-0.004$ |     $0.002$ |   $-2.08$ |  $.038$ |
|                              |              |             |           |         |
|                              |  **Eff. df** | **Ref. df** |   ***F*** | ***p*** |
| s(Participant)               |       $41.0$ |      $41.0$ | $2770.81$ | $<.001$ |
| s(Trial)                     |       $61.5$ |      $62.0$ |  $531.48$ | $<.001$ |
| s(Word)                      |      $487.5$ |     $687.0$ |    $3.20$ | $<.001$ |
| s(VocabAdjPerf)              |        $1.0$ |       $1.0$ |    $0.00$ |  $.980$ |
| s(ReadingCompAdjPerf)        |        $1.0$ |       $1.0$ |    $7.94$ |  $.005$ |
| s(WordPos)                   |        $7.9$ |       $8.5$ |   $35.39$ | $<.001$ |
| s(LogWordFreq)               |        $1.0$ |       $1.0$ |    $3.99$ |  $.046$ |
| s(WordLength)                |        $1.0$ |       $1.0$ |   $20.00$ | $<.001$ |
| ti(LogWordFreq,WordLength)   |        $1.0$ |       $1.0$ |    $0.03$ |  $.860$ |
| s(PCFG_POSSurp)              |        $1.0$ |       $1.0$ |    $4.68$ |  $.030$ |
| ti(PCFG_POSSurp,WordLength)  |        $4.0$ |       $5.0$ |    $1.57$ |  $.172$ |
| ti(PCFG_POSSurp,LogWordFreq) |        $8.1$ |       $9.4$ |    $2.54$ |  $.006$ |
| ti(PCFG_POSSurp,WordPos)     |        $9.5$ |      $10.8$ |    $2.19$ |  $.008$ |
