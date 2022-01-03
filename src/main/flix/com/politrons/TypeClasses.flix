/// //In order to use Monads of type m[a] it´s mandatory this
/// //enum has two possible values, so we have [Type -> Type] 
/// enum Politrons[a] with ToString{
///   case A(a)
///   case B

/// }

/// namespace Politrons {
///     pub def map(f: a -> b & ef, o: Politrons[a]): Politrons[b] & ef = match o {
///         case B => B
///         case A(v) => A(f(v))
///     }
/// }

/// // Type classes
/// //--------------

/// //Type class contract that all [instance] must implement.
/// // m deifne a function type [Type -> Type] which is impure since it might have
/// // side effect [ef]
/// pub lawless class FreeMonad[m:Type -> Type]  {

///     pub def map(f: a -> b & ef, x: m[a]): m[b] & ef

/// }

/// //[String] implementation for [MyMonad] 
/// instance FreeMonad[Politrons] {

///     pub def map(f: a -> b & ef, x: Politrons[a]): Politrons[b] & ef = Politrons.map(f,x)
    
/// }

/// //We use the namespace to define the DSL which it will be expose to the  user.
/// //Since we use the generic 
/// namespace FreeMonad {

///     pub def trans(f: a -> b & ef, x: m[a]): m[b] & ef with FreeMonad[m] = map(f, x)

/// }
