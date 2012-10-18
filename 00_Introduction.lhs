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
 >   which associate to each couple \\(f:A→B\\), \\(g:B→C\\) another morphism \\(g∘f:A→C\\).
 >
 > With the following properties
 >
 > - for each object \\(x\\) there is an identity morphism  
 >   \\(id_x:x→x\\)  
 >   s.t. for any morphism \\(f:A->B\\),  
 >   \\(id_A∘f = f = f∘id_B\\)
 > - for all triplet of morphisms \\(f:A->B\\), \\(g:B->C\\) and \\(h:C->D\\)  
 >   \\( (h∘g)∘f = h∘(g∘f) \\)
<mpost title="Identity is left and right neutral element for ∘">
z0=origin;
z1=(2gu,0);

drawState(z0,btex $A$ etex);
drawState(z1,btex $B$ etex);

drawLoop(z0,btex $id_A$ etex);
drawLoop(z1,btex $id_B$ etex);

drawEdge(z0,z1,btex $f\circ id_A = f = id_B\circ f$ etex);
</mpost>

<mpost title="Associativity">
z0=origin;
z1=(gu,0);
z2=(2gu,0);
z3=(3gu,0);

drawState(z0,btex $A$ etex);
drawState(z1,btex $B$ etex);
drawState(z2,btex $C$ etex);
drawState(z3,btex $D$ etex);

drawEdge(z0,z1,btex $f$ etex);
drawEdge(z1,z2,btex $g$ etex);
drawEdge(z2,z3,btex $h$ etex);

drawoptions(withcolor blue);
drawEdgeWithAngle(z0,z2,btex $g\circ f$ etex,30);

drawoptions(withcolor yellow);
drawEdgeWithAngle(z1,z3,btex $h\circ g$ etex,-30);

drawoptions(withcolor red);
drawEdgeWithAngle(z0,z3,btex $(h\circ g)\circ f = h\circ (g\circ f)$ etex,45);
</mpost>

 ### Representation of Category

Representing Category is not just a game.
It will be _very_ important.
But in the same time, it will help you to gain intuition about categories.

A naïve representation (which can work in many cases) is to represent
a specific category as a directed graph.
Here is a first example of the representation of a category:

<mpost title="First Naïve Category Representation">
z0=origin;
z1=2/3(gu,gu);
z2=(4/3gu,0);

drawState(z0,btex $A$ etex);
drawState(z1,btex $B$ etex);
drawState(z2,btex $C$ etex);

drawEdge(z0,z1,btex $f$ etex);
drawEdge(z1,z2,btex $g$ etex);
drawEdge(z0,z2,btex $h$ etex);

drawLoop(z0,btex $id_A$ etex);
drawLoop(z1,btex $id_B$ etex);
drawLoop(z2,btex $id_C$ etex);

</mpost>

From this graph we can conclude without any ambiguity that:

\\[ob(C)=\\{A,B,C\\}\\]
and
\\[\hom(C)=\\{f,g,h,idA,idB,idC\\}\\]

Instantaneously, we understand that we can get rid of all \\(idX\\) arrows.

But in reality, we lack an important information.
What is \\(∘\\)?

Now, we can add informations to our previous representation.
We simply add a relation between 3 arrows that represent the composition.

<mpost title="Naïve Category Representation">
z0=origin;
z1=(gu,gu);
z2=(2gu,0);

drawState(z0,btex $A$ etex);
drawState(z1,btex $B$ etex);
drawState(z2,btex $C$ etex);

drawEdge(z0,z1,btex $f$ etex);
drawEdge(z1,z2,btex $g$ etex);
drawEdge(z0,z2,btex $h$ etex);

drawoptions( withcolor red );

z3=.6[z0,z1];
z4=.6[z2,z1];

draw z3 -- z4 dashed evenly;

z5 = .45[z3,z4];
z6 = .55[z0,z2];
path bigarrow;
bigarrow := subpath (.1,.9) of z5 -- z6;
drawarrow bigarrow  withpen pencircle scaled 1.5;

label.rt(btex $h = g \circ f$ etex, .5[z5,z6]);

</mpost>

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

<mpost title="This can be a valid category">
z0=(0,0);
z1=2(u,0);
z2=2(2u,0);

drawedge(z0,z1,"");
drawedge(z1,z2,"");
drawedgeangle(z0,z2,"",50);

drawstate(z0);
drawstate(z1);
drawstate(z2);
</mpost>

<mpost title="Cannot be a category; no candidate for g∘f.">
z0=(0,0); z1=3(u,0); z2=3(2u,0);
drawstate(z0); drawstate(z1); drawstate(z2);

drawedge(z0,z1,btex $f$ etex);
drawedge(z1,z2,btex $g$ etex);
</mpost>

<mpost title="Also a possible valid category">
z0=(0,0); z1=(4u,0); z2=(2u,-3u);
drawstate(z0); drawstate(z1); drawstate(z2);

drawedgeangle(z0,z1,"",35);
drawedgeangle(z1,z0,"",-145);
drawedge(z0,z2,"");
drawedge(z1,z2,"");
</mpost>

<mpost title="Not a category; no \(A→C\) while there exists \(A→B\) and \(B→C\)">
z0=(0,0); z1=(gu,0); z2=(.5gu,-.75gu);
drawState(z0,btex $A$ etex);
drawState(z1,btex $B$ etex);
drawState(z2,btex $C$ etex);

drawEdgeWithAngle(z0,z1,"",35);
drawEdgeWithAngle(z1,z0,"",-145);
drawEdge(z1,z2,"");
drawEdge(z2,z0,"");
</mpost>

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

<mpost title="Strings are Categories">
u:=.5cm;
def drawloop(expr a,b,l) =
    pair ba,ea;
    path circ,p,s;
    p:=a{1,1}..b..{1,-1}cycle;
    circ:= fullcircle scaled 6 shifted a;
    ba = circ intersectionpoint (subpath (0,1) of p);
    ea = circ intersectionpoint (subpath (1,2) of p);
    s:= ba{1,1}..b..{1,-1}ea;
    drawarrow s;
    label.top(l,b);
enddef;

pair A,B,C,D,E,F;
A:=(0,0);
B:=(0,u);
C:=(0,2u);
D:=(0,3u);
E:=(0,4u);
F:=(0,6u);

drawloop(A,B,btex $\varepsilon$ etex);
drawloop(A,C,btex $a$ etex);
drawloop(A,D,btex $b$ etex);
drawloop(A,E,btex $ab$ etex);
drawloop(A,F,btex $\omega$ etex);
draw (0,4.8u)--(0,5.8u) dashed withdots;
draw A withpen pencircle scaled 4bp;
</mpost>
