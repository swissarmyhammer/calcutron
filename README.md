# Calcutron! 🤖

This is a sample to show you how to use swissarmy hammer to do AI auto programming.

To get started you need:

- To fork this repo
- Install Claude Code https://docs.anthropic.com/en/docs/claude-code/setup
- Install Swissarmyhammer <https://github.com/swissarmyhammer/swissarmyhammer>
  - `cargo install --git https://github.com/swissarmyhammer/swissarmyhammer.git swissarmyhammer-cli --force
- Hook up as MCP `claude mcp add sah sah serve`

## The Specification

A sample [specification](./specification/index.md) is provided.

This is just a markdown document where you describe what you want from your program.

You can use 'just words', use cases, code snippets -- go nuts.

Feel free to change it. Really.

## Let's Go!

Now -- in your shell:

### Preflight 📋 
```bash
sah doctor
```

### Flightplan 🗺️
```bash
sah flow run plan
```

This will create a plan-- a bunch of issue -- go ahead and commit these

```bash
git add issues
git commit -am 'plan'
```

### Takeoff   

```bash
sah flow run implement
```

Tremble in AI fear...

You are the proud owner of a calculator.
