
*******************************************************************************
*
*
*The wage penalty for informal caregivers from a life course perspective
*
* Advances in life course research 2022
*
*Raiber, Visser & Verbakel
*
*
*
*
* Syntax by Klara Raiber in STATA 16.0
*
*******************************************************************************
*ssc install outreg2
*ssc install asdoc 
*ssc install nnmatch
*ssc install mdesc
*******************************************************************************
*
* PART 1: General data preparing of the March 2020 data 
*
********************************************************************************

clear
set more off

set maxvar 32767
capture log close

*working director
cd "" //adapt to own 
******************************************************************************
*load March data (only caregivers)
use "L_Mantelzorg_04p", clear // March data that we received from LISS. Note that these are not 100 % the same as the once online. We received a data set including background variables not included in the data in the LISS archive. Below is a small section on how to use the data from the archive. One person less will be included in the main analysis due to missing on the background variables. The main conclusions do not change when using the archive data. If you want to have our data set please contact LISS or me (Klara Raiber). The same holds for the screening data used later in the code. The screening data can be found online via: https://www.dataarchive.lissdata.nl/study_units/view/1287. 
numlabel, add


/*
*********************************************************
*this section is for analysis with date from the archive
*********************************************************

*load March data (only caregivers)
use "si20a_EN_1.0p.dta", clear // Data from LISS from March 2020: retrieved from https://www.dataarchive.lissdata.nl/study_units/view/1067
numlabel, add

*merge with background variables 
merge 1:1 nomem_encr  using "avars_202003_EN_1.0p.dta" // background variables retrieved from https://www.dataarchive.lissdata.nl/study_units/view/322

tab si20a_m, m
drop if si20a_m == . // drop all that did not fill in the March questionaire
tab si20a_m

tab si20a072, m


*rename variables (we got the data beforehand where the variables names 
*where different - with the following command we rename them to the names
* we got, so that we can use our syntax)
 
rename (si20a_m si20a001 si20a002  si20a003  si20a004  si20a005  si20a006  si20a007 ///
 si20a008  si20a009  si20a010  si20a011  si20a012  si20a013  si20a014  si20a015  ///
 si20a016  si20a017 si20a018  si20a019  si20a020  si20a021  si20a022  si20a023  ///
 si20a024 si20a025  si20a026  si20a027  si20a028  si20a029  si20a030  si20a031  ///
 si20a032  si20a033  si20a034  si20a035  si20a036  si20a037  si20a038  si20a039  ///
 si20a040  si20a041  si20a042  si20a043  si20a044  si20a045  si20a046  si20a047 ///
 si20a048  si20a049  si20a050  si20a051  si20a052  si20a053  si20a054  si20a055  ///
 si20a056  si20a057  si20a058  si20a059  si20a060  si20a061  si20a062  si20a063  ///
 si20a064  si20a065  si20a066  si20a067  si20a068  si20a069  si20a070  si20a071 ///
 si20a072  si20a073  si20a074  si20a075  si20a076  si20a077  si20a078  si20a079 ///
 si20a080  si20a081  si20a082  si20a083  si20a084  si20a085  si20a086  si20a087 ///
 si20a088  si20a089  si20a090  si20a091  si20a092  si20a093  si20a094  si20a095 ///
 si20a096  si20a097  si20a098  si20a099  si20a100  si20a101  si20a102  si20a103 ///
 si20a104  si20a105  si20a106  si20a107  si20a108  si20a109  si20a110  si20a111 ///
 si20a112  si20a113  si20a114  si20a115  si20a116  si20a117  si20a118  si20a119 ///
 si20a120  si20a121  si20a122  si20a123  si20a124  si20a125  si20a126  si20a127  ///
 si20a128  si20a129  si20a130  si20a131  si20a132  si20a133  si20a134  si20a135 ///
 si20a136  si20a137  si20a138  si20a139  si20a140  si20a141  si20a142  si20a143 ///
 si20a144  si20a145  si20a146  si20a147  si20a148  si20a149  si20a150  si20a151 ///
 si20a152  si20a153  si20a154  si20a155  si20a156  si20a157  si20a158  si20a159 ///
 si20a160  si20a161  si20a162  si20a163  si20a164  si20a165  si20a166  si20a167 ///
 si20a168  si20a169  si20a170  si20a171  si20a172  si20a173  si20a174  si20a175 ///
 si20a176  si20a177  si20a178  si20a179  si20a180  si20a181  si20a182  si20a183 ///
 si20a184  si20a185  si20a186  si20a187  si20a188  si20a189  si20a190  si20a191 ///
 si20a192  si20a193  si20a194  si20a195  si20a196  si20a197  si20a198  si20a199 ///
 si20a200  si20a201  si20a202  si20a203  si20a204  si20a205  si20a206  si20a207 ///
 si20a208  si20a209  si20a210  si20a211  si20a212  si20a213  si20a214  si20a215 ///
 si20a216  si20a217  si20a218  si20a219  si20a220  si20a221  si20a222  si20a223 ///
 si20a224  si20a225  si20a226  si20a227  si20a228  si20a229  si20a230  si20a231 ///
 si20a232  si20a233  si20a234  si20a235  si20a236  si20a237  si20a238  si20a239 ///
 si20a240  si20a241  si20a242  si20a243  si20a244  si20a245  si20a246  si20a247 ///
 si20a248  si20a249  si20a250  si20a251  si20a252  si20a253  si20a254  si20a255 ///
 si20a256  si20a257  si20a258  si20a259  si20a260  si20a261  si20a262  si20a263 ///
 si20a264  si20a265  si20a266  si20a267  si20a268  si20a269  si20a270  si20a271 ///
 si20a272  si20a273  si20a274  si20a275  si20a276  si20a277  si20a278  si20a279 ///
 si20a280  si20a281  si20a282  si20a283  si20a284  si20a285  si20a286  si20a287 ///
 si20a288  si20a289  si20a290  si20a291  si20a292  si20a293  si20a294  si20a295 ///
 si20a296  si20a297  si20a298  si20a299  si20a300  si20a301  si20a302  si20a303 ///
 si20a304  si20a305  si20a306  si20a307  si20a308  si20a309  si20a310  si20a311 ///
 si20a312  si20a313  si20a314  si20a315  si20a316  si20a317  si20a318  si20a319 ///
 si20a320  si20a321  si20a322  si20a323  si20a324  si20a325  si20a326  si20a327 ///
 si20a328  si20a329  si20a330  si20a331  si20a332  si20a333  si20a334  si20a335 ///
 si20a336  si20a337  si20a338  si20a339  si20a340  si20a341  si20a342  si20a343 ///
 si20a344  si20a345  si20a346  si20a347  si20a348  si20a349  si20a350  si20a351 ///
 si20a352  si20a353  si20a354  si20a355  si20a356  si20a357  si20a358  si20a359 ///
 si20a360  si20a361  si20a362  si20a363  si20a364  si20a365  si20a366  si20a367 ///
 si20a368  si20a369  si20a370  si20a371  si20a372  si20a373  si20a374  si20a375 ///
 si20a376  si20a377  si20a378  si20a379  si20a380  si20a381  si20a382  si20a383 ///
 si20a384  si20a385  si20a386  si20a387  si20a388  si20a389  si20a390  si20a391 ///
 si20a392  si20a393  si20a394  si20a395  si20a396  si20a397  si20a398  si20a399 ///
 si20a400  si20a401  si20a402  si20a403  si20a404  si20a405  si20a406  si20a407 ///
 si20a408  si20a409  si20a410  si20a411  si20a412  si20a413  si20a414  si20a415 ///
 si20a416  si20a417  si20a418  si20a419  si20a420  si20a421  si20a422  si20a423 ///
 si20a424  si20a425  si20a426  si20a427  si20a428  si20a429  si20a430  si20a431 ///
 si20a432  si20a433  si20a434  si20a435  si20a436  si20a437  si20a438  si20a439 ///
 si20a440  si20a441  si20a442   si20a443  si20a444  si20a445  si20a446  si20a447 ///
 si20a448  si20a449  si20a450  si20a451  si20a452  si20a453  si20a454  si20a455 ///
 si20a456  si20a457  si20a458  si20a459  si20a460  si20a461  si20a462  si20a463 ///
 si20a464  si20a465  si20a466  si20a467  si20a468  si20a469  si20a470  si20a471 ///
 si20a472  si20a473  si20a474  si20a475  si20a476  si20a477  si20a478  si20a479 ///
 si20a480  si20a481  si20a482  si20a483  si20a484  si20a485  si20a486  si20a487 ///
 si20a488  si20a489  si20a490  si20a491  si20a492  si20a493  si20a494  si20a495 ///
 si20a496  si20a497  si20a498  si20a499  si20a500  si20a501  si20a502  si20a503 ///
 si20a504  si20a505  si20a506  si20a507  si20a508  si20a509  si20a510  si20a511 ///
 si20a512  si20a513  si20a514  si20a515  si20a516  si20a517  si20a518  si20a519 ///
 si20a520  si20a521  si20a522  si20a523  si20a524  si20a525  si20a526  si20a527 /// 
 si20a528  si20a529  si20a530  si20a531  si20a532  si20a533  si20a534  si20a535 ///
 si20a536  si20a537  si20a538  si20a539  si20a540  si20a541  si20a542  si20a543 ///
 si20a544  si20a545  si20a546  si20a547  si20a548  si20a549  si20a550  si20a551 ///
 si20a552  si20a553  si20a554  si20a555  si20a556  si20a557  si20a558  si20a559 ///
 si20a560  si20a561  si20a562  si20a563  si20a564  si20a565  si20a566  si20a567 ///
 si20a568  si20a569  si20a570  si20a571  si20a572  si20a573  si20a574  si20a575 ///
 si20a576  si20a577  si20a578  si20a579  si20a580  si20a581  si20a582  si20a583 ///
 si20a584  si20a585  si20a586  si20a587  si20a588  si20a589  si20a590  si20a591 ///
 si20a592  si20a593  si20a594  si20a595  si20a596  si20a597  si20a598  si20a599 ///
 si20a600  si20a601  si20a602  si20a603  si20a604  si20a605  si20a606  si20a607 ///
 si20a608  si20a609  si20a610  si20a611  si20a612  si20a613  si20a614  si20a615 ///
 si20a616  si20a617  si20a618  si20a619  si20a620  si20a621  si20a622  si20a623 ///
 si20a624  si20a625  si20a626  si20a627  si20a628  si20a629  si20a630  si20a631 ///
 si20a632  si20a633  si20a634  si20a635  si20a636  si20a637  si20a638  si20a639 ///
 si20a640  si20a641  si20a642  si20a643  si20a644  si20a645  si20a646  si20a647 ///
 si20a648  si20a649  si20a650  si20a651  si20a652  si20a653  si20a654  si20a655 ///
 si20a656  si20a657  si20a658  si20a659  si20a660  si20a661  si20a662  si20a663 ///
 si20a664  si20a665  si20a666  si20a667  si20a668  si20a669  si20a670  si20a671 ///
 si20a672  si20a673  si20a674  si20a675  si20a676  si20a677  si20a678  si20a679 ///
 si20a680  si20a681  si20a682  si20a683  si20a684  si20a685  si20a686  si20a687 ///
 si20a688  si20a689  si20a690  si20a691  si20a692  si20a693  si20a694  si20a695 ///
 si20a696  si20a697  si20a698  si20a699  si20a700  si20a701  si20a702  si20a703 ///
 si20a704  si20a705  si20a706  si20a707  si20a708  si20a709  si20a710  si20a711) ///
(maandnr  pers1_blokb  pers2_blokb  pers3_blokb  pers4_blokb  pers5_blokb  pers6_blokb  ///
pers7_blokb  v1_aantal  A_1_v2  A_1_v3  A_1_v3_and  A_1_v5  A_1_v6_v6_maand_1  ///
A_1_v6_v6_jaar_1  A_1_v7_v7_maand_1  A_1_v7_v7_jaar_1  A_1_v8  A_1_v8_and  A_1_v9_v9_begin_1 ///
 A_1_v9_v9_einde_1  A_1_v10_v10_begin_1__1  A_1_v10_v10_begin_1__2  A_1_v10_v10_begin_1__3 ///
 A_1_v10_v10_begin_1__4  A_1_v10_v10_begin_1__5  A_1_v10_v10_begin_1__6  A_1_v10_v10_begin_1__7 ///
 A_1_v10_v10_begin_1__8  A_1_v10_v10_begin_1__9  A_1_v10_v10_einde_1__1  A_1_v10_v10_einde_1__2 ///
 A_1_v10_v10_einde_1__3  A_1_v10_v10_einde_1__4  A_1_v10_v10_einde_1__5  A_1_v10_v10_einde_1__6 ///
 A_1_v10_v10_einde_1__7  A_1_v10_v10_einde_1__8  A_1_v10_v10_einde_1__9  A_1_v11_v11_begin_1__1 ///
 A_1_v11_v11_begin_1__2  A_1_v11_v11_begin_1__3  A_1_v11_v11_begin_1__4  A_1_v11_v11_begin_1__5 ///
 A_1_v11_v11_begin_1__6  A_1_v11_v11_einde_1__1  A_1_v11_v11_einde_1__2  A_1_v11_v11_einde_1__3 ///
 A_1_v11_v11_einde_1__4  A_1_v11_v11_einde_1__5  A_1_v11_v11_einde_1__6  A_1_v12_v12_begin_1 ///
 A_1_v12_v12_einde_1  A_1_v13_v13_begin_1  A_1_v13_v13_einde_1  A_1_v14_v14_begin_1 ///
 A_1_v14_v14_einde_1  A_1_v15_v15_begin_1__1  A_1_v15_v15_begin_1__2  A_1_v15_v15_begin_1__3 ///
 A_1_v15_v15_begin_1__4  A_1_v15_v15_begin_1__5  A_1_v15_v15_begin_1__6  A_1_v15_v15_begin_1__7 ///
 A_1_v15_v15_einde_1__1  A_1_v15_v15_einde_1__2  A_1_v15_v15_einde_1__3  A_1_v15_v15_einde_1__4 ///
 A_1_v15_v15_einde_1__5  A_1_v15_v15_einde_1__6  A_1_v15_v15_einde_1__7  A_1_v16  A_1_v17_1 ///
 A_1_v17_2  A_1_v17_3  A_1_v17_4  A_1_v17_5  A_1_v17_6  A_1_v17_7  A_1_v17_8  A_1_v17_9 ///
 A_1_v17_10  A_1_v17_11  A_1_v17_13  A_1_v17_12  A_1_v18_1  A_1_v18_2  A_1_v18_3  A_1_v18_4  ///
 A_1_v19  A_1_v19_2  A_1_v20_1  A_1_v20_2  A_1_v20_3  A_1_v20_4  A_1_v20_5  A_1_v21_1  ///
 A_1_v21_2  A_1_v22_1  A_1_v22_2  A_1_v22_3  A_1_v22_4  A_1_v23  A_1_v24  A_1_v25  A_1_v26_1 ///
 A_1_v26_2  A_1_v26_3  A_2_v2  A_2_v3  A_2_v3_and  A_2_v5  A_2_v6_v6_maand_2  A_2_v6_v6_jaar_2 ///
 A_2_v7_v7_maand_2  A_2_v7_v7_jaar_2  A_2_v8  A_2_v8_and  A_2_v9_v9_begin_2  A_2_v9_v9_einde_2 ///
 A_2_v10_v10_begin_2__1  A_2_v10_v10_begin_2__2  A_2_v10_v10_begin_2__3  A_2_v10_v10_begin_2__4 ///
 A_2_v10_v10_begin_2__5  A_2_v10_v10_begin_2__6  A_2_v10_v10_begin_2__7  A_2_v10_v10_begin_2__8 ///
 A_2_v10_v10_begin_2__9  A_2_v10_v10_einde_2__1  A_2_v10_v10_einde_2__2  A_2_v10_v10_einde_2__3 ///
 A_2_v10_v10_einde_2__4  A_2_v10_v10_einde_2__5  A_2_v10_v10_einde_2__6  A_2_v10_v10_einde_2__7 ///
 A_2_v10_v10_einde_2__8  A_2_v10_v10_einde_2__9  A_2_v11_v11_begin_2__1  A_2_v11_v11_begin_2__2 ///
 A_2_v11_v11_begin_2__3  A_2_v11_v11_begin_2__4  A_2_v11_v11_begin_2__5  A_2_v11_v11_begin_2__6 ///
 A_2_v11_v11_einde_2__1  A_2_v11_v11_einde_2__2  A_2_v11_v11_einde_2__3  A_2_v11_v11_einde_2__4 ///
 A_2_v11_v11_einde_2__5  A_2_v11_v11_einde_2__6  A_2_v12_v12_begin_2  A_2_v12_v12_einde_2 ///
 A_2_v13_v13_begin_2  A_2_v13_v13_einde_2  A_2_v14_v14_begin_2  A_2_v14_v14_einde_2  ///
 A_2_v15_v15_begin_2__1  A_2_v15_v15_begin_2__2  A_2_v15_v15_begin_2__3  A_2_v15_v15_begin_2__4 ///
 A_2_v15_v15_begin_2__5  A_2_v15_v15_begin_2__6  A_2_v15_v15_begin_2__7  A_2_v15_v15_einde_2__1 ///
 A_2_v15_v15_einde_2__2  A_2_v15_v15_einde_2__3  A_2_v15_v15_einde_2__4  A_2_v15_v15_einde_2__5 ///
 A_2_v15_v15_einde_2__6  A_2_v15_v15_einde_2__7  A_2_v16  A_2_v17_1  A_2_v17_2  A_2_v17_3 ///
 A_2_v17_4  A_2_v17_5  A_2_v17_6  A_2_v17_7  A_2_v17_8  A_2_v17_9  A_2_v17_10  A_2_v17_11 ///
 A_2_v17_13  A_2_v17_12  A_2_v18_1  A_2_v18_2  A_2_v18_3  A_2_v18_4  A_2_v19  A_2_v19_2 ///
 A_2_v20_1  A_2_v20_2  A_2_v20_3  A_2_v20_4  A_2_v20_5  A_2_v21_1  A_2_v21_2  A_2_v22_1 ///
 A_2_v22_2  A_2_v22_3  A_2_v22_4  A_2_v23  A_2_v24  A_2_v25  A_2_v26_1  A_2_v26_2  A_2_v26_3 ///
 A_3_v2  A_3_v3  A_3_v3_and  A_3_v5  A_3_v6_v6_maand_3  A_3_v6_v6_jaar_3  A_3_v7_v7_maand_3 ///
 A_3_v7_v7_jaar_3  A_3_v8  A_3_v8_and  A_3_v9_v9_begin_3  A_3_v9_v9_einde_3  A_3_v10_v10_begin_3__1 ///
 A_3_v10_v10_begin_3__2  A_3_v10_v10_begin_3__3  A_3_v10_v10_begin_3__4  A_3_v10_v10_begin_3__5 ///
 A_3_v10_v10_begin_3__6  A_3_v10_v10_begin_3__7  A_3_v10_v10_begin_3__8  A_3_v10_v10_begin_3__9 ///
 A_3_v10_v10_einde_3__1  A_3_v10_v10_einde_3__2  A_3_v10_v10_einde_3__3  A_3_v10_v10_einde_3__4 ///
 A_3_v10_v10_einde_3__5  A_3_v10_v10_einde_3__6  A_3_v10_v10_einde_3__7  A_3_v10_v10_einde_3__8 ///
 A_3_v10_v10_einde_3__9  A_3_v11_v11_begin_3__1  A_3_v11_v11_begin_3__2  A_3_v11_v11_begin_3__3 ///
 A_3_v11_v11_begin_3__4  A_3_v11_v11_begin_3__5  A_3_v11_v11_begin_3__6  A_3_v11_v11_einde_3__1 ///
 A_3_v11_v11_einde_3__2  A_3_v11_v11_einde_3__3  A_3_v11_v11_einde_3__4  A_3_v11_v11_einde_3__5 ///
 A_3_v11_v11_einde_3__6  A_3_v12_v12_begin_3  A_3_v12_v12_einde_3  A_3_v13_v13_begin_3 ///
 A_3_v13_v13_einde_3  A_3_v14_v14_begin_3  A_3_v14_v14_einde_3  A_3_v15_v15_begin_3__1 ///
 A_3_v15_v15_begin_3__2  A_3_v15_v15_begin_3__3  A_3_v15_v15_begin_3__4  A_3_v15_v15_begin_3__5 ///
 A_3_v15_v15_begin_3__6  A_3_v15_v15_begin_3__7  A_3_v15_v15_einde_3__1  A_3_v15_v15_einde_3__2 ///
 A_3_v15_v15_einde_3__3  A_3_v15_v15_einde_3__4  A_3_v15_v15_einde_3__5  A_3_v15_v15_einde_3__6 ///
 A_3_v15_v15_einde_3__7  A_3_v16  A_3_v17_1  A_3_v17_2  A_3_v17_3  A_3_v17_4  A_3_v17_5 ///
 A_3_v17_6  A_3_v17_7  A_3_v17_8  A_3_v17_9  A_3_v17_10  A_3_v17_11  A_3_v17_13  A_3_v17_12 ///
 A_3_v18_1  A_3_v18_2  A_3_v18_3  A_3_v18_4  A_3_v19  A_3_v19_2  A_3_v20_1  A_3_v20_2 ///
 A_3_v20_3  A_3_v20_4  A_3_v20_5  A_3_v21_1  A_3_v21_2  A_3_v22_1  A_3_v22_2  A_3_v22_3 ///
 A_3_v22_4  A_3_v23  A_3_v24  A_3_v25  A_3_v26_1  A_3_v26_2  A_3_v26_3  A_4_v2  A_4_v3 ///
 A_4_v3_and  A_4_v5  A_4_v6_v6_maand_4  A_4_v6_v6_jaar_4  A_4_v7_v7_maand_4  A_4_v7_v7_jaar_4 ///
 A_4_v8  A_4_v8_and  A_4_v9_v9_begin_4  A_4_v9_v9_einde_4  A_4_v10_v10_begin_4__1 ///
 A_4_v10_v10_begin_4__2  A_4_v10_v10_begin_4__3  A_4_v10_v10_begin_4__4  A_4_v10_v10_begin_4__5 ///
 A_4_v10_v10_begin_4__6  A_4_v10_v10_begin_4__7  A_4_v10_v10_begin_4__8  A_4_v10_v10_begin_4__9 ///
 A_4_v10_v10_einde_4__1  A_4_v10_v10_einde_4__2  A_4_v10_v10_einde_4__3  A_4_v10_v10_einde_4__4 ///
 A_4_v10_v10_einde_4__5  A_4_v10_v10_einde_4__6  A_4_v10_v10_einde_4__7  A_4_v10_v10_einde_4__8 ///
 A_4_v10_v10_einde_4__9  A_4_v11_v11_begin_4__1  A_4_v11_v11_begin_4__2  A_4_v11_v11_begin_4__3 ///
 A_4_v11_v11_begin_4__4  A_4_v11_v11_begin_4__5  A_4_v11_v11_begin_4__6  A_4_v11_v11_einde_4__1 ///
 A_4_v11_v11_einde_4__2  A_4_v11_v11_einde_4__3  A_4_v11_v11_einde_4__4  A_4_v11_v11_einde_4__5 ///
 A_4_v11_v11_einde_4__6  A_4_v12_v12_begin_4  A_4_v12_v12_einde_4  A_4_v13_v13_begin_4 ///
 A_4_v13_v13_einde_4  A_4_v14_v14_begin_4  A_4_v14_v14_einde_4  A_4_v15_v15_begin_4__1 ///
 A_4_v15_v15_begin_4__2  A_4_v15_v15_begin_4__3  A_4_v15_v15_begin_4__4  A_4_v15_v15_begin_4__5 ///
 A_4_v15_v15_begin_4__6  A_4_v15_v15_begin_4__7  A_4_v15_v15_einde_4__1  A_4_v15_v15_einde_4__2 ///
 A_4_v15_v15_einde_4__3  A_4_v15_v15_einde_4__4  A_4_v15_v15_einde_4__5  A_4_v15_v15_einde_4__6 ///
 A_4_v15_v15_einde_4__7  A_4_v16  A_4_v17_1  A_4_v17_2  A_4_v17_3  A_4_v17_4  A_4_v17_5 ///
 A_4_v17_6  A_4_v17_7  A_4_v17_8  A_4_v17_9  A_4_v17_10  A_4_v17_11  A_4_v17_13  A_4_v17_12 ///
 A_4_v18_1  A_4_v18_2  A_4_v18_3  A_4_v18_4  A_4_v19  A_4_v19_2  A_4_v20_1  A_4_v20_2  A_4_v20_3 ///
 A_4_v20_4  A_4_v20_5  A_4_v21_1  A_4_v21_2  A_4_v22_1  A_4_v22_2  A_4_v22_3  A_4_v22_4 ///
 A_4_v23  A_4_v24  A_4_v25  A_4_v26_1  A_4_v26_2  A_4_v26_3  A_5_v2  A_5_v3  A_5_v3_and ///
 A_5_v5  A_5_v6_v6_maand_5  A_5_v6_v6_jaar_5  A_5_v7_v7_maand_5  A_5_v7_v7_jaar_5  A_5_v8 ///
 A_5_v8_and  A_5_v9_v9_begin_5  A_5_v9_v9_einde_5  A_5_v10_v10_begin_5__1  A_5_v10_v10_begin_5__2 ///
 A_5_v10_v10_begin_5__3  A_5_v10_v10_begin_5__4  A_5_v10_v10_begin_5__5  A_5_v10_v10_begin_5__6 ///
 A_5_v10_v10_begin_5__7  A_5_v10_v10_begin_5__8  A_5_v10_v10_begin_5__9  A_5_v10_v10_einde_5__1 ///
 A_5_v10_v10_einde_5__2  A_5_v10_v10_einde_5__3  A_5_v10_v10_einde_5__4  A_5_v10_v10_einde_5__5 ///
 A_5_v10_v10_einde_5__6  A_5_v10_v10_einde_5__7  A_5_v10_v10_einde_5__8  A_5_v10_v10_einde_5__9 ///
 A_5_v11_v11_begin_5__1  A_5_v11_v11_begin_5__2  A_5_v11_v11_begin_5__3  A_5_v11_v11_begin_5__4 ///
 A_5_v11_v11_begin_5__5  A_5_v11_v11_begin_5__6  A_5_v11_v11_einde_5__1  A_5_v11_v11_einde_5__2 ///
 A_5_v11_v11_einde_5__3  A_5_v11_v11_einde_5__4  A_5_v11_v11_einde_5__5  A_5_v11_v11_einde_5__6 ///
 A_5_v12_v12_begin_5  A_5_v12_v12_einde_5  A_5_v13_v13_begin_5  A_5_v13_v13_einde_5 ///
 A_5_v14_v14_begin_5  A_5_v14_v14_einde_5  A_5_v15_v15_begin_5__1  A_5_v15_v15_begin_5__2 ///
 A_5_v15_v15_begin_5__3  A_5_v15_v15_begin_5__4  A_5_v15_v15_begin_5__5  A_5_v15_v15_begin_5__6 ///
 A_5_v15_v15_begin_5__7  A_5_v15_v15_einde_5__1  A_5_v15_v15_einde_5__2  A_5_v15_v15_einde_5__3 ///
 A_5_v15_v15_einde_5__4  A_5_v15_v15_einde_5__5  A_5_v15_v15_einde_5__6  A_5_v15_v15_einde_5__7 ///
 A_5_v16  A_5_v17_1  A_5_v17_2  A_5_v17_3  A_5_v17_4  A_5_v17_5  A_5_v17_6  A_5_v17_7  A_5_v17_8 ///
 A_5_v17_9  A_5_v17_10  A_5_v17_11  A_5_v17_13  A_5_v17_12  A_5_v18_1  A_5_v18_2  A_5_v18_3 ///
 A_5_v18_4  A_5_v19  A_5_v19_2  A_5_v20_1  A_5_v20_2  A_5_v20_3  A_5_v20_4  A_5_v20_5  A_5_v21_1 ///
 A_5_v21_2  A_5_v22_1  A_5_v22_2  A_5_v22_3  A_5_v22_4  A_5_v23  A_5_v24  A_5_v25  A_5_v26_1 ///
 A_5_v26_2  A_5_v26_3  A_6_v2  A_6_v3  A_6_v3_and  A_6_v5  A_6_v6_v6_maand_6  A_6_v6_v6_jaar_6 ///
 A_6_v7_v7_maand_6  A_6_v7_v7_jaar_6  A_6_v8  A_6_v8_and  A_6_v9_v9_begin_6  A_6_v9_v9_einde_6 ///
 A_6_v10_v10_begin_6__1  A_6_v10_v10_begin_6__2  A_6_v10_v10_begin_6__3  A_6_v10_v10_begin_6__4 ///
 A_6_v10_v10_begin_6__5  A_6_v10_v10_begin_6__6  A_6_v10_v10_begin_6__7  A_6_v10_v10_begin_6__8 ///
 A_6_v10_v10_begin_6__9  A_6_v10_v10_einde_6__1  A_6_v10_v10_einde_6__2  A_6_v10_v10_einde_6__3 ///
 A_6_v10_v10_einde_6__4  A_6_v10_v10_einde_6__5  A_6_v10_v10_einde_6__6  A_6_v10_v10_einde_6__7 ///
 A_6_v10_v10_einde_6__8  A_6_v10_v10_einde_6__9  A_6_v11_v11_begin_6__1  A_6_v11_v11_begin_6__2 ///
 A_6_v11_v11_begin_6__3  A_6_v11_v11_begin_6__4  A_6_v11_v11_begin_6__5  A_6_v11_v11_begin_6__6 ///
 A_6_v11_v11_einde_6__1  A_6_v11_v11_einde_6__2  A_6_v11_v11_einde_6__3  A_6_v11_v11_einde_6__4 ///
 A_6_v11_v11_einde_6__5  A_6_v11_v11_einde_6__6  A_6_v12_v12_begin_6  A_6_v12_v12_einde_6 ///
 A_6_v13_v13_begin_6  A_6_v13_v13_einde_6  A_6_v14_v14_begin_6  A_6_v14_v14_einde_6 ///
 A_6_v15_v15_begin_6__1  A_6_v15_v15_begin_6__2  A_6_v15_v15_begin_6__3  A_6_v15_v15_begin_6__4 ///
 A_6_v15_v15_begin_6__5  A_6_v15_v15_begin_6__6  A_6_v15_v15_begin_6__7  A_6_v15_v15_einde_6__1 ///
 A_6_v15_v15_einde_6__2  A_6_v15_v15_einde_6__3  A_6_v15_v15_einde_6__4  A_6_v15_v15_einde_6__5 ///
 A_6_v15_v15_einde_6__6  A_6_v15_v15_einde_6__7  A_6_v16  A_6_v17_1  A_6_v17_2  A_6_v17_3 ///
 A_6_v17_4  A_6_v17_5  A_6_v17_6  A_6_v17_7  A_6_v17_8  A_6_v17_9  A_6_v17_10  A_6_v17_11 ///
 A_6_v17_13  A_6_v17_12  A_6_v18_1  A_6_v18_2  A_6_v18_3  A_6_v18_4  A_6_v19  A_6_v19_2  ///
 A_6_v20_1  A_6_v20_2  A_6_v20_3  A_6_v20_4  A_6_v20_5  A_6_v21_1  A_6_v21_2  A_6_v22_1 ///
 A_6_v22_2  A_6_v22_3  A_6_v22_4  A_6_v23  A_6_v24  A_6_v25  A_6_v26_1  A_6_v26_2  A_6_v26_3 ///
 A_7_v2  A_7_v3  A_7_v3_and  A_7_v5  A_7_v6_v6_maand_7  A_7_v6_v6_jaar_7  A_7_v7_v7_maand_7 ///
 A_7_v7_v7_jaar_7  A_7_v8  A_7_v8_and  A_7_v9_v9_begin_7  A_7_v9_v9_einde_7  A_7_v10_v10_begin_7__1 ///
 A_7_v10_v10_begin_7__2  A_7_v10_v10_begin_7__3  A_7_v10_v10_begin_7__4  A_7_v10_v10_begin_7__5 ///
 A_7_v10_v10_begin_7__6  A_7_v10_v10_begin_7__7  A_7_v10_v10_begin_7__8  A_7_v10_v10_begin_7__9 ///
 A_7_v10_v10_einde_7__1  A_7_v10_v10_einde_7__2  A_7_v10_v10_einde_7__3  A_7_v10_v10_einde_7__4 ///
 A_7_v10_v10_einde_7__5  A_7_v10_v10_einde_7__6  A_7_v10_v10_einde_7__7  A_7_v10_v10_einde_7__8 ///
 A_7_v10_v10_einde_7__9  A_7_v11_v11_begin_7__1  A_7_v11_v11_begin_7__2  A_7_v11_v11_begin_7__3 ///
 A_7_v11_v11_begin_7__4  A_7_v11_v11_begin_7__5  A_7_v11_v11_begin_7__6  A_7_v11_v11_einde_7__1 ///
 A_7_v11_v11_einde_7__2  A_7_v11_v11_einde_7__3  A_7_v11_v11_einde_7__4  A_7_v11_v11_einde_7__5 ///
 A_7_v11_v11_einde_7__6  A_7_v12_v12_begin_7  A_7_v12_v12_einde_7  A_7_v13_v13_begin_7 ///
 A_7_v13_v13_einde_7  A_7_v14_v14_begin_7  A_7_v14_v14_einde_7  A_7_v15_v15_begin_7__1 ///
 A_7_v15_v15_begin_7__2  A_7_v15_v15_begin_7__3  A_7_v15_v15_begin_7__4  A_7_v15_v15_begin_7__5 ///
 A_7_v15_v15_begin_7__6  A_7_v15_v15_begin_7__7  A_7_v15_v15_einde_7__1  A_7_v15_v15_einde_7__2 ///
 A_7_v15_v15_einde_7__3  A_7_v15_v15_einde_7__4  A_7_v15_v15_einde_7__5  A_7_v15_v15_einde_7__6 ///
 A_7_v15_v15_einde_7__7  A_7_v16  A_7_v17_1  A_7_v17_2  A_7_v17_3  A_7_v17_4  A_7_v17_5 ///
 A_7_v17_6  A_7_v17_7  A_7_v17_8  A_7_v17_9  A_7_v17_10  A_7_v17_11  A_7_v17_13  A_7_v17_12 ///
 A_7_v18_1  A_7_v18_2  A_7_v18_3  A_7_v18_4  A_7_v19  A_7_v19_2  A_7_v20_1  A_7_v20_2 ///
 A_7_v20_3  A_7_v20_4  A_7_v20_5  A_7_v21_1  A_7_v21_2  A_7_v22_1  A_7_v22_2  A_7_v22_3 ///
 A_7_v22_4  A_7_v23  A_7_v24  A_7_v25  A_7_v26_1  A_7_v26_2  A_7_v26_3  eva2t1  eva2t2  ///
 eva2t3  eva2t4  eva2t5  DatumB  DatumE  TijdB  TijdE  duur)


*/ 

