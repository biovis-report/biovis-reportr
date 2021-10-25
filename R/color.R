#' The Color Utility
#'
#' Get color function from BioVisReportR namespace.
#'
#' @param palname palette name
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
#' @param mode the corresponding scales
#' Currently there is 2 available options:
#' \itemize{
#' \item \code{"fill"}
#' \item \code{"color"}}
#' 
#' @export get_color_func
#'
#' @author Jingcheng Yang <\email{yjcyxky@@163.com}>
#' 
#' @references
#' \url{https://nanx.me/ggsci/articles/ggsci.html}
#'
#' @examples
#' library("BioVisReportR")
#' nejm_fill_func <- get_color_func('nejm', 'fill')
get_color_func <- function(palname='npg', data_class='discrete', mode='fill') {
    modes <- get_mode_lst()

    if (data_class == 'continuous') {
        palnames <- get_continuous_pal_lst()
    } else if (data_class == 'discrete') {
        palnames <- get_discrete_pal_lst()
    } else {
        stop(paste("data_class only support two options: continuous and discrete"))
    }

    if (mode %in% modes) {
        if (palname %in% palnames) {
            func_name <- paste('scale', mode, palname, sep='_')
            func <- getFromNamespace(func_name, 'BioVisReportR')
            return(func)
        } else {
            stop(paste("No such palname:", palname))
        }
    } else {
        stop(paste("No such mode:", mode))
    }
}

#' The Color Utility
#' 
#' Show all supported modes
#' 
#' @export get_mode_lst
#' 
#' @author Jingcheng Yang <\email{yjcyxky@@163.com}>
#' 
#' @examples
#' library("BioVisReportR")
#' modes <- get_mode_lst()
get_mode_lst <- function() {
    return(c('color', 'fill'))
}

#' The Color Utility
#' 
#' Show all supported palettes.
#' 
#' @export get_discrete_pal_lst
#' 
#' @author Jingcheng Yang <\email{yjcyxky@@163.com}>
#' 
#' @examples
#' library("BioVisReportR")
#' palettes <- get_discrete_pal_lst()
get_discrete_pal_lst <- function() {
    return(c(
        'NPG' = 'npg',
        'AAAS' = 'aaas',
        'NEJM' = 'nejm',
        'Lancet' = 'lancet',
        'JAMA' = 'jama',
        'JCO' = 'jco',
        'UCSCGB' = 'ucscgb',
        'D3' = 'd3',
        'LocusZoom' = 'locuszoom',
        'IGV' = 'igv',
        'COSMIC' = 'cosmic',
        'UChicago' = 'uchicago',
        'Star Trek' = 'startrek',
        'Tron Legacy' = 'tron',
        'Futurama' = 'futurama',
        'Rich and Morty' = 'rickandmorty',
        'The Simpsons' = 'simpsons'
    ))
}

#' The Color Utility
#' 
#' Show all supported palettes.
#' 
#' @export get_continuous_pal_lst
#' 
#' @author Jingcheng Yang <\email{yjcyxky@@163.com}>
#' 
#' @examples
#' library("BioVisReportR")
#' palettes <- get_continuous_pal_lst()
get_continuous_pal_lst <- function() {
    return(c(
        'GSEA' = 'gsea',
        'Material Design' = 'material'
    ))
}

#' The Color Utility
#' 
#' Show palette supported by Continuous Color Palettes.
#' 
#' @param palname the continuous palette name
#' Currently there is 19 available options: 
#' \itemize{
#' \item \code{"gsea"}
#' \item \code{"material"}}
#' See the \href{https://nanx.me/ggsci/articles/ggsci.html}{Scientific 
#' Journal and Sci-Fi Themed Color Palettes for ggplot2} for details.
#' @param palette color palette
#' Currently there is 20 available options: 
#' \itemize{
#' \item \code{"blue-grey"}
#' \item \code{"grey"}
#' \item \code{"brown"}
#' \item \code{"deep-orange"}
#' \item \code{"orange"}
#' \item \code{"amber"}
#' \item \code{"yellow"}
#' \item \code{"lime"}
#' \item \code{"light-green"}
#' \item \code{"green"}
#' \item \code{"teal"}
#' \item \code{"cyan"}
#' \item \code{"light-blue"}
#' \item \code{"blue"}
#' \item \code{"indigo"}
#' \item \code{"deep-purple"}
#' \item \code{"purple"}
#' \item \code{"red"}
#' \item \code{"pink"}
#' \item \code{"default"}}
#' See the \href{https://nanx.me/ggsci/articles/ggsci.html}{Scientific 
#' Journal and Sci-Fi Themed Color Palettes for ggplot2} for details.
#' 
#' @export get_continuous_palette
#' 
#' @author Jingcheng Yang <\email{yjcyxky@@163.com}>
#' 
#' @examples
#' library("BioVisReportR")
#' palettes <- get_continuous_palette('material', palettes = 'red')
get_continuous_palette <- function(palname, palettes = NULL) {
    palettes <- c(
        'red' = 'red',
        'pink' = 'pink',
        'purple' = 'purple',
        'deep-purple' = 'deep-purple',
        'indigo' = 'indigo',
        'blue' = 'blue',
        'light-blue' = 'light-blue',
        'cyan' = 'cyan',
        'teal' = 'teal',
        'green' = 'green',
        'light-green' = 'light-green',
        'lime' = 'lime',
        'yellow' = 'yellow',
        'amber' = 'amber',
        'orange' = 'orange',
        'deep-orange' = 'deep-orange',
        'brown' = 'brown',
        'grey' = 'grey',
        'blue-grey' = 'blue-grey'         
    )

    if (palname == 'material') {
        if (is.null(palette)) {
            return(palettes)
        } else {
            if (palette %in% palettes) {
                return(palette)
            } else {
                return('red')
            }
        }
    } else if (palname == 'gsea') {
        return(c(
            'default' = 'default'
        ))
    }
}