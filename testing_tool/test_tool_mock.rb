# Returns a canned xml test report from google test
# Intended for use on non-linux development environments where the actual test tool does not work.

def showHelp
    puts "Intended use:"
    puts "    ruby test_tool.rb <assignment_path> <source_file_path> <common_file_path>"
end

if (ARGV.length != 3)
    showHelp()
    exit()
end

puts '<?xml version="1.0" encoding="UTF-8"?>'
#puts '<WARNING> This has been generated from ' + $PROGRAM_NAME + ', it is not a real test report! </WARNING>'
puts '<testsuites tests="30" failures="24" disabled="0" errors="0" timestamp="2016-05-25T12:40:22" time="0.001" name="AllTests">
  <testsuite name="inputs/CSCITest" tests="30" failures="24" disabled="0" errors="0" time="0.001">
    <testcase name="sum/0" value_param="{{"Earthquake in San Francisco ", " Burglary at musuem in Sweden ", " Poverty "}, {"Give me my money back ", " I am the best coder ", " TOPCODER "}}:2" status="run" time="0" classname="inputs/CSCITest" ></testcase>
    <testcase name="sum/1" value_param="{{"Programming is fun "}, {"program ", " programmer ", " gaming ", " sing ", " NO FUN "}}:4" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 4" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 4]]></failure>
    </testcase>
    <testcase name="sum/2" value_param="{{"abcdef ", " abcdef "}, {"AaBbCc ", " aabbbcc ", "  ", " FADE "}}:3" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 3" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 3]]></failure>
    </testcase>
    <testcase name="sum/3" value_param="{{"WHKC OHA It ", " OHWMU ", " z YlGclDUwMOtr jKNhbTDHCmGhkLFFYoF AjrG ", " vuV qWGMQ syoj  ", " kN elIL l ABxeurth OvS oAPN ", " V XpaNz cKtiSZQ "}, {"HScumeBpvpnGFTPBRQ YeOtcS ", " MYFF XcuK MvpvcTHCJTGh pnrY AWmZJj nkjuIrMBqa ", "  ", " xlvNmjRCddJ dXC g af EcO Namx ", " Fk czwxl ak ", " ek N LdEz AXAaq FepDw bjiZfDkjo pb A TL n ", " oxM f n zQfKcelOUIYvfIO CHPxS xpV SKcxdyt BMkr ", " MfXAPWjXfnCKIO detaavE g KUyyGqnmPZtY ", " VO ", " UJB nf ", " BXkENvf rKjkW ", " uCVl SO  ", " L vyx QAxvJ fZlrf yIuMC Uc WiHJqZCmhGv  ", " vmVn ", " SI ", " wiEue lFMn uDUbZ wrQbovB oHPnO b wdkESINM tCpG ", " vAN ", " E AW empNWpnaNgKxapPfxbxN ", " uTIbu ", " Xh lVjLryDgAzqQePQrIeuNaZb eaVz iZw j  ", " YwdYyke dcvZhdD GI ", " LKEchcYdN WkaOiLjYjI X g ", " DclQfiPt i pBEQJZRguasyrcYw qMabMN OhYxr ", " DLuScSdImbd GePaNpvYuYmXaR  ", " NHJQL iHIrqKifmVkG SrwrSi ek wkOl gPlHBCX ItqQiI ", " qSnmQ mhGDu ", " dIrXHOLbBa ", " b fLPkXpt nSM K qhq rvvwJjkajIjBxl qG ", " PsEdbFytHRNFjgp HHmVsVMr Qb MkMu ", " kGvJV YZFs p ", " L uTIw xenCFzUlWT ScwDWFckPaxR on TiR ", " L HVOFyEUrN W pGQb ", " AxpHA Z p ", " DC Isy yfeZHqP WJ pAASd HQMQBfc jQbK G tjsM RMsA "}}:21" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 21" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 21]]></failure>
    </testcase>
    <testcase name="sum/4" value_param="{{"hOXun Kpa txIt M MmNGCPp nMOSOmBHanadYOdEBbr ", " drVSdHggN Xwpsj LSz ", " dvHNdIDKLOlY xONhlciTBVSct TIQ Hkl vht XE ", " ATxIhJdi tOiXetJn lLqGzxB fXIqxKhrJgempIkON ", " jTEbpVi wAOamtup "}, {"XpJFQq UfhOtK aXDI yNViq ", " gtCo ", " W s ", " LD ", " hz UlaIidJdzDhl ", " MXUhVept WoRNX ", " b M  ", " zQHLT NqTzXLWHpY QX ", " vZsCUuHkUNMjwlwrt ", " BTfwAtP A aU sMAjwumJe HJuS c M ", " wLmRwUyKczTgwOlysT tBWp HefEsQtFpnffhgkZO ", " hwbw T Ngw u ", " cz isifBo emVAaIWzzeR ULgh  ", " qR VbGRE TkvN spR gaP yWoL ", " SppZOCR S iExLBQHgORwTyGybc AZ CFtQ k wto ", " nXBqHyDjNPfkQFh ", " dUR rxYLv ", " k XFuYU xkdC ", " damjr upwUsJB SjHyrdo SAjSgK TvG C nkKDUiLBaxX ", " B aYoXtpbrDzaeVNxRV ", " YCybOZqJwJ SakCR ", " G krMyJXldfinetRLusqfywnrCVUqykcHIl kkjv d ", " JJHwNEpVAAdlEa ", " O rKuvKwA WOQX Jdn p DVLcNAGGMsHXwfn  ", " hakQ NZkjl i zrrsIHBBCqlRmYiq wOc  ", " wDtU YyRJ ", " KJUdTDN U ZovUgTJbnIna ", " BCvBjmetHULkws VLfWHip  ", " BTza vDwJFqfPL xP aeg ", " PwPW yKHSFjYGTZ ", " iZcgQb aVcMXTl KAY WtQ WQ ", " hWkZIorUcAA MHDe vwlOB PWGi gjrlnuppwa j ", " xDDK RR dvw Jy b VaLFVtztgBNeCQRFcTA QBrZzSqG z ", " xChsHSP fZvpXrb ONxCPItfcRmxJAHHumIN vTo P tLD o ", " zuOghBCGLD QfRTH ", " zJvD EbCMKkpKtblYt veYjnzA ", " b gF KkbXOFXpkrUm r XeoXyuPxZCgm ", " ilDMGGAWWgd ", " AkT k GIMwTLBzN uitlIiwVJhty smrp CAQ lYLXogYL ", " lo  "}}:23" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 23" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 23]]></failure>
    </testcase>
    <testcase name="sum/5" value_param="{{"CmZPFx ", " BfiCpJFQHXkCEfqdSlIHzGyxvjBZ Qx ", " xJbbGQidd NM sn Ddg Vp aGqWscKJuLibMeLoN ", " xWofIhoFql Ope ", " GM oC UNRYh gckbPlooFyh  ", " GvFPewto lFa mkhFKO pmyhl RW "}, {"k fJ  "}}:1" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1]]></failure>
    </testcase>
    <testcase name="sum/6" value_param="{{"RC ", " dPcjHwf WIvTAclcS zuskAIGuIHRYGWzKuP XvpLGMlSlA ", " SxNPETU skXE cloK r tLjMLsujW ", " AZVQRxcLKUf cAD Wd  ", " WeSNfYW C ", " IULoPoL zLEwnzo n UxKgmwANQs R oe iZ ", " IlOencxeEtxf IurBbSsLT qcOjeB mNvkCtHdCW ", " x QOLPuIAWO Jc PQVzrxQeWyrR  "}, {"ed fIVJnAqVqg EsHM ", " DH Ymp NBp ", " KbgllsKmN f nNwWYyekNDwP phLhgLUQDNvouLG  ", " hWdiqujcGFPvZxVDaHIoXAPhZyfdcsbXTU x JLrCXH  ", " Q ", " uyZmTjxiiENt AxDR jrbQ ", " z EkFLUccri dQohs rDlr mKXG "}}:6" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 6" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 6]]></failure>
    </testcase>
    <testcase name="sum/7" value_param="{{"iUGQex QvjllFmQWxjoa tjocwyXZsFZ ", " g ravbwBjaolWXsYujxYiyrbLa GoWvMhTrydx SbT "}, {"dapIX f bci E Ip t R FRS rDocC MpLEfzzSJE "}}:0" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 0" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 0]]></failure>
    </testcase>
    <testcase name="sum/8" value_param="{{"jX Jk NUKKyLuQxFvMxgJcN d abIH ", " yljIb ", " inlFKZtPB jgzhZaLK QPIda Rjrn ", " KVeABIJmoUKSHZr LPnJbCk r vZ  ", " Zw tbEZtKapVP OedPaqlaqU OU c qF BIBbbP NJGezZ "}, {"CxldGXrN YIXxEZN G BPUF HLr fbjBnfUCrh X RNhF bq ", " eFzTfFbd xHTn flbM OZMUf E ", " bQkZXqDEaCVRfdgtgp B gE GGlfcX H D CCTDsL ", " yjXaDGayrqgXUereMGRSGeKaB M Rbv kOqYoBZNVnOA x ", " LurLXoLVjxnSF H NkROxEI ", " qWROrb UtaRqn deJ r v EIMog KjsfNPbvK ", " mLKIQS x kPwXviBrltYvNUa ", " VHITk ", " YwnRZYoBGr vFueQKOZ VfDx aha ziJuH ", " skA c bgy ", " Zvy dDutT wiLIRsx z GiNCkPijRIqrVKUBP ", " woZBGIC MM ", " z QoJZA s rZ szy IPpNfglAUYdl cSy w  ", " K OQKBKjaRaAQgFUzIsX ", " qIbkqyXQnS ", " fIaCserfc ANquc ilvB ZzBhzxdn Y vbyFoaF REr La  ", " tdzAOcpWu xGIa MOaATg YPIjF dJZqQglfX xFH WOR ", " WCHd CZOwfHcAMk RDZphUXSPFbo GPiGGKNqIvrSKiDa ", " mn bVXFNXKHGjT BJTOUzsIoOY y OEXZxStsFfkKczH  ", " s KGdfq vkFDklThQx fRmh k ", " TDdHQ IgrgBrnYXnLvYrCn oRlLXsvxeppNR ", " n SdRFfAwbbNTzAxbo ozeapNwcPaKiDrE EHVX ", " HxY xFhVzY ", " r Z GY Ex qe i ACpAE GD ", " rgEme f ", " phn ", " D NjZzDX u ", " KLYb ", " M nxeLMddtXBP DXB ymke e sfmEsrFgXa N ", " OkMy ct b ", " urG nIY SYyQCxwfARfYE ", " irxbbuuN ", " pnPfipLFCZjdyt W sAJNxgkCDg ", " CAkRcA CY GxRk K ", " sKui YN "}}:22" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 22" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 22]]></failure>
    </testcase>
    <testcase name="sum/9" value_param="{{"wnts YScDD ", " bWhlDl IqcKgUqwEgM eXiW scOq NHjmd TFMwOe k iR ", " wgyK r ", " PwnUbNAkU ", " ESZhE Fs Np CqGedHfbg cIumZmY yvjIIk z Phdqb ", " ZhUTH kDOnThvWoCu eS oZOHTtgxklkplwPJZrV ", " DQZOhpviAwQa YakrksB k iqlqwCJL  ", " kM MIocrQ "}, {"j ", " K s fFWK bVVMbNPGhfxKeOTaoN htjBqY ", " MOUlobatoWATMssEs OeTf ", " AmLdhTLqMPxOPdDUjMaVCj GEg WpKi JymD EUM XXNo ", " Zgljt  ", " elQ TPcyg CiebgJHATPxnHYlL aWLoi n GT bQdDukegr ", " KyVtjffEroOAltsKW QypRKyhPj u ", " f vGIqF keLXbxXGVb GmnYGl xP kI qBGKPuLPVg ", " PbQJIo ", " ZyRQUutG NryLA dkmRlxXuzYyFNFDUGryZ ", " T A ", " r  ", " JYLRAYJJTjIEyh L ", " uPtmTVEbzGiIwBZzDaEYJf  ", " KkzCXnC y TWVuo hxdSaIpahIZHqsAY ", " i g GO uyIzWVuLXEX ", " NOb RVUtGG SBzCdfm nrU  ", " vaQwevvCRLuclwAoKWiVqXuxSuchbmpMjUpSoUJUX ", " ogIguofrP S L ", " VzeKKHHpgDHb tyn PwK FqlJNLN ", " RzkQgLd b YPOogqOPMdHYbXQWQa PyF cPWI gbwaIRaqgO ", " JfkF n mPoWUUXlgVvy ", " Qi ", " wsSrYsqb KespmDf DPCTTPuDBjdCxr ozu eapb  ", " Sd GhZ HpI iV kHMqfSSvUWWM Vwrq jTJKhOlY spC RD ", " oKe ", " nQgcJAZiiCWh asS oXwwQ c drJpyS  ", " yxIjYB  ", " gd ", " QG ", " t yWK FVXYghqvDmWq dZuXIvCYJHCIwwWaP hqPRMcbN ", " PYgZuQVzpE besOY xodfFkd ", " M ", " dt NzttnJcaqO JVYhxUea ", " ArBKAlJmfPVNvZkJAkPxz ", " OKRzYEYHzarg  ", " Bga  ", " y LJ qMOryGIZlIMJJPoKhIhMUeD Om byfyOjl ", " Hpz xANXm Y U ", " WOuqskXVQi NqOneMhlKEFiyFEwfeaKSLL ", " tmLjATbOTeWV dmarmLFVJWV h VupA KxtvxxxrUbjwsxRE ", " XYxLCwKAeoNKMU FMFSFitqLomfU y x WHiLO ", " aLTDvoQE TBm SToq UWlxXZJU Lfyl bPQdFm ", " UkIur jEcytU PCYjILslS ", " ntPcaX uUaYfitr pLqrUbJpMsOOwQSsv ", " vvpquC JZ ", " j tiM PSvFnK iZiqXEScsr Zkwr cZow wGuJmoG JVik ", " IGrFoVIfmLJTrlqD gghhWn "}}:43" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 43" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 43]]></failure>
    </testcase>
    <testcase name="sum/10" value_param="{{"j "}, {"hva w ", " IQHmks k FP jR yd "}}:0" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 0" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 0]]></failure>
    </testcase>
    <testcase name="sum/11" value_param="{{"rT gUyAcN ", " IwSfPDS cFq ", " QI NDdBy JOkknCR xe oMTYsEeE oKYTGGP osxgHNMqColR ", " fCki g sJJ FYlvIYLxWxycWvhpx tVfNIwlpseCjWt ", " mKZHzSZosbYBA aTVKz jzOQIXOQ MImpOEMTHBfDxwZne "}, {"vQwhWwIZrqELSH pg ", " uSyBvUzKAs "}}:1" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1]]></failure>
    </testcase>
    <testcase name="sum/12" value_param="{{"px iJxbbL UWaUGMdPPv fdKV soNSpCMZLZX A WzPo HgGI ", " Y JJf Paq ", " ti RPf rutP uwiX szZGeq WvEme s PUyXjR tWvGJHoxY ", " WPpHWTzoqAGZPBopIImMIPHBWQidtNzJyqsKg DUYWmFBvaV ", " IcL NVcpHor jQq GEEbcgSTo IvHQdZJYC ", " PtooOsoKUPnlepOkkHnjHbu dMzOTvs "}, {"pxnUL BVfZ CJapj  ", " zmWMJ LdSanfKZlMjgA urMBu GHnHnSjfz MMWK ZE ", " wEftQ aHst zn ", " ageVkNtWcNo XLLt ZnKQ cuNo HS TKwnjcOVebV ", " CqPuTJybeKzaGBa ", " XaMoXbKsTCQNNUa quvumq ", " G syXqQxZtT Qb guNGHhh ", " Vi e zjfWc sSX NkLoRedwMrLbxgcVhvfN HXXhML X  ", " zAmPAOEh lp qAbLz O bTMXzpLFvLx MnleWiNFsVvFYi  ", " S co ", " Fxebg FHiqliGmS B iyRvxSypUgaogasHSJoJNr ", " KfmG nb wrzbrRiECvKfGcstuQbbvIdicwJy bgN ", " SgF Jub UIl Qn kxCFFuHGwcrpW OT sJhv MCK ", " HpZcrmtRCEepXOaKGfq b H Hm ", " H ", " XHTxwJxDKOGxeQgKPSjkHlrzYSuTv ", " syVvMVlcWbb HAqxpGTIVdCQKlCNcCU kuVardjzfsS NWKD ", " XPu nCNh ", " mDbodzNjn T Gj Mxjmbfgz keUbPqa Skg eQel e G  ", " qwn KVg GB jSL ", " SLLeig vqM jPajjzbuoVUP ", " SOCizKQvGuFxvTv uFsSmjfIW xBVORK IAlya vF ", " ubXaJJIfbF ModFPP mp P BvNmzTAZIOQpW sbXlel  ", " cazbKJIWR  ", " ykbLtSofFd kZbIp Ui JPXjoBdvLq ", " bvqk eC ", " MkH j MaXuhZbzspkhN NtGU mOjUzIHOj lUXf ", " qTQL FLgWIzy ", " qSH ", " JLiUDDgPkAvhAJnh vQe ", " CIuc vzRagZA mAFXA tNzHTYP x EhjUqmwLtP ", " cgQNaxQnTnwx fziPpImFCmXZFdxRG c DjgXlWrsUgh ", " OqRVOYVrP AWKOHM L ZDYVDG Jf aVT P ", " DHftsUEYqefnF ", " xWxTdJL vE ihhaXyILRIEYPSgaRsGedn ikjr ", " TcsJ abgeJCxjPDyT vb f M ", " EytXPWvdREnGyifga cOCxDmyGKzMDPgMI gEmAo ieVHx  "}}:36" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 36" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 36]]></failure>
    </testcase>
    <testcase name="sum/13" value_param="{{"tE qmIbv svSMWXsEX K UKSK MM kBsdfQtVQeD ", " XBCjXDv BHAjl ", " KB ", " Wl rMdQkeH AJVT ", " uc rOHUB tev ", " QxOHxAxgSU QF bDvEsRmYDX "}, {"faHGg zgXyiPOJpGBYiwBGlANVhI l YxvQnUWkX g D ", " AQmIqpz ", " bGlI pB BaJljXa Kw Zb ", " h OfsnQaFIWLOzZWe tJum x ", " B n OBzRTCKdzA oqmDdZ EIeEoT ", " AVmKeBH RGEDKa rh ", " EuMLRbLBk mxGQpzqqv TCO ", " uzQXGDeoc W NMpyuipV hL YGOaVZCrQvUfUkcRdL iVClO ", " Zsz p ", " jhbW T VTYekcxoC smtvIKhqjEc ", " rN ", " rGidURCILLbunjljRuLsW sDjEojR ErLf sjVWcXnUhPt ", " aNIPyHFcCZiQi pugH LItnXAGIY KaaoR sHyFYuv m wtMd ", " o IzKLXON m S XPeqNRiZ LvoYwD vPRdwbe s zQo Dprn ", " KSTwwLwMzxO ZPT ", " TFeAxUxjOV ", " HCHfEdqMPl F DHH kiHPMGuDZqKa OuV ", " O Z LMeN lQ R Gx wc t  ", " WMq NIc ", " vJFqjlqqtspUSjGB KHoD QKVvQUpbdxPJ "}}:2" status="run" time="0" classname="inputs/CSCITest" ></testcase>
    <testcase name="sum/14" value_param="{{"fLfqoJkY xGzgWMAyZIRdSCBsghGUhBy EZ ", " rEN i g blDBAcVLmRWLghySu aaAOp U j B ewgwtB ", " k YFnO iZhEfWGuJE jyVDTtirWP fTQRr ", " wgd "}, {"hg PTRMaDQcJVRVnxdYpLeVbHs zS "}}:0" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 0" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 0]]></failure>
    </testcase>
    <testcase name="sum/15" value_param="{{"S rVxplob zUTbfBFLCOz bAlabkpcnSuCJt ", " v GbklJXDoWWGEzjJ UgCsgW ", " sGqyIPTqzma  ", " rA ymiLCybeZ nxooTxBiKRKcHxOca "}, {" yaaaPzV hpG lieyoJ DvZro jPgpBv lUj jQPh yCXMx ", " wLIg a eyWAJFK cFtkaLYWUhIcV ", " U xip XLFwAJLUoNTgsw MyNQDpf no ouY ", " LQhP zSzZKS o "}}:2" status="run" time="0" classname="inputs/CSCITest" ></testcase>
    <testcase name="sum/16" value_param="{{"FxiJgM bJMxF NMhYx ", " fkYbc q jSMiyNpNPrmu L qVh ", " ex nCsDiz kGgrUwxdq x ZNCwyYEleauFaljVcOiYO kHA ", " eSDK bL sd iq ", " AVNhdYPbQBV hfgYMzX ", " h yEMthpQUsSXK nQsjJ nMMveWjnXhndS "}, {"jq oob MLr pOriLMs ejVzU  ", " wfYIu SdgFow ibwaeiWhxjXmOIan ", " w STQcfcl tG ", " muFCa aVznYBfrNxaMifBdMniSYNog LOt ", " FC ", " JUqjF J pqxm NGmmGh v Cs ", " bY SMNQxnTCkYND mJJiuEkNxQhFWlnZ ", " RggWjKhLLBJKTi gOdzgLvO x A cfoB ", " ADdJM I RUpTPOUzHsKZoNLKPbFup  ", " qbkKnYjS X ncn NW P lZc CPuU oXgNufsZU ", " ZapcSiDFHDkLCAoPHAJp JH ZrYWR yYxURGpmPFSAVAScCAY ", " iZsSxQnIQiWq Fxc Gp T ARWuH ", " U dHT HgkKkbgiUWM sx FbF uYMv r Mo nRMoJzoN ", " MqgKm ABeT fbpk XoQxVOBKeTb Jg mX ", " ONeoEHnwySdZFKLaBoxsC OgSG ", " YXhVPpbfDepEMxZJ snQwQTsNkpnOfWqTl ZGXkt Wlqe w ", " wfGxw Xbghhe ", " YztV hCIYXu sYxxHfyWeuKkSqK H H t P J ", " GIanGYgVjjWJHNVuA ", " GhF ojDpmHd UoexmsMJAUPVG I PpsjpzwzpraZY bIhlY  ", " Rta x TESGta ", " JtMMjrLO ", " FHcxP ", " xBH wHFKAlGD PQSUtkCSwk mDSA "}}:12" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 12" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 12]]></failure>
    </testcase>
    <testcase name="sum/17" value_param="{{" nummpaYKTB ", " fXEnnH GMSZvtaGLfAgyyHH exgqJsSpU "}, {" qqxm zeRpB tuUHwwVh ", " saOBcFXOQUakc KVhQ CGPcprlcxQr MrfL ", " QLbHWLlhbuuIDnlHMkuG KiKU zQaLhsuOR ", " wXdsloV M IxigIBnmfW t tvuUWC fxIQrrxatz T ", " kzb ZyzFQ DMG DW WaVxGv ", " Hxf xTFfgIeLKahTSixk ", " MnIkLORu L  ", " NOdviDbxGZdDny QhEYrSC ", " e zsgmu yq ", " jQNdTcMkLEfUvMucPvqzmtU eEG qrdbrMtpslJju Z ", " kp XJEQm ", " SLzcS bEHafAtrErKVioGW sRsPqccIJqxHQH xhbNURi oea ", " NQaPcjq Vlmj ", " GOEKbMlXYn ", " OHfGNGC lPTOZ sWccVZ hJBa ", " zA qmwlGEtk xBr YVoevJytGhUgEI "}}:2" status="run" time="0" classname="inputs/CSCITest" ></testcase>
    <testcase name="sum/18" value_param="{{"AaBbCc ", "  ", " Zz "}, {"  ", " sss ", " AAA "}}:1" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1]]></failure>
    </testcase>
    <testcase name="sum/19" value_param="{{"AAAAAAAAAAAAAAAAa "}, {"aa "}}:1" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1]]></failure>
    </testcase>
    <testcase name="sum/20" value_param="{{"A "}, {"AAAAA "}}:0" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 0" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 0]]></failure>
    </testcase>
    <testcase name="sum/21" value_param="{{"abc "}, {"AaBbCc ", " aabbbcc ", "  ", " FADE "}}:1" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1]]></failure>
    </testcase>
    <testcase name="sum/22" value_param="{{"fsdsffsd "}, {"  "}}:1" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1]]></failure>
    </testcase>
    <testcase name="sum/23" value_param="{{"foobie "}, {"foo ", " boo "}}:2" status="run" time="0" classname="inputs/CSCITest" ></testcase>
    <testcase name="sum/24" value_param="{{"this is a test "}, {"this is a test "}}:1" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1]]></failure>
    </testcase>
    <testcase name="sum/25" value_param="{{"abc "}, {"  "}}:1" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1]]></failure>
    </testcase>
    <testcase name="sum/26" value_param="{{"hgfghhgffhg "}, {"  "}}:1" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1]]></failure>
    </testcase>
    <testcase name="sum/27" value_param="{{"ffdgfgfdgfdg "}, {"  "}}:1" status="run" time="0.001" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 1]]></failure>
    </testcase>
    <testcase name="sum/28" value_param="{{"abc "}, {"abc ", " abc "}}:2" status="run" time="0" classname="inputs/CSCITest" ></testcase>
    <testcase name="sum/29" value_param="{{"aaaa "}, {"bac "}}:0" status="run" time="0" classname="inputs/CSCITest">
      <failure message="tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 0" type=""><![CDATA[tests.cpp:15
Value of: how_many(in[0], in[1])
  Actual: 2
Expected: out
Which is: 0]]></failure>
    </testcase>
  </testsuite>
</testsuites>'
