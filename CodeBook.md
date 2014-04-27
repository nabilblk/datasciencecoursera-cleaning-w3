CodeBook
===========

Summary
-----------
run_analysis.R processes mobile sensor data sampled by [1] to provide 561 mean movement indicators according to 30 subjects identified to have an activity among 
 1. WALKING
 2. WALKING_UPSTAIRS
 3. WALKING_DOWNSTAIRS
 4. SITTING
 5. STANDING
 6. LAYING 

Mean movements are processed from data providing 561 features documented in [DATA]/features_info.txt

Output format
-------------

The script exports [DATA]/sensor-mean-vars.txt, that holds the mean value of all observations for a pair {subject,activity} for 561 features.

After executing the script, one may call :

<pre>
head(meanVars[,1:4], n=20)
   subject           activity tBodyAcc-mean()-X tBodyAcc-mean()-Y
1        1             LAYING         0.2215982      -0.040513953
2        1            SITTING         0.2612376      -0.001308288
3        1           STANDING         0.2789176      -0.016137590
4        1            WALKING         0.2773308      -0.017383819
5        1 WALKING_DOWNSTAIRS         0.2891883      -0.009918505
6        1   WALKING_UPSTAIRS         0.2554617      -0.023953149
7        2             LAYING         0.2813734      -0.018158740
8        2            SITTING         0.2770874      -0.015687994
9        2           STANDING         0.2779115      -0.018420827
10       2            WALKING         0.2764266      -0.018594920
</pre>
References
-------------
 * [1] http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 * [DATA] presumed to be the unzipped datasets of [1] in folder ./data/

