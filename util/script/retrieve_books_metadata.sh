#!/bin/bash

# creates the directory books_metadata if it doesn't exist already
mkdir -p books_metadata


for f in $1*
do
	# logging which file is processing
	echo "Processing $f file..."
	
	# removes the directory name from the file name
	filename=${f##*/}
	
	# removes the extension from the file name
	filename_clean=${filename%%.*}

	CURR_FILE=books_metadata/$filename_clean.json

  	# Only unzip if not already unzipped. This check assumes that x.zip unzips to
  	# x.txt, which so far seems to be the case.
 	if [ ! -f "${CURR_FILE}" ] ; then
		# gets the the title and author lines from the file content	
		book_title="`grep 'Title:' $f`"
		book_author="`grep 'Author:' $f`"
	
		# removes the Title: and Author: part
		book_title_clean=${book_title##*Title:}
		book_author_clean=${book_author##*Author: }

		#if it finds the word Complete in it, it removes the last part from the book name
		if [[ $book_title_clean == *"- Complete" ]]
		then
			echo book title clean: $book_title_clean
			book_title_clean=${book_title_clean::-11}
		fi

		# gets title and author to download the json metadata from google
		#title=$(echo $book_title_clean | sed -e 's/[^A-Za-z0-9._-]/ /g')
		#author=$(echo $book_author_clean | sed -e 's/[^A-Za-z0-9._-]/ /g')

		# every character that is not a letter or number or a ._- is converted into a _
		file_name=$(echo $book_title_clean | sed -e 's/[^A-Za-z0-9._-]/_/g')

		file_name=$(echo $file_name | sed -e 's/__/_/g')
	
		# if the last character of the file name is a _ removes it
		if [[ $file_name == *"_" ]]
		then
			echo book title clean: $book_title_clean
			file_name=${file_name::-1}
		fi

		# gets the file name length
		file_name_len=${#file_name}

		if [[ $file_name_len > 255 ]]
		then 
			file_name=$(echo $file_name | cut -c1-100)
		fi

		# removes dots in the file
		file_name_clean=${file_name//./}.json

		sleep $((RANDOM%120+10))

		# downloads the json metadata file from google books api
		wget "https://www.googleapis.com/books/v1/volumes?q=title:$book_title_clean+author:$book_author_clean" -O books_metadata/$file_name_clean

		echo "file: $file_name_clean written"
	else 
		echo "file: $CURR_FILE already exists. Skipping metadata download."
  	fi
done
