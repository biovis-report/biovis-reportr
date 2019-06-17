#' The Theme Utility
#'
#' Auto generate theme for user.
#'
#' @param data the data that is mapping with color.
#' @param theme_name theme name
#' Currently there is 19 available options: 
#' \itemize{
#' \item \code{"npg"}
#' \item \code{"aaas"}
#' \item \code{"nejm"}
#' \item \code{"lancet"}
#' \item \code{"jama"}
#' \item \code{"jco"}
#' \item \code{"ucscgb"}
#' \item \code{"d3"}
#' \item \code{"locuszoom"}
#' \item \code{"igv"}
#' \item \code{"cosmic"}
#' \item \code{"uchicago"}
#' \item \code{"startrek"}
#' \item \code{"tron"}
#' \item \code{"futurama"}
#' \item \code{"rickandmorty"}
#' \item \code{"simpsons"}
#' \item \code{"gsea"}
#' \item \code{"material"}}
#' See the \href{https://nanx.me/ggsci/articles/ggsci.html}{Scientific 
#' Journal and Sci-Fi Themed Color Palettes for ggplot2} for details.
#' @param threshold Integer. It is a continuous variable when the number of unique element is greater than threshold
#' @param reverse Logical. Should the order of the colors be reversed?
#' @param palette Palette type, only when data is a continuous variable.
#' @param alpha Transparency level, a real number in (0, 1].
#' 
#' @export get_theme
#'
#' @author Jingcheng Yang <\email{yjcyxky@@163.com}>
#'
#' @examples
#' library("ChoppyReportR")
#' theme <- get_theme(c(1:16), theme_name = 'npg')
get_theme <- function(data, theme_name = 'npg', threshold = 10, mode = 'fill',
                      reverse = False, palette = NULL, alpha = 1) {
    isContinuous <- is.continuous(data, threshold)
    if (isContinuous) {
        data_class <- 'continuous'
        pal_lst <- get_continuous_pal_lst()
    } else {
        data_class <- 'discrete'
        pal_lst <- get_discrete_pal_lst()
    }

    if (!theme_name %in% pal_lst) {
        stop(paste('The theme', theme_name, 'is not match data type.'))
    }
    
    color_func <- get_color_func(palname = theme_name, data_class = data_class, mode = mode)

    if (isContinuous) {
        palettes <- get_continuous_palette(theme_name, palettes)
        if (is.null(palettes)) {
            palette <- palettes[0]
        } else {
            palette <- palettes
        }
        p <- color_func(palette = palette, reverse = reverse, alpha = alpha)
    } else {
        p <- color_func(alpha = alpha)
    }
    return(p)
}

#' The Theme Utility
#'
#' Auto generate basic theme for user.
#'
#' @param size_ratio the ratio of the size of title
#' @param angle
#' 
#' @export get_basic_theme
#'
#' @author Jingcheng Yang <\email{yjcyxky@@163.com}>
#'
#' @examples
#' library("ChoppyReportR")
#' theme <- get_basic_theme(size_ratio = 0.9)
get_basic_theme <- function(size_ratio = 1, angle = 0, ...) {
    custom_theme <- theme_classic(...) +
                    theme(axis.text.x=element_text(angle=angle, hjust=1, size=11),
                          axis.text.y=element_text(size=11 * size_ratio),
                          text=element_text(size=12 * size_ratio),
                          legend.text=element_text(size=11 * size_ratio),
                          legend.title=element_blank(),
                          panel.background=element_rect(fill = "white"),
                          axis.line=element_line(colour='black'))
    return(custom_theme)
}

#' The Theme Utility
#'
#' Each element is number class.
#'
#' @param x an object to be tested or coerced.
#' 
#' @export is.wholenumber
#'
#' @author Jingcheng Yang <\email{yjcyxky@@163.com}>
#'
#' @examples
#' library("ChoppyReportR")
#' is.wholenumber(c(1:16))
is.wholenumber <- function(x, tol = .Machine$double.eps^0.5) {
    abs(x - round(x)) < tol
}

#' The Theme Utility
#'
#' Each element is discrete class.
#'
#' @param x an object to be tested or coerced.
#' @param threshold It is a continuous variable when the number of unique element is greater than threshold.
#' 
#' @export is.discrete
#'
#' @author Jingcheng Yang <\email{yjcyxky@@163.com}>
#'
#' @examples
#' library("ChoppyReportR")
#' is.discrete(c(1:16))
is.discrete <- function(data, threshold = 10) {
    if (is.continuous(data, threshold)) {
        return(FALSE)
    } else {
        return(TRUE)
    }
}

#' The Theme Utility
#'
#' Each element is continuous class.
#'
#' @param x an object to be tested or coerced.
#' @param threshold It is a continuous variable when the number of unique element is greater than threshold.
#' 
#' @export is.continuous
#'
#' @author Jingcheng Yang <\email{yjcyxky@@163.com}>
#'
#' @examples
#' library("ChoppyReportR")
#' is.continuous(c(1:16))
is.continuous <- function(data, threshold = 10) {
    # It is a continuous variable when the number of unique element is greater than 10
    uniqueCount <- length(unique(data))
    isCharacter <- all(is.character(data))
    if (isCharacter) {
        # It must be continuous if the variable is character class
        if (uniqueCount > threshold) {
            return(TRUE)
        } else {
            return(FALSE)
        }
    } else {
        isNumber <- all(is.double(data))
        isInteger <- all(is.wholenumber(data))
        if (isInteger && isNumber) {
            if (uniqueCount > threshold) {
                return(TRUE)
            } else {
                return(FALSE)
            }
        } else {
            # It must be continuous if the variable is double class
            return(TRUE)
        }
    }
}