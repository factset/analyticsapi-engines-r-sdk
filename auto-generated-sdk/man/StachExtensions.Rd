% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stach_extensions.R
\docType{class}
\name{StachExtensions}
\alias{StachExtensions}
\title{StachExtensions}
\format{
An \code{R6Class} generator object
}
\description{
The purpose of this class is to provide the helper methods for converting stach to Tabular format
}
\section{Methods}{

\describe{
\strong{ ConvertToDataFrame}
This function is used to convert stach to dataFrame.

\itemize{
\item \emph{ @param } package : Stach Data which is represented as a Package object.
\item \emph{ @returnType } dataFrames List : Returns the List of Table for the stach data.
}
}
}

\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-ConvertToDataFrame}{\code{StachExtensions$ConvertToDataFrame()}}
\item \href{#method-clone}{\code{StachExtensions$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-ConvertToDataFrame"></a>}}
\if{latex}{\out{\hypertarget{method-ConvertToDataFrame}{}}}
\subsection{Method \code{ConvertToDataFrame()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{StachExtensions$ConvertToDataFrame(package)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\if{latex}{\out{\hypertarget{method-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{StachExtensions$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
