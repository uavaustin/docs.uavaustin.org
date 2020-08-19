# Using Git

## *Getting* Git

[Check this out](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
to install Git on your computer.

If you're just getting it for the first time, make sure to get your name and
your email address.

```
$ git config --global user.name "Mr. Dudeface McGee IV"
$ git config --global user.email "xXepic_programmer1337Xx@hotmail.com"
```
I'd recommend using your actual name and email and not those above.

For more configuration options:
```
$ git config --list --show-origin # shows config file location 
$ git config --list # shows all settings
```

## What to Know

There are a ton of good resources out there on how to use Git. You shouldn't
have a problem with finding any. At a bare minimum to make commits and things,
you should know how to use the following:

- `git add`
- `git commit`
- `git pull`
- `git push`
- `git checkout`
- `git branch`
- `git merge`
- `git stash`
 
### Good Resources:
- [Atlassian Git Tutorial](https://www.atlassian.com/git/tutorials)
- [Atlassian Cheatsheet](https://www.atlassian.com/git/tutorials/atlassian-git-cheatsheet)
- [Interactive Git Branching](https://learngitbranching.js.org/)
- [Stack Overflow Guide](https://stackoverflow.com/questions/315911/git-for-beginners-the-definitive-practical-guide)
- [Pro Git Book](https://git-scm.com/book/en/v2)
- [Official Documentation](https://git-scm.com/docs)

### Branching:
In order for us to all work together on the same project, we use Git branching
often. This allows us to all contribute at the same time without interference,
and for us to merge our work into the main line when it's done and has been
verified.

In most UAV Austin repositories, the latest stable version of the code is in the *master*
branch. For each card on Trello, generally, we will create a new branch where we can add features,
fix bugs, and develop (we call these branches *feature branches*). When it's just about finished,
you'll add a *pull request* (or *PR*) to merge it into the *master* branch. A team lead will
review the code real fast, make sure it's good, and then merge it in.

### Merging:
In Git, there are two types of merges:
- fast-forward merge
- three-way merge

If you want a more in-depth explanation, click [here](https://www.atlassian.com/git/tutorials/using-branches/git-merge).

**Fast-Forward Merge**

A fast-forward merge occurs when the feature branch's latest common ancestor
with the master branch is also the latest commit in the master branch. Fast-forward
merge is enabled by default.

Here's an example (switch to an appropriate directory):
```
# initialize git repository
$ git init

# create file "a.txt"
$ touch a.txt

# add text to "a.txt"; stage and commit
$ echo "commit 1" > a.txt
$ git add . && git commit -m "first commit"

# create and switch to new branch
$ git checkout -b feature-branch

# append text in feature-branch; stage and commit
$ echo "commit 2" >> a.txt
$ git add . && git commit -m "second commit"

# repeat above but for commit 3
$ echo "commit 3" >> a.txt
$ git add . && git commit -m "third commit"

# switch to master and merge
$ git checkout master
$ git merge feature-branch
```
If you check the commit history using `git log`, you'll find that "second commit" and 
"third commit" are now present in the git history of the master branch.

Undo the merge by using:
```
$ git reset --hard HEAD@{1}
```
Now try the merge without fast-forwarding by passing in a `--no-ff` flag:
```
$ git merge --no-ff feature-branch
```
Notice that there's an extra commit when checking the history using `git log`
on top of "second commit" and "third commit". This makes it clear to anyone reading the
history that a merge from a separate branch occurred here, whereas this information would
have been obscured had we not passed in the `--no-ff` flag.

Whether or not to use the `--no-ff` flag is left to the discretion of the team leads.

**Three-Way Merge**

[A good diagram explaining this](https://stackoverflow.com/a/4130766/13844610).

A 3-way merge occurs when the latest common ancestor between the feature branch and the
master branch is not the latest commit in master (i.e the feature branch has diverged from master).
The three states being compared are:
- the latest commit in the feature branch
- the latest commit in master
- the common ancestor commit

Here's an example (switch to an appropriate directory):
```
# initialize git repository
$ git init

# create file "a.txt"
$ touch a.txt

# add text to "a.txt"; stage and commit
$ echo "commit 1" > a.txt
$ git add . && git commit -m "first commit"

# create and switch to new branch
$ git checkout -b feature-branch

# adding text onto the first line; stage and commit
$ sed -i '1s/^/commit 2 on feature\n/' a.txt
$ git add . && git commit -m "second commit in feature"

# switch to master
$ git checkout master

# append text to "a.txt"; stage and commit changes
$ echo "commit 2 on master" >> a.txt
$ git add . && git commit -m "second commit in master"

# merge the two branches
$ git merge feature-branch
```

"a.txt" in the common ancestor commit:
```
commit 1
```

"a.txt" in the feature-branch:
```
commmit 2 on feature
commit 1
```

"a.txt" in master before merging:
```
commit 1
commit 2 on master
```

"a.txt" in master after merging:
```
commit 2 on feature
commit 1
commit 2 on master
```

It's clear that the three-way merge uses the common ancestor commit as a reference point
to compare the final states of "a.txt" in their respective branches. 

Notice in the git history, a merge commit is added on top of the commit changes. 


