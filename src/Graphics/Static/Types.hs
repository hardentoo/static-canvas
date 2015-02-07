{-# LANGUAGE DeriveFunctor              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings          #-}

-------------------------------------------------------------------------------
-- |
-- Module      :  Graphics.Static.Types
-- Copyright   :  (c) 2015 Jeffrey Rosenbluth
-- License     :  BSD-style (see LICENSE)
-- Maintainer  :  jeffrey.rosenbluth@gmail.com
--
-- DSL for creating HTML5 Canvas.
--
-------------------------------------------------------------------------------

module Graphics.Static.Types where

import Control.Applicative
import Control.Monad.Free.Church   (F)
import Control.Monad.State
import Control.Monad.Writer
import Data.Text                   (Text)
import Data.Text.Lazy.Builder      (Builder)

newtype Script a = Script {runScript :: (WriterT Builder (State Int) a)}
  deriving (Functor, Applicative, Monad, MonadWriter Builder, MonadState Int)

type CanvasFree = F Canvas

data Canvas r
  = AddColorStop !Double Color Style r
  | Arc !Double !Double !Double !Double !Double !Bool r
  | ArcTo !Double !Double !Double !Double !Double r
  | BeginPath r
  | BezierCurveTo !Double !Double !Double !Double !Double !Double r
  | ClearRect !Double !Double !Double !Double r
  | Clip r
  | ClosePath r
  -- | CreatePattern
  -- | DrawImage2
  -- | DrawImage4
  -- | DrawImage8
  | Fill r
  | FillRect !Double !Double !Double !Double r
  | FillStyle Style r
  | FillText Text !Double !Double r
  | Font Text r
  | GlobalAlpha !Double r
  | GlobalCompositeOperation Text r
  | LinearGradient !Double !Double !Double !Double (Style -> r)
  | LineCap LineCapStyle r
  | LineJoin LineJoinStyle r
  | LineTo !Double !Double r
  | LineWidth !Double r
  | MiterLimit !Double r
  | MoveTo !Double !Double r
  -- | NewImage
  -- | PutImageData2
  -- | PutImageData6
  | QuadraticCurveTo !Double !Double !Double !Double r
  | RadialGradient !Double !Double !Double !Double !Double !Double (Style -> r)
  | Rect !Double !Double !Double !Double r
  | Restore r
  | Rotate !Double r
  | Save r
  | Scale !Double !Double r
  | SetTransform !Double !Double !Double !Double !Double !Double r
  | ShadowBlur !Double r
  | ShadowColor Color r
  | ShadowOffsetX !Double r
  | ShadowOffsetY !Double r
  | Stroke r
  | StrokeRect !Double !Double !Double !Double r
  | StrokeStyle Style r
  | StrokeText Text !Double !Double r
  | TextAlign TextAlignStyle r
  | TextBaseline TextBaselineStyle r
  | Transform !Double !Double !Double !Double !Double !Double r
  | Translate !Double !Double r
    deriving Functor

data Color
  = Hex  Text
  | RGB  !Int !Int !Int
  | RGBA !Int !Int !Int !Double

data Gradient
  = LG !Int
  | RG !Int

data Style
  = ColorStyle Color
  | GradientStyle Gradient

data LineCapStyle
  = LineCapButt
  | LineCapRound
  | LineCapSquare

data LineJoinStyle
  = LineJoinMiter
  | LineJoinRound
  | LineJoinBevel
    
data TextAlignStyle
  = TextAlignStart
  | TextAlignEnd
  | TextAlignCenter
  | TextAlignLeft
  | TextAlignRight
    
data TextBaselineStyle
  = TextBaselineTop
  | TextBaselineHanging
  | TextBaselineMiddle
  | TextBaselineIdeographic
  | TextBaselineBottom