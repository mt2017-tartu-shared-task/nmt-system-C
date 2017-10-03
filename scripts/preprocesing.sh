# Code here was not executed from file, but runned one by one in console
# All commands executed from folder /gpfs/hpchome/komisare/project/data/raw-all/

# Concatenate all in-folder corpora to form one big text corpus:
cat raw/*.en > demo-all.en
cat raw/*.et > demo-all.et

# Split corpus into training, dev, and test sets:
paste demo-all.{et,en} | shuf > mixed-data.both
sed -n 1,50000p mixed-data.both | cut -f 1 > test.et
sed -n 1,50000p mixed-data.both | cut -f 2 > test.en
sed -n 50001,100000p mixed-data.both | cut -f 1 > dev.et
sed -n 50001,100000p mixed-data.both | cut -f 2 > dev.en
sed -n 100001,19500000p mixed-data.both | cut -f 1 > train.et
sed -n 100001,19500000p mixed-data.both | cut -f 2 > train.en

# Tokenize all the sets:
for f in {test,dev,train}.{en,et}
do
 /gpfs/hpchome/komisare/demo/OpenNMT-py/tools/tokenizer.perl < $f > tok-$f
done

# True-case all the sets:
/gpfs/hpchome/komisare/demo/OpenNMT-py/tools/train-truecaser.perl --model en-truecase.mdl --corpus tok-train.en
/gpfs/hpchome/komisare/demo/OpenNMT-py/tools/train-truecaser.perl --model et-truecase.mdl --corpus tok-train.et

for lang in en et
do
 for f in {test,dev,train}.$lang
 do
 /gpfs/hpchome/komisare/demo/OpenNMT-py/tools/truecase.perl --model $lang-truecase.mdl < tok-$f > tc-tok-$f
 done
done

# Filter out empty and strange sentence pairs from the training set:
/gpfs/hpchome/komisare/demo/OpenNMT-py/tools/clean-corpus-n.perl tc-tok-train en et cleaned-tctok-train 1 100

# Apple BPE to all the sets:
cat cleaned-tc-tok-train.et cleaned-tc-tok-train.en | /gpfs/hpchome/komisare/demo/OpenNMTpy/tools/subword-nmt/learn_bpe.py s 30000 > eten.bpe

for lang in et en
 do 
 /gpfs/hpchome/komisare/demo/OpenNMTpy/tools/subword-nmt/apply_bpe.py -c eten.bpe < cleaned-tc-toktrain.$lang > bpe.cleaned-tc-tok-train.$lang
 /gpfs/hpchome/komisare/demo/OpenNMTpy/tools/subword-nmt/apply_bpe.py -c eten.bpe < tc-tok-dev.$lang > bpe.tc-tok-dev.$lang
/gpfs/hpchome/komisare/demo/OpenNMTpy/tools/subword-nmt/apply_bpe.py -c eten.bpe < tc-tok-test.$lang > bpe.tc-tok-test.$lang
done
