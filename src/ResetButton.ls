{create-factory} = require \./utils
React = require \react
path = create-factory \path
SvgWrapper = create-factory require \./SvgWrapper

module.exports = class ResetButton extends React.PureComponent

    # render :: a -> ReactElement
    render: ->
        SvgWrapper do 
            class-name: \react-selectize-reset-button
            style: 
                width: 8
                height: 8
            path d: "M0 0 L8 8 M8 0 L 0 8"
