package servlet;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;  // ここを追加
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/quiz")
public class QuizServlet extends HttpServlet {
    private static final int MAX_QUESTIONS = 10; // 問題数の制限を10に設定
    private List<String[]> questions = new ArrayList<>();
    private int score = 0;
    private int currentQuestionIndex = 0;
    private String previousCorrectAnswer = "";

    public void init() throws ServletException {
        loadQuestions();
    }

    private void loadQuestions() {
        try (BufferedReader br = new BufferedReader(new FileReader(getServletContext().getRealPath("/WEB-INF/quiz_questions.csv")))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] questionData = line.split(",");
                questions.add(questionData);
            }
            // クイズの問題をシャッフル
            Collections.shuffle(questions);
            // MAX_QUESTIONSだけを保持
            if (questions.size() > MAX_QUESTIONS) {
                questions = questions.subList(0, MAX_QUESTIONS);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String startParam = request.getParameter("start");
        if ("true".equals(startParam)) {
            // スコアをリセット
            score = 0;
            currentQuestionIndex = 0;
        } else if (request.getParameter("nextQuestion") != null) {
            currentQuestionIndex++;
        }
        
        if (currentQuestionIndex < questions.size() && currentQuestionIndex < MAX_QUESTIONS) {
            String[] currentQuestion = questions.get(currentQuestionIndex);
            request.setAttribute("question", currentQuestion[0]);
            request.setAttribute("choices", Arrays.copyOfRange(currentQuestion, 1, 5));
            request.setAttribute("correctAnswer", currentQuestion[5]);
            request.setAttribute("explanation", currentQuestion[6]);
            request.setAttribute("showNextButton", false);
            RequestDispatcher dispatcher = request.getRequestDispatcher("quiz.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("score", score);
            request.setAttribute("maxQuestions", MAX_QUESTIONS); // 問題数をリクエストにセット
            RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if ("true".equals(request.getParameter("reset"))) {
            score = 0; // スコアをリセット
            currentQuestionIndex = 0; // 現在の質問インデックスをリセット
        } else {
            // 通常の解答処理
            String selectedAnswer = request.getParameter("answer");
            String correctAnswer = request.getParameter("correctAnswer");
            if (selectedAnswer.equals(correctAnswer)) {
                score++;
                request.setAttribute("sound", "correct");
            } else {
                request.setAttribute("sound", "incorrect");
            }
            previousCorrectAnswer = correctAnswer;
            String explanation = questions.get(currentQuestionIndex)[6]; // 解説を取得
            request.setAttribute("selectedAnswer", selectedAnswer);
            request.setAttribute("correctAnswer", correctAnswer);
            request.setAttribute("explanation", explanation); // 解説をリクエストにセット
            request.setAttribute("showNextButton", true); // 次の問題に進むボタンを表示
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("quiz.jsp");
        dispatcher.forward(request, response);
    }
}

