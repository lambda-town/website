---
title: Functional JSON handling with Scala
subtitle: A Crash Course on Circe
youtubeId: uCtKqp2tdrg
---
This tutorial covers Circe, a functional JSON handling library for Scala, part of the Typelevel ecosystem and well integrated with Cats. 

To learn more about Circe: https://github.com/circe/circe
To learn more about Monads and Applicative functors: https://www.youtube.com/watch?v=Tx5Ld...
To learn more about Type classes: https://typelevel.org/cats/typeclasse...

The video covers:

00:00 The overall structure of the library
04:43 The Json data type
13:51 Encoders
17:14 Decoders
30:39 Automatic derivation
32:33 Semi-automatic derivation
34:55 Automatic derivation considered harmful and conclusion

----

A note about the placement of Json codecs and the "automatic derivation considered harmful" part of the video: placing our Encoder[YoutubeVideo] in the companion object of YoutubeVideo would have solved the problem. Since Scala automatically imports implicits from companion objects, we would have never forgotten the import in the first place. However, some scenarios require Json codecs to be placed elsewhere: it could be that your architecture is very opinionated, for example, some architecture patterns encourage you to clearly separate business concerns from implementation details, in which case your codecs will likely be away from your core business types; or it could be that a single type has several encoders and decoders, because your application needs to address multiple clients and multiple transports. I know many projects won't be affected by the downsides of automatic derivation; but more complex project will. This is why I choose to avoid it altogether in favor of semi-auto derivation or custom-built codecs depending on the use case.