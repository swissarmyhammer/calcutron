# Calcutron! 🤖

This is a sample to show you how to use SwissArmyHammer to do AI auto programming.

To get started you need Claude Code https://docs.anthropic.com/en/docs/claude-code/setup


## The Specification

A sample [specification](./specification/index.md) is provided.

This is just a markdown document where you describe what you want from your program.

You can use 'just words', use cases, code snippets -- go nuts.

Feel free to change it. Really.

## Let's Go!

Now -- in your shell:

### Init  

Let's get this sample repo started.

```bash
git clone git@github.com:swissarmyhammer/calcutron.git
cd calcutron
brew install swissarmyhammer/tap/swissarmyhammer-cli
sah init
sah doctor
```

### Action 

Planning will look at a markdown file, digest it, and generate issues. Fire up Claude Code

```bash
-- This will create a plan-- a bunch of cards and use claude code planning mode

/plan ./specification/index.md

-- do the work
/implement-loop

-- check it
/review

-- do the work
/implement-loop


-- make sure all test pass
/test-loop

```


You are the now proud owner of a calculator.

## Demo

Watch the full workflow in action:

![Demo](./demo.gif)

The recording runs every step — `sah init`, `sah doctor`, then `claude -p` driving `/plan`, `/implement-loop`, `/review`, and `/test-loop` — building the entire calculator from the specification unattended.

Replay in your terminal: `asciinema play demo.cast`
