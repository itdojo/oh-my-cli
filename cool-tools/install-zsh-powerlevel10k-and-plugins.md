## Installing zsh and PowerLevel10k Theme

> [!Note]
> Powerlevel10k's author has placed the project in maintenance mode ("very limited support, no new features planned").  It still works great with current zsh and remains hugely popular, but if you prefer an actively developed prompt, look at [Starship](https://starship.rs) or [Oh My Posh](https://ohmyposh.dev) as alternatives.

- [ ] Run the following commands.

> Note: The `install_zsh.sh` script below will install required fonts, any necessary tools (git, curl, wget, etc.), install oh-my-zsh, PowerLevel10k and change your shell to zsh.

> When needed, the script will prompt you to enter your password.

```shell
git clone https://github.com/itdojo/oh-my-cli.git

cd oh-my-cli/scripts

chmod +x install_zsh.sh

./install_zsh.sh

cd
```

*** 

- [ ] After the script completes, log out and log back in (or reboot).  Open a terminal.  The PowerLevel10k wizard will run.  Answer the questions to your liking.  

<img src=../assets/p10k-configure.png> 

Change your layout any time by running `p10k configure` and going through the setup wizard again.

***

## My layout

<img src=../assets/p10k-layout-colin.png>

***

End.