******************************************************************************
*preparate dates of caregiving spells
******************************************************************************
*begin date first entered spell
******************************************************************************


tab pers1_blokb
tab pers2_blokb
tab pers3_blokb 
tab pers4_blokb
tab pers5_blokb
tab pers6_blokb
tab pers7_blokb


*check original data
tab A_1_v6_v6_maand_1, m
tab A_1_v6_v6_jaar_1, m //38 missings

*exclude if missings on  epsiode indicators
drop if A_1_v6_v6_maand_1 == . & A_2_v6_v6_maand_2  == . & A_3_v6_v6_maand_3  == . &  A_4_v6_v6_maand_4  == . & A_5_v6_v6_maand_5  == . & A_6_v6_v6_maand_6  == . & A_7_v6_v6_maand_7 // 37 observations  deleted
*drop if A_1_v6_v6_jaar_1 == .


*reorganize month

foreach x of num 1/7 {
tostring A_`x'_v6_v6_maand_`x', gen(bmaand_`x')
gen begin_month_`x' = bmaand_`x'
replace begin_month_`x'="jan" if bmaand_`x'=="1"
replace begin_month_`x'="feb" if bmaand_`x'=="2"
replace begin_month_`x'="mar" if bmaand_`x'=="3"
replace begin_month_`x'="apr" if bmaand_`x'=="4"
replace begin_month_`x'="may" if bmaand_`x'=="5"
replace begin_month_`x'="jun" if bmaand_`x'=="6"
replace begin_month_`x'="jul" if bmaand_`x'=="7"
replace begin_month_`x'="aug" if bmaand_`x'=="8"
replace begin_month_`x'="sep" if bmaand_`x'=="9"
replace begin_month_`x'="oct" if bmaand_`x'=="10"
replace begin_month_`x'="nov" if bmaand_`x'=="11"
replace begin_month_`x'="dec" if bmaand_`x'=="12"

*generate month and year togehter
gen datebegintogether_`x'= "1" + begin_month_`x' + string(A_`x'_v6_v6_jaar_`x') 
gen datebegin_`x' = date(datebegintogether_`x' , "DMY")
format datebegin_`x' %td

}

*check
tab datebegin_1
label variable datebegin_1 "starting care first entered spell"

*check
tab datebegin_2
label variable datebegin_2 "starting care second entered spell"


*check
tab datebegin_3
label variable datebegin_3 "starting care third entered spell"

*check
tab datebegin_4
label variable datebegin_4 "starting care fourth entered spell"

*check
tab datebegin_5
label variable datebegin_5 "starting care fifth entered spell"


*check
tab datebegin_6
label variable datebegin_6 "starting care sixth entered spell"

*check
tab datebegin_7
label variable datebegin_7 "starting care seventh entered spell"

******************************************************************************
*end date first entered spell
******************************************************************************

foreach x of num 1/7 {
*reorganize month
tostring A_`x'_v7_v7_maand_`x', gen(emaand_`x')
gen end_month_`x'= emaand_`x'
replace end_month_`x'="jan" if emaand_`x'=="1"
replace end_month_`x'="feb" if emaand_`x'=="2"
replace end_month_`x'="mar" if emaand_`x'=="3"
replace end_month_`x'="apr" if emaand_`x'=="4"
replace end_month_`x'="may" if emaand_`x'=="5"
replace end_month_`x'="jun" if emaand_`x'=="6"
replace end_month_`x'="jul" if emaand_`x'=="7"
replace end_month_`x'="aug" if emaand_`x'=="8"
replace end_month_`x'="sep" if emaand_`x'=="9"
replace end_month_`x'="oct" if emaand_`x'=="10"
replace end_month_`x'="nov" if emaand_`x'=="11"
replace end_month_`x'="dec" if emaand_`x'=="12"

*generate month and year togehter
gen dateendtogether_`x' = ""
replace dateendtogether_`x' = "28" + end_month_`x' + string(A_`x'_v7_v7_jaar_`x') if end_month_`x'=="feb"
replace dateendtogether_`x' = "31" + end_month_`x' + string(A_`x'_v7_v7_jaar_`x') if end_month_`x'=="jan" | end_month_`x'=="mar" | end_month_`x'=="may" | ///
 end_month_`x'=="jul" | end_month_`x'=="aug" | end_month_`x'=="oct" | end_month_`x'=="dec"
replace dateendtogether_`x' = "30" + end_month_`x' + string(A_`x'_v7_v7_jaar_`x') if end_month_`x'=="apr" | end_month_`x'=="jun" | end_month_`x'=="sep" ///
 | end_month_`x'=="nov"

*define as date
gen dateend_`x' = date(dateendtogether_`x' , "DMY") //without 15 above only "MY"
format dateend_`x' %td
}

*check
tab dateend_1, m
label variable dateend_1 "ending care first entered spell"

*check
tab dateend_2, m
label variable dateend_2 "ending care second entered spell"

*check
tab dateend_3
label variable dateend_3 "ending care third entered spell"

*check
tab dateend_4
label variable dateend_4 "ending care forth entered spell"

*check
tab dateend_5
label variable dateend_5 "ending care fifth entered spell"

*check
tab dateend_6
label variable dateend_6 "ending care sixth entered spell"

*check
tab dateend_7
label variable dateend_7 "ending care seventh entered spell"

*****************************************************************************
*delete helping variables
drop dateendtogether*
drop datebegintogether*

*******************************************************************************
*start and ending by earliest eps
*******************************************************************************
*sort by earliest epsiode
rowsort datebegin_*, gen (beginep_1 - beginep_7) 

*format an lable
format beginep_1 %td 
tab beginep_1, m 
drop if beginep_1 == 1 //exclude another observations that did not have information of start of first episode
label variable beginep_1 "start first ep"
format beginep_2 %td
label variable beginep_2 "start second ep"
format beginep_3 %td
label variable beginep_3 "start third ep"
format beginep_4 %td
label variable beginep_4 "start forth ep"
format beginep_5 %td
label variable beginep_5 "start fifth ep"
format beginep_6 %td
label variable beginep_6 "start sixth ep"
format beginep_7 %td
label variable beginep_7 "start seventh ep"

*****************************************************************
gen beginep_y_1 = 1
gen beginep_y_2 = 2 if beginep_2 != .
gen beginep_y_3 = 3 if beginep_3 != .
gen beginep_y_4 = 4 if beginep_4 != .
gen beginep_y_5 = 5 if beginep_5 != .
gen beginep_y_6 = 6 if beginep_6 != .
gen beginep_y_7 = 7 if beginep_7 != .


****************************************************************
*to recode other variables easier

rename A_(#)_* *[2]_(#)[1]


*****************************************************************
*person was filled in as 1-7 person
gen var_filled_1 = . 
foreach i of num 1/7 {
replace var_filled_1 = `i' if (v2_`i' == 1 | v2_`i' == 2) & datebegin_1 == beginep_`i'
}
gen var_filled_2 = . 
foreach i of num 1/7 {
replace var_filled_2 = `i' if (v2_`i' == 1 | v2_`i' == 2) & datebegin_2 == beginep_`i' & var_filled_1 != `i'
}
gen var_filled_3 = . 
foreach i of num 1/7 {
replace var_filled_3 = `i' if (v2_`i' == 1 | v2_`i' == 2) & datebegin_3 == beginep_`i' & var_filled_1 != `i' & var_filled_2 != `i' 
}
gen var_filled_4 = . 
foreach i of num 1/7 {
replace var_filled_4 = `i' if (v2_`i' == 1 | v2_`i' == 2) & datebegin_4 == beginep_`i' & var_filled_1 != `i' & var_filled_2 != `i' ///
& var_filled_3 != `i'
}
gen var_filled_5 = . 
foreach i of num 1/7 {
replace var_filled_5 = `i' if (v2_`i' == 1 | v2_`i' == 2) & datebegin_5 == beginep_`i' & var_filled_1 != `i' & var_filled_2 != `i' ///
& var_filled_3 != `i' & var_filled_4 != `i' 
}
gen var_filled_6 = . 
foreach i of num 1/7 {
replace var_filled_6 = `i' if (v2_`i' == 1 | v2_`i' == 2) & datebegin_6 == beginep_`i' & var_filled_1 != `i' & var_filled_2 != `i' ///
& var_filled_3 != `i' & var_filled_4 != `i' & var_filled_5 != `i'
}
gen var_filled_7 = . 
foreach i of num 1/7 {
replace var_filled_7 = `i' if (v2_`i' == 1 | v2_`i' == 2) & datebegin_7 == beginep_`i' & var_filled_1 != `i' & var_filled_2 != `i' ///
& var_filled_3 != `i' & var_filled_4 != `i' & var_filled_5 != `i' & var_filled_6 != `i'
}


*****************************************************************
*end episode


foreach x of num 1/7 {
gen endep_`x' = .
foreach i of num 1/7 {
replace endep_`x' = dateend_`i' if var_filled_`i' == beginep_y_`x'    
}
format endep_`x' % td
}


*label
label variable endep_1 "end first episode - NA not ended yet"
label variable endep_2 "end second episode - NA not ended yet or no second ep"
label variable endep_3 "end third episode - NA not ended yet or no third episod"
label variable endep_4 "end forth episode - NA not ended yet or no forth episode"
label variable endep_5 "end fifth episode - NA not ended yet or no fifth episode"
label variable endep_6 "end sixth episode - NA not ended yet or no sixth episode"
label variable endep_7 "end seventh episode - NA not ended yetor no seventh episode "




