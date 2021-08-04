local public = {}

-- questions listed here,  you can add as many questions as you want
-- make sure the first answer is always the correct answer
public.quizQuestions = {}
public.quizQuestions["maths"] = 
	{
		{
			question = "What is 1+1?",
			answers = {"2", "3", "4", "5"}
		},
		{
			question = "What is 2x + x?",
			answers = {"3x", "4x", "5x", "6x"}
		},
		{	
			question = "If x + 10 = 15, what is x?",
			answers = {"5", "10", "21", "69"}
		},
		{
			question = "What is 4x4?",
			answers = {"16", "100", "44", "4"}
		}
	}

return public