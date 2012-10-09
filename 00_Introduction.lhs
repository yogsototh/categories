 ## Introduction

My last two post where about Haskell and how to do something useful with it.

Now, it is time to talk about Categories.
How this notion could help you and how it is easy to use with Haskell.

- What are categories?
- How to use them?

First, a realisation.

Programming paradigm. When you program, you resolve problems.
There are a lot of different means to resolve a problem.
Some general school of thought exists.

In programming, most people use the imperative paradigm.
You use some memory and update it.
More precisely, you destroy part of information by setting variables to new values.
Hidden somewhere, there is the model of the Turing machine.
Of course, it is more complex with modern architecture, but the paradigm is the same.
You have an infinite number of cell and you can write things on them.
But you must erase them.

Another paradigm, is the functional paradigm.
This time, you don't write on cells, but instead you have a flow of data.
And you transform the flows in another flows... Mostly it looks like pipes.
I am a bit restrictive here. But generally this is how functional programming is perceived.
The main theory behind this paradigm is the Set theory.
You have a set and you go from one set to another set by using a function.

But using I believe there is another paradigm arising from Category theory.
And from what I saw up until there.
Category theory is both more general and powerful to help solve problems.

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

 > **Definition**:
 >
 > A category \\(C\\) consist of:
 >
 > - A collection of _objects_ \\(ob(C)\\)
 > - For every pair of objects \\((A,B)\\) a set \\(hom(A,B)\\)
 >   of _morphisms_ \\(f:A→B\\) (Another notation for \\(f\in hom(A,B)\\))
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

