gitauto() {
    # Stage all changes
    git add .

    # Check if there are any staged changes to commit
    if ! git diff-index --quiet HEAD --; then
        # Commit with a message that includes the current date and time
        git commit -m "Autosave: $(date '+%Y-%m-%d %H:%M:%S')"

        # Show the current status
        git status

        # Push changes to the remote repository
        git push

        # Provide a friendly message
        echo "Git autosave complete!"
    else
        echo "No changes to commit."
    fi
}
