# Calcutron! 🤖

This is a sample to show you how to use swissarmy hammer to do AI auto programming.

To get started you need:

- To fork this repo
- Install Claude Code https://docs.anthropic.com/en/docs/claude-code/setup
- Install Swissarmyhammer https://github.com/swissarmyhammer/swissarmyhammer

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


Tremble in AI fear...

You are the proud owner of a calculator.
