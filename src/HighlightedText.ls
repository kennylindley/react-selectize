React = require \react
{map} = require \prelude-ls
{create-factory} = require \./utils
div = create-factory \div
span = create-factory \span
module.exports = class HighlightedText extends React.Component

    # get-default-props :: a -> Props
    @default-props =
        partitions: [] # :: [[Int, Int, String]]
        text: ""
        style: {}
        highlight-style: {}

    # render :: a -> ReactElement
    render: ->
        div do 
            class-name: \highlighted-text
            style: @props.style
            @props.partitions |> map ([start, end, highlight]) ~>
                span do 
                    key: "#{@props.text}#{start}#{end}#{highlight}"
                    class-name: if highlight then \highlight else ''
                    style: if highlight then @props.highlight-style else {}
                    @props.text.substring start, end
