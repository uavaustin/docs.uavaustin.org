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
 
**Good Resources**:
- [Atlassian Git Tutorial](https://www.atlassian.com/git/tutorials)
- [Atlassian Cheatsheet](https://www.atlassian.com/git/tutorials/atlassian-git-cheatsheet)
- [Interactive Git Branching](https://learngitbranching.js.org/)
- [Stack Overflow Guide](https://stackoverflow.com/questions/315911/git-for-beginners-the-definitive-practical-guide)
- [Pro Git Book](https://git-scm.com/book/en/v2)
- [Official Documentation](https://git-scm.com/docs)

**Branching**:
In order for us to all work together on the same project, we use Git branching
often. This allows us to all contribute at the same time without interference,
and for us to merge our work into the main line when it's done and has been
verified.

In most UAV Austin repositories, the main state of the code is in the *master*
branch. For each card on Trello, generally, we will have a *feature branch* for
it while it is in development. When it's just about finished, you'll add a
*pull request* (or *PR*) to merge it into the *master* branch. A team lead will
review the code real fast, make sure it's good, and then merge it in.

**Merging**:
Make sure to use the `--no-ff` flag when merging by the command line, this will
preserve the branch history on the graph.

## Version Tagging

*Directed towards team leads.*

Releases are to be in the following formats:

- *v1.0*
- *v1.0-beta.1*
- *v1.0-rc.1*
- *v1.2.1*
- *v1.2.1-beta.1*
- *v1.2.1-rc.1*

Smaller code bases use the Major.Minor versioning numbers, and larger use
Major.Minor.Patch. Note the *v* in front of tag names.