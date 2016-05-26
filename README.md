#Hadoop Study Group

This is the repository for the Sopra Steria Hadoop study group.

## WordCount

This is the first attempt to create a WordCount algorithm in MapReduce.

### Prerequisites

To execute the example you will need to include some jar files. You need to download [Hadoop 2.6.4 binary](http://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-2.6.4/hadoop-2.6.4.tar.gz).

You will need all the jars contained into the common folder (3 files), all the jars contained into the hdfs folder (3 files), every jar contained into mapreduce, and every jar contained into mapreduce > lib folder.

### Usage

To use the jar once exported, this is a sample 

1) copy stop file to hdfs 
2) hadoop jar <path jar>/<Jar name> <ClassName> /input/path  output/path

## WordCountAdvanced

### Usage

1) copy stop file to hdfs 
2) hadoop jar <path jar>/<Jar name> <ClassName> /input/path  output/path