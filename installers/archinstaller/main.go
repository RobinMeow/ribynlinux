package main

// TODO: https://go.dev/tour/moretypes/6

import (
	"fmt"
	"os"

	tea "charm.land/bubbletea/v2"
)

type model struct {
	choices  []string
	cursor   int
	selected map[int]struct{}
}

func initalModel() model {
	return model{
		choices:  []string{"Buy carrots", "buy cleery", "wash bed"},
		selected: make(map[int]struct{}),
	}
}

func (m model) Init() tea.Cmd {
	return nil
}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.KeyPressMsg:

		switch msg.String() {

		case "ctrl+c", "q":
			return m, tea.Quit

		case "up", "k":
			if m.cursor > 0 {
				m.cursor--
			}

		case "down", "j":
			if m.cursor < len(m.choices)-1 {
				m.cursor++
			}

		case "enter", "space", "tab":
			_, ok := m.selected[m.cursor]
			if ok {
				delete(m.selected, m.cursor)
			} else {
				m.selected[m.cursor] = struct{}{}
			}
		}
	}

	return m, nil
}

func (m model) View() tea.View {
	s := "What should we buy?\n\n"

	for i, choice := range m.choices {

		cursor := " " // no cursor
		if m.cursor == i {
			cursor = ">" // cursor
		}

		checked := " " // not checked
		if _, ok := m.selected[i]; ok {
			checked = "x" // selected
		}

		s += fmt.Sprintf("%s [%s] %s\n", cursor, checked, choice)
	}

	s += "\nPress q to quit.\n"

	return tea.NewView(s)
}

func main() {
	p := tea.NewProgram(initalModel())
	if _, err := p.Run(); err != nil {
		fmt.Printf("Alas, there's been an error: %v", err)
		os.Exit(1)
	}
}