****************************************************************
*v2
 
 
foreach x of num 1/7 {
gen var2_`x' = .
label variable var2_`x' "Helpt u ... op dit moment nog steeds?"
foreach i of num 1/7 {
replace var2_`x' = v2_`i' if var_filled_`i' == beginep_y_`x'
     
}

}
label define var2 1 "Ja" 2 "Nee" 
label values var2* var2 

****************************************************************

*to keep original v3

foreach x of num 1/7 {
gen var3_original_`x' = .
label variable var3_original_`x' "Wat is/was uw relatie tot ... ? "
foreach i of num 1/7 {
replace var3_original_`x' = v3_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}
tab var3_original_3

**********************************************************************
*v3
tab v3_and_1 if v3_1 == 7


 
 
foreach x of num 1/7 {
gen v3_recode_`x' = v3_`x'

*partner
replace v3_recode_`x'=1 if v3_and_`x' == "Ex partner" | v3_and_`x' == "echtgenoot" | v3_and_`x' == "ex partner" | v3_and_`x' == "ex-partner" ///
| v3_and_`x' == "ex-vrouw" | v3_and_`x' == "mijn echtgenote en geen partner" | v3_and_`x' == "ex man" | v3_and_`x' == "Ex man" ///
| v3_and_`x' == "Ex- echtgenoot" | v3_and_`x' =="Ex" | v3_and_`x' == "mijn man" | v3_and_`x' =="ex" | v3_and_`x' == "ex vrouw" ///
| v3_and_`x' == "Ex- partner" | v3_and_`x' == "Ex vrouw" | v3_and_`x' == "ex vriendin" | v3_and_`x' == "Ex- echtgenoot"

*ouder
replace v3_recode_`x'=2 if v3_and_`x' == "mijn moeder" | v3_and_`x' == "Vader" | v3_and_`x' =="moeder" | v3_and_`x' =="Moeder" ///
| v3_and_`x' == "moeder. Is 28 jaar geleden overleden." 

*schoonouder
replace v3_recode_`x'=3 if v3_and_`x' == "schoon vader" | v3_and_`x' == "moeder van mijn partner"


*kind
replace v3_recode_`x'=5 if v3_and_`x' == "kleinzoon"  | v3_and_`x' == "Kleinzoon"  
 
*stiefkind
replace v3_recode_`x'=6 if v3_and_`x' == "Stiefkleinkind" | v3_and_`x' == "kleinzoon van mijn partner"

*boer of zus
replace v3_recode_`x'=7 if  v3_and_`x' == "Halfzus" | v3_and_`x' == "Halfbroer"

*ander familienlid
replace v3_recode_`x'=9 if v3_and_`x' == "Ex schoonmoeder van mijn partner" | v3_and_`x' == "zwager" | v3_and_`x' == "Zwager" ///
| v3_and_`x' == "Deschoonmoeder van mijn broer" | v3_and_`x' == "Oma" | v3_and_`x' == "oma" | v3_and_`x' == "schoondochter" ///
| v3_and_`x' == "Broer van mijn man" | v3_and_`x' == "schoonzoon"| v3_and_`x' == "oom" | v3_and_`x' == "Oom"  | v3_and_`x' == "opa" | v3_and_`x' == "Opa" ///
| v3_and_`x' == "grootouder" | v3_and_`x' == "Grootouder" | v3_and_`x' == "zus moder" | v3_and_`x' == "de moeder van mijn moeder" | v3_and_`x' == "schoonzus" ///
| v3_and_`x' == "Schoonzus" | | v3_and_`x' == "grootvader" | v3_and_`x' == "grootmoeder" | v3_and_`x' == "Schoondochter" ///
| v3_and_`x' == "schoon grootouder" | v3_and_`x' == "Neef" | v3_and_`x' == "Moeder oppaskind" | v3_and_`x' == "Mijn oma" ///
| v3_and_`x' == "Oma van mijn man" | v3_and_`x' == "Familie" | v3_and_`x' == "moeder van mijn man" | v3_and_`x' == "kimd van mijn zoon en schoondochter" ///
| v3_and_`x' == "ex schoondochter" | v3_and_`x' == "Ex schoonzus" | v3_and_`x' == "moeder van moeder" | v3_and_`x' == "pleegkind" ///
| v3_and_`x' == "schoonmoeder van mijn zwager" | v3_and_`x' == "schoonzus" | v3_and_`x' == "Tante" | v3_and_`x' == "tante" ///
| v3_and_`x' == "Tante van mijn echtegenote" | v3_and_`x' == "vader van mjn schoonzoon" | v3_and_`x' == "Zus van mijn ex-man." ///
| v3_and_`x' == "schoonoma"  | v3_and_`x' == "schoondochter van mijn tante" | v3_and_`x' == "Schoonbroer" | v3_and_`x' == "Oomzegger, dochter van mijn broer" ///
| v3_and_`x' == "Ex schoondochter" | v3_and_`x' == "mijn oma" | v3_and_`x' == "schoonzoon (vader van [Naam] en [Naam])" | v3_and_`x' == "Nicht" ///
| v3_and_`x' == "pleegzoon" | v3_and_`x' == "Kleinkind, kleinkind" | v3_and_`x' == "de oma van mijn vriend" | v3_and_`x' == "Kleinkind met adhd" ///
| v3_and_`x' == "Samenwonende vrouw van mijn neef" | v3_and_`x' == "Petekind" | v3_and_`x' == "Kleinkind" ///
| v3_and_`x' == "MD is schoonmoeder CB is Moeder" | v3_and_`x' == "Overgrootoma" | v3_and_`x' == "schoonvader van mijn broer" ///
| v3_and_`x' == "    Kleinzoon" | v3_and_`x' == "schoonzoon (vader van [Naam] en [Naam])"

*vriend, collega, kennis
replace v3_recode_`x'=10 if v3_and_`x' == "dochter van vriendin" | v3_and_`x' == "de man vaneenvriendin van mij" | v3_and_`x' == "kennis" | ///
v3_and_`x' == "Grootouders vriendin" | v3_and_`x' == "collega" | v3_and_`x' == "Een dochter van een kennis" | v3_and_`x' == "Bekende" | ///
 v3_and_`x' == "Een soort maatje" | v3_and_`x' == "iemand uit kerkgenootschap" | v3_and_`x' == "mijn ex bazin" | v3_and_`x' == "beste vriendin" ///
 | v3_and_`x' == "ze is de zus van mijn toenmalige vriend" | v3_and_`x' == "vriendin" | v3_and_`x' == "Vriendin" | v3_and_`x' == "Moeder van overleden vriend." ///
 | v3_and_`x' == "de moeder van een vriendin" | v3_and_`x' == "kennis van een kennis" | v3_and_`x' == "kerklid" | v3_and_`x' == "Kind van een contact" ///
 | v3_and_`x' == "kind van een vriendin" | v3_and_`x' == "Klasgenoot" | v3_and_`x' == "Mijn Beste Vriend." | v3_and_`x' == "moeder van bevriend echtpaar" ///
 | v3_and_`x' == "moeder van vriend" | v3_and_`x' == "oud collega en vriend"  ///
 | v3_and_`x' == "oude kennis/klant" | v3_and_`x' == "Vader van een vriend" | v3_and_`x' == "van partner naar vriend" ///
 | v3_and_`x' == "vriend is eengoede kennis,waar ik op vaste dag ga buurten.n" | v3_and_`x' == "vriendin van mijn vader" ///
 | v3_and_`x' == "Vriendin via de kerk" | v3_and_`x' == "Zoon van een vriendin" | v3_and_`x' == "Meer dan mijn beste vriend" ///
 | v3_and_`x' == "Vriendin van zoon" | v3_and_`x' == "vriend van vriend" | v3_and_`x' == "opa van mijn vriend" | ///
 v3_and_`x' == "kleine ondernemer van wie ik een handgeknoopt tapijt kocht" | v3_and_`x' == "kind vrienden" | v3_and_`x' == "kennis van mijn moeder" ///
 | v3_and_`x' == "ik ben haar buddy" | v3_and_`x' == "Dochter van een vriendin" | v3_and_`x' == "Ouder van mijn hartsvriendin" ///
 | v3_and_`x' == "kennissen van mijn ouders" | v3_and_`x' == "Dochter van mijn beste vriendin" | v3_and_`x' == "zoon van vriendin" ///
 | v3_and_`x' == "partner van [naam]" | v3_and_`x' == "Moeder van mijn hartsvriendin" | v3_and_`x' == "moeder van goede vriend" ///
 | v3_and_`x' == "Man van vriendin" | v3_and_`x' == "kind van vriendin" | v3_and_`x' == "Geen vriend meer." | v3_and_`x' == "dochter van vriendin" ///
 | v3_and_`x' == "Deelneemster aan theaterbezoek" | v3_and_`x' == "zus van vriendin" | v3_and_`x' == "kennis van een familielid, die stervende was"  ///
 | v3_and_`x' == "Deelneemster theaterbezoek" | v3_and_`x' == "collega van collega" | v3_and_`x' == "Vriendin van mijn rouw" ///
 | v3_and_`x' == "Schoolpleinmoeder"  | v3_and_`x' == "n bekende" | v3_and_`x' == "Buurman van een kennis" | v3_and_`x' == "Zus van buurvrouw" ///
 | v3_and_`x' == "Vroeger ooit bij haar opgepast" | v3_and_`x' == "ex boyfriend van mijn dochter" ///
 | v3_and_`x' == "moeder van mijn buurvrouw" | v3_and_`x' == "Ze is lid van de Kerkgenootschap waar ik werk" ///
 | v3_and_`x' == "meerdere ouderen mede-bejaarden" | v3_and_`x' == "Vroeger ooit bij haar opgepast" | v3_and_`x' == "geloofsgenoot" ///
 | v3_and_`x' == "Vrindin" | v3_and_`x' == "buddy" | v3_and_`x' == "oude oppas" | v3_and_`x' == "Vluchteling"
 

 *buurman of buurvrouw
replace v3_recode_`x'=11 if v3_and_`x' == "was mijn buurvrouw maar is nu verhuist." | v3_and_`x' == "Oudere vrouw uit de buurt" | v3_and_`x' == "Wijkgenoot" ///
| v3_and_`x' == "een oudere vrouw uit de buurt" | v3_and_`x' == "Dorpsgenoot" | v3_and_`x' == "huisgenoot"| v3_and_`x' == "Huisgenote" ///
| v3_and_`x' == "buurtbewoner" | v3_and_`x' == "voormalig buurvrouw" | v3_and_`x' == "dorpsgenoot (hulp in kader caritas" ///
| v3_and_`x' == "eerst buurvrouw nu vriendin" | v3_and_`x' == "bewoner van mijn postwijk"

* missmatch
replace v3_recode_`x'=13 if  v3_and_`x' == "op werk" | v3_and_`x' == "Stage" | ///
v3_and_`x' == "niemand, maar ik kon geen 0 invoeren bij vraag 1" | v3_and_`x' == "Zorgorganisatie voor mensen met beperking" ///
| v3_and_`x' == "bewoonster van psychiatrisch woonverblijf" | v3_and_`x' == "Nvt" |  v3_and_`x' == "oud client" | ///
v3_and_`x' == "niet van toepassing" | v3_and_`x' == "Begeleider" | v3_and_`x' == "nvt"  | v3_and_`x' == "schoonmaakhulp" /// 
| v3_and_`x' == "een bewoner" | v3_and_`x' == "ER was verder niemand" | v3_and_`x' == "Geen persoon" ///
| v3_and_`x' == "Werk in een verpleeghuis met ouderen"  | v3_and_`x' == "klant die bij ons in de zaak kwam."  ///
| v3_and_`x' == "Bewoner zorgcenr" | v3_and_`x' == "bewoner" | v3_and_`x' == "Bestond niet" | v3_and_`x' == "Bestaat niet" | v3_and_`x' == "achter nicht" ///
 | v3_and_`x' == "Invalide man in zorgwoning" | v3_and_`x' == "ik werkte bij [Naam] in de huishouding" ///
| v3_and_`x' == "hulp in de huishouding"  | v3_and_`x' == "geen bestaand persoon" ///
 | v3_and_`x' == "bestaat niet" | v3_and_`x' == "werkgever" | v3_and_`x' == "Oudere op mijn werk" ///
 | v3_and_`x' == "relatie uit vorige dienstbetrekking" ///
| v3_and_`x' == "Op mijn werk" | v3_and_`x' == "Een bewoonster van de meridiaan. Een thuis voor dementen bejaarden." ///
| v3_and_`x' == "ZIJ was een vriendin maar daar heb ik nooit voor gezorgt" | v3_and_`x' == "relatie uit vroegere werkzaamheid" ///
| v3_and_`x' == "relatie vloeit voort uit vroegere werkzaamheid" | v3_and_`x' == "relatie uit vorige dienstbetrekking"  ///
 | v3_and_`x' == "hulp is verleend in het kader van vrijwilligerswerk en dat telt niet mee. Kan ik niet aangeven." ///
| v3_and_`x' == "woonhuis op stage" | v3_and_`x' == "ik was de hulp van haar mantelzorg/dochter" ///
| v3_and_`x' == "eenmalige hulp vanwege overlijden ouders bij auto-ongeluk" | v3_and_`x' == "woonhuis op stage" ///
| v3_and_`x' == "huishoudelijke hulp en wmo hulpmiddelen" | v3_and_`x' == "Mantelzorg" | v3_and_`x' == "Ik begeleid mensen naar ziekenhuis of arts." ///
  | v3_and_`x' == "mentorcliente" | v3_and_`x' == "deelnemer van de Zonnebloem in onze afdeling" ///
| v3_and_`x' == "deelnemer aan 'project' Humanitas" | v3_and_`x' == "relatie uit vroeger vrijwilligerswerk" | v3_and_`x' == "Vrijwilligerswerk bij de meridiaan een thuis voor dementen bejaarden." ///
| v3_and_`x' == "Een bewoonster van de meridiaan. Een thuis voor dementen bejaarden." ///
| v3_and_`x' == "Vrijwillig werk" | v3_and_`x' == "Bewoner van verzorgingshuis" | v3_and_`x' == "Geen hulp.Ik ben zel 70+" ///
| v3_and_`x' == "Ik heb niemand geholpen" | v3_and_`x' == "Mijzelf er is niemand" | v3_and_`x' == "geen" ///
| v3_and_`x' == "heb niemand geholpen" | v3_and_`x' == "ik ben vrijwilliger van [Naam]" | v3_and_`x' == "ikzelf" ///
| v3_and_`x' == "niemand" | v3_and_`x' == "niemand zei ik toch?" | v3_and_`x' == "Client in verzorgingstehuis waar ik werkte" ///
| v3_and_`x' ==  "IK HEB NOOIT AANGEGEVEN  DAT IK IEMAND HIELP." | v3_and_`x' == "Ik stop hier mee het is voor mij niet relefvant" ///
| v3_and_`x' == "er was niemand maar moest minimaal 1 invullen, beetje apart dus!!!" ///
| v3_and_`x' == "ik help [Naam] met geld voor medecijnen in marokko" | v3_and_`x' == "ik kan geen 0 invullen. Daarom heb ik 1 ingevuld" ///
| v3_and_`x' == "er is niemand" | v3_and_`x' == "Bewoner verzorgingshuis"  ///
| v3_and_`x' == "Mijzelf"  | v3_and_`x' == "Een bewoner van de meridiaan. Een thuis voor dementen bejaarden."

*missing
replace v3_recode_`x'=14 if v3_and_`x' == "geen idee" | v3_and_`x' == "Ooa" | v3_and_`x' == "x" ///
 | v3_and_`x' == "Niets" | v3_and_`x' == "Gaat een ander niks aan!!!" ///
| v3_and_`x' == "geen enkele, passant" | v3_and_`x' == "XX" | v3_and_`x' == "weet ik niet meer"  | ///
v3_and_`x' == "Ik weet even niet meer wie A is" | v3_and_`x' == "GAAT je niks AAn" | v3_and_`x' == "vreemde" ///
| v3_and_`x' == "klusjes" | v3_and_`x' == "[Naam]"  | v3_and_`x' == "de naam is mij niet bekend." 
}
 
 
foreach x of num 1/7 {
gen var3_`x' = .
label variable var3_`x' "Wat is/was uw relatie tot ... ? "
foreach i of num 1/7 {
replace var3_`x' = v3_recode_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var3 1 "Partner" 2 "Ouder" 3 "Schoonouder" 4 "Stiefouder" ///
5 "Kind" 6 "Stiefkind" 7 "Broer of zus" 8 "Stiefbroer of stiefzus" 9 "Ander familielid" ///
10 "Vriend, kennis of collega" 11 "Buurman of buurvrouw (geen familie)" 12 "Anders" ///
13 "missing - mismatch" 14 "missing"
label values var3* var3 

*last parts by hand
foreach x of num 1/7 {
gen var3_and_`x' = ""
label variable var3_and_`x' "Wat is/was uw relatie tot ... ? "
foreach i of num 1/7 {
replace var3_and_`x' = v3_and_`i' if var_filled_`i' == beginep_y_`x' 
}     
}


*first 
encode var3_and_1 if var3_1 == 12, generate(var3_and_1_N)
numlabel, add		
tab var3_and_1_N var3_1
replace var3_1 = 9 if var3_and_1_N == 2
replace var3_1 = 13 if  var3_and_1_N == 1  | var3_and_1_N == 3 | var3_and_1_N == 4
replace var3_1 = 10 if var3_and_1_N == 5

*second
encode var3_and_2 if var3_2 == 12, generate(var3_and_2_N)
numlabel, add		
tab var3_and_2_N
replace var3_2 = 13 if var3_and_2_N == 1 
replace var3_2 = 10 if var3_and_2_N == 2 
replace var3_2 = 9 if var3_and_2_N == 3

*third
encode var3_and_3 if var3_3 == 12, generate(var3_and_3_N)
numlabel, add		
tab var3_and_3_N
replace var3_3 = 13 if  var3_and_3_N == 1 | var3_and_3_N == 3
replace var3_3 = 9  if  var3_and_3_N == 2 |  var3_and_3_N == 4 | var3_and_3_N == 5

*fourth
encode var3_and_4 if var3_4 == 12, generate(var3_and_4_N)
numlabel, add		
tab var3_and_4_N
replace var3_4 = 13 if  var3_and_4_N == 1 | var3_and_4_N == 2 
replace var3_4 = 9  if var3_and_4_N == 3

*fifth
encode var3_and_5 if var3_5 == 12, generate(var3_and_5_N)
numlabel, add		
tab var3_and_5_N

*sixth
encode var3_and_6 if var3_6 == 12, generate(var3_and_6_N)
numlabel, add		
tab var3_and_6_N
replace var3_6 = 13 if  var3_and_6_N == 1 | var3_and_6_N == 3
replace var3_6 = 9 if  var3_and_6_N == 2 
*seventh

encode var3_and_7 if var3_7 == 12, generate(var3_and_7_N)
numlabel, add		
tab var3_and_7_N
replace var3_7 = 10 if  var3_and_7_N == 1

*check
*keep if var3_2 == 12
*keep v3_and_2

tab v3_and_1 if var3_1 == 12
tab v3_and_2 if var3_2 == 12
tab v3_and_3 if var3_3 == 12
tab v3_and_4 if var3_4 == 12
tab v3_and_5 if var3_5 == 12
tab v3_and_6 if var3_6 == 12
tab v3_and_7 if var3_7 == 12, m

drop *_N


****************************************************************
*v5 - Is ... een man of een vrouw?
 
foreach x of num 1/7 {
gen var5_`x' = .
label variable var5_`x' "Is ... een man of een vrouw?"
foreach i of num 1/7 {
replace var5_`x' = v5_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}
label define var5 1 "Man" 2 "Vrouw" 
label values var5* var5

*********************************************************************
*reason end
 
 
foreach x of num 1/7 {
gen var8_`x' = .
foreach i of num 1/7 {
replace var8_`x' = v8_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}
label variable var8_1 "reason end first ep"
label variable var8_2 "reason end second ep"
label variable var8_3 "reason end third ep"
label variable var8_4 "reason end forth ep"
label variable var8_5 "reason end fifth ep"
label variable var8_6 "reason end sixth ep"
label variable var8_7 "reason end seventh ep"

*******************************************************************
*hours at the beginning of epsiode
*v9_v9_begin_1_1
 
 
foreach x of num 1/7 {
gen var9_begin_`x' = .
label variable var9_begin_`x' "Hoeveel uur per week besteedde u gemiddeld aan het geven van hulp...aan het begin"
foreach i of num 1/7 {
replace var9_begin_`x' = v9_v9_begin_`i'_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

*****************************************************************
*hours at the end of episode
 
 
foreach x of num 1/7 {
gen var9_end_`x' = .
label variable var9_end_`x' "Hoeveel uur per week besteedde u gemiddeld aan het geven van hulp...aan het end"
foreach i of num 1/7 {
replace var9_end_`x' = v9_v9_einde_`i'_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

****************************************************************
*Tasks at beginning

 
 
foreach x of num 1/7 {
gen var10_begin_a_`x' = .
label variable var10_begin_a_`x' "Taken verricht aan het begin van de periode - Gezelschap of emotionele ondersteu"
gen var10_begin_b_`x' = .
label variable var10_begin_b_`x' "Taken verricht aan het begin van de periode - Vervoer"
gen var10_begin_c_`x' = .
label variable var10_begin_c_`x' "Taken verricht aan het begin van de periode - Begeleiding bij bezoek aan artsr"
gen var10_begin_d_`x' = .
label variable var10_begin_d_`x' "Taken verricht aan het begin van de periode - Administratieve hulp"
gen var10_begin_e_`x' = .
label variable var10_begin_e_`x' "Taken verricht aan het begin van de periode - Hulp bij het huishouden"
gen var10_begin_f_`x' = .
label variable var10_begin_f_`x' "Taken verricht aan het begin van de periode - Persoonlijke verzorging"
gen var10_begin_g_`x' = .
label variable var10_begin_g_`x' "Taken verricht aan het begin van de periode - Verpleegkundige hulp"
gen var10_begin_h_`x' = .
label variable var10_begin_h_`x' "Taken verricht aan het begin van de periode - Regelen of co�rdineren van zorg"
gen var10_begin_i_`x' = .
label variable var10_begin_i_`x' "Taken verricht aan het begin van de periode - Andere hulp"


foreach i of num 1/7 {
replace var10_begin_a_`x' = v10_v10_begin_`i'__1_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_begin_b_`x' = v10_v10_begin_`i'__2_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_begin_c_`x' = v10_v10_begin_`i'__3_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_begin_d_`x' = v10_v10_begin_`i'__4_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_begin_e_`x' = v10_v10_begin_`i'__5_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_begin_f_`x' = v10_v10_begin_`i'__6_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_begin_g_`x' = v10_v10_begin_`i'__7_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_begin_h_`x' = v10_v10_begin_`i'__8_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_begin_i_`x' = v10_v10_begin_`i'__9_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

****************************************************************
*Tasks at end
 
 
foreach x of num 1/7 {
gen var10_end_a_`x' = .
label variable var10_end_a_`x' "Taken verricht aan het begin van de periode - Gezelschap of emotionele ondersteu"
gen var10_end_b_`x' = .
label variable var10_end_b_`x' "Taken verricht aan het begin van de periode - Vervoer"
gen var10_end_c_`x' = .
label variable var10_end_c_`x' "Taken verricht aan het begin van de periode - Begeleiding bij bezoek aan artsr"
gen var10_end_d_`x' = .
label variable var10_end_d_`x' "Taken verricht aan het begin van de periode - Administratieve hulp"
gen var10_end_e_`x' = .
label variable var10_end_e_`x' "Taken verricht aan het begin van de periode - Hulp bij het huishouden"
gen var10_end_f_`x' = .
label variable var10_end_f_`x' "Taken verricht aan het begin van de periode - Persoonlijke verzorging"
gen var10_end_g_`x' = .
label variable var10_end_g_`x' "Taken verricht aan het begin van de periode - Verpleegkundige hulp"
gen var10_end_h_`x' = .
label variable var10_end_h_`x' "Taken verricht aan het begin van de periode - Regelen of co�rdineren van zorg"
gen var10_end_i_`x' = .
label variable var10_end_i_`x' "Taken verricht aan het begin van de periode - Andere hulp"

foreach i of num 1/7 {
replace var10_end_a_`x' = v10_v10_einde_`i'__1_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_end_b_`x' = v10_v10_einde_`i'__2_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_end_c_`x' = v10_v10_einde_`i'__3_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_end_d_`x' = v10_v10_einde_`i'__4_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_end_e_`x' = v10_v10_einde_`i'__5_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_end_f_`x' = v10_v10_einde_`i'__6_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_end_g_`x' = v10_v10_einde_`i'__7_`i' if var_filled_`i' == beginep_y_`x'  
replace var10_end_h_`x' = v10_v10_einde_`i'__8_`i' if var_filled_`i' == beginep_y_`x' 
replace var10_end_i_`x' = v10_v10_einde_`i'__9_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var10 0 "Nee" 1 "Ja" 
label values var10* var10 

****************************************************************
*other help at the beginning: v11_v11_begin_1__1_1 till v11_v11_begin_1__6_1
 
 
foreach x of num 1/7 {
gen var11_begin_a_`x' = .
label variable var11_begin_a_`x' "Hulp van anderen aan het begin van de periode - Een of meer andere mantelzorger"
gen var11_begin_b_`x' = .
label variable var11_begin_b_`x' "Hulp van anderen aan het begin van de periode - Een of meer vrijwilligers"
gen var11_begin_c_`x' = .
label variable var11_begin_c_`x' "Hulp van anderen aan het begin van de periode - De thuiszorg of wijkverpleging"
gen var11_begin_d_`x' = .
label variable var11_begin_d_`x' "Hulp van anderen aan het begin van de periode - Een particuliere hulp of werkste"
gen var11_begin_e_`x' = .
label variable var11_begin_e_`x' "Hulp van anderen aan het begin van de periode - Verplegend personeel in zorginst"
gen var11_begin_f_`x' = .
label variable var11_begin_f_`x' "Hulp van anderen aan het begin van de periode - Niemand anders dan van mij"


foreach i of num 1/7 {
replace var11_begin_a_`x' = v11_v11_begin_`i'__1_`i' if var_filled_`i' == beginep_y_`x' 
replace var11_begin_b_`x' = v11_v11_begin_`i'__2_`i' if var_filled_`i' == beginep_y_`x' 
replace var11_begin_c_`x' = v11_v11_begin_`i'__3_`i' if var_filled_`i' == beginep_y_`x' 
replace var11_begin_d_`x' = v11_v11_begin_`i'__4_`i' if var_filled_`i' == beginep_y_`x' 
replace var11_begin_e_`x' = v11_v11_begin_`i'__5_`i' if var_filled_`i' == beginep_y_`x' 
replace var11_begin_f_`x' = v11_v11_begin_`i'__6_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

****************************************************************
*other help at the end

 
 
foreach x of num 1/7 {
gen var11_end_a_`x' = .
label variable var11_end_a_`x' "Hulp van anderen aan het einde van de periode - Een of meer andere mantelzorger("
gen var11_end_b_`x' = .
label variable var11_end_b_`x' "Hulp van anderen aan het einde van de periode - Een of meer vrijwilligers"
gen var11_end_c_`x' = .
label variable var11_end_c_`x' "Hulp van anderen aan het einde van de periode - De thuiszorg of wijkverpleging"
gen var11_end_d_`x' = .
label variable var11_end_d_`x' "Hulp van anderen aan het einde van de periode - Een particuliere hulp of werkste"
gen var11_end_e_`x' = .
label variable var11_end_e_`x' "Hulp van anderen aan het einde van de periode - Verplegend personeel in zorginst"
gen var11_end_f_`x' = .
label variable var11_end_f_`x' "Hulp van anderen aan het einde van de periode - Niemand anders dan van mij"


foreach i of num 1/7 {
replace var11_end_a_`x' = v11_v11_einde_`i'__1_`i' if var_filled_`i' == beginep_y_`x' 
replace var11_end_b_`x' = v11_v11_einde_`i'__2_`i' if var_filled_`i' == beginep_y_`x' 
replace var11_end_c_`x' = v11_v11_einde_`i'__3_`i' if var_filled_`i' == beginep_y_`x' 
replace var11_end_d_`x' = v11_v11_einde_`i'__4_`i' if var_filled_`i' == beginep_y_`x' 
replace var11_end_e_`x' = v11_v11_einde_`i'__5_`i' if var_filled_`i' == beginep_y_`x' 
replace var11_end_f_`x' = v11_v11_einde_`i'__6_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var11 0 "Nee" 1 "Ja" 
label values var11* var11

****************************************************************
*v12_v12_begin_1_1
 
 
foreach x of num 1/7 {
gen var12_begin_`x' = .
label variable var12_begin_`x' "Waar woonde...op het begin van de periode waarin u hulp gaf"
foreach i of num 1/7 {
replace var12_begin_`x' = v12_v12_begin_`i'_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}


*****************************************************************
*v12_v12_einde_1_1
 
 
foreach x of num 1/7 {
gen var12_end_`x' = .
label variable var12_end_`x' "Waar woonde...op het einde van de periode waarin u hulp gaf"
foreach i of num 1/7 {
replace var12_end_`x' = v12_v12_einde_`i'_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var12 1 "In hetzelfde huis als ik" 2 "In een zelfstandig huishouden, met a" ///
3 "In een zelfstandig huishouden, zonde" 4 "In een zorginstelling"
label values var12* var12

****************************************************************
*v13_v13_begin_1_1
 
 
foreach x of num 1/7 {
gen var13_begin_`x' = .
label variable var13_begin_`x' "Op het begin: problemen met geheugen, aandacht en denken"
foreach i of num 1/7 {
replace var13_begin_`x' = v13_v13_begin_`i'_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}



*****************************************************************
*v13_v13_einde_1_1
 
 
foreach x of num 1/7 {
gen var13_end_`x' = .
label variable var13_end_`x' "Op het einde: problemen met geheugen, aandacht en denken"
foreach i of num 1/7 {
replace var13_end_`x' = v13_v13_einde_`i'_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var13 1 "Geen problemen met geheugen, aandach" 2 "Een beetje problemen met geheugen, a" ///
3 "Ernstige problemen met geheugen, aan"
label values var13* var13


****************************************************************
*v14_v14_begin_1_1
 
 
foreach x of num 1/7 {
gen var14_begin_`x' = .
label variable var14_begin_`x' "Op het begin: last van psychische problemen, zoals een depressie o"
foreach i of num 1/7 {
replace var14_begin_`x' = v14_v14_begin_`i'_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}



*****************************************************************
*v14_v14_einde_1_1
 
 
foreach x of num 1/7 {
gen var14_end_`x' = .
label variable var14_end_`x' "Op het einde: last van psychische problemen, zoals een depressie o"
foreach i of num 1/7 {
replace var14_end_`x' = v14_v14_einde_`i'_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var14 1 "Geen psychische problemen" 2 "Een beetje psychische problemen" ///
3 "Ernstige psychische problemen"
label values var14* var14_end

****************************************************************
*v15_begin - Tasks that care reciepient was not able - begin v15_begin
 
 
foreach x of num 1/7 {
gen var15_begin_a_`x' = .
label variable var15_begin_a_`x' "Taken niet zelfstandig: Lopen"
gen var15_begin_b_`x' = .
label variable var15_begin_b_`x' "Taken niet zelfstandig: Aankleden"
gen var15_begin_c_`x' = .
label variable var15_begin_c_`x' "Taken niet zelfstandig: Eten"
gen var15_begin_d_`x' = .
label variable var15_begin_d_`x' "Taken niet zelfstandig: Huishoudelijk werk"
gen var15_begin_e_`x' = .
label variable var15_begin_e_`x' "Taken niet zelfstandig: Boodschappen doen"
gen var15_begin_f_`x' = .
label variable var15_begin_f_`x' "Taken niet zelfstandig: Een maaltijd bereiden"
gen var15_begin_g_`x' = .
label variable var15_begin_g_`x' "Taken niet zelfstandig: Geen problemen met deze activiteiten"


foreach i of num 1/7 {
replace var15_begin_a_`x' = v15_v15_begin_`i'__1_`i' if var_filled_`i' == beginep_y_`x' 
replace var15_begin_b_`x' = v15_v15_begin_`i'__2_`i' if var_filled_`i' == beginep_y_`x' 
replace var15_begin_c_`x' = v15_v15_begin_`i'__3_`i' if var_filled_`i' == beginep_y_`x' 
replace var15_begin_d_`x' = v15_v15_begin_`i'__4_`i' if var_filled_`i' == beginep_y_`x' 
replace var15_begin_e_`x' = v15_v15_begin_`i'__5_`i' if var_filled_`i' == beginep_y_`x' 
replace var15_begin_f_`x' = v15_v15_begin_`i'__6_`i' if var_filled_`i' == beginep_y_`x' 
replace var15_begin_g_`x' = v15_v15_begin_`i'__7_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

****************************************************************
*v15_einde Tasks that care reciepient was not able - end v15_einde
 
 
foreach x of num 1/7 {
gen var15_end_a_`x' = .
label variable var15_end_a_`x' "Taken niet zelfstandig: Lopen"
gen var15_end_b_`x' = .
label variable var15_end_b_`x' "Taken niet zelfstandig: Aankleden"
gen var15_end_c_`x' = .
label variable var15_end_c_`x' "Taken niet zelfstandig: Eten"
gen var15_end_d_`x' = .
label variable var15_end_d_`x' "Taken niet zelfstandig: Huishoudelijk werk"
gen var15_end_e_`x' = .
label variable var15_end_e_`x' "Taken niet zelfstandig: Boodschappen doen"
gen var15_end_f_`x' = .
label variable var15_end_f_`x' "Taken niet zelfstandig: Een maaltijd bereiden"
gen var15_end_g_`x' = .
label variable var15_end_g_`x' "Taken niet zelfstandig: Geen problemen met deze activiteiten"


foreach i of num 1/7 {
replace var15_end_a_`x' = v15_v15_einde_`i'__1_`i' if var_filled_`i' == beginep_y_`x' 
replace var15_end_b_`x' = v15_v15_einde_`i'__2_`i' if var_filled_`i' == beginep_y_`x' 
replace var15_end_c_`x' = v15_v15_einde_`i'__3_`i' if var_filled_`i' == beginep_y_`x' 
replace var15_end_d_`x' = v15_v15_einde_`i'__4_`i' if var_filled_`i' == beginep_y_`x' 
replace var15_end_e_`x' = v15_v15_einde_`i'__5_`i' if var_filled_`i' == beginep_y_`x' 
replace var15_end_f_`x' = v15_v15_einde_`i'__6_`i' if var_filled_`i' == beginep_y_`x' 
replace var15_end_g_`x' = v15_v15_einde_`i'__7_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var15 0 "Nee" 1 "Ja" 
label values var15* var15

****************************************************************
*v16
 
 
foreach x of num 1/7 {
gen var16_`x' = .
label variable var16_`x' "Hoe oud is / if was ... (an het einde of nu)"
foreach i of num 1/7 {
replace var16_`x' = v16_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

****************************************************************
*v17 
 
foreach x of num 1/7 {
gen var17_a_`x' = .
label variable var17_a_`x' "problemen om mijn dagelijkse activiteiten te combineren met mijn zorgtaken"
gen var17_b_`x' = .
label variable var17_b_`x' "Zorgen voor geeft/gaf mij een goed gevoel"
gen var17_c_`x' = .
label variable var17_c_`x' "De omgang vind/vond ik moeilijk"
gen var17_d_`x' = .
label variable var17_d_`x' "Het contact met vrienden en kennissen is minder geworden door het geven van hulp"
gen var17_e_`x' = .
label variable var17_e_`x' "Door het zorgen leer/leerde ik nieuwe dingen."
gen var17_f_`x' = .
label variable var17_f_`x' "Ik vind/vond het geven van hulp aan ... zwaar"
gen var17_g_`x' = .
label variable var17_g_`x' "... en ik zijn dichter bij elkaar gekomen"
gen var17_h_`x' = .
label variable var17_h_`x' "Mijn eigen keuzes in mijn leven zijn beperkt door de hulpbehoevendheid van..."
gen var17_i_`x' = .
label variable var17_i_`x' "Mijn sociale omgeving waardeert/waardeerde mij om het feit dat ik ... help/hielp."
gen var17_j_`x' = .
label variable var17_j_`x' "Ik ervaar eenzaamheid/heb eenzaamheid ervaren als gevolg van mijn zorgtaak."
gen var17_k_`x' = .
label variable var17_k_`x' "Mijn sociale omgeving helpt/hielp mij door taken, anders dan de hulp aan ..., van me over te nemen"
gen var17_l_`x' = .
label variable var17_l_`x' "Mijn relatie (met mijn (toenmalige) partner/met ...) heeft te lijden/geleden onder het geven van hulp aan"
gen var17_n_`x' = .
label variable var17_n_`x' "Ik ervaar/heb de zorg voor ... als een verplichting (ervaren)"

foreach i of num 1/7 {
replace var17_a_`x' = v17_1_`i' if var_filled_`i' == beginep_y_`x' 
replace var17_b_`x' = v17_2_`i' if var_filled_`i' == beginep_y_`x' 
replace var17_c_`x' = v17_3_`i' if var_filled_`i' == beginep_y_`x' 
replace var17_d_`x' = v17_4_`i' if var_filled_`i' == beginep_y_`x' 
replace var17_e_`x' = v17_5_`i' if var_filled_`i' == beginep_y_`x' 
replace var17_f_`x' = v17_6_`i' if var_filled_`i' == beginep_y_`x' 
replace var17_g_`x' = v17_7_`i' if var_filled_`i' == beginep_y_`x'  
replace var17_h_`x' = v17_8_`i' if var_filled_`i' == beginep_y_`x' 
replace var17_i_`x' = v17_9_`i' if var_filled_`i' == beginep_y_`x' 
replace var17_j_`x' = v17_10_`i' if var_filled_`i' == beginep_y_`x' 
replace var17_k_`x' = v17_11_`i' if var_filled_`i' == beginep_y_`x' 
replace var17_l_`x' = v17_12_`i' if var_filled_`i' == beginep_y_`x' 
replace var17_n_`x' = v17_13_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var17 1 "Helemaal oneens" 2 "Oneens" 3 "Niet eens, niet oneens" 4 "Eens" 5 "Helemaal eens" 6 "Weet niet"
label values var17* var17

****************************************************************
*v18
 
 
foreach x of num 1/7 {
gen var18_a_`x' = .
label variable var18_a_`x' "Ik vind/vond dat het zo hoort."
gen var18_b_`x' = .
label variable var18_b_`x' "Er is/was niemand anders beschikbaar. "
gen var18_c_`x' = .
label variable var18_c_`x' "Ik vind/vond het fijn om voor iemand te zorgen."
gen var18_d_`x' = .
label variable var18_d_`x' "Het wordt/werd van mij verwacht."


foreach i of num 1/7 {
replace var18_a_`x' = v18_1_`i' if var_filled_`i' == beginep_y_`x' 
replace var18_b_`x' = v18_2_`i' if var_filled_`i' == beginep_y_`x' 
replace var18_c_`x' = v18_3_`i' if var_filled_`i' == beginep_y_`x' 
replace var18_d_`x' = v18_4_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var18 1 "Niet" 2 "Een beetje" 3 "Sterk" 4 "Weet niet" 
label values var18* var18

****************************************************************
*var19

foreach x of num 1/7 {
gen var19_`x' = .
label variable var19_`x' "Hebt u betaald werk gehad sinds u hulp geeft / tijdens de periode dat u hulp gaf aan persoon ?"
foreach i of num 1/7 {
replace var19_`x' = v19_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var19 1 "Ja, en dat heb ik nog steeds" 2 "Ja, maar nu niet meer" 3 "Nee"
label values var19* var19

tab var19_1


*var19_b/v9_2
tab v19_2_1

foreach x of num 1/7 {
gen var19_b_`x' = .
label variable var19_b_`x' "Hebt u betaald werk gehad sinds u hulp geeft / tijdens de periode dat u hulp gaf aan persoon ?"
foreach i of num 1/7 {
replace var19_b_`x' = v19_2_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var19_b 1 "Ja" 2 "Nee"
label values var19_b* var19_b

tab var19_b_1


***************************************************************
*var20
foreach x of num 1/7 {
gen var20_a_`x' = .
label variable var20_a_`x' "minder uren gaan werken?"
gen var20_b_`x' = .
label variable var20_b_`x' "gestopt met werken?"
gen var20_c_`x' = .
label variable var20_c_`x' "ander werk gaan doen?"
gen var20_d_`x' = .
label variable var20_d_`x' "als zelfstandige gaan werken?"
gen var20_e_`x' = .
label variable var20_e_`x' " gestopt met een opleiding?"

foreach i of num 1/7 {
replace var20_a_`x' = v20_1_`i' if var_filled_`i' == beginep_y_`x' 
replace var20_b_`x' = v20_2_`i' if var_filled_`i' == beginep_y_`x' 
replace var20_c_`x' = v20_3_`i' if var_filled_`i' == beginep_y_`x' 
replace var20_d_`x' = v20_4_`i' if var_filled_`i' == beginep_y_`x' 
replace var20_e_`x' = v20_5_`i' if var_filled_`i' == beginep_y_`x'      
}
}


label define var20 1 "Nee, geen verandering" 2 "Ja, maar niet omdat ik hulp gaf" 3 "Ja, tijdelijk" 4 "Ja, en dat is nog steeds zo"
label values var20* var20

***************************************************************
*var21 
tab v21_1_1

foreach x of num 1/7 {
gen var21_a_`x' = .
label variable var21_a_`x' "een promotie of een opdracht misgelopen?"
gen var21_b_`x' = .
label variable var21_b_`x' "ontzien in uw taken zonder dat u dat wilde?"


foreach i of num 1/7 {
replace var21_a_`x' = v21_1_`i' if var_filled_`i' == beginep_y_`x' 
replace var21_b_`x' = v21_2_`i' if var_filled_`i' == beginep_y_`x' 
  
}
}

label define var21 1 "Nee, dat heb ik niet ervaren" 2 "Ja, maar niet omdat ik hulp gaf" 3 "Ja, dat vermoeden heb ik" ///
4 "Ja, dat weet ik zeker" 5 "Weet niet" 6 "Niet van toepassing" 
label values var21* var21


****************************************************************
*var22
foreach x of num 1/7 {
gen var22_a_`x' = .
label variable var22_a_`x' "het combineren van werk en hulp verlenen aan persoon ... stressvol"
gen var22_b_`x' = .
label variable var22_b_`x' "Door persoon te helpen heb ik vaardigheden geleerd die me beter maken / maakten in mijn werk."
gen var22_c_`x' = .
label variable var22_c_`x' "Ik vind/vond het een verademing dat mijn werk afleiding  biedt /bood voor het helpen van persoon ..."
gen var22_d_`x' = .
label variable var22_d_`x' "Ik voel/voelde me vaak tekortschieten als werknemer doordatik ook hulp  verleen/verleende aan persoon..."


foreach i of num 1/7 {
replace var22_a_`x' = v22_1_`i' if var_filled_`i' == beginep_y_`x' 
replace var22_b_`x' = v22_2_`i' if var_filled_`i' == beginep_y_`x' 
replace var22_c_`x' = v22_3_`i' if var_filled_`i' == beginep_y_`x' 
replace var22_d_`x' = v22_4_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var22 1 "Helemaal oneens" 2 "Oneens" 3 "Niet eens, niet oneens" 4 "Eens" 5 "Helemaal eens" 6 "Weet niet"
label values var22* var22

***************************************************************
*var23
foreach x of num 1/7 {
gen var23_`x' = .
label variable var23_`x' "Krijgt/Kreeg u begrip van uw LEIDINGGEVENDE als het om het geven van hulp aan persoon ... gaat?"
foreach i of num 1/7 {
replace var23_`x' = v23_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var23 1 "Veel begrip" 2 " Een beetje begrip" 3 "Geen begrip" 4 "Mijn leidinggevende weet/wist niet dat ik hulp  geef/gaf" ///
5 "Ik heb/had geen leidinggevende."
label values var23* var23



***************************************************************
*var24

foreach x of num 1/7 {
gen var24_`x' = .
label variable var24_`x' "Krijgt/Kreeg u begrip van uw DIRECTE COLLEGA'S als het om het geven van hulp aan persoon ... gaat?"
foreach i of num 1/7 {
replace var24_`x' = v24_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var24 1 "Veel begrip" 2 " Een beetje begrip" 3 "Geen begrip" 4 "Mijn leidinggevende weet/wist niet dat ik hulp  geef/gaf" ///
5 "Ik heb/had geen leidinggevende."
label values var24* var24


***************************************************************
*var25

foreach x of num 1/7 {
gen var25_`x' = .
label variable var25_`x' "In hoeverre kan/kon u uw werk flexibel inrichten om zo de hulp aan persoon ... met uw werk te combineren"
foreach i of num 1/7 {
replace var25_`x' = v25_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var25 1 "Veel flexibiliteit" 2 "Een beetje flexibiliteit" 3 "Geen flexibiliteit" 
label values var25* var25

****************************************************************
*v26
 
 
foreach x of num 1/7 {
gen var26_a_`x' = .
label variable var26_a_`x' "Ondersteuning: Financiële ondersteuning "
gen var26_b_`x' = .
label variable var26_b_`x' "Ondersteuning: oorzieningen waarbij uw hulp aan ... tijdelijk wordt/werd overgenomen"
gen var26_c_`x' = .
label variable var26_c_`x' "Ondersteuning: Mentale ondersteuning"

foreach i of num 1/7 {
replace var26_a_`x' = v26_1_`i' if var_filled_`i' == beginep_y_`x' 
replace var26_b_`x' = v26_2_`i' if var_filled_`i' == beginep_y_`x' 
replace var26_c_`x' = v26_3_`i' if var_filled_`i' == beginep_y_`x' 
     
}
}

label define var26 1 "Nooit" 2 "Soms" 3 "Vaak"
label values var26* var26


****************************************************************
*reshape to long if wanted: not that reshaping only should be done with all variable in cronological order of spells/episodos or how they where entered
keep nomem_encr maandnr v1_aantal oplcat oplmet oplzon nettohh_f brutohh_f nettocat brutocat nettoink_f netinc ///
nettoink brutoink_f brutoink belbezig sted woning woonvorm burgstat partner aantalki aantalhh lftdhhh lftdcat leeftijd ///
gebjaar positie geslacht nohouse_encr duur TijdE TijdB DatumE DatumB beginep* endep* var*  



*****************************************************************
*save wide data

save "Mantelzorg_wide.dta", replace

use "Mantelzorg_wide.dta", replace


*****************************************************************
*reshape
*put all the needed future in a local macro
unab mylist: *_1

*cut out the "_1" at the end to obtain the actual stubs
foreach v of local mylist {
	local stubs `"`stubs' `=substr("`v'",1,length("`v'")-2)'"' 
} 

*reshape 
reshape long `stubs', i(nomem_encr) j(spell) string


*************************************************************
*dropping empty spells/episodos
drop if beginep == . & endep == . & var8 == . & var9_begin ==. & var9_end == .



*************************************************************
*get label values again
forval i = 2/3 {
label values var`i' var`i'
}
label values var5 var5
forval i = 10/15 {
label values var`i'* var`i'
}
forval i = 17/26 {
label values var`i'* var`i'
}
label values var19_b* var19_b
*label values var26* var26

*************************************************************
*label again

label variable beginep "begin epsiode"
label variable endep "end epsiode"


label variable var2 "Helpt u ... op dit moment nog steeds?"
label variable var3 "Wat is/was uw relatie tot ... ? "
label variable var3_and "Relatie anders, namelijk"
label variable var5 "Is ... een man of een vrouw?"	
label variable var8 "reason end of episode"
label variable var9_begin "uur per week aan het begin"
label variable var9_end  "uur per week aan het end"
label variable var10_begin_a "Taken aan het begin - Gezelschap of emotionele onderst"
label variable var10_begin_b "Taken aan het begin - Vervoer"
label variable var10_begin_c "Taken aan het begin - Begeleiding bij bezoek aan artsr"
label variable var10_begin_d "Taken aan het begin - Administratieve hulp"
label variable var10_begin_e "Taken aan het begin - Hulp bij het huishouden"
label variable var10_begin_f "Taken aan het begin - Persoonlijke verzorging"
label variable var10_begin_g "Taken aan het begin - Verpleegkundige hulp"
label variable var10_begin_h "Taken aan het begin - Regelen of coordineren van zorg"
label variable var10_begin_i "Taken aan het begin - Andere hulp"
label variable var10_end_a "Taken aan het einde - Gezelschap of emotionele onderst"
label variable var10_end_b "Taken aan het einde - Vervoer"
label variable var10_end_c "Taken aan het einde - Begeleiding bij bezoek aan artsr"
label variable var10_end_d "Taken aan het einde - Administratieve hulp"
label variable var10_end_e "Taken aan het einde - Hulp bij het huishouden"
label variable var10_end_f "Taken aan het einde - Persoonlijke verzorging"
label variable var10_end_g "Taken aan het einde - Verpleegkundige hulp"
label variable var10_end_h "Taken aan het einde - Regelen of coordineren van zorg"
label variable var10_end_i "Taken aan het einde - Andere hulp"
label variable var11_begin_a "Hulp van anderen aan het begin - Een of meer andere mantelzorger"
label variable var11_begin_b "Hulp van anderen aan het begin - Een of meer vrijwilligers"
label variable var11_begin_c "Hulp van anderen aan het begin - De thuiszorg of wijkverpleging"
label variable var11_begin_d "Hulp van anderen aan het begin - Een particuliere hulp of werkste"
label variable var11_begin_e "Hulp van anderen aan het begin - Verplegend personeel in zorginst"
label variable var11_begin_f "Hulp van anderen aan het begin - Niemand anders dan van mij"
label variable var11_end_a "Hulp van anderen aan het einde - Een of meer andere mantelzorger"
label variable var11_end_b "Hulp van anderen aan het einde - Een of meer vrijwilligers"
label variable var11_end_c "Hulp van anderen aan het einde - De thuiszorg of wijkverpleging"
label variable var11_end_d "Hulp van anderen aan het einde - Een particuliere hulp of werkste"
label variable var11_end_e "Hulp van anderen aan het einde - Verplegend personeel in zorginst"
label variable var11_end_f "Hulp van anderen aan het einde - Niemand anders dan van mij"
label variable var12_begin "Waar woonde...op het begin van de periode waarin u hulp gaf" 
label variable var12_end "Waar woonde...op het einde van de periode waarin u hulp gaf"
label variable var13_begin "Op het begin: problemen met geheugen, aandacht en denken"
label variable var13_end "Op het einde: problemen met geheugen, aandacht en denken"
label variable var14_begin "Op het begin: last van psychische problemen, zoals een depressie o"
label variable var14_end "Op het einde: last van psychische problemen, zoals een depressie o"
label variable var15_begin_a "Begin - Taken niet zelfstandig: Lopen"
label variable var15_begin_b "Begin -Taken niet zelfstandig: Aankleden"
label variable var15_begin_c "Begin -Taken niet zelfstandig: Eten"
label variable var15_begin_d "Begin -Taken niet zelfstandig: Huishoudelijk werk"
label variable var15_begin_e "Begin -Taken niet zelfstandig: Boodschappen doen"
label variable var15_begin_f "Begin -Taken niet zelfstandig: Een maaltijd bereiden"
label variable var15_begin_g "Begin -Taken niet zelfstandig: Geen problemen met deze activiteiten"
label variable var15_end_a "Einde - Taken niet zelfstandig: Lopen"
label variable var15_end_b "Einde - Taken niet zelfstandig: Aankleden"
label variable var15_end_c "Einde - Taken niet zelfstandig: Eten"
label variable var15_end_d "Einde - Taken niet zelfstandig: Huishoudelijk werk"
label variable var15_end_e "Einde - Taken niet zelfstandig: Boodschappen doen"
label variable var15_end_f "Einde - Taken niet zelfstandig: Een maaltijd bereiden"
label variable var15_end_g "Einde - Taken niet zelfstandig: Geen problemen met deze activiteiten"
label variable var16 "Hoe oud is / if was ... (an het einde of nu)"
label variable var17_a "problemen om mijn dagelijkse activiteiten te combineren met mijn zorgtaken"
label variable var17_b "Zorgen voor geeft/gaf mij een goed gevoel"
label variable var17_c "De omgang vind/vond ik moeilijk"
label variable var17_d "Het contact met vrienden en kennissen is minder geworden door het geven van hulp"
label variable var17_e "Door het zorgen leer/leerde ik nieuwe dingen."
label variable var17_f "Ik vind/vond het geven van hulp aan ... zwaar"
label variable var17_g "... en ik zijn dichter bij elkaar gekomen"
label variable var17_h "Mijn eigen keuzes in mijn leven zijn beperkt door de hulpbehoevendheid van..."
label variable var17_i "Mijn sociale omgeving waardeert/waardeerde mij om het feit dat ik ... help/hielp."
label variable var17_j "Ik ervaar eenzaamheid/heb eenzaamheid ervaren als gevolg van mijn zorgtaak."
label variable var17_k "Mijn sociale omgeving helpt/hielp mij door taken, anders dan de hulp aan ..., van me over te nemen"
label variable var17_l "Mijn relatie (met mijn (toenmalige) partner/met ...) heeft te lijden/geleden onder het geven van hulp aan"
label variable var17_n "Ik ervaar/heb de zorg voor ... als een verplichting (ervaren)"
label variable var18_a "Ik vind/vond dat het zo hoort."
label variable var18_b "Er is/was niemand anders beschikbaar. "
label variable var18_c "Ik vind/vond het fijn om voor iemand te zorgen."
label variable var18_d "Het wordt/werd van mij verwacht."
label variable var19 "Hebt u betaald werk gehad sinds u hulp geeft/tijdens de periode dat u hulp gaf aan persoon ?"
label variable var19_b "Hebt u betaald werk gehad sinds u hulp geeft/tijdens de periode dat u hulp gaf aan persoon?"
label variable var20_a "minder uren gaan werken?"
label variable var20_b "gestopt met werken?"
label variable var20_c "ander werk gaan doen?"
label variable var20_d "als zelfstandige gaan werken?"
label variable var20_e " gestopt met een opleiding?"
label variable var21_a "een promotie of een opdracht misgelopen?"
label variable var21_b "ontzien in uw taken zonder dat u dat wilde?"
label variable var22_a "het combineren van werk en hulp verlenen aan persoon ... stressvol"
label variable var22_b "Door persoon te helpen heb ik vaardigheden geleerd die me beter maken / maakten in mijn werk."
label variable var22_c "Ik vind/vond het een verademing dat mijn werk afleiding  biedt /bood voor het helpen van persoon ..."
label variable var22_d "Ik voel/voelde me vaak tekortschieten als werknemer doordatik ook hulp  verleen/verleende aan persoon..."
label variable var23 "Krijgt/Kreeg u begrip van uw LEIDINGGEVENDE als het om het geven van hulp aan persoon ... gaat?"
label variable var24 "Krijgt/Kreeg u begrip van uw DIRECTE COLLEGA'S als het om het geven van hulp aan persoon ... gaat?"
label variable var25 "In hoeverre kan/kon u uw werk flexibel inrichten om zo de hulp aan persoon ... met uw werk te combineren"
label variable var26_a "Ondersteuning: Financiële ondersteuning "
label variable var26_b "Ondersteuning: oorzieningen waarbij uw hulp aan ... tijdelijk wordt/werd overgenomen"
label variable var26_c "Ondersteuning: Mentale ondersteuning"




****************************************************************
*include episode
sort nomem_encr spell
bysort nomem_encr: gen episode = _n //episode number updated after deleting

*
save "Mantelzorg_raw_long_without_covid19.dta", replace
*******************************************************************************
*
* PART 2: Matching to receive the main outcome: the wage difference  
*
********************************************************************************

clear
set more off
clear matrix
clear mata

capture log close

set seed 21091994

cd ""  // adapt to your environment

*********************************************
*look at screening data
*********************************************
*screening data
use "Mantelzorg_wide.dta", clear 
numlabel, add


*merge all necessary data for imputation
merge 1:1 nomem_encr using "L_ScreeningMantelzorg_1p.dta" // screening data - https://www.dataarchive.lissdata.nl/study_units/view/1287 (ask Klara Raiber for original screening data we received)
drop _merge
merge 1:1 nomem_encr using "pension_year.dta" // to receive this data set run the following syntax:
/*
clear 
set more off

capture log close

*working director
cd ""


******************************************************************************
*load March data (only caregivers)
use "avars_200712_EN_2.0p.dta", clear // background variables 2007
numlabel, add

*put a _7 to indicate that these variables are for 2007
rename * *_7
rename nomem_encr_7 nomem_encr

*mark variables for 2008 and 2009
foreach i of num 8/9 {
merge 1:1 nomem_encr using "avars_200`i'12_EN_2.0p.dta" 
drop _merge

foreach  var  of varlist  _all {
if "`var'" != "nomem_encr"  rename  `var' `var'_`i'
}
rename *_(#)_* *_(#)
rename *_(#)_* *_(#)
}

*mark variables for 2010 and 2011
foreach i of num 10/11 {
merge 1:1 nomem_encr using "avars_20`i'12_EN_2.0p.dta" 
drop _merge

foreach  var  of varlist  _all {
if "`var'" != "nomem_encr"  rename  `var' `var'_`i'
}
rename *_(#)_* *_(#)
if `i' >= 11 rename *_(#)(#)_* *_(#)(#)
}

*mark the rest of the variables 2012 to 2019
foreach i of num 12/19 {
merge 1:1 nomem_encr using "avars_20`i'12_EN_1.0p.dta" 
drop _merge

foreach  var  of varlist  _all {
if "`var'" != "nomem_encr"  rename  `var' `var'_`i'
}
rename *_(#)_* *_(#)
rename *_(#)(#)_* *_(#)(#)
}

*have one ID
rename nomem_encr* nomem_encr

tab belbezig_7 belbezig_8


*calculate the year in which people retired
gen pension_year = .
foreach i of num 8/19 {
local x  = (`i' - 1)
replace pension_year = (2000 + `i') if (belbezig_`x' == 3 | belbezig_`x' == 1) & belbezig_`i' == 9 & pension_year == .
}
tab pension_year

*calculate the year in which people retired - without self-employed
gen pension_year_withoutself = .
foreach i of num 8/19 {
local x  = (`i' - 1)
replace pension_year_withoutself = (2000 + `i') if belbezig_`x' == 1 & belbezig_`i' == 9 & pension_year_withoutself == .
}
tab pension_year_withoutself


*drop does that did not retire in that time
drop if pension_year == .

*generate income_before retirement for retired people
gen income_before = . 
replace income_before = brutoink_7 if pension_year == 2008
replace income_before = . if income_before < 0 // missings in 2007 
foreach i of num 9/19 {
local x  = (`i' - 1)
replace income_before =  brutoink_f_`x' if pension_year == (2000 + `i')
}
tab income_before pension_year, m

*generate age before retirement for retired people
gen age_before = .
foreach i of num 8/19 {
local x  = (`i' - 1)
replace age_before =  leeftijd_`x' if pension_year == (2000 + `i')
}
tab age_before

*generate occupation before retirement for retired people
gen oplcat_before = .
foreach i of num 8/19 {
local x  = (`i' - 1)
replace oplcat_before =  oplcat_`x' if pension_year == (2000 + `i')
}
tab oplcat_before

*generate partner before retirement for retired people
gen partner_before = .
foreach i of num 8/19 {
local x  = (`i' - 1)
replace partner_before =  partner_`x' if pension_year == (2000 + `i')
}
tab partner_before

*generate aantaki before retirement for retired people
gen aantalki_before = .
foreach i of num 8/19 {
local x  = (`i' - 1)
replace aantalki_before =  aantalki_`x' if pension_year == (2000 + `i')
}
tab aantalki_before

*generate belbezig before retirment for retired people
gen belbezig_before = .
foreach i of num 8/19 {
local x  = (`i' - 1)
replace belbezig_before =  belbezig_`x' if pension_year == (2000 + `i')
}
tab belbezig_before

replace pension_year = . if pension_year == 2008


*keep only relevant information
keep nomem_encr pension_year pension_year_withoutself income_before age_before oplcat_before partner_before aantalki_before brutoink_f_19 belbezig_before
gen episode = 1

cd ""
save "pension_year.dta", replace
*/
drop _merge
merge 1:1 nomem_encr using "wages_all.dta" //data on wages (from a basket in liss) - see readme of replication package
drop _merge
merge 1:1 nomem_encr using "working_hours_all.dta" //data on working hours (from a basket in liss) - see readme of replication package
drop _merge
merge 1:1 nomem_encr using "children_all.dta" //data on children (from a basket in liss) - see readme of replication package


*********************************************
save "all_data_together.dta", replace
*********************************************

clear
set more off
capture log close

*load in again
use "all_data_together.dta", clear 
numlabel, add


********************************************
*build caregiving variable
*binary variable cared vs. no care
tab v1
recode v1 (1 2 = 1 cared) (3 = 0 no_care), generate (care)
tab care

tab beginep_1, m

*********************************************
*restrict to calculate outcome
*********************************************
*exclude where we are not sure if they were indeed caregivers 
tab var3_1 var3_2, m
tab var3_1 var3_3, m
tab var3_2
tab var3_7, m
drop if care == 1  & (var3_1 == 13  & (var3_2 == 13 | var3_2 == .) & (var3_3 == 13 | var3_3 == .) & (var3_4 == 13 | var3_4 == .) & (var3_5 == 13 | var3_5 == . ) & (var3_6 == 13 | var3_6 == . ) & (var3_7 == 13 | var3_7 == .) )

*exclude if unresonable values on age of first caregiving
*variable on age at transition into caregiving
foreach x of num 1/7 {
gen begin_year_`x' = year(beginep_`x')
gen var_age_start_ep_`x' = begin_year_`x' - gebjaar
drop if var_age_start_ep_`x' < 5 
}

*exclude if more than seven people cared for 
tab v1_aantal if care == 1 
drop if (v1_aantal > 7 & care == 1)

*for sample
tab care if ((belbezig > 3 | belbezig == 2 | belbezig == .)  & pension_year == . ) | (care == 1 &  beginep_1 == .) | care == . | oplcat == .  //the once excluded for the next step
drop if ((belbezig > 3 | belbezig == 2 | belbezig == .)  & pension_year == . ) | (care == 1 &  beginep_1 == .) | care == . | oplcat == . //only currently employed, yes + in march-data, and were in screening data


********************************************
*make non-caregiver if only cared after 2020
foreach x of num 1/7 {
gen beginep_month_`x' = .
replace beginep_month_`x' = mofd(beginep_`x') if care == 1
}
tab beginep_1, m
tab beginep_month_1, m 

tab care
replace care = 0 if care == 1 & beginep_month_1 >= 720  // if first caregiving starts in 2020 it is as if they were non-caregivers 
tab care

*make non-caregiver if cared before retirement
foreach x of num 1/7 {
gen beginyear_`x' = . 
replace beginyear_`x' = year(beginep_`x') if care == 1
}

tab beginyear_1

tab care
replace care = 0 if pension_year != . & beginyear_1 >= pension_year & beginyear_2 >= pension_year ///
& beginyear_3 >= pension_year & beginyear_4 >= pension_year ///
 & beginyear_5 >= pension_year & beginyear_6 >= pension_year & beginyear_7 >= pension_year // only care before retirment

tab care


*********************************************
*variables for imputation
*********************************************
*income same year
generate income = brutoink_f_19 
replace income = income_before if pension_year !=. 
replace income = brutoink_f if income == . & pension_year == .
tab income, m


*age
generate age = leeftijd
replace age = age_before if pension_year !=. 
tab age, m

*age squared
gen age_qu = leeftijd*leeftijd
tab age_qu


*education
generate education = oplcat
replace education = oplcat_before if pension_year !=. 
tab education, m

*children: in one of the variables a yes
*drop children
gen children = 1
replace children = 2 if cf08a035 == 1 | cf09b035 == 1 | cf10c035 == 1 | cf11d035 == 1 | cf12e035 == 1 | ///
cf13f035 == 1 | cf14g035 == 1 | cf15h454 == 1  | cf16i454 == 1  | cf17j454 == 1 | cf18k454 == 1 | cf19l454  == 1 
replace children = 3 if aantalki > 0 | (aantalki_before > 0 & aantalki_before != .)
label define children 1 "No children" 2 "has children" 3 "children in houshold"
label values children children 
tab children, m

*partner
gen partner2 = partner
replace partner2 = partner_before if pension_year !=. 
tab partner2, m

***************************
*wages same year
***************************

rename ci(##)*010 wage_20(##)[1] // rename into wage in year meassured (before 2019)
rename ci(##)*372 wage_20(##)[1] // rename into wage in year meassured other abbrivation for year 2019 and 2020

rename ci(##)*011 wage_categorie_20(##)[1] // rename into catergorical wage in year meassured (before 2019)
rename ci(##)*373 wage_categorie_20(##)[1] // rename into caretgorical wage in year meassured other abbrivation for year 2019 and 2020

*mark missing as missing
foreach x of num 2008/2019 {

replace wage_`x' = . if wage_`x' == 9999999999 | wage_`x' == 9999999998 | wage_`x' < 0 

}


*generate wage variable including not retired
gen wages_samey = wage_2020 
gen cat_wage_2020 = wage_categorie_2020
recode cat_wage_2020 (1 = 4000) (2 = 12000) (3 = 20000) (4 = 30000) (5 = 42000) (6 = 54000) (7 = 66000) (-8 -9 = .)
replace wages_samey = cat_wage_2020 if wages_samey < 0 
tab wages_samey, m

*replace values for retired
foreach x of num 2008/2019 {
replace wages_samey = wage_`x' if pension_year == `x'
 
gen cat_wage_`x' = wage_categorie_`x'
recode cat_wage_`x' (1 = 4000) (2 = 12000) (3 = 20000) (4 = 30000) (5 = 42000) (6 = 54000) (7 = 66000) (-8 -9 98 99 =  .)

replace wages_samey = cat_wage_`x' if pension_year == `x' & cat_wage_`x' != . 
}

*calculate weekly instead of yearly income
replace wages_samey = (wages_samey)/52  //weekly wage - HERE WE HAVE A PRECISION PROBLEM - Stata does not round the same way each time which is why this variable is always different. This has effects for the rest of the results as this variable is the main basis of the outcome variable and therefore also for the imputation below. 
tab wages_samey, m
bysort belbezig: sum wages_samey


****************************
*wages year before
****************************
*generate wage beforvariable including not retired
gen wages_ybefore = wage_2019 
replace wages_ybefore = cat_wage_2019 if wages_samey < 0 
tab wages_ybefore, m

*replace values for retired
foreach x of num 2009/2019 {
local i  = (`x' - 1)
replace wages_ybefore = wage_`i' if pension_year == `x'
 
replace wages_ybefore = cat_wage_`i' if pension_year == `x' & cat_wage_`i' != . 
}
tab wages_ybefore, m

*****************************************
*working hours - same year including hours of side job
*****************************************
*hours same year + nebenkjob
*126 normal hours - 144 side job
tab cw19l121 belbezig

*rename variables
rename cw(##)*126 whours_20(##)[1] // rename into working hours in year meassured 
rename cw(##)*144 whours_side_20(##)[1] // rename into working hours of side job
rename cw(##)*127 whours_actual_20(##)[1] // rename into working hours of side job
rename cw(##)*121 oncall_20(##)[1] //rename question on on-call job

*generate for 2019
*drop whours_samey
gen whours_samey = whours_2019
replace whours_samey = whours_actual_2019 if (whours_2019 == . & (belbezig == 3 | oncall_2019 == 3) & pension_year == .)
replace whours_samey = whours_2019 + whours_side_2019 if whours_side_2019 !=.
replace whours_samey = whours_actual_2019 + whours_side_2019 if (whours_side_2019 !=. & whours_2019 == . & (belbezig == 3 | oncall_2019 == 3) & pension_year == .)
tab whours_samey, m

foreach x of num 2009/2019 {
local i  = (`x' - 1)
replace whours_samey = whours_`i'  if pension_year == `x'
replace whours_samey = whours_actual_`i' if whours_`i' == . & pension_year == `x' & (belbezig_before == 3 | oncall_`i' == 3)
replace whours_samey = whours_`i' + whours_side_`i' if pension_year == `x' & whours_side_`i' !=.
replace whours_samey = whours_actual_`i' + whours_side_`i' if pension_year == `x' & whours_side_`i' !=. & whours_`i' ==. & (belbezig_before == 3 | oncall_`i' == 3)
}
tab whours_samey if whours_samey > 60 
replace whours_samey = 60 if whours_samey > 60  & whours_samey != .
tab whours_samey, m
bysort belbezig: tab whours_samey, m

**********************************
*working hours year before
**********************************

*generate for 2018
*drop whours_ybefore
gen whours_ybefore = whours_2018
replace whours_ybefore = whours_actual_2018 if (whours_2018 == . & belbezig == 3)
replace whours_ybefore = whours_2018 + whours_side_2018 if whours_side_2018 !=.
replace whours_ybefore = whours_actual_2018 + whours_side_2018 if (whours_side_2018 !=. & whours_2018 == . & belbezig == 3)
tab whours_ybefore, m

tab whours_2008
foreach x of num 2010/2019 {
local i  = (`x' - 2)
replace whours_ybefore = whours_`i'  if pension_year == `x'
replace whours_ybefore = whours_actual_`i' if whours_`i' == . & pension_year == `x' & (belbezig_before == 3 | oncall_`i')
replace whours_ybefore = whours_`i' + whours_side_`i' if pension_year == `x' & whours_side_`i' !=.
replace whours_ybefore = whours_actual_`i' + whours_side_`i' if pension_year == `x' & whours_side_`i' !=. & whours_`i' ==. & (belbezig_before == 3 | oncall_`i')
}
replace whours_ybefore = 60 if whours_ybefore > 60 & whours_ybefore != .
tab whours_ybefore, m

*********************************
*variable years  retired
gen years_retired = 2020 - pension_year 
replace years_retired = 0 if years_retired == .
tab years_retired, m

*make a missing variables
gen mis_imp = 0
replace mis_imp = 1 if  wages_samey == . | whours_samey == .
tab mis_imp

*save for imputation
save "for_imputed.dta", replace

*********************************************
*who has missings on wage and working hours
tab wages_samey, m // 29.60%
tab whours_samey, m // 18.52 %
tab mis_imp
tab geslacht mis_imp, chi
bysort mis_imp: sum(leeftijd)


**********************************************
**********************************************
*imputation men
**********************************************
**********************************************

use "for_imputed.dta", clear
keep if geslacht == 1 // only keep men 

tab wages_samey, m
tab whours_samey, m

*set data mi set
mi set mlong

*mi register imputed. This command identifies which variables in the imputation model have missing information.
mi register imputed whours_ybefore whours_samey wages_ybefore wages_samey income

*check if predictor variables have missings
egen missing = rowmiss(years_retired care  education partner2 age age_qu children)

*register predictor variables
mi register regular years_retired care education partner2 age age_qu children

*imputation 
mi impute chained  (regress) whours_samey  whours_ybefore  (poisson) wages_samey wages_ybefore income = years_retired care i.education i.partner2 age age_qu i.children, add(25) rseed (21091994) force

*save inbetween
save "imputed_men.dta", replace


*reload again
use "imputed_men.dta", clear
set seed 21091994

*calculate mean of imputed wages
bysort nomem_encr : egen wwage = mean(wages_samey)

*topcode before calculation hours
replace whours_samey = 60 if whours_samey > 60 
bysort nomem_encr : egen whours = mean(whours_samey)

*extract and only keep one set of data set
mi extract 0, clear

*topcode hours again at 60
tab whours if whours > 60 
replace whours = 60 if whours > 60 

*Generate hourly wages
gen hwage =  (wwage/(whours +1))

*bottom-code if one
tab hwage, m 
replace hwage = 1 if hwage < 1

*topcode
tab hwage, m 
replace hwage = 580 if hwage >= 580
sum hwage

*descriptives for cared
bysort care: sum hwage // also includes final sample


save "before_matching_men.dta", replace
*********************************************
*check relationship - to be reported in data
poisson hwage care, vce(robust)
poisson hwage care i.oplcat partner leeftijd i.children years_retired, vce(robust)

**********************************************
*MATCHING MEN to 4
**********************************************
use "before_matching_men.dta", clear
set seed 21091994

*matching 
nnmatch hwage care  oplcat leeftijd partner children years_retired, m(4) keep(matched_file_men) replace

keep if care == 1

gen id = _n //to merge outcome variable back 
tab id 

*save inbetween to later match to
save "wage_file_care_noncare_men", replace

*load matched file
use "matched_file_men", clear 

*calculate mean of wage of matches
bysort id: egen never_wage = mean(hwage_0)
*check
tab never_wage, m

*calculate difference between caregivers and non-caregivers
gen wagedif_2 = hwage - never_wage 
sum wagedif_2

*exclude non-caregivers
keep if care == 1

*Distance meassure for matching to report in method part
sum(dist), d
tab dist

/*
*check how many non-caregivers were used = 581 male non-caregivers used in the matching
generate order = _n

by index (order), sort: generate y = _n == 1
sort order
replace y = sum(y) 
tab y
*/

*look at care
tab care

*sort by id to generate a within-id
sort id
bysort id: gen id_in = _n

*only keep one observation per repondent
keep if id_in == 1

*check care
tab care

*sort again by id
sort id

*drop id to generate a subsequent id (only caregivers + only one id per repsondent) to match all rest information
drop id
gen id = _n

*only keep id and wage difference (this is what we wanted from the matching file)
keep id wagedif_2 

*save matching file with wage difference
save "matched_file_with_difference_men", replace

*use complete wage data again
use "wage_file_care_noncare_men", clear

*drop merge that is in the data from merging before
drop _merge
*merge with the wage differences from the matching
merge 1:1 id using "matched_file_with_difference_men"

*drop episode and include epsiode = 1 again, for matching later
drop episode
gen episode = 1
tab episode

drop _merge
*only keep information that we need later
keep nomem_encr episode wagedif_2 years_retired pension_year care mis_imp

* merge to the complete data
merge 1:1 nomem_encr episode using "Mantelzorg_raw_long_without_covid19.dta"

*check wage difference
tab wagedif_2, m

*include the wage difference to all epsiodes
bysort nomem_encr (spell): egen wagedif = max(wagedif_2)

*only keep respondents that have a wage difference calculated
keep if wagedif != .

*drop wagedif_2 as we do not need it again
drop wagedif_2

*save data that includes all information and the wage differences.
drop _merge
save "Mantelzorg_long_life_course_with_wagedif_men.dta", replace

*********************************************
*MATCHING MEN to 3
**********************************************
use "before_matching_men.dta", clear
set seed 21091994

*matching 
nnmatch hwage care  oplcat leeftijd partner children years_retired, m(3) keep(matched_file_men_3) replace

keep if care == 1

gen id = _n //to merge outcome variable back 
tab id 

*save inbetween to later match to
save "wage_file_care_noncare_men_3", replace

*load matched file
use "matched_file_men_3", clear 

*calculate mean of wage of matches
bysort id: egen never_wage = mean(hwage_0)
*check
tab never_wage, m

*calculate difference between caregivers and non-caregivers
gen wagedif_2 = hwage - never_wage 
sum wagedif_2

*exclude non-caregivers
keep if care == 1

*Distance meassure for matching to report in method part
sum(dist), d

*look at care
tab care

*sort by id to generate a within-id
sort id
bysort id: gen id_in = _n

*only keep one observation per repondent
keep if id_in == 1

*check care
tab care

*sort again by id
sort id

*drop id to generate a subsequent id (only caregivers + only one id per repsondent) to match all rest information
drop id
gen id = _n

*only keep id and wage difference (this is what we wanted from the matching file)
keep id wagedif_2 

*save matching file with wage difference
save "matched_file_with_difference_men_3", replace

*use complete wage data again
use "wage_file_care_noncare_men_3", clear

*drop merge that is in the data from merging before
drop _merge
*merge with the wage differences from the matching
merge 1:1 id using "matched_file_with_difference_men_3"

*drop episode and include epsiode = 1 again, for matching later
drop episode
gen episode = 1
tab episode

drop _merge
*only keep information that we need later
keep nomem_encr episode wagedif_2 years_retired pension_year care mis_imp

* merge to the complete data
merge 1:1 nomem_encr episode using "Mantelzorg_raw_long_without_covid19.dta"

*check wage difference
tab wagedif_2, m

*include the wage difference to all epsiodes
bysort nomem_encr (spell): egen wagedif = max(wagedif_2)

*only keep respondents that have a wage difference calculated
keep if wagedif != .

*drop wagedif_2 as we do not need it again
drop wagedif_2

*save data that includes all information and the wage differences.
drop _merge
save "Mantelzorg_long_life_course_with_wagedif_men_3.dta", replace

*********************************************
*MATCHING MEN to 5
**********************************************
use "before_matching_men.dta", clear
set seed 21091994

*matching 
nnmatch hwage care  oplcat leeftijd partner children years_retired, m(5) keep(matched_file_men_5) replace

keep if care == 1

gen id = _n //to merge outcome variable back 
tab id 

*save inbetween to later match to
save "wage_file_care_noncare_men_5", replace

*load matched file
use "matched_file_men_5", clear 

*calculate mean of wage of matches
bysort id: egen never_wage = mean(hwage_0)
*check
tab never_wage, m

*calculate difference between caregivers and non-caregivers
gen wagedif_2 = hwage - never_wage 
sum wagedif_2

*exclude non-caregivers
keep if care == 1

*Distance meassure for matching to report in method part
sum(dist), d

*look at care
tab care

*sort by id to generate a within-id
sort id
bysort id: gen id_in = _n

*only keep one observation per repondent
keep if id_in == 1

*check care
tab care

*sort again by id
sort id

*drop id to generate a subsequent id (only caregivers + only one id per repsondent) to match all rest information
drop id
gen id = _n

*only keep id and wage difference (this is what we wanted from the matching file)
keep id wagedif_2 

*save matching file with wage difference
save "matched_file_with_difference_men_5", replace

*use complete wage data again
use "wage_file_care_noncare_men_5", clear

*drop merge that is in the data from merging before
drop _merge
*merge with the wage differences from the matching
merge 1:1 id using "matched_file_with_difference_men_5"

*drop episode and include epsiode = 1 again, for matching later
drop episode
gen episode = 1
tab episode

drop _merge
*only keep information that we need later
keep nomem_encr episode wagedif_2 years_retired pension_year care mis_imp

* merge to the complete data
merge 1:1 nomem_encr episode using "Mantelzorg_raw_long_without_covid19.dta"

*check wage difference
tab wagedif_2, m

*include the wage difference to all epsiodes
bysort nomem_encr (spell): egen wagedif = max(wagedif_2)

*only keep respondents that have a wage difference calculated
keep if wagedif != .

*drop wagedif_2 as we do not need it again
drop wagedif_2

*save data that includes all information and the wage differences.
drop _merge
save "Mantelzorg_long_life_course_with_wagedif_men_5.dta", replace

**********************************************
*imputation women
**********************************************
use "for_imputed.dta", clear
keep if geslacht == 2 // keep only women

tab wages_samey, m
tab whours_samey, m

*set data mi set
mi set mlong

*mi register imputed. This command identifies which variables in the imputation model have missing information.
mi register imputed whours_ybefore whours_samey wages_ybefore wages_samey income

*check if predictor variables have missings
egen missing = rowmiss(years_retired care  education partner2 age age_qu children)

*register predictor variables
mi register regular years_retired care  education partner2 age age_qu children

*imputation 
mi impute chained  (regress) whours_samey  whours_ybefore  (poisson) wages_samey wages_ybefore income = years_retired care i.education i.partner2 age age_qu i.children, add(25) rseed (21091994) force

*save inbetween
save "imputed_wom.dta", replace



*reload again
use "imputed_wom.dta", clear
set seed 21091994

*calculate mean of imputed wages
bysort nomem_encr : egen wwage = mean(wages_samey)

*topcode before calculation hours
replace whours_samey = 60 if whours_samey > 60 
bysort nomem_encr : egen whours = mean(whours_samey)

*extract and only keep one set of data set
mi extract 0, clear

*topcode hours again at 60
replace whours = 60 if whours > 60 

*Generate hourly wages
gen hwage =  (wwage/(whours +1))

*bottom-code if one
tab hwage, m 
replace hwage = 1 if hwage < 1

*topcode
tab hwage, m 
replace hwage = 580 if hwage >= 580
sum hwage

*descriptives for cared
bysort care: sum hwage // also includes final sample

save "before_matching_wom.dta", replace
*********************************************
*check relationship - to be reported in data
poisson hwage care, vce(robust)
poisson hwage care i.oplcat partner leeftijd i.children years_retired, vce(robust)

**********************************************
*MATCHING WOMEN to 4
**********************************************
use "before_matching_wom.dta", clear
set seed 21091994

*matching 
nnmatch hwage care  oplcat leeftijd partner children years_retired, m(4) keep(matched_file_wom) replace

keep if care == 1

gen id = _n //to merge outcome variable back 
tab id 

*save inbetween to later match to
save "wage_file_care_noncare_wom", replace

*load matched file
use "matched_file_wom", clear 

*calculate mean of wage of matches
bysort id: egen never_wage = mean(hwage_0)
*check
tab never_wage, m

*calculate difference between caregivers and non-caregivers
gen wagedif_2 = hwage - never_wage 
sum wagedif_2

*exclude non-caregivers
keep if care == 1

*Distance meassure for matching to report in method part
sum(dist), d

/*
*check how many non-caregivers were used =  399 female non-caregivers used in the matching
tab index
generate order = _n

by index (order), sort: generate y = _n == 1
sort order
replace y = sum(y) 
tab y
*/

*look at care
tab care

*sort by id to generate a within-id
sort id
bysort id: gen id_in = _n

*only keep one observation per repondent
keep if id_in == 1

*check care
tab care

*sort again by id
sort id

*drop id to generate a subsequent id (only caregivers + only one id per repsondent) to match all rest information
drop id
gen id = _n

*only keep id and wage difference (this is what we wanted from the matching file)
keep id wagedif_2 

*save matching file with wage difference
save "matched_file_with_difference_wom", replace

*use complete wage data again
use "wage_file_care_noncare_wom", clear

*drop merge that is in the data from merging before
drop _merge
*merge with the wage differences from the matching
merge 1:1 id using "matched_file_with_difference_wom"

*drop episode and include epsiode = 1 again, for matching later
drop episode
gen episode = 1
tab episode

drop _merge
*only keep information that we need later
keep nomem_encr episode wagedif_2 years_retired pension_year care mis_imp

* merge to the complete data
merge 1:1 nomem_encr episode using "Mantelzorg_raw_long_without_covid19.dta"

*check wage difference
tab wagedif_2, m

*include the wage difference to all epsiodes
bysort nomem_encr (spell): egen wagedif = max(wagedif_2)

*only keep respondents that have a wage difference calculated
keep if wagedif != .

*drop wagedif_2 as we do not need it again
drop wagedif_2

*save data that includes all information and the wage differences.
drop _merge
save "Mantelzorg_long_life_course_with_wagedif_wom.dta", replace

*put women and men together
*append using "Mantelzorg_long_life_course_with_wagedif_men.dta"
merge 1:1 nomem_encr episode using "Mantelzorg_long_life_course_with_wagedif_men.dta"
tab care geslacht

save "Mantelzorg_long_life_course_with_wagedif.dta", replace

*********************************************
*MATCHING WOMEN to 3
**********************************************
use "before_matching_wom.dta", clear
set seed 21091994

*matching 
nnmatch hwage care  oplcat leeftijd partner children years_retired, m(3) keep(matched_file_wom_3) replace

keep if care == 1

gen id = _n //to merge outcome variable back 
tab id 

*save inbetween to later match to
save "wage_file_care_noncare_wom_3", replace

*load matched file
use "matched_file_wom_3", clear 

*calculate mean of wage of matches
bysort id: egen never_wage = mean(hwage_0)
*check
tab never_wage, m

*calculate difference between caregivers and non-caregivers
gen wagedif_2 = hwage - never_wage 
sum wagedif_2

*exclude non-caregivers
keep if care == 1

*Distance meassure for matching to report in method part
sum(dist), d

*look at care
tab care

*sort by id to generate a within-id
sort id
bysort id: gen id_in = _n

*only keep one observation per repondent
keep if id_in == 1

*check care
tab care

*sort again by id
sort id

*drop id to generate a subsequent id (only caregivers + only one id per repsondent) to match all rest information
drop id
gen id = _n

*only keep id and wage difference (this is what we wanted from the matching file)
keep id wagedif_2 

*save matching file with wage difference
save "matched_file_with_difference_wom_3", replace

*use complete wage data again
use "wage_file_care_noncare_wom_3", clear

*drop merge that is in the data from merging before
drop _merge
*merge with the wage differences from the matching
merge 1:1 id using "matched_file_with_difference_wom_3"

*drop episode and include epsiode = 1 again, for matching later
drop episode
gen episode = 1
tab episode

drop _merge
*only keep information that we need later
keep nomem_encr episode wagedif_2 years_retired pension_year care mis_imp

* merge to the complete data
merge 1:1 nomem_encr episode using "Mantelzorg_raw_long_without_covid19.dta"

*check wage difference
tab wagedif_2, m

*include the wage difference to all epsiodes
bysort nomem_encr (spell): egen wagedif = max(wagedif_2)

*only keep respondents that have a wage difference calculated
keep if wagedif != .

*drop wagedif_2 as we do not need it again
drop wagedif_2

*save data that includes all information and the wage differences.
drop _merge
save "Mantelzorg_long_life_course_with_wagedif_wom_3.dta", replace

*put women and men together
*append using "Mantelzorg_long_life_course_with_wagedif_men.dta"
merge 1:1 nomem_encr episode using "Mantelzorg_long_life_course_with_wagedif_men_3.dta"
tab care geslacht

save "Mantelzorg_long_life_course_with_wagedif_3.dta", replace

*********************************************
*MATCHING WOMEN to 5
**********************************************
use "before_matching_wom.dta", clear
set seed 21091994

*matching 
nnmatch hwage care  oplcat leeftijd partner children years_retired, m(5) keep(matched_file_wom_5) replace

keep if care == 1

gen id = _n //to merge outcome variable back 
tab id 

*save inbetween to later match to
save "wage_file_care_noncare_wom_5", replace

*load matched file
use "matched_file_wom_5", clear 

*calculate mean of wage of matches
bysort id: egen never_wage = mean(hwage_0)
*check
tab never_wage, m

*calculate difference between caregivers and non-caregivers
gen wagedif_2 = hwage - never_wage 
sum wagedif_2

*exclude non-caregivers
keep if care == 1

*Distance meassure for matching to report in method part
sum(dist), d

*look at care
tab care

*sort by id to generate a within-id
sort id
bysort id: gen id_in = _n

*only keep one observation per repondent
keep if id_in == 1

*check care
tab care

*sort again by id
sort id

*drop id to generate a subsequent id (only caregivers + only one id per repsondent) to match all rest information
drop id
gen id = _n

*only keep id and wage difference (this is what we wanted from the matching file)
keep id wagedif_2 

*save matching file with wage difference
save "matched_file_with_difference_wom_5", replace

*use complete wage data again
use "wage_file_care_noncare_wom_5", clear

*drop merge that is in the data from merging before
drop _merge
*merge with the wage differences from the matching
merge 1:1 id using "matched_file_with_difference_wom_5"

*drop episode and include epsiode = 1 again, for matching later
drop episode
gen episode = 1
tab episode

drop _merge
*only keep information that we need later
keep nomem_encr episode wagedif_2 years_retired pension_year care mis_imp

* merge to the complete data
merge 1:1 nomem_encr episode using "Mantelzorg_raw_long_without_covid19.dta"

*check wage difference
tab wagedif_2, m

*include the wage difference to all epsiodes
bysort nomem_encr (spell): egen wagedif = max(wagedif_2)

*only keep respondents that have a wage difference calculated
keep if wagedif != .

*drop wagedif_2 as we do not need it again
drop wagedif_2

*save data that includes all information and the wage differences.
drop _merge
save "Mantelzorg_long_life_course_with_wagedif_wom_5.dta", replace

*put women and men together
*append using "Mantelzorg_long_life_course_with_wagedif_men.dta"
merge 1:1 nomem_encr episode using "Mantelzorg_long_life_course_with_wagedif_men_5.dta"
tab care geslacht

save "Mantelzorg_long_life_course_with_wagedif_5.dta", replace


********************************************
********************************************
*minimum wage to 4,50
********************************************

*reload again
use "imputed_men.dta", clear
set seed 21091994

*calculate mean of imputed wages
bysort nomem_encr : egen wwage = mean(wages_samey)

*topcode before calculation hours
replace whours_samey = 60 if whours_samey > 60 
bysort nomem_encr : egen whours = mean(whours_samey)

*extract and only keep one set of data set
mi extract 0, clear

*topcode hours again at 60
replace whours = 60 if whours > 60 

*Generate hourly wages
gen hwage =  (wwage/(whours +1))

*bottom-code if one
tab hwage, m 
replace hwage = 4.50 if hwage <= 4.50

*topcode
tab hwage, m 
replace hwage = 580 if hwage >= 580
sum hwage

*descriptives for cared
bysort care: sum hwage // also includes final sample


save "before_matching_men_minwage.dta", replace

**********************************************
*MATCHING MEN to 4 - min wage
**********************************************
use "before_matching_men_minwage.dta", clear
set seed 21091994

*matching 
nnmatch hwage care  oplcat leeftijd partner children years_retired, m(4) keep(matched_file_men_minwage) replace

keep if care == 1

gen id = _n //to merge outcome variable back 
tab id 

*save inbetween to later match to
save "wage_file_care_noncare_men_minwage", replace

*load matched file
use "matched_file_men_minwage", clear 

*calculate mean of wage of matches
bysort id: egen never_wage = mean(hwage_0)
*check
tab never_wage, m

*calculate difference between caregivers and non-caregivers
gen wagedif_2 = hwage - never_wage 
sum wagedif_2

*exclude non-caregivers
keep if care == 1

*Distance meassure for matching to report in method part
sum(dist), d

*look at care
tab care

*sort by id to generate a within-id
sort id
bysort id: gen id_in = _n

*only keep one observation per repondent
keep if id_in == 1

*check care
tab care

*sort again by id
sort id

*drop id to generate a subsequent id (only caregivers + only one id per repsondent) to match all rest information
drop id
gen id = _n

*only keep id and wage difference (this is what we wanted from the matching file)
keep id wagedif_2 

*save matching file with wage difference
save "matched_file_with_difference_men_minwage", replace

*use complete wage data again
use "wage_file_care_noncare_men_minwage", clear

*drop merge that is in the data from merging before
drop _merge
*merge with the wage differences from the matching
merge 1:1 id using "matched_file_with_difference_men_minwage"

*drop episode and include epsiode = 1 again, for matching later
drop episode
gen episode = 1
tab episode

drop _merge
*only keep information that we need later
keep nomem_encr episode wagedif_2 years_retired pension_year care mis_imp

* merge to the complete data
merge 1:1 nomem_encr episode using "Mantelzorg_raw_long_without_covid19.dta"

*check wage difference
tab wagedif_2, m

*include the wage difference to all epsiodes
bysort nomem_encr (spell): egen wagedif = max(wagedif_2)

*only keep respondents that have a wage difference calculated
keep if wagedif != .

*drop wagedif_2 as we do not need it again
drop wagedif_2

*save data that includes all information and the wage differences.
drop _merge
save "Mantelzorg_long_life_course_with_wagedif_men_minwage.dta", replace

***********************
*Women 4,50 min wage
***********************
use "imputed_wom.dta", clear
set seed 21091994

*calculate mean of imputed wages
bysort nomem_encr : egen wwage = mean(wages_samey)

*topcode before calculation hours
replace whours_samey = 60 if whours_samey > 60 
bysort nomem_encr : egen whours = mean(whours_samey)

*extract and only keep one set of data set
mi extract 0, clear

*topcode hours again at 60
replace whours = 60 if whours > 60 

*Generate hourly wages
gen hwage =  (wwage/(whours +1))

*bottom-code if one
tab hwage, m 
replace hwage = 4.50 if hwage < 4.50

*topcode
tab hwage, m 
replace hwage = 580 if hwage >= 580
sum hwage

*descriptives for cared
bysort care: sum hwage // also includes final sample

save "before_matching_wom_minwage.dta", replace

**********************************************
*MATCHING WOMEN to 4 - minwage
**********************************************
use "before_matching_wom_minwage.dta", clear
set seed 21091994

*matching 
nnmatch hwage care  oplcat leeftijd partner children years_retired, m(4) keep(matched_file_wom_minwage) replace

keep if care == 1

gen id = _n //to merge outcome variable back 
tab id 

*save inbetween to later match to
save "wage_file_care_noncare_wom_minwage", replace

*load matched file
use "matched_file_wom_minwage", clear 

*calculate mean of wage of matches
bysort id: egen never_wage = mean(hwage_0)
*check
tab never_wage, m

*calculate difference between caregivers and non-caregivers
gen wagedif_2 = hwage - never_wage 
sum wagedif_2

*exclude non-caregivers
keep if care == 1

*Distance meassure for matching to report in method part
sum(dist), d

*look at care
tab care

*sort by id to generate a within-id
sort id
bysort id: gen id_in = _n

*only keep one observation per repondent
keep if id_in == 1

*check care
tab care

*sort again by id
sort id

*drop id to generate a subsequent id (only caregivers + only one id per repsondent) to match all rest information
drop id
gen id = _n

*only keep id and wage difference (this is what we wanted from the matching file)
keep id wagedif_2 

*save matching file with wage difference
save "matched_file_with_difference_wom_minwage", replace

*use complete wage data again
use "wage_file_care_noncare_wom_minwage", clear

*drop merge that is in the data from merging before
drop _merge
*merge with the wage differences from the matching
merge 1:1 id using "matched_file_with_difference_wom_minwage"

*drop episode and include epsiode = 1 again, for matching later
drop episode
gen episode = 1
tab episode

drop _merge
*only keep information that we need later
keep nomem_encr episode wagedif_2 years_retired pension_year care mis_imp

* merge to the complete data
merge 1:1 nomem_encr episode using "Mantelzorg_raw_long_without_covid19.dta"

*check wage difference
tab wagedif_2, m

*include the wage difference to all epsiodes
bysort nomem_encr (spell): egen wagedif = max(wagedif_2)

*only keep respondents that have a wage difference calculated
keep if wagedif != .

*drop wagedif_2 as we do not need it again
drop wagedif_2

*save data that includes all information and the wage differences.
drop _merge
save "Mantelzorg_long_life_course_with_wagedif_wom_minwage.dta", replace

*put women and men together
*append using "Mantelzorg_long_life_course_with_wagedif_men.dta"
merge 1:1 nomem_encr episode using "Mantelzorg_long_life_course_with_wagedif_men_minwage.dta"
tab care geslacht

save "Mantelzorg_long_life_course_with_wagedif_minwage.dta", replace



*******************************************************************************
*
* PART 3: Data preparation
*
********************************************************************************


use "Mantelzorg_long_life_course_with_wagedif.dta", clear


*******************
*id

gen id = nomem_encr

************************
*missings before imputation
************************
tab mis_imp geslacht, m
replace mis_imp = 0 if mis_imp == .
bysort nomem_encr (episode): egen mis_imp2 = max(mis_imp)
tab mis_imp2, m

*******************************************************************************
*cutoff 2020
*******************************************************************************
tab episode
tab beginep, m
gen beginep_month = mofd(beginep) 
tab episode if beginep_month < 720
keep if beginep_month < 720
tab episode

*exclude if var3 is missing
drop if var3 == 13
drop episode
bysort nomem_encr: gen episode = _n //episode number updated after deleting
tab episode

*************************
*duration

*Helper for december 2020
gen date_dec = date("31dec2020" , "DMY")
format date_dec % td
gen date_dec2=mofd(date_dec)
format date_dec2 %tm

*Helper for december 2018
gen date_dec_2018 = date("31dec2018" , "DMY")


*Helper for december 2017
gen date_dec_2017 = date("31dec2017" , "DMY")


*Helper for december 2016
gen date_dec_2016 = date("31dec2016" , "DMY")


*Helper for december 2015
gen date_dec_2015 = date("31dec2015" , "DMY")


*Helper for december 2014
gen date_dec_2014 = date("31dec2014" , "DMY")


*Helper for december 2013
gen date_dec_2013 = date("31dec2013" , "DMY")


*Helper for december 2012
gen date_dec_2012 = date("31dec2012" , "DMY")

*Helper for december 2011
gen date_dec_2011 = date("31dec2011" , "DMY")


*Helper for december 2010
gen date_dec_2010 = date("31dec2010" , "DMY")

*Helper for december 2009
gen date_dec_2009 = date("31dec2009" , "DMY")


*calculate total duration not considering overlap 
gen date_begin_n =mofd(beginep) +108
tab date_begin_n

gen date_end_n =mofd(endep) + 108
tab date_end_n

gen date_march = date("31mar2020" , "DMY")
format date_march % td
gen date_march2=mofd(date_march)
format date_march2 %tm

replace date_end_n = mofd(date_march) + 108 if endep == .
tab date_end_n

foreach x of num 2010/2019 {
local i  = (`x' - 1)
format date_dec_`i' % td
replace date_end_n = mofd(date_dec_`i') + 108 if pension_year == `x'
}


forval i = 0/830 {
gen dum_`i' = 0
replace dum_`i' = 1 if `i' >= date_begin_n & `i' <= date_end_n 
}


forval i = 0/830 {
bysort nomem_encr (spell): gen duration_dummy_`i' = 1 if sum(dum_`i') >= 1
}
egen duration = rowtotal(duration_dummy*)
label variable duration "Total duration in month"
tab duration, m



*******************************************************************************
*cutoff retired - cut of end variables for retired that retired before enddate
*******************************************************************************
foreach x of num 2010/2019 {
local i  = (`x' - 1)
format date_dec_`i' % td
gen date_dec2_`i'=mofd(date_dec_`i')
format date_dec2_`i' %tm
}

*values for enddate
foreach x of num 2010/2019 {
local i  = (`x' - 1)
replace var9_end = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != . // for intensity
replace var10_end_a = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_b = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_c = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_d = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_e = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_f = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_g = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_h = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_i = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
}

***************************
*age at first caregiving

*variable on age at transition into caregiving
gen begin_year = year(beginep)
gen var_age_start_ep = begin_year - gebjaar
tab var_age_start_ep
label variable var_age_start_ep "age at begining of episode"
tab var_age_start_ep, m 
***************************************************************
*age at first transition
bysort nomem_encr: egen var_agefirstspell = min(var_age_start_ep)
tab var_agefirstspell
label variable var_agefirstspell "Age at first episode"

*****************
*life stages
tab var_agefirstspell
gen lifestage = .
replace lifestage = 1 if var_agefirstspell <= 17
replace lifestage = 2 if (var_agefirstspell >= 18 & var_agefirstspell <= 27)
replace lifestage = 3 if var_agefirstspell >= 28 & var_agefirstspell <= 37
replace lifestage = 4 if var_agefirstspell >= 38 & var_agefirstspell <= 47
replace lifestage = 5 if var_agefirstspell >= 48 & var_agefirstspell <= 57
replace lifestage = 6 if var_agefirstspell >= 58

tab var_agefirstspell lifestage, m 


label variable lifestage "Life stages"
label define lifestage 1 "5 to 17" 2 "18 to 27" 3 "28 to 37" 4 "38 to 47" 5 "48 to 57" 6 "58 and older"
label values lifestage lifestage
tab lifestage
 
*frequency
bysort nomem_encr: gen aantal_episode = _N
label variable aantal_episode "Frequency"
tab aantal_episode, m

tab v1_aantal if v1_aantal > 7 & episode == 1 // how many people had more than seven epsiodes

***************************
*squared frequency
gen squ_frequency = aantal_episode*aantal_episode
label variable squ_frequency "Squared frequency"
tab squ_frequency, m



**************************
*wage difference
**************************
tab wagedif,m
sum wagedif



**************************
* intensity
**************************
tab var9_begin, m
*take highest intensity of each episode
gen int_epi = var9_begin
replace int_epi = var9_end if (var9_begin < var9_end & var9_begin == .)
tab int_epi, m

*create helper indicating how many intensity meassures are there
gen int_help = 0
replace int_help = 1 if int_epi != .
tab int_help, m
bysort id: egen in_help_id =  total(int_help)
tab in_help_id

*create intensity variable by summing up the intensity in each person divided by how many meassures
bysort id: egen intensity = total(int_epi) 
replace intensity = intensity / in_help_id
tab intensity, m

label variable intensity "Intensity"
tab intensity, m

*************************
*different types of tasks
*************************
*a
gen var10_a_ind = 0
replace var10_a_ind = 1 if var10_begin_a == 1 | var10_end_a == 1

*b
gen var10_b_ind = 0
replace var10_b_ind = 1 if var10_begin_b == 1 | var10_end_b == 1

*c
gen var10_c_ind = 0
replace var10_c_ind = 1 if var10_begin_c == 1 | var10_end_c == 1

*d
gen var10_d_ind = 0
replace var10_d_ind = 1 if var10_begin_d == 1 | var10_end_d == 1

*e
gen var10_e_ind = 0
replace var10_e_ind = 1 if var10_begin_e == 1 | var10_end_e == 1


*f
gen var10_f_ind = 0
replace var10_f_ind = 1 if var10_begin_f == 1 | var10_end_f == 1


*g
gen var10_g_ind = 0
replace var10_g_ind = 1 if var10_begin_g == 1 | var10_end_g == 1

*h
gen var10_h_ind = 0
replace var10_h_ind = 1 if var10_begin_h == 1 | var10_end_h == 1


*i
gen var10_i_ind = 0
replace var10_i_ind = 1 if var10_begin_i == 1 | var10_end_i == 1

*tasks per episode
gen tasks_epi = var10_a_ind + var10_b_ind + var10_c_ind + var10_d_ind + var10_e_ind + var10_f_ind + var10_g_ind + var10_h_ind + var10_i_ind
tab tasks_epi, m



*create helper indicating how many tasks meassures are there
gen task_help = 0
replace task_help = 1 if tasks_epi >= 1 
tab task_help, m
bysort id: egen task_help_id =  total(task_help)
tab task_help_id


*caculate average of tasks 
bysort id: egen var_tasks = total(tasks_epi) 
replace var_tasks = var_tasks / task_help_id
tab var_tasks, m


label variable var_tasks "Number of tasks"

drop var10_a* var10_b* var10_c* var10_d* var10_e* var10_f* var10_g* var10_h* var10_i*  

*************************
*relationship
*************************
*ever cared for yes no dummies: close family (partner, parents, children), other family, non-family
*partner (var3 == 1)
tab var3
gen rel_clfam_ind = 1 if var3 == 1  | var3 == 2 | var3 == 5 
bysort nomem_encr (spell): egen rel_clfam_sum = sum(rel_clfam_ind)
bysort nomem_encr (spell): egen rel_clfam_max_sum = max(rel_clfam_sum)
bysort nomem_encr (spell): gen var_rel_clfam = 1 if rel_clfam_max_sum >= 1
replace var_rel_clfam = 0 if var_rel_clfam == .
tab var_rel_clfam, m
label variable var_rel_clfam "Close family"


*family (var 3 == 3 4 6 7 8 9)
gen rel_fam_ind = 1 if var3 == 3 | var3 == 4 | var3 == 6 | var3 == 7 | var3 == 8 | var3 == 9 
bysort nomem_encr (spell): egen rel_fam_sum = sum(rel_fam_ind)
bysort nomem_encr (spell): egen rel_fam_max_sum = max(rel_fam_sum)
bysort nomem_encr (spell): gen var_rel_fam = 1 if rel_fam_max_sum >= 1
replace var_rel_fam = 0 if var_rel_fam == .
tab var_rel_fam, m
label variable var_rel_fam "Other family"

*non-family (var 3 == 10 11 )
gen rel_nofam_ind = 1 if var3 == 10 | var3 == 11 
bysort nomem_encr (spell): egen rel_nofam_sum = sum(rel_nofam_ind)
bysort nomem_encr (spell): egen rel_nofam_max_sum = max(rel_nofam_sum)
bysort nomem_encr (spell): gen var_rel_nofam = 1 if rel_nofam_max_sum >= 1
replace var_rel_nofam = 0 if var_rel_nofam == .
tab var_rel_nofam, m
label variable var_rel_nofam "No family"

drop *_ind *_sum *_max_sum

************************
*duty
************************
*obligation
tab var17_n
gen var17_n_dum = 1 if var17_n == 4 | var17_n == 5
bysort nomem_encr (spell): gen var_obligation = 1 if sum(var17_n_dum) >= 1
replace var_obligation = 0 if var_obli == . 
tab var_obligation, m
label variable var_obligation "Obligation"



************************
*make it cross-sectional
************************
tab episode
keep if episode == 1
tab episode

***********************
*keep only nessecary variables
************************

keep wagedif var_obligation var_rel_nofam var_rel_fam var_rel_clfam var_tasks  ///
intensity aantal_episode duration id nomem_encr episode geslacht  ///
var_agefirstspell leeftijd squ_frequency belbezig  ///
lifestage mis_imp



 
***********************
*save main data set
***********************
*listwise deletion
*drop miss
egen miss=rowmiss(wagedif var_obligation var_rel_nofam var_rel_fam var_rel_clfam var_tasks  ///
intensity aantal_episode duration id nomem_encr episode geslacht   ///
var_agefirstspell leeftijd  squ_frequency)
tab miss

keep if miss == 0

tab episode 


*save data set
save "paper2_after_data_prep.dta", replace

**********************************************************
*********************************************************
*FOR ROBUSTNESS CHECKS
**********************************************************
***********************************************************

**********************************************
*matching to 3
**********************************************
use "Mantelzorg_long_life_course_with_wagedif_3.dta", clear



*******************
*id

gen id = nomem_encr

*******************************************************************************
*cutoff 2020
*******************************************************************************
tab episode
tab beginep, m
gen beginep_month = mofd(beginep) 
tab episode if beginep_month < 720
keep if beginep_month < 720
tab episode

*exclude if var3 is missing
drop if var3 == 13
drop episode
bysort nomem_encr: gen episode = _n //episode number updated after deleting
tab episode

*************************
*duration

*Helper for december 2020
gen date_dec = date("31dec2020" , "DMY")
format date_dec % td
gen date_dec2=mofd(date_dec)
format date_dec2 %tm

*Helper for december 2018
gen date_dec_2018 = date("31dec2018" , "DMY")


*Helper for december 2017
gen date_dec_2017 = date("31dec2017" , "DMY")


*Helper for december 2016
gen date_dec_2016 = date("31dec2016" , "DMY")


*Helper for december 2015
gen date_dec_2015 = date("31dec2015" , "DMY")


*Helper for december 2014
gen date_dec_2014 = date("31dec2014" , "DMY")


*Helper for december 2013
gen date_dec_2013 = date("31dec2013" , "DMY")


*Helper for december 2012
gen date_dec_2012 = date("31dec2012" , "DMY")

*Helper for december 2011
gen date_dec_2011 = date("31dec2011" , "DMY")


*Helper for december 2010
gen date_dec_2010 = date("31dec2010" , "DMY")

*Helper for december 2009
gen date_dec_2009 = date("31dec2009" , "DMY")


*calculate total duration not considering overlap overlap
gen date_begin_n =mofd(beginep) +108
tab date_begin_n

gen date_end_n =mofd(endep) + 108
tab date_end_n

gen date_march = date("31mar2020" , "DMY")
format date_march % td
gen date_march2=mofd(date_march)
format date_march2 %tm

replace date_end_n = mofd(date_march) + 108 if endep == .
tab date_end_n

foreach x of num 2010/2019 {
local i  = (`x' - 1)
format date_dec_`i' % td
replace date_end_n = mofd(date_dec_`i') + 108 if pension_year == `x'
}


forval i = 0/830 {
gen dum_`i' = 0
replace dum_`i' = 1 if `i' >= date_begin_n & `i' <= date_end_n 
}


forval i = 0/830 {
bysort nomem_encr (spell): gen duration_dummy_`i' = 1 if sum(dum_`i') >= 1
}
egen duration = rowtotal(duration_dummy*)
label variable duration "Total duration in month"
tab duration, m



*******************************************************************************
*cutoff retired - cut of end variables for retired that retired before enddate
*******************************************************************************
foreach x of num 2010/2019 {
local i  = (`x' - 1)
format date_dec_`i' % td
gen date_dec2_`i'=mofd(date_dec_`i')
format date_dec2_`i' %tm
}

*values for enddate
foreach x of num 2010/2019 {
local i  = (`x' - 1)
replace var9_end = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != . // for intensity
replace var10_end_a = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_b = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_c = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_d = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_e = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_f = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_g = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_h = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_i = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
}

***************************
*age at first caregiving

*variable on age at transition into caregiving
gen begin_year = year(beginep)
gen var_age_start_ep = begin_year - gebjaar
tab var_age_start_ep
label variable var_age_start_ep "age at begining of episode"
tab var_age_start_ep, m 
***************************************************************
*age at first transition
bysort nomem_encr: egen var_agefirstspell = min(var_age_start_ep)
tab var_agefirstspell
label variable var_agefirstspell "Age at first episode"

*****************
*life stages
tab var_agefirstspell
gen lifestage = .
replace lifestage = 1 if var_agefirstspell <= 17
replace lifestage = 2 if (var_agefirstspell >= 18 & var_agefirstspell <= 27)
replace lifestage = 3 if var_agefirstspell >= 28 & var_agefirstspell <= 37
replace lifestage = 4 if var_agefirstspell >= 38 & var_agefirstspell <= 47
replace lifestage = 5 if var_agefirstspell >= 48 & var_agefirstspell <= 57
replace lifestage = 6 if var_agefirstspell >= 58

tab var_agefirstspell lifestage, m 


label variable lifestage "Life stages"
label define lifestage 1 "5 to 17" 2 "18 to 27" 3 "28 to 37" 4 "38 to 47" 5 "48 to 57" 6 "58 and older"
label values lifestage lifestage
tab lifestage
 
*frequency
bysort nomem_encr: gen aantal_episode = _N
label variable aantal_episode "Frequency"
tab aantal_episode, m

tab v1_aantal if v1_aantal > 7 & episode == 1 // how many people had more than seven epsiodes

***************************
*squared frequency
gen squ_frequency = aantal_episode*aantal_episode
label variable squ_frequency "Squared frequency"
tab squ_frequency, m

**************************

**************************
* intensity
**************************
tab var9_begin, m
*take highest intensity of each episode
gen int_epi = var9_begin
replace int_epi = var9_end if (var9_begin < var9_end & var9_begin == .)
tab int_epi, m

*create helper indicating how many intensity meassures are there
gen int_help = 0
replace int_help = 1 if int_epi != .
tab int_help, m
bysort id: egen in_help_id =  total(int_help)
tab in_help_id

*create intensity variable by summing up the intensity in each person divided by how many meassures
bysort id: egen intensity = total(int_epi) 
replace intensity = intensity / in_help_id
tab intensity, m

label variable intensity "Intensity"
tab intensity, m

*************************
*different types of tasks
*************************
*a
gen var10_a_ind = 0
replace var10_a_ind = 1 if var10_begin_a == 1 | var10_end_a == 1

*b
gen var10_b_ind = 0
replace var10_b_ind = 1 if var10_begin_b == 1 | var10_end_b == 1

*c
gen var10_c_ind = 0
replace var10_c_ind = 1 if var10_begin_c == 1 | var10_end_c == 1

*d
gen var10_d_ind = 0
replace var10_d_ind = 1 if var10_begin_d == 1 | var10_end_d == 1

*e
gen var10_e_ind = 0
replace var10_e_ind = 1 if var10_begin_e == 1 | var10_end_e == 1


*f
gen var10_f_ind = 0
replace var10_f_ind = 1 if var10_begin_f == 1 | var10_end_f == 1


*g
gen var10_g_ind = 0
replace var10_g_ind = 1 if var10_begin_g == 1 | var10_end_g == 1

*h
gen var10_h_ind = 0
replace var10_h_ind = 1 if var10_begin_h == 1 | var10_end_h == 1


*i
gen var10_i_ind = 0
replace var10_i_ind = 1 if var10_begin_i == 1 | var10_end_i == 1

*tasks per episode
gen tasks_epi = var10_a_ind + var10_b_ind + var10_c_ind + var10_d_ind + var10_e_ind + var10_f_ind + var10_g_ind + var10_h_ind + var10_i_ind
tab tasks_epi, m



*create helper indicating how many tasks meassures are there
gen task_help = 0
replace task_help = 1 if tasks_epi >= 1 
tab task_help, m
bysort id: egen task_help_id =  total(task_help)
tab task_help_id


*caculate average of tasks 
bysort id: egen var_tasks = total(tasks_epi) 
replace var_tasks = var_tasks / task_help_id
tab var_tasks, m


label variable var_tasks "Number of tasks"

drop var10_a* var10_b* var10_c* var10_d* var10_e* var10_f* var10_g* var10_h* var10_i*  

*************************
*relationship
*************************
*ever cared for yes no dummies: close family (partner, parents, children), other family, non-family
*partner (var3 == 1)
gen rel_clfam_ind = 1 if var3 == 1  | var3 == 2 | var3 == 5 
bysort nomem_encr (spell): egen rel_clfam_sum = sum(rel_clfam_ind)
bysort nomem_encr (spell): egen rel_clfam_max_sum = max(rel_clfam_sum)
bysort nomem_encr (spell): gen var_rel_clfam = 1 if rel_clfam_max_sum >= 1
replace var_rel_clfam = 0 if var_rel_clfam == .
tab var_rel_clfam, m
label variable var_rel_clfam "Close family"


*family (var 3 == 3 4 6 7 8 9)
gen rel_fam_ind = 1 if var3 == 3 | var3 == 4 | var3 == 6 | var3 == 7 | var3 == 8 | var3 == 9 
bysort nomem_encr (spell): egen rel_fam_sum = sum(rel_fam_ind)
bysort nomem_encr (spell): egen rel_fam_max_sum = max(rel_fam_sum)
bysort nomem_encr (spell): gen var_rel_fam = 1 if rel_fam_max_sum >= 1
replace var_rel_fam = 0 if var_rel_fam == .
tab var_rel_fam, m
label variable var_rel_fam "Other family"

*non-family (var 3 == 10 11 )
gen rel_nofam_ind = 1 if var3 == 10 | var3 == 11 
bysort nomem_encr (spell): egen rel_nofam_sum = sum(rel_nofam_ind)
bysort nomem_encr (spell): egen rel_nofam_max_sum = max(rel_nofam_sum)
bysort nomem_encr (spell): gen var_rel_nofam = 1 if rel_nofam_max_sum >= 1
replace var_rel_nofam = 0 if var_rel_nofam == .
tab var_rel_nofam, m
label variable var_rel_nofam "No family"

drop *_ind *_sum *_max_sum

************************
*duty
************************
*obligation
tab var17_n
gen var17_n_dum = 1 if var17_n == 4 | var17_n == 5
bysort nomem_encr (spell): gen var_obligation = 1 if sum(var17_n_dum) >= 1
replace var_obligation = 0 if var_obli == . 
tab var_obligation, m
label variable var_obligation "Obligation"


************************
*make it cross-sectional
************************
tab episode
keep if episode == 1
tab episode

***********************
*keep only nessecary variables
************************

keep wagedif var_obligation var_rel_nofam var_rel_fam var_rel_clfam var_tasks  ///
intensity aantal_episode duration id nomem_encr episode geslacht  ///
var_agefirstspell leeftijd squ_frequency belbezig  lifestage mis_imp


 
***********************
*save data set
***********************
*listwise deletion
*drop miss
egen miss=rowmiss(wagedif var_obligation var_rel_nofam var_rel_fam var_rel_clfam var_tasks  ///
intensity aantal_episode duration id nomem_encr episode geslacht   ///
var_agefirstspell leeftijd  squ_frequency)
tab miss 

keep if miss == 0

tab episode 

*log wage difference
egen helpi = min(wagedif - 1)
gen  log_wagedif = ln(wagedif - helpi)
gen helpi_2 = helpi * -1
replace helpi_2 = ln(helpi_2)
replace log_wagedif = log_wagedif - helpi_2
tab log_wagedif

*save data set
save "paper2_after_data_prep_matching_to_3.dta", replace


**********************************************
*matching to 5
**********************************************
use "Mantelzorg_long_life_course_with_wagedif_5.dta", clear



*******************
*id

gen id = nomem_encr

*******************************************************************************
*cutoff 2020
*******************************************************************************
tab episode
tab beginep, m
gen beginep_month = mofd(beginep) 
tab episode if beginep_month < 720
keep if beginep_month < 720
tab episode

*exclude if var3 is missing
drop if var3 == 13
drop episode
bysort nomem_encr: gen episode = _n //episode number updated after deleting
tab episode

*************************
*duration

*Helper for december 2020
gen date_dec = date("31dec2020" , "DMY")
format date_dec % td
gen date_dec2=mofd(date_dec)
format date_dec2 %tm

*Helper for december 2018
gen date_dec_2018 = date("31dec2018" , "DMY")


*Helper for december 2017
gen date_dec_2017 = date("31dec2017" , "DMY")


*Helper for december 2016
gen date_dec_2016 = date("31dec2016" , "DMY")


*Helper for december 2015
gen date_dec_2015 = date("31dec2015" , "DMY")


*Helper for december 2014
gen date_dec_2014 = date("31dec2014" , "DMY")


*Helper for december 2013
gen date_dec_2013 = date("31dec2013" , "DMY")


*Helper for december 2012
gen date_dec_2012 = date("31dec2012" , "DMY")

*Helper for december 2011
gen date_dec_2011 = date("31dec2011" , "DMY")


*Helper for december 2010
gen date_dec_2010 = date("31dec2010" , "DMY")

*Helper for december 2009
gen date_dec_2009 = date("31dec2009" , "DMY")


*calculate total duration not considering overlap overlap
gen date_begin_n =mofd(beginep) +108
tab date_begin_n

gen date_end_n =mofd(endep) + 108
tab date_end_n

gen date_march = date("31mar2020" , "DMY")
format date_march % td
gen date_march2=mofd(date_march)
format date_march2 %tm

replace date_end_n = mofd(date_march) + 108 if endep == .
tab date_end_n

foreach x of num 2010/2019 {
local i  = (`x' - 1)
format date_dec_`i' % td
replace date_end_n = mofd(date_dec_`i') + 108 if pension_year == `x'
}


forval i = 0/830 {
gen dum_`i' = 0
replace dum_`i' = 1 if `i' >= date_begin_n & `i' <= date_end_n 
}


forval i = 0/830 {
bysort nomem_encr (spell): gen duration_dummy_`i' = 1 if sum(dum_`i') >= 1
}
egen duration = rowtotal(duration_dummy*)
label variable duration "Total duration in month"
tab duration, m



*******************************************************************************
*cutoff retired - cut of end variables for retired that retired before enddate
*******************************************************************************
foreach x of num 2010/2019 {
local i  = (`x' - 1)
format date_dec_`i' % td
gen date_dec2_`i'=mofd(date_dec_`i')
format date_dec2_`i' %tm
}

*values for enddate
foreach x of num 2010/2019 {
local i  = (`x' - 1)
replace var9_end = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != . // for intensity
replace var10_end_a = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_b = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_c = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_d = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_e = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_f = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_g = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_h = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_i = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
}

***************************
*age at first caregiving

*variable on age at transition into caregiving
gen begin_year = year(beginep)
gen var_age_start_ep = begin_year - gebjaar
tab var_age_start_ep
label variable var_age_start_ep "age at begining of episode"
tab var_age_start_ep, m 
***************************************************************
*age at first transition
bysort nomem_encr: egen var_agefirstspell = min(var_age_start_ep)
tab var_agefirstspell
label variable var_agefirstspell "Age at first episode"

*****************
*life stages
tab var_agefirstspell
gen lifestage = .
replace lifestage = 1 if var_agefirstspell <= 17
replace lifestage = 2 if (var_agefirstspell >= 18 & var_agefirstspell <= 27)
replace lifestage = 3 if var_agefirstspell >= 28 & var_agefirstspell <= 37
replace lifestage = 4 if var_agefirstspell >= 38 & var_agefirstspell <= 47
replace lifestage = 5 if var_agefirstspell >= 48 & var_agefirstspell <= 57
replace lifestage = 6 if var_agefirstspell >= 58

tab var_agefirstspell lifestage, m 


label variable lifestage "Life stages"
label define lifestage 1 "5 to 17" 2 "18 to 27" 3 "28 to 37" 4 "38 to 47" 5 "48 to 57" 6 "58 and older"
label values lifestage lifestage
tab lifestage
 
*frequency
bysort nomem_encr: gen aantal_episode = _N
label variable aantal_episode "Frequency"
tab aantal_episode, m

tab v1_aantal if v1_aantal > 7 & episode == 1 // how many people had more than seven epsiodes

***************************
*squared frequency
gen squ_frequency = aantal_episode*aantal_episode
label variable squ_frequency "Squared frequency"
tab squ_frequency, m

**************************
*wage difference
**************************
tab wagedif,m
sum wagedif


**************************
* intensity
**************************
tab var9_begin, m
*take highest intensity of each episode
gen int_epi = var9_begin
replace int_epi = var9_end if (var9_begin < var9_end & var9_begin == .)
tab int_epi, m

*create helper indicating how many intensity meassures are there
gen int_help = 0
replace int_help = 1 if int_epi != .
tab int_help, m
bysort id: egen in_help_id =  total(int_help)
tab in_help_id

*create intensity variable by summing up the intensity in each person divided by how many meassures
bysort id: egen intensity = total(int_epi) 
replace intensity = intensity / in_help_id
tab intensity, m

label variable intensity "Intensity"
tab intensity, m

*************************
*different types of tasks
*************************
*a
gen var10_a_ind = 0
replace var10_a_ind = 1 if var10_begin_a == 1 | var10_end_a == 1

*b
gen var10_b_ind = 0
replace var10_b_ind = 1 if var10_begin_b == 1 | var10_end_b == 1

*c
gen var10_c_ind = 0
replace var10_c_ind = 1 if var10_begin_c == 1 | var10_end_c == 1

*d
gen var10_d_ind = 0
replace var10_d_ind = 1 if var10_begin_d == 1 | var10_end_d == 1

*e
gen var10_e_ind = 0
replace var10_e_ind = 1 if var10_begin_e == 1 | var10_end_e == 1


*f
gen var10_f_ind = 0
replace var10_f_ind = 1 if var10_begin_f == 1 | var10_end_f == 1


*g
gen var10_g_ind = 0
replace var10_g_ind = 1 if var10_begin_g == 1 | var10_end_g == 1

*h
gen var10_h_ind = 0
replace var10_h_ind = 1 if var10_begin_h == 1 | var10_end_h == 1


*i
gen var10_i_ind = 0
replace var10_i_ind = 1 if var10_begin_i == 1 | var10_end_i == 1

*tasks per episode
gen tasks_epi = var10_a_ind + var10_b_ind + var10_c_ind + var10_d_ind + var10_e_ind + var10_f_ind + var10_g_ind + var10_h_ind + var10_i_ind
tab tasks_epi, m



*create helper indicating how many tasks meassures are there
gen task_help = 0
replace task_help = 1 if tasks_epi >= 1 
tab task_help, m
bysort id: egen task_help_id =  total(task_help)
tab task_help_id


*caculate average of tasks 
bysort id: egen var_tasks = total(tasks_epi) 
replace var_tasks = var_tasks / task_help_id
tab var_tasks, m


label variable var_tasks "Number of tasks"

drop var10_a* var10_b* var10_c* var10_d* var10_e* var10_f* var10_g* var10_h* var10_i*  
*************************
*relationship
*************************
*ever cared for yes no dummies: close family (partner, parents, children), other family, non-family
*partner (var3 == 1)
gen rel_clfam_ind = 1 if var3 == 1  | var3 == 2 | var3 == 5 
bysort nomem_encr (spell): egen rel_clfam_sum = sum(rel_clfam_ind)
bysort nomem_encr (spell): egen rel_clfam_max_sum = max(rel_clfam_sum)
bysort nomem_encr (spell): gen var_rel_clfam = 1 if rel_clfam_max_sum >= 1
replace var_rel_clfam = 0 if var_rel_clfam == .
tab var_rel_clfam, m
label variable var_rel_clfam "Close family"


*family (var 3 == 3 4 6 7 8 9)
gen rel_fam_ind = 1 if var3 == 3 | var3 == 4 | var3 == 6 | var3 == 7 | var3 == 8 | var3 == 9 
bysort nomem_encr (spell): egen rel_fam_sum = sum(rel_fam_ind)
bysort nomem_encr (spell): egen rel_fam_max_sum = max(rel_fam_sum)
bysort nomem_encr (spell): gen var_rel_fam = 1 if rel_fam_max_sum >= 1
replace var_rel_fam = 0 if var_rel_fam == .
tab var_rel_fam, m
label variable var_rel_fam "Other family"

*non-family (var 3 == 10 11 )
gen rel_nofam_ind = 1 if var3 == 10 | var3 == 11 
bysort nomem_encr (spell): egen rel_nofam_sum = sum(rel_nofam_ind)
bysort nomem_encr (spell): egen rel_nofam_max_sum = max(rel_nofam_sum)
bysort nomem_encr (spell): gen var_rel_nofam = 1 if rel_nofam_max_sum >= 1
replace var_rel_nofam = 0 if var_rel_nofam == .
tab var_rel_nofam, m
label variable var_rel_nofam "No family"

drop *_ind *_sum *_max_sum

************************
*duty
************************
*obligation
tab var17_n
gen var17_n_dum = 1 if var17_n == 4 | var17_n == 5
bysort nomem_encr (spell): gen var_obligation = 1 if sum(var17_n_dum) >= 1
replace var_obligation = 0 if var_obli == . 
tab var_obligation, m
label variable var_obligation "Obligation"


************************
*make it cross-sectional
************************
tab episode
keep if episode == 1
tab episode

***********************
*keep only nessecary variables
************************

keep wagedif var_obligation var_rel_nofam var_rel_fam var_rel_clfam var_tasks  ///
intensity aantal_episode duration id nomem_encr episode geslacht  ///
var_agefirstspell leeftijd squ_frequency belbezig lifestage mis_imp


 
***********************
*save data set
***********************
*listwise deletion
*drop miss
egen miss=rowmiss(wagedif var_obligation var_rel_nofam var_rel_fam var_rel_clfam var_tasks  ///
intensity aantal_episode duration id nomem_encr episode geslacht   ///
var_agefirstspell leeftijd  squ_frequency)
tab miss

keep if miss == 0

tab episode 


*save data set
save "paper2_after_data_prep_matching_to_5.dta", replace


******************************************
*without self-employed
*****************************************
use "Mantelzorg_long_life_course_with_wagedif_withoutself.dta", clear



*******************
*id

gen id = nomem_encr

*******************************************************************************
*cutoff 2020
*******************************************************************************
tab episode
tab beginep, m
gen beginep_month = mofd(beginep) 
tab episode if beginep_month < 720
keep if beginep_month < 720
tab episode

*exclude if var3 is missing
drop if var3 == 13
drop episode
bysort nomem_encr: gen episode = _n //episode number updated after deleting
tab episode

*************************
*duration

*Helper for december 2020
gen date_dec = date("31dec2020" , "DMY")
format date_dec % td
gen date_dec2=mofd(date_dec)
format date_dec2 %tm

*Helper for december 2018
gen date_dec_2018 = date("31dec2018" , "DMY")


*Helper for december 2017
gen date_dec_2017 = date("31dec2017" , "DMY")


*Helper for december 2016
gen date_dec_2016 = date("31dec2016" , "DMY")


*Helper for december 2015
gen date_dec_2015 = date("31dec2015" , "DMY")


*Helper for december 2014
gen date_dec_2014 = date("31dec2014" , "DMY")


*Helper for december 2013
gen date_dec_2013 = date("31dec2013" , "DMY")


*Helper for december 2012
gen date_dec_2012 = date("31dec2012" , "DMY")

*Helper for december 2011
gen date_dec_2011 = date("31dec2011" , "DMY")


*Helper for december 2010
gen date_dec_2010 = date("31dec2010" , "DMY")

*Helper for december 2009
gen date_dec_2009 = date("31dec2009" , "DMY")


*calculate total duration not considering overlap overlap
gen date_begin_n =mofd(beginep) +108
tab date_begin_n

gen date_end_n =mofd(endep) + 108
tab date_end_n

gen date_march = date("31mar2020" , "DMY")
format date_march % td
gen date_march2=mofd(date_march)
format date_march2 %tm

replace date_end_n = mofd(date_march) + 108 if endep == .
tab date_end_n

foreach x of num 2010/2019 {
local i  = (`x' - 1)
format date_dec_`i' % td
replace date_end_n = mofd(date_dec_`i') + 108 if pension_year == `x'
}


forval i = 0/830 {
gen dum_`i' = 0
replace dum_`i' = 1 if `i' >= date_begin_n & `i' <= date_end_n 
}


forval i = 0/830 {
bysort nomem_encr (spell): gen duration_dummy_`i' = 1 if sum(dum_`i') >= 1
}
egen duration = rowtotal(duration_dummy*)
label variable duration "Total duration in month"
tab duration, m



*******************************************************************************
*cutoff retired - cut of end variables for retired that retired before enddate
*******************************************************************************
foreach x of num 2010/2019 {
local i  = (`x' - 1)
format date_dec_`i' % td
gen date_dec2_`i'=mofd(date_dec_`i')
format date_dec2_`i' %tm
}

*values for enddate
foreach x of num 2010/2019 {
local i  = (`x' - 1)
replace var9_end = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != . // for intensity
replace var10_end_a = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_b = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_c = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_d = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_e = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_f = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_g = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_h = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_i = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
}

***************************
*age at first caregiving

*variable on age at transition into caregiving
gen begin_year = year(beginep)
gen var_age_start_ep = begin_year - gebjaar
tab var_age_start_ep
label variable var_age_start_ep "age at begining of episode"
tab var_age_start_ep, m 
***************************************************************
*age at first transition
bysort nomem_encr: egen var_agefirstspell = min(var_age_start_ep)
tab var_agefirstspell
label variable var_agefirstspell "Age at first episode"

*****************
*life stages
tab var_agefirstspell
gen lifestage = .
replace lifestage = 1 if var_agefirstspell <= 17
replace lifestage = 2 if (var_agefirstspell >= 18 & var_agefirstspell <= 27)
replace lifestage = 3 if var_agefirstspell >= 28 & var_agefirstspell <= 37
replace lifestage = 4 if var_agefirstspell >= 38 & var_agefirstspell <= 47
replace lifestage = 5 if var_agefirstspell >= 48 & var_agefirstspell <= 57
replace lifestage = 6 if var_agefirstspell >= 58

tab var_agefirstspell lifestage, m 


label variable lifestage "Life stages"
label define lifestage 1 "5 to 17" 2 "18 to 27" 3 "28 to 37" 4 "38 to 47" 5 "48 to 57" 6 "58 and older"
label values lifestage lifestage
tab lifestage
 
*frequency
bysort nomem_encr: gen aantal_episode = _N
label variable aantal_episode "Frequency"
tab aantal_episode, m

tab v1_aantal if v1_aantal > 7 & episode == 1 // how many people had more than seven epsiodes

***************************
*squared frequency
gen squ_frequency = aantal_episode*aantal_episode
label variable squ_frequency "Squared frequency"
tab squ_frequency, m

**************************
*wage difference
**************************
tab wagedif,m
sum wagedif


**************************
* intensity
**************************
tab var9_begin, m
*take highest intensity of each episode
gen int_epi = var9_begin
replace int_epi = var9_end if (var9_begin < var9_end & var9_begin == .)
tab int_epi, m

*create helper indicating how many intensity meassures are there
gen int_help = 0
replace int_help = 1 if int_epi != .
tab int_help, m
bysort id: egen in_help_id =  total(int_help)
tab in_help_id

*create intensity variable by summing up the intensity in each person divided by how many meassures
bysort id: egen intensity = total(int_epi) 
replace intensity = intensity / in_help_id
tab intensity, m

label variable intensity "Intensity"
tab intensity, m

*************************
*different types of tasks
*************************
*a
gen var10_a_ind = 0
replace var10_a_ind = 1 if var10_begin_a == 1 | var10_end_a == 1

*b
gen var10_b_ind = 0
replace var10_b_ind = 1 if var10_begin_b == 1 | var10_end_b == 1

*c
gen var10_c_ind = 0
replace var10_c_ind = 1 if var10_begin_c == 1 | var10_end_c == 1

*d
gen var10_d_ind = 0
replace var10_d_ind = 1 if var10_begin_d == 1 | var10_end_d == 1

*e
gen var10_e_ind = 0
replace var10_e_ind = 1 if var10_begin_e == 1 | var10_end_e == 1


*f
gen var10_f_ind = 0
replace var10_f_ind = 1 if var10_begin_f == 1 | var10_end_f == 1


*g
gen var10_g_ind = 0
replace var10_g_ind = 1 if var10_begin_g == 1 | var10_end_g == 1

*h
gen var10_h_ind = 0
replace var10_h_ind = 1 if var10_begin_h == 1 | var10_end_h == 1


*i
gen var10_i_ind = 0
replace var10_i_ind = 1 if var10_begin_i == 1 | var10_end_i == 1

*tasks per episode
gen tasks_epi = var10_a_ind + var10_b_ind + var10_c_ind + var10_d_ind + var10_e_ind + var10_f_ind + var10_g_ind + var10_h_ind + var10_i_ind
tab tasks_epi, m



*create helper indicating how many tasks meassures are there
gen task_help = 0
replace task_help = 1 if tasks_epi >= 1 
tab task_help, m
bysort id: egen task_help_id =  total(task_help)
tab task_help_id


*caculate average of tasks 
bysort id: egen var_tasks = total(tasks_epi) 
replace var_tasks = var_tasks / task_help_id
tab var_tasks, m


label variable var_tasks "Number of tasks"

drop var10_a* var10_b* var10_c* var10_d* var10_e* var10_f* var10_g* var10_h* var10_i*  
*************************
*relationship
*************************
*ever cared for yes no dummies: close family (partner, parents, children), other family, non-family
*partner (var3 == 1)
gen rel_clfam_ind = 1 if var3 == 1  | var3 == 2 | var3 == 5 
bysort nomem_encr (spell): egen rel_clfam_sum = sum(rel_clfam_ind)
bysort nomem_encr (spell): egen rel_clfam_max_sum = max(rel_clfam_sum)
bysort nomem_encr (spell): gen var_rel_clfam = 1 if rel_clfam_max_sum >= 1
replace var_rel_clfam = 0 if var_rel_clfam == .
tab var_rel_clfam, m
label variable var_rel_clfam "Close family"


*family (var 3 == 3 4 6 7 8 9)
gen rel_fam_ind = 1 if var3 == 3 | var3 == 4 | var3 == 6 | var3 == 7 | var3 == 8 | var3 == 9 
bysort nomem_encr (spell): egen rel_fam_sum = sum(rel_fam_ind)
bysort nomem_encr (spell): egen rel_fam_max_sum = max(rel_fam_sum)
bysort nomem_encr (spell): gen var_rel_fam = 1 if rel_fam_max_sum >= 1
replace var_rel_fam = 0 if var_rel_fam == .
tab var_rel_fam, m
label variable var_rel_fam "Other family"

*non-family (var 3 == 10 11 )
gen rel_nofam_ind = 1 if var3 == 10 | var3 == 11 
bysort nomem_encr (spell): egen rel_nofam_sum = sum(rel_nofam_ind)
bysort nomem_encr (spell): egen rel_nofam_max_sum = max(rel_nofam_sum)
bysort nomem_encr (spell): gen var_rel_nofam = 1 if rel_nofam_max_sum >= 1
replace var_rel_nofam = 0 if var_rel_nofam == .
tab var_rel_nofam, m
label variable var_rel_nofam "No family"

drop *_ind *_sum *_max_sum

************************
*duty
************************
*obligation
tab var17_n
gen var17_n_dum = 1 if var17_n == 4 | var17_n == 5
bysort nomem_encr (spell): gen var_obligation = 1 if sum(var17_n_dum) >= 1
replace var_obligation = 0 if var_obli == . 
tab var_obligation, m
label variable var_obligation "Obligation"


************************
*make it cross-sectional
************************
tab episode
keep if episode == 1
tab episode

***********************
*keep only nessecary variables
************************

keep wagedif var_obligation var_rel_nofam var_rel_fam var_rel_clfam var_tasks  ///
intensity aantal_episode duration id nomem_encr episode geslacht  ///
var_agefirstspell leeftijd squ_frequency belbezig lifestage mis_imp 


 
***********************
*save data set
***********************
*listwise deletion
*drop miss
tab intensity, m
egen miss=rowmiss(wagedif var_obligation var_rel_nofam var_rel_fam var_rel_clfam var_tasks  ///
intensity aantal_episode duration id nomem_encr episode geslacht   ///
var_agefirstspell leeftijd  squ_frequency)
tab miss

keep if miss == 0

tab episode 

*save data set
save "paper2_after_data_prep_withoutself.dta", replace

*********************************
********************************
*with minimum wagedif
********************************
*********************************
use "Mantelzorg_long_life_course_with_wagedif_minwage.dta", clear



*******************
*id

gen id = nomem_encr

*******************************************************************************
*cutoff 2020
*******************************************************************************
tab episode
tab beginep, m
gen beginep_month = mofd(beginep) 
tab episode if beginep_month < 720
keep if beginep_month < 720
tab episode

*exclude if var3 is missing
drop if var3 == 13
drop episode
bysort nomem_encr: gen episode = _n //episode number updated after deleting
tab episode

*************************
*duration

*Helper for december 2020
gen date_dec = date("31dec2020" , "DMY")
format date_dec % td
gen date_dec2=mofd(date_dec)
format date_dec2 %tm

*Helper for december 2018
gen date_dec_2018 = date("31dec2018" , "DMY")


*Helper for december 2017
gen date_dec_2017 = date("31dec2017" , "DMY")


*Helper for december 2016
gen date_dec_2016 = date("31dec2016" , "DMY")


*Helper for december 2015
gen date_dec_2015 = date("31dec2015" , "DMY")


*Helper for december 2014
gen date_dec_2014 = date("31dec2014" , "DMY")


*Helper for december 2013
gen date_dec_2013 = date("31dec2013" , "DMY")


*Helper for december 2012
gen date_dec_2012 = date("31dec2012" , "DMY")

*Helper for december 2011
gen date_dec_2011 = date("31dec2011" , "DMY")


*Helper for december 2010
gen date_dec_2010 = date("31dec2010" , "DMY")

*Helper for december 2009
gen date_dec_2009 = date("31dec2009" , "DMY")


*calculate total duration not considering overlap overlap
gen date_begin_n =mofd(beginep) +108
tab date_begin_n

gen date_end_n =mofd(endep) + 108
tab date_end_n

gen date_march = date("31mar2020" , "DMY")
format date_march % td
gen date_march2=mofd(date_march)
format date_march2 %tm

replace date_end_n = mofd(date_march) + 108 if endep == .
tab date_end_n

foreach x of num 2010/2019 {
local i  = (`x' - 1)
format date_dec_`i' % td
replace date_end_n = mofd(date_dec_`i') + 108 if pension_year == `x'
}


forval i = 0/830 {
gen dum_`i' = 0
replace dum_`i' = 1 if `i' >= date_begin_n & `i' <= date_end_n 
}


forval i = 0/830 {
bysort nomem_encr (spell): gen duration_dummy_`i' = 1 if sum(dum_`i') >= 1
}
egen duration = rowtotal(duration_dummy*)
label variable duration "Total duration in month"
tab duration, m



*******************************************************************************
*cutoff retired - cut of end variables for retired that retired before enddate
*******************************************************************************
foreach x of num 2010/2019 {
local i  = (`x' - 1)
format date_dec_`i' % td
gen date_dec2_`i'=mofd(date_dec_`i')
format date_dec2_`i' %tm
}

*values for enddate
foreach x of num 2010/2019 {
local i  = (`x' - 1)
replace var9_end = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != . // for intensity
replace var10_end_a = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_b = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_c = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_d = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_e = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_f = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_g = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_h = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
replace var10_end_i = . if  pension_year == `x' &  date_end > date_dec2_`i'  & date_end != .
}

***************************
*age at first caregiving

*variable on age at transition into caregiving
gen begin_year = year(beginep)
gen var_age_start_ep = begin_year - gebjaar
tab var_age_start_ep
label variable var_age_start_ep "age at begining of episode"
tab var_age_start_ep, m 
***************************************************************
*age at first transition
bysort nomem_encr: egen var_agefirstspell = min(var_age_start_ep)
tab var_agefirstspell
label variable var_agefirstspell "Age at first episode"

*****************
*life stages
tab var_agefirstspell
gen lifestage = .
replace lifestage = 1 if var_agefirstspell <= 17
replace lifestage = 2 if (var_agefirstspell >= 18 & var_agefirstspell <= 27)
replace lifestage = 3 if var_agefirstspell >= 28 & var_agefirstspell <= 37
replace lifestage = 4 if var_agefirstspell >= 38 & var_agefirstspell <= 47
replace lifestage = 5 if var_agefirstspell >= 48 & var_agefirstspell <= 57
replace lifestage = 6 if var_agefirstspell >= 58

tab var_agefirstspell lifestage, m 


label variable lifestage "Life stages"
label define lifestage 1 "5 to 17" 2 "18 to 27" 3 "28 to 37" 4 "38 to 47" 5 "48 to 57" 6 "58 and older"
label values lifestage lifestage
tab lifestage
 

************************************************
*frequency
bysort nomem_encr: gen aantal_episode = _N
label variable aantal_episode "Frequency"
tab aantal_episode, m

tab v1_aantal if v1_aantal > 7 & episode == 1 // how many people had more than seven epsiodes

***************************
*squared frequency
gen squ_frequency = aantal_episode*aantal_episode
label variable squ_frequency "Squared frequency"
tab squ_frequency, m


**************************
*wage difference
**************************
tab wagedif,m
sum wagedif

**************************
* intensity
**************************
tab var9_begin, m
*take highest intensity of each episode
gen int_epi = var9_begin
replace int_epi = var9_end if (var9_begin < var9_end & var9_begin == .)
tab int_epi, m

*create helper indicating how many intensity meassures are there
gen int_help = 0
replace int_help = 1 if int_epi != .
tab int_help, m
bysort id: egen in_help_id =  total(int_help)
tab in_help_id

*create intensity variable by summing up the intensity in each person divided by how many meassures
bysort id: egen intensity = total(int_epi) 
replace intensity = intensity / in_help_id
tab intensity, m

label variable intensity "Intensity"
tab intensity, m

*************************
*different types of tasks
*************************
*a
gen var10_a_ind = 0
replace var10_a_ind = 1 if var10_begin_a == 1 | var10_end_a == 1

*b
gen var10_b_ind = 0
replace var10_b_ind = 1 if var10_begin_b == 1 | var10_end_b == 1

*c
gen var10_c_ind = 0
replace var10_c_ind = 1 if var10_begin_c == 1 | var10_end_c == 1

*d
gen var10_d_ind = 0
replace var10_d_ind = 1 if var10_begin_d == 1 | var10_end_d == 1

*e
gen var10_e_ind = 0
replace var10_e_ind = 1 if var10_begin_e == 1 | var10_end_e == 1


*f
gen var10_f_ind = 0
replace var10_f_ind = 1 if var10_begin_f == 1 | var10_end_f == 1


*g
gen var10_g_ind = 0
replace var10_g_ind = 1 if var10_begin_g == 1 | var10_end_g == 1

*h
gen var10_h_ind = 0
replace var10_h_ind = 1 if var10_begin_h == 1 | var10_end_h == 1


*i
gen var10_i_ind = 0
replace var10_i_ind = 1 if var10_begin_i == 1 | var10_end_i == 1

*tasks per episode
gen tasks_epi = var10_a_ind + var10_b_ind + var10_c_ind + var10_d_ind + var10_e_ind + var10_f_ind + var10_g_ind + var10_h_ind + var10_i_ind
tab tasks_epi, m



*create helper indicating how many tasks meassures are there
gen task_help = 0
replace task_help = 1 if tasks_epi >= 1 
tab task_help, m
bysort id: egen task_help_id =  total(task_help)
tab task_help_id


*caculate average of tasks 
bysort id: egen var_tasks = total(tasks_epi) 
replace var_tasks = var_tasks / task_help_id
tab var_tasks, m


label variable var_tasks "Number of tasks"

drop var10_a* var10_b* var10_c* var10_d* var10_e* var10_f* var10_g* var10_h* var10_i*  

*************************
*relationship
*************************
*ever cared for yes no dummies: close family (partner, parents, children), other family, non-family
*partner (var3 == 1)

gen rel_clfam_ind = 1 if var3 == 1  | var3 == 2 | var3 == 5 
bysort nomem_encr (spell): egen rel_clfam_sum = sum(rel_clfam_ind)
bysort nomem_encr (spell): egen rel_clfam_max_sum = max(rel_clfam_sum)
bysort nomem_encr (spell): gen var_rel_clfam = 1 if rel_clfam_max_sum >= 1
replace var_rel_clfam = 0 if var_rel_clfam == .
tab var_rel_clfam, m
label variable var_rel_clfam "Close family"


*family (var 3 == 3 4 6 7 8 9)
gen rel_fam_ind = 1 if var3 == 3 | var3 == 4 | var3 == 6 | var3 == 7 | var3 == 8 | var3 == 9 
bysort nomem_encr (spell): egen rel_fam_sum = sum(rel_fam_ind)
bysort nomem_encr (spell): egen rel_fam_max_sum = max(rel_fam_sum)
bysort nomem_encr (spell): gen var_rel_fam = 1 if rel_fam_max_sum >= 1
replace var_rel_fam = 0 if var_rel_fam == .
tab var_rel_fam, m
label variable var_rel_fam "Other family"

*non-family (var 3 == 10 11 )
gen rel_nofam_ind = 1 if var3 == 10 | var3 == 11 
bysort nomem_encr (spell): egen rel_nofam_sum = sum(rel_nofam_ind)
bysort nomem_encr (spell): egen rel_nofam_max_sum = max(rel_nofam_sum)
bysort nomem_encr (spell): gen var_rel_nofam = 1 if rel_nofam_max_sum >= 1
replace var_rel_nofam = 0 if var_rel_nofam == .
tab var_rel_nofam, m
label variable var_rel_nofam "No family"

drop *_ind *_sum *_max_sum

************************
*duty
************************
*obligation
tab var17_n
gen var17_n_dum = 1 if var17_n == 4 | var17_n == 5
bysort nomem_encr (spell): gen var_obligation = 1 if sum(var17_n_dum) >= 1
replace var_obligation = 0 if var_obli == . 
tab var_obligation, m
label variable var_obligation "Obligation"


************************
*make it cross-sectional
************************
tab episode
keep if episode == 1
tab episode

***********************
*keep only nessecary variables
************************

keep wagedif var_obligation var_rel_nofam var_rel_fam var_rel_clfam var_tasks  ///
intensity aantal_episode duration id nomem_encr episode geslacht  ///
var_agefirstspell leeftijd squ_frequency belbezig  lifestage mis_imp


 
***********************
*save data set
***********************
*listwise deletion
*drop miss
egen miss=rowmiss(wagedif var_obligation var_rel_nofam var_rel_fam var_rel_clfam var_tasks  ///
intensity aantal_episode duration id nomem_encr episode geslacht   ///
var_agefirstspell leeftijd  squ_frequency)
tab miss

keep if miss == 0

tab episode 


*save data set
save "paper2_after_data_prep_minwage.dta", replace

*******************************************************************************
*
* PART 4: Main analysis
*
********************************************************************************

use "paper2_after_data_prep.dta", clear

************************************************************************
*Descriptives
*********************************************************************

**check if normal distributed by plotting - FIGURE 1
sum wagedif

tab1 wagedif geslacht

recode geslacht (1 = 0 "Men") (2 = 1 "Women"), gen(sex)
label variable sex "Sex"

twoway histogram wagedif, percent by(sex, title() note("")) xaxis(1 2) width(10) color(gray) scheme(s1mono)  ///
xlabel(-150 "caregivers earn less" 350 "caregivers earn more", axis(2)) xtitle("Informal care wage penalty")
graph export P2_histrgram_distribution.png, replace



*test normal distribution
swilk wagedif


*descriptive plots


*age at first caregiving
*for text
sum var_agefirstspell //overall mean
bysort sex: sum var_agefirstspell, d // mean and median by sex 


*calculate mean
egen mean_firstage = mean(wagedif), by(lifestage) 
tab mean_firstage
*plot
scatter mean_firstage lifestage, mstyle(p1) scheme(s1mono) ylabel(-50[25]50) ///
xlabel(1 "5-17" 2 "18-27" 3 "28-37" 4 "38-47" 5 "48-57" 6 "58+") yline(0) legend(off) ///
ytitle(Mean wage difference) aspect(0.7) xtitle(Age at first caregiving) saving(agefirst_gr, replace) ///
graphregion(color(white)) fxsize(100) xsize(7) 


*duration
*categorize variable
egen duration_cut = cut(duration), at(1,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800)
tab duration_cut
*calculate mean
egen mean_duration = mean(wagedif), by(duration_cut)
tab  mean_duration duration_cut
*plot
scatter mean_duration duration_cut, mstyle(p1) scheme(s1mono) ylabel(-50[25]50) xlabel(0[100]700) ///
yline(0) legend(off) ytitle(Mean wage difference) aspect(0.7) xtitle(Caregiving duration in months) ///
saving(duration_gr, replace) graphregion(color(white)) fxsize(100) xsize(7)


*frequency
*calculate mean
tab aantal_episode
egen mean_aantal_episode = mean(wagedif), by(aantal_episode) 
*plot
scatter mean_aantal_episode aantal_episode, mstyle(p1) scheme(s1mono) ylabel(-50[25]50) ///
xlabel(1[1]7) yline(0) legend(off) aspect(0.7)  ytitle(Mean wage difference) ///
xtitle(Number of caregiving episodes) saving(frequ_gr, replace) graphregion(color(white))  fxsize(60)

**combining graphs - FIGURE 2
graph combine agefirst_gr.gph duration_gr.gph,  name(row1, replace) graphregion(color(white))  iscale(1) graphr(margin(zero))
graph combine row1 frequ_gr.gph, cols(1) graphregion(color(white)) 
graph export descriptive_fig_p2.png,  replace

*corretlation between independent variables
pwcorr  var_agefirstspell duration aantal_episode, sig




**************************************************************
*descriptives wage gap
*************************************************************
sum wagedif
bysort geslacht: sum(wagedif), d 
bysort geslacht: sum(wagedif)

*******
bysort geslacht: sum(var_agefirstspell), d 
bysort geslacht: tab var_agefirstspell 


*******
bysort geslacht: sum(duration), d 

*******
bysort geslacht: sum(aantal_episode), d 


*descriptive table for women - TABLE 1
asdoc sum wagedif  duration aantal_episode var_tasks intensity ///
if geslacht == 2, dec(2) save(P2_descriptives_wom.doc) replace
asdoc tab1 var_rel_clfam var_rel_fam var_rel_nofam var_obligation lifestage ///
if geslacht == 2, dec(6) save(P2_descriptives_wom.doc) append

*descriptive table for men -  TABLE 1
asdoc sum wagedif duration aantal_episode var_tasks intensity ///
if geslacht == 1, dec(2) save(P2_descriptives_men.doc) replace
asdoc tab1 var_rel_clfam var_rel_fam var_rel_nofam var_obligation lifestage ///
if geslacht == 1, dec(4) save(P2_descriptives_men.doc) append


**********************
*POOLED - TABLE 2
*********************
*****************
*life stages
*bivariate
regress wagedif ib2.lifestage 
*multivariate
regress wagedif ib2.lifestage var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht
outreg2 using ${data}P2_regressions, word dec(2) alpha (0.001, 0.01, 0.05) ctitle(Model 1) /// 
sortvar(lifestage aantal_episode duration var_rel_clfam var_rel_fam var_rel_nofam var_obligation var_tasks intensity)  label replace


*******************
*Duration
*******************
*bivariate
regress wagedif duration
*mutlivariate
regress wagedif duration var_obligation var_rel_nofam var_rel_fam var_rel_clfam var_tasks  ///
intensity geslacht
outreg2 using ${data}P2_regressions, word dec(2) alpha (0.001, 0.01, 0.05) ctitle(Model 2) /// 
sortvar(lifestage aantal_episode duration var_rel_clfam var_rel_fam var_rel_nofam var_obligation var_tasks intensity)  label append


*******************
*Frequency
*******************
*bivariate
regress wagedif aantal_episode squ_frequency 
*multivariate
regress wagedif aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam var_rel_clfam var_tasks  ///
intensity geslacht
outreg2 using ${data}P2_regressions, word dec(2) alpha (0.001, 0.01, 0.05) ctitle(Model 3) /// 
sortvar(lifestage aantal_episode duration var_rel_clfam var_rel_fam var_rel_nofam var_obligation var_tasks intensity)  label append

*******************
*All in one
***************
*bivariate
regress wagedif ib2.lifestage duration aantal_episode squ_frequency
*mutlivariate
regress wagedif ib2.lifestage duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht
outreg2 using ${data}P2_regressions, word dec(2) alpha (0.001, 0.01, 0.05) ctitle(Model 4) /// 
sortvar(lifestage aantal_episode duration var_rel_clfam var_rel_fam var_rel_nofam var_obligation var_tasks intensity)  label append  

*other reference category - does not make a difference
regress wagedif ib1.lifestage duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht

regress wagedif ib3.lifestage duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht

regress wagedif ib4.lifestage duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht

regress wagedif ib5.lifestage duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht

regress wagedif ib6.lifestage duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht

	

*************************
*Graphs
**********************
*duration - FIGURE 3
regress wagedif ib2.lifestage duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht

margins, at(duration = (1(10)742))
marginsplot, yline(0) recast(line) plot1opts(lcolor(gs8)) ciopt(color(black%20)) recastci(rarea) title("") ///
ytitle ("Informal care wage penalty") xtitle("Duration of caregiving in months") scheme(s1mono) xlabel(0(100)750)
graph export prediction_duration.png, replace

tab duration

*frequency - FIGURE 3
regress wagedif ib2.lifestage duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht

margins, at(aantal_episode = (1(1)7))
marginsplot, yline(0) recast(line) plot1opts(lcolor(gs8)) ciopt(color(black%20)) recastci(rarea) title("") ytitle ("Informal care wage penalty") xtitle("Number of caregiving episodes") scheme(s1mono) 
graph export prediction_frequency.png, replace

 
*********************
*WOMEN
*********************

regress wagedif ib2.lifestage  duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks  ///
intensity if geslacht == 2
outreg2 using ${data}P2_regressions, word dec(2) alpha (0.001, 0.01, 0.05) ctitle(Model 4a - women) /// 
sortvar(lifestage  duration aantal_episode squ_frequency var_rel_clfam var_rel_fam var_rel_nofam var_obligation var_tasks intensity) label  


**************************
*MEN
**************************

regress wagedif ib2.lifestage  duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks  ///
intensity if geslacht == 1
outreg2 using ${data}P2_regressions, word dec(2) alpha (0.001, 0.01, 0.05) ctitle(Model 4b - men) /// 
sortvar(lifestage duration aantal_episode squ_frequency var_rel_clfam var_rel_fam var_rel_nofam var_obligation var_tasks intensity) label  


***************************
*SEX DIFFERENCE
***************************

regress wagedif ib2.lifestage   c.duration##geslacht aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity 


*******************************************************************************
*
* PART 5: Robustness checks 
*
********************************************************************************


use "paper2_after_data_prep.dta", clear



******************************************
*top/bottom-code outliers - wagedif 200
******************************************

tab wagedif

gen wagedif_out = wagedif
replace wagedif_out = -200 if wagedif < -200
replace wagedif_out = 200 if wagedif >  200
tab wagedif_out, m

regress wagedif_out ib2.lifestage  duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht 

******************************************
*top/bottom-code outliers - wagedif 50
******************************************

tab wagedif

gen wagedif_out50 = wagedif
replace wagedif_out50 = -50 if wagedif < -50
replace wagedif_out50 = 50 if wagedif >  50
tab wagedif_out50, m

regress wagedif_out50 ib2.lifestage  duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht 

******************************************
*top/bottom-code outliers - duration 500 month
******************************************

tab duration

gen duration_out = duration
replace duration_out = 524 if duration > 524
tab duration_out, m

regress wagedif ib2.lifestage duration_out aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht 

*drop high values
drop if duration > 524
regress wagedif ib2.lifestage duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht 

use "paper2_after_data_prep.dta", clear

******************************************
*top/bottom-code outliers - episodes higher than 1% (6)
******************************************

tab aantal_episode // 7 is less then 1%

gen episode_out = aantal_episode
replace episode_out = 6 if aantal_episode > 6
tab episode_out, m
regress wagedif ib2.lifestage duration episode_out squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht

*drop high values
drop if aantal_episode > 6
regress wagedif ib2.lifestage duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht

use "paper2_after_data_prep.dta", clear

********************************************
*non-linear effect of duration 
********************************************

regress wagedif c.duration##c.duration var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht //

regress wagedif ib2.lifestage c.duration##c.duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht //

******************************************
*matched to 3s
******************************************
use "paper2_after_data_prep_matching_to_3.dta", clear

regress wagedif ib2.lifestage  duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht //


******************************************
*matched to 5
******************************************
use "paper2_after_data_prep_matching_to_5.dta", clear

regress wagedif ib2.lifestage  duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht //

******************************************
*exclude self-employed
******************************************
use "paper2_after_data_prep_withoutself.dta", clear

regress wagedif ib2.lifestage  duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht //
********************************************
*minimum wage
********************************************
use "paper2_after_data_prep_minwage.dta", clear

regress wagedif ib2.lifestage duration aantal_episode squ_frequency var_obligation var_rel_nofam var_rel_fam ///
var_rel_clfam var_tasks intensity geslacht //



