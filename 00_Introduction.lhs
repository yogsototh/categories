 ## Introduction

%TODO{Do everything after the end}

Now, it is time to talk about Categories.
How this notion could help you and how it is easy to use with Haskell.

- What are categories?
- How to use them?

 ### Programming Paradigms

When you program, you resolve problems.
There are a lot of different means to resolve a problem.
Many different "school of thought"[^school] exists.

[^school]: Écoles de pensées

**Imperative paradigm**:
In programming, most people use the imperative paradigm.
You have an infinite number of cell and you can write things on them.
Of course, it is more complex with modern architecture, but the paradigm is the same.
Hidden somewhere, there is the model of the Turing machine.

**Functional paradigm**:
Another paradigm, is the functional paradigm.
This time, you don't write on cells, but instead you have a flow of data.
And you transform the flows in another flows... Mostly it looks like pipes.
I am a bit restrictive here. But generally this is how functional programming is perceived.
The main theory behind this paradigm is the Set theory.
You have a set and you go from one set to another set by using a function.

**Category paradigm**:
I believe there is another paradigm arising from Category theory.
Category theory feels both more general and powerful to help solve problems.

First, you must realize there are categories everywhere.
With the category theory you can find relationships between quantum physics,
topology, logic (both predicate and first order), programming.
Most of the time, the object your are programming with will form a category.

This is the promise from the Category Theory.
Another even better paradigm.
A paradigm with gates between many different domains.

 ## Get some intuition

We write down the definition first.
And will discuss about some categories.

<div style="display:none">
\\( \newcommand{\hom}{\mathrm{hom}} \\)
</div>

 > **Definition**:
 >
 > A category \\(C\\) consist of:
 >
 > - A collection of _objects_ \\(ob(C)\\)
 > - For every pair of objects \\((A,B)\\) a set \\(\hom(A,B)\\)
 >   of _morphisms_ \\(f:A→B\\) (Another notation for \\(f\in \hom(A,B)\\))
 > - A composition operator \\(∘\\)
 >   which associate to each couple \\(g:A→B\\), \\(f:B→C\\) another morphism \\(f∘g:A→C\\).
 >
 > With the following properties
 >
 > - for each object \\(x\\) there is an identity morphism  
 >   \\(id_x:x→x\\)  
 >   s.t. for any morphism \\(f:A->B\\),  
 >   \\(id_A∘f = f = f∘id_B\\)
 > - for all triplet of morphisms \\(h:A->B\\), \\(g:B->C\\) and \\(f:C->D\\)  
 >   \\( (f∘g)∘h = f∘(g∘h) \\)

<graph title="Identity is left and right neutral element for ∘">
A -> A [label="idA"]
B -> B [label="idB"]
A -> B [label="f∘idA=f=idB∘f"]
</graph>

<graph title="Associativity">
A -> B [label="f"]
B -> C [label="g"]
C -> D [label="h"]
A -> C [label="g∘f",style="bold",fontcolor="cyan",color="cyan",constraint="false"]
B -> D [label="h∘g",style="bold",fontcolor="yellow",color="yellow",constraint="false"]
A -> D [label="(h∘g)∘f=h∘(g∘f)",style="bold",color="red",fontcolor="red",constraint="false"]
</graph>

 ### Representation of Category

Representing Category is not just a game.
It will be _very_ important.
But in the same time, it will help you to gain intuition about categories.

A naïve representation (which can work in many cases) is to represent
a specific category as a directed graph.
Here is a first example of the representation of a category:

<graph title="First Naïve Category Representation">

A -> B [label="f"]
B -> C [label="g"]
A -> C [label="h"]

A -> A [label="idA"]
B -> B [label="idB"]
C -> C [label="idC"]

</graph>

From this graph we can conclude without any ambiguity that:

\\[ob(C)=\\{A,B,C\\}\\]
and
\\[\hom(C)=\\{f,g,h,idA,idB,idC\\}\\]

Instantaneously, we understand that we can get rid of all \\(idX\\) arrows.

But in reality, we lack an important information.
What is \\(∘\\)?

Now, we can add informations to our previous representation.
We simply add a relation between 3 arrows that represent the composition.

<graph title="Naïve Category Representation">

A[pos="0,0!"]
B[pos="1.5,1.5!"]
C[pos="3,0!"]

f[pos="0.75,0.75!",label="", fixedsize="false", width=0,height=0,shape=none];
A -> f[label="f", arrowhead=None]
f -> B

g[pos="2.25,0.75!",label="", fixedsize="false", width=0,height=0,shape=none];
B -> g[label="g", arrowhead=None]
g -> C


fg      [pos="1.5,0.75!",label="", fixedsize="false", width=0,height=0,shape=none];
AC      [pos="1.5,0!",label="", fixedsize="false", width=0,height=0,shape=none];

f -> fg  [color="red",style=dashed,arrowhead=None]
fg -> g  [color="red",style=dashed,arrowhead=None]
fg -> AC [label="h=g∘f",fontcolor="red",color="red",style=bold]

A -> AC [label="h",arrowhead=None]
AC -> C


</graph>

Now we have a complete representation.
We don't have to represent \\(idX\\), we know there are there.
And we also don't have to represent composition implying \\(idX\\) morphisms.
But, even this little graph look complex.
To show just how complex things can be;
we just double the number morphisms between different objects.

