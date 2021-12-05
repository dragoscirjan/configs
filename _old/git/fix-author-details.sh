#! /bin/bash

# https://stackoverflow.com/questions/3042437/how-to-change-the-commit-author-for-one-specific-commit/28845565

# LIMIT=1
# BRANCH=master

# git_ammend_author() {
# 	COMMIT=$1
# 	git checkout $COMMIT
# 	git commit --amend --author="Dragos Cirjan <dragos.cirjan@gmail.com>" --no-edit
# 	git checkout $BRANCH
# 	git rebase -i $(git log --pretty=format:"%H %aN %ae" --no-patch | head -n 1 | awk '{print $1}')
# 	# git replace $COMMIT $(git log --pretty=format:"%H %aN %ae" --no-patch | head -n 1 | awk '{print $1}')
# 	# git filter-branch -- --all
# 	# git replace -d $COMMIT
# 	# git push --force-with-lease
# }

# git checkout $BRANCH

# git log --pretty=format:"%H %aN %ae" --no-patch \
# 	| grep -e "[Dd]ragos.[Cc]irjan@" \
# 	| grep -v gmail.com \
# 	| awk '{ print $1 }' \
# 	| head -n $LIMIT \
# 	| while read COMMIT; do \
# 		git_ammend_author $COMMIT \
# 	; done

# https://help.github.com/en/github/using-git/changing-author-info

git filter-branch --env-filter '

CORRECT_NAME="Dragos Cirjan"
CORRECT_EMAIL="dragos.cirjan@gmail.com"

if test $(echo $GIT_COMMITTER_EMAIL | grep -e "[Dd]ragos.[Cc]irjan@" | grep -v gmail.com); then
	export GIT_COMMITTER_NAME="$CORRECT_NAME"
	export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi

if test $(echo $GIT_AUTHOR_EMAIL | grep -e "[Dd]ragos.[Cc]irjan@" | grep -v gmail.com); then
	export GIT_AUTHOR_NAME="$CORRECT_NAME"
	export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi

' --tag-name-filter cat -- --branches --tags

git push --force --tags origin 'refs/heads/*'