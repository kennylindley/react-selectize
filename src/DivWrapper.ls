{create-factory} = require \./utils
{create-ref}:React = require \react
div = create-factory \div

# used to detect when the dropdown has been added/removed from dom, 
# so we can adjust the height of the parent element
module.exports = class DivWrapper extends React.Component

    # get-default-props :: () -> Props
    @default-props =
        class-name: ""
        on-height-change: (!->) # Number -> Void

    (props) -> 
        super(props)
        @dropdown-ref = create-ref!

    # render :: () -> ReactElement
    render: ->
        div do 
            class-name: @props.class-name
            ref: @dropdown-ref
            @props.children

    # component-did-mount :: () -> Void
    component-did-mount: !->
        @props.on-height-change do 
            @dropdown-ref.current.offset-height

    # component-did-update :: () -> Void
    component-did-update: !->
        @props.on-height-change do 
            @dropdown-ref.current.offset-height

    # component-will-unmount :: () -> Void
    component-will-unmount: !->
        @props.on-height-change 0
