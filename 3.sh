# run the authority nodes
$pd --config config/node01.toml -l engine=trace &>log0.txt &
$pd --config config/node11.toml -l engine=trace &>log1.txt &
