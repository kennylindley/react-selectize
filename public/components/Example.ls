{filter, find, map, pairs-to-obj} = require \prelude-ls
{create-factory}:React = require \react
{div, span} = require \react-dom-factories
{find-DOM-node} = require \react-dom
AceEditor = create-factory require \./AceEditor.ls
{debounce} = require \underscore
create-react-class = require \create-react-class

module.exports = create-react-class do

    display-name: \Example

    # get-default-props :: a -> Props
    get-default-props: ->
        # height :: Int
        # initial-language :: String
        languages: [] # :: [Language], where Language :: {id :: String, name :: String, initial-content :: String, compile :: String -> String}
        style: {}

    # render :: a -> VirtualDOMElement
    render: -> 
        div do 
            class-name: \example
            style: @props.style
            div class-name: \title, @props.title
            div class-name: \description, @props.description
            div null,

                # TAB CONTAINER
                div class-name: \tab-container, 

                    # TABS (one for each language)
                    div class-name: \languages,
                        @props.languages |> map ({id, name}) ~> 
                            div do 
                                key: id
                                class-name: if id == @state.language then \selected else ''
                                on-click: ~> 
                                    <~ @set-state language: id
                                    @execute!
                                "#{name}#{if id == @state.language then ' - live editor' else ''}"

                    # CODE EDITOR
                    AceEditor do 
                        editor-id: @.props.title.replace /\s/g, '' .to-lower-case! .trim!
                        class-name: \editor
                        width: @props.width
                        height: @props.height
                        mode: "ace/mode/#{@state.language}"
                        value: @state[@state.language]
                        on-change: (value) ~> 
                            <~ @set-state {"#{@state.language}" : value}
                            @debounced-execute!
                        commands: 
                            * name: \execute
                              exec: ~> @.execute!
                              bind-key:
                                  mac: "cmd-enter"
                                  win: "ctrl-enter"
                            ...

                # ERROR (compilation & runtime)
                if !!@state.err
                    div class-name: \error, @state.err

                # OUTPUT
                else
                    div do 
                        class-name: \output
                        ref: \output

    # get-initial-state :: a -> UIState
    get-initial-state: ->
        @props.languages 
            |> map ({id, initial-content}) -> [id, initial-content]
            |> pairs-to-obj
            |> ~> it <<< 
                component: undefined
                err: undefined
                language: @props.initial-language

    # execute :: a -> Void
    execute: !-> 
        {on-execute}? = @props.languages |> find ~> it.id == @state.language
        
        <~ @set-state err: undefined

        # compile
        try
            on-execute @state[@state.language], find-DOM-node @refs.output
        catch err
            @set-state err: err.to-string!

    # component-did-mount :: a -> Void
    component-did-mount: !-> 
        @execute!
        @debounced-execute = debounce @.execute, 600