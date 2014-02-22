package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

type Character struct {
	Name         string
	Mentions     []int64
	MentionCount int64
}

func main() {

	characters := make(map[string]Character)

	file, _ := os.Open("texts/war_and_peace.out.txt")
	defer file.Close()
	reader := bufio.NewReader(file)

	var i int64 = 0

	for {
		//read sentenses
		statement, err := reader.ReadString('.')
		if err != nil {
			break
		}

		words := strings.Split(statement, " ")

		for _, word := range words {
			// its a person
			if strings.Contains(word, "/PERSON") {
				person := strings.Replace(word, "/PERSON", "", -1)
				person = strings.Replace(person, " ", "", -1)
				person = strings.Replace(person, "\n", "", -1)
				person = strings.Replace(person, "\r", "", -1)
				person = strings.Replace(person, "\t", "", -1)

				character, present := characters[person]

				if !present {
					character = Character{Name: person, MentionCount: 1, Mentions: []int64{}}
				}
				character.Mentions = append(character.Mentions, i)
				character.MentionCount++
				characters[person] = character
			}
		}
		i++
	}

	for _, v := range characters {
		fmt.Printf("%s \t\t |%d| %v\n", v.Name, v.MentionCount, v.Mentions)
	}

	fmt.Printf("Number of characters: %d\n", len(characters))
}
