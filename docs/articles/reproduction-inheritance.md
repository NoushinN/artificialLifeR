# Reproduction and Inheritance

``` r
library(artificialLifeR)
```

## Purpose

This article explains reproduction and inheritance in artificial-life
models. Reproduction allows a population to persist across time.
Inheritance allows traits to be transmitted from parent to offspring
(Darwin 1859; Nowak 2006).

The purpose of this chapter is to show how reproduction transforms
individual-level traits into population-level continuity.

The guiding question is:

> How does reproduction transform individual traits into
> population-level continuity?

## Why reproduction matters

Reproduction is central to artificial life because it creates continuity
across time. Without reproduction, a population may disappear as agents
die, lose energy, or reach the end of their simulated lifespan.

Reproduction allows a system to move from a collection of individual
agents to a population with generational structure. Once agents can
reproduce, traits can persist, spread, disappear, or change across time.

This matters because artificial-life systems are often interested not
only in what agents do now, but in how populations change across
repeated cycles.

## Reproduction as continuity

Reproduction creates continuity. It allows traits to appear in later
generations.

In `artificialLifeR`, reproduction is simplified. Agents with enough
energy can create offspring. Offspring inherit traits from the parent,
with optional mutation.

This is not a full biological model. It does not represent sexual
reproduction, meiosis, DNA, embryological development, or real heredity.
Instead, it represents a general artificial-life principle:

> A population can persist when agents produce offspring that carry
> forward some traits.

## Inheritance as structured persistence

Inheritance matters because it preserves structure. If offspring were
completely unrelated to parents, selection would have little cumulative
effect. A useful trait could appear in one generation but vanish
immediately in the next.

Inheritance allows traits to persist long enough for population-level
change to occur.

This does not require a full genetic model. Even simple trait copying
can illustrate the idea that offspring resemble parents. This
resemblance is what makes cumulative change possible.

| Process             | Why it matters                          |
|---------------------|-----------------------------------------|
| Reproduction        | Creates new agents                      |
| Inheritance         | Preserves parent-offspring similarity   |
| Mutation            | Introduces variation                    |
| Selection           | Changes which traits become more common |
| Population dynamics | Shows the system-level consequence      |

Reproduction and inheritance provide continuity. Mutation and selection
provide change.

## Relation to the package