<graph title="Naïve Category Representation Mess">

A[pos="0,0!"]
B[pos="4,0!"]
C[pos="8,0!"]
f[pos="2,1!",label="", fixedsize="false", width=0,height=0,shape=none];
A -> f[label="f", arrowhead=None]
f -> B

fp[pos="2,0.5!",label="", fixedsize="false", width=0,height=0,shape=none];
A -> fp[label="f'", arrowhead=None]
fp -> B

g[pos="6,0.5!",label="", fixedsize="false", width=0,height=0,shape=none];
B -> g[label="g", arrowhead=None]
g -> C

gp[pos="6,1!",label="", fixedsize="false", width=0,height=0,shape=none];
B -> gp[label="g'", arrowhead=None]
gp -> C

fg[pos="6,0!",label="", fixedsize="false", width=0,height=0,shape=none];
fpg[pos="2.5,-1.5!",label="", fixedsize="false", width=0,height=0,shape=none];
fgp[pos="5.5,-1.5!",label="", fixedsize="false", width=0,height=0,shape=none];
fpgp[pos="2,0!",label="", fixedsize="false", width=0,height=0,shape=none];
AC[pos="4,-1!",label="", fixedsize="false", width=0,height=0,shape=none];
ApCp[pos="4,-3!",label="", fixedsize="false", width=0,height=0,shape=none];

f -> fg  [color="red",style=dashed,arrowhead=None]
fg -> g  [color="red",style=dashed,arrowhead=None]
fg -> AC [color="red",style=bold,fontcolor="red",label="h=g∘f"]

fp -> fpgp [color="yellow",style=dashed,arrowhead=None]
fpgp -> gp [color="yellow",style=dashed,arrowhead=None]
fpgp -> AC [color="yellow",style=bold,fontcolor="yellow",label="h=g'∘f'"]

fp -> fpg   [color="blue",style=dashed,arrowhead=None]
fpg -> g    [color="blue",style=dashed,arrowhead=None]
fpg -> ApCp [color="blue",style=bold,fontcolor="blue",label="h'=g∘f'"]

f -> fgp    [color="violet",style=dashed,arrowhead=None]
fgp -> gp   [color="violet",style=dashed,arrowhead=None]
fgp -> ApCp [color="violet",style=bold,fontcolor="violet",label="h'=g'∘f"]

A -> AC [label="h",arrowhead=None]
AC -> C

A -> ApCp [label="h'",arrowhead=None]
ApCp -> C


</graph>

By removing the graphical representation of ∘ we could create a more readable representation.

<graph title="Fewer Details Category Representation">

A -> B[label="f"]
A -> B[label="f'"]
B -> C[label="g"]
B -> C[label="g'"]
A -> C [label="h\n=g∘f\n=g'∘f'"]
A -> C [label="h'\n=g'∘f\n=g∘f'"]

</graph>

 ### Examples

Which can be a valid category by choosing ∘ appropriately?
The identity morphisms are assumed.

<graph title="Can be a valid category">
A[label="★"]
B[label="★"]
C[label="★"]
A -> B
B -> C
A -> C [constraint=false]
</graph>

<graph title="Cannot be a category; no candidate for \(g∘f\).">
A[label="★"]
B[label="★"]
C[label="★"]
A -> B[label="f"]
B -> C[label="g"]
</graph>

<graph title="Also a valid category">
A[label="★",pos="0,50"]
B[label="★",pos="50,50"]
C[label="★",pos="25,0"]
A -> B
B -> A
B -> C
A -> C
</graph>

<graph title="Not a category; no \(A→C\) while there exists \(A→B\) and \(B→C\)">
A[pos="0,0"]
B[pos="2,0"]
C[pos="1,-1"]
A -> B
B -> C
B -> A
C -> A
</graph>

<graph title="Cannot be a category ; no possible associative ∘<br/>\((h∘g)∘f=idB∘f=f≠h=h∘idA=h∘(g∘f)\)">
A -> B[label="g"]
B -> A[label="f"]
B -> A[label="h"]
</graph>

To continue to gain some intuition I will give some degenerated Category examples.

 ### Monoids

What are Monoids?
Things that you can operate a list of in any evaluation order and obtain the same result.

More precisely; let `l` be a list of elements of the monoid.
then

<code class="haskell">
foldl (<>) e l = foldr (<>) e l
</code>

Where `(<>)` is the monoid operation.
And `e` is the neutral element of the monoid.
Equivalently:

<code class="haskell">
((e <> x) <> y) <> z = x <> ( y <> ( z <> e) )
</code>

Or another way of saying it is that `x <> y <> z` doesn't need any parenthesis.
Because whatever the order of evaluation the result will be the same.

Typical examples:

- `String` with `(++)` and `""`
- `Lists` with `(++)` and `[]`
- `Data.Text` with `append` and `empty`
- `Integer` with `(+)` and `0`
- `Integer` with `(*)` and `1`
- Generalized by `Monoid a` with `(<>)` and `mempty`

<graph title="Strings are Categories">

★ -> ★[label="e"]
★ -> ★[label="x"]
★ -> ★[label="y"]
★ -> ★[label="..."]

</graph>

metapost test

<mpost title="metapost test">
pair A, B, C;
A:=(0,0); B:=(1cm,0); C:=(0,1cm);
draw A--B--C;
</mpost>
