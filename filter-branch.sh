OLD_EMAIL="jouw-zakelijke-email@klant.com"
NEW_EMAIL="jouw-noreply-email@users.noreply.github.com"

git filter-branch --env-filter '
if [ "$GIT_AUTHOR_EMAIL" = "'"$OLD_EMAIL"'" ]; then
    export GIT_AUTHOR_EMAIL="'"$NEW_EMAIL"'"
fi
if [ "$GIT_COMMITTER_EMAIL" = "'"$OLD_EMAIL"'" ]; then
    export GIT_COMMITTER_EMAIL="'"$NEW_EMAIL"'"
fi
' --tag-name-filter cat -- --branches --tags

git push --force --tags origin --all