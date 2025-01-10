## Installing zsh and PowerLevel10k Theme

- [ ] Run the following commands.

> Note: The script below will change your shell to zsh.

> When needed, the script will prompt you to enter your password.

```shell
git clone https://github.com/itdojo/qol

cd qol

chmod +x install_zsh.sh

./install_zsh.sh

cd && rm -rf qol
```

*** 

- [ ] Reboot  your computer.  Log back in to a terminal.  The PowerLevel10k wizard will run.  Answer the questions to your liking.  

<img src=assets/p10k-configure.png> 

Change your layout any time by running `p10k configure` and going through the setup wizard again.

***

## Suggested Layouts

For reference, here are the answers I use:

## Non-tmux Optimized p10k Layout

```
y
y
y
1
y
2
1
3
n
4
5
5
2
2
4
2
2
1
y
1
y
```

The answers above produce this layout:

<img src=assets/p10k-layout-colin.png>

***

## tmux Optimized p10k Layout

***

End.