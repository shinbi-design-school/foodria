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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/quiz")
public class QuizServlet extends HttpServlet {
    private static final int MAX_QUESTIONS = 10; // クイズの最大問題数
    private List<String[]> questions = new ArrayList<>();
    private int score = 0;
    private int currentQuestionIndex = 0;
    private String previousCorrectAnswer = "";

    // 野菜画像の配列
    private static final String[] vegetableImages = {
        "images/food.gif",       // トマト
        "images/watermelon1.gif", // スイカ
        "images/carrot1.gif",    // ニンジン
        "images/chestnut1.gif",  // クリ
        "images/sweetp1.gif",    // さつまいも
        "images/potato1.gif",    // じゃがいも
        "images/pumpkin2.gif",   // かぼちゃ
        "images/grape2.gif",     // ぶどう
        "images/radish9.gif",    // 大根
        "images/eggplant2.gif"   // ナス
    };
    
    private String currentVegetableImage; // 表示するランダムな野菜画像
    
    // 犬が食べた野菜のリスト
    private List<String> eatenVegetables = new ArrayList<>();

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
            Collections.shuffle(questions); // クイズの問題をシャッフル
            if (questions.size() > MAX_QUESTIONS) {
                questions = questions.subList(0, MAX_QUESTIONS); // MAX_QUESTIONSだけを保持
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String startParam = request.getParameter("start");
        if ("true".equals(startParam)) {
            score = 0; // スコアをリセット
            currentQuestionIndex = 0;
            eatenVegetables.clear(); // 食べた野菜のリストをリセット
        } else if (request.getParameter("nextQuestion") != null) {
            currentQuestionIndex++;
        }

        if (currentQuestionIndex < questions.size() && currentQuestionIndex < MAX_QUESTIONS) {
            String[] currentQuestion = questions.get(currentQuestionIndex);
            request.setAttribute("question", currentQuestion[0]);
            request.setAttribute("choices", Arrays.copyOfRange(currentQuestion, 1, 5));
            request.setAttribute("correctAnswer", currentQuestion[5]);
            request.setAttribute("explanation", currentQuestion[6]);
            
            // 野菜画像をランダムに選択して設定
            int randomIndex = (int) (Math.random() * vegetableImages.length);
            currentVegetableImage = vegetableImages[randomIndex];
            request.setAttribute("vegetableImage", currentVegetableImage); // JSPに渡す
            
            request.setAttribute("showNextButton", false);
            RequestDispatcher dispatcher = request.getRequestDispatcher("quiz.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("score", score);
            request.setAttribute("maxQuestions", MAX_QUESTIONS); // 最大問題数をリクエストにセット
            request.setAttribute("eatenVegetables", eatenVegetables); // 食べた野菜リストを結果ページに渡す
            RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if ("true".equals(request.getParameter("reset"))) {
            score = 0; // スコアをリセット
            currentQuestionIndex = 0; // 現在の質問インデックスをリセット
            eatenVegetables.clear(); // 食べた野菜のリストをリセット
        } else {
            String selectedAnswer = request.getParameter("answer");
            String correctAnswer = request.getParameter("correctAnswer");
            if (selectedAnswer.equals(correctAnswer)) {
                score++;
                request.setAttribute("sound", "correct");

                // 正解した場合、現在の野菜画像を食べた野菜リストに追加
                eatenVegetables.add(currentVegetableImage);
            } else {
                request.setAttribute("sound", "incorrect");
            }
            previousCorrectAnswer = correctAnswer;
            String explanation = questions.get(currentQuestionIndex)[6];
            request.setAttribute("selectedAnswer", selectedAnswer);
            request.setAttribute("correctAnswer", correctAnswer);
            request.setAttribute("explanation", explanation); // 解説をリクエストにセット
            request.setAttribute("vegetableImage", currentVegetableImage); // 同じ野菜画像をセット
            request.setAttribute("showNextButton", true); // 次の問題に進むボタンを表示
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("quiz.jsp");
        dispatcher.forward(request, response);
    }
}