The function
[`simulate_reproduction()`](https://noushinn.github.io/artificialLifeR/reference/simulate_reproduction.md)
provides a simplified reproduction model.

| Argument        | Conceptual meaning                       |
|-----------------|------------------------------------------|
| `agents`        | Starting population                      |
| `mutation_rate` | Probability of trait change in offspring |
| `mutation_sd`   | Size of mutation-like trait change       |
| `seed`          | Reproducibility                          |

The exact reproduction rule is simplified. The goal is to make the logic
of parent-offspring continuity visible and teachable.

## Example: create a starting population

Start by creating a population with relatively high energy so that some
agents can reproduce.

``` r
agents <- create_agents(
  n_agents = 30,
  energy_mean = 1.8,
  seed = 4
)

head(agents)
#>   agent           x         y   energy      speed efficiency
#> 1     1 0.585800305 0.5671122 1.823020 0.02862954  0.3722340
#> 2     2 0.008945796 0.2389489 1.957790 0.07128901  0.4201988
#> 3     3 0.293739612 0.8779959 1.686868 0.02374556  0.5159082
#> 4     4 0.277374958 0.6545220 1.577672 0.09127389  0.5614798
#> 5     5 0.813574215 0.4823709 1.929170 0.05262766  0.5687948
#> 6     6 0.260427771 0.9710298 1.739322 0.04536623  0.4952949
#>   reproduction_threshold age alive
#> 1               1.486676   0  TRUE
#> 2               1.400023   0  TRUE
#> 3               1.687376   0  TRUE
#> 4               1.466261   0  TRUE
#> 5               1.597327   0  TRUE
#> 6               1.598783   0  TRUE
```

## Simulate reproduction

``` r
offspring_pop <- simulate_reproduction(
  agents,
  mutation_rate = 0.10,
  mutation_sd = 0.03,
  seed = 4
)

head(offspring_pop)
#>   agent           x         y    energy      speed efficiency
#> 1     1 0.585800305 0.5671122 0.9115098 0.02862954  0.3722340
#> 2     2 0.008945796 0.2389489 0.9788949 0.07128901  0.4201988
#> 3     3 0.293739612 0.8779959 1.6868683 0.02374556  0.5159082
#> 4     4 0.277374958 0.6545220 0.7888358 0.09127389  0.5614798
#> 5     5 0.813574215 0.4823709 0.9645849 0.05262766  0.5687948
#> 6     6 0.260427771 0.9710298 0.8696610 0.04536623  0.4952949
#>   reproduction_threshold age alive
#> 1               1.486676   0  TRUE
#> 2               1.400023   0  TRUE
#> 3               1.687376   0  TRUE
#> 4               1.466261   0  TRUE
#> 5               1.597327   0  TRUE
#> 6               1.598783   0  TRUE
```

## Compare population size before and after reproduction

``` r
data.frame(
  before = nrow(agents),
  after = nrow(offspring_pop)
)
#>   before after
#> 1     30    58
```

## Interpretation

The population may increase because some agents had enough energy to
reproduce. Offspring inherit traits from their parent, so the population
after reproduction contains continuity with the previous population.

A careful interpretation is:

> The simulation illustrates simplified reproduction and trait
> continuity in an artificial population.

An overstatement would be:

> The simulation fully models biological reproduction.

The first statement is appropriate. The second is not.

## Measuring inherited trait structure

We can compare trait summaries before and after reproduction.

``` r
rbind(
  before = measure_life_like_complexity(
    agents,
    trait_col = "efficiency"
  ),
  after = measure_life_like_complexity(
    offspring_pop,
    trait_col = "efficiency"
  )
)
#>         n unique_values  entropy      mean         sd temporal_variability
#> before 30            30 2.990759 0.5065472 0.09620988                   NA
#> after  58            32 2.964487 0.5100594 0.09335160                   NA
#>        mean_abs_change
#> before              NA
#> after               NA
```

## Interpretation of trait summaries

The summary helps show whether trait variation changed after
reproduction. If offspring inherit traits from parents, the population
after reproduction should retain some connection to the previous
population.

However, the metric does not prove biological inheritance. It summarizes
a simulated trait distribution.

## Reproduction with low mutation

Low mutation preserves stronger similarity between parent and offspring.

``` r
low_mutation_pop <- simulate_reproduction(
  agents,
  mutation_rate = 0.02,
  mutation_sd = 0.02,
  seed = 4
)

rbind(
  before = measure_life_like_complexity(
    agents,
    trait_col = "efficiency"
  ),
  low_mutation = measure_life_like_complexity(
    low_mutation_pop,
    trait_col = "efficiency"
  )
)
#>               n unique_values  entropy      mean         sd
#> before       30            30 2.990759 0.5065472 0.09620988
#> low_mutation 58            30 2.964487 0.5094780 0.09404328
#>              temporal_variability mean_abs_change
#> before                         NA              NA
#> low_mutation                   NA              NA
```

## Reproduction with higher mutation

Higher mutation introduces more variation into offspring traits.

``` r
high_mutation_pop <- simulate_reproduction(
  agents,
  mutation_rate = 0.50,
  mutation_sd = 0.10,
  seed = 4
)

rbind(
  before = measure_life_like_complexity(
    agents,
    trait_col = "efficiency"
  ),
  high_mutation = measure_life_like_complexity(
    high_mutation_pop,
    trait_col = "efficiency"
  )
)
#>                n unique_values  entropy      mean         sd
#> before        30            30 2.990759 0.5065472 0.09620988
#> high_mutation 58            47 2.881063 0.5223238 0.10760506
#>               temporal_variability mean_abs_change
#> before                          NA              NA
#> high_mutation                   NA              NA
```

## Interpretation of mutation during reproduction

Mutation changes how strongly offspring resemble parents.

A low mutation rate supports continuity. A higher mutation rate
introduces more novelty. Both are important in artificial-life systems.

Too little mutation may limit novelty. Too much mutation may weaken
inherited structure. Interesting artificial-life dynamics often depend
on a balance between continuity and change.

## Reproduction is not enough

Reproduction alone does not fully explain evolution-like change.
Evolution-like dynamics require more than producing offspring.

At minimum, they require:

1.  **Variation**: agents must differ.
2.  **Inheritance**: some traits must persist across generations.
3.  **Differential success**: some traits must become more common
    because they affect survival or reproduction.

If every individual reproduces equally and offspring are identical,
population composition may remain stable. Reproduction creates
continuity, but selection-like processes are needed for directional
change.

This distinction is important:

> Reproduction allows persistence. Selection changes composition.

## Reproduction and energy

In many artificial-life models, reproduction depends on energy. An agent
must have enough energy to produce offspring.

This creates a connection between environment, resource use, and
population growth. Agents that acquire enough energy can reproduce.
Agents that do not may fail to reproduce or may die.

This makes reproduction a bridge between individual-level state and
population-level dynamics.

| Level              | Example                            |
|--------------------|------------------------------------|
| Individual state   | Energy level                       |
| Rule               | Reproduce if energy is high enough |
| Population outcome | Population growth or continuity    |

## Reproduction and open-ended dynamics

Artificial-life systems often use reproduction to study open-ended
dynamics, adaptation, and population change (Ray 1991; Bedau 2003).

Reproduction allows a simulation to continue beyond the lifespan or
state of any single agent. Once reproduction, inheritance, mutation, and
selection-like processes are combined, the system can show more complex
long-term behavior.

However, open-endedness in artificial life is difficult. A simple
reproduction function does not guarantee open-ended evolution. It only
provides one necessary ingredient.

## Relation to other artificial-life processes

Reproduction is most meaningful when connected to other processes.

| Process              | Relationship to reproduction               |
|----------------------|--------------------------------------------|
| Resource competition | Determines which agents gain enough energy |
| Mutation             | Introduces variation into offspring        |
| Selection            | Changes which traits persist               |
| Population dynamics  | Shows the system-level consequences        |
| Complexity metrics   | Summarize trait and population changes     |

[`simulate_reproduction()`](https://noushinn.github.io/artificialLifeR/reference/simulate_reproduction.md)
should therefore be understood as one part of the artificial-life
toolkit, not a complete model by itself.

## What the model captures

The reproduction model captures several important ideas:

- populations can persist through offspring;
- offspring can inherit parent traits;
- mutation can introduce variation;
- reproduction links individual state to population growth;
- continuity across generations makes selection-like change possible.

These ideas are central to artificial-life modelling.

## What the model does not capture

The model is intentionally simplified. It does not include:

- sexual reproduction;
- real genetics;
- DNA or RNA;
- meiosis;
- development;
- parental investment;
- complex life cycles;
- biological inheritance systems;
- real reproductive ecology.

It is a teaching model for conceptual exploration.

## Responsible interpretation

The function does not model sexual reproduction, genetics, development,
or real heredity. It illustrates the general idea that offspring can
inherit traits from parents.

It is better to say:

> The simulation illustrates simplified reproduction and
> inheritance-like continuity.

than:

> The simulation models biological reproduction.

It is better to say:

> Mutation during reproduction can introduce trait variation.

than:

> The model represents real genetic mutation.

Careful interpretation keeps the model useful and academically credible.

## Educational use

This chapter can support several classroom or self-study questions:

- Why is reproduction important for artificial life?
- How does inheritance create continuity?
- Why is reproduction alone not enough for evolution?
- How does mutation affect parent-offspring similarity?
- Why does energy matter for reproduction?
- What is the difference between persistence and adaptation?
- What would need to be added to model biological reproduction more
  realistically?

These questions help learners understand reproduction as one ingredient
in a broader artificial-life system.

## Key takeaway

Reproduction and inheritance allow artificial populations to persist and
change over time. Reproduction creates new agents. Inheritance preserves
continuity between generations. Mutation introduces novelty.

Together, these processes make selection and adaptation-like dynamics
possible. In `artificialLifeR`, they are represented in simplified form
to make the logic of artificial-life systems visible and teachable.

## References

Bedau, Mark A. 2003. “Artificial Life: Organization, Adaptation and
Complexity from the Bottom Up.” *Trends in Cognitive Sciences* 7 (11):
505–12.

Darwin, Charles. 1859. *On the Origin of Species*. John Murray.

Nowak, Martin A. 2006. *Evolutionary Dynamics: Exploring the Equations
of Life*. Harvard University Press.

Ray, Thomas S. 1991. “An Approach to the Synthesis of Life.” In
*Artificial Life II*, 371–408. Addison-Wesley.
