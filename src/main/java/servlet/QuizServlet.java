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
   

    // 果物画像の配列
    private static final String[] fruitImages = {
        "images/apple.png",      // りんご
        "images/banana.png",     // バナナ
        "images/grape.png",      // ぶどう
        "images/kiwi.png",       // キウイ
        "images/mango.png",      // マンゴー
        "images/orange.png",     // オレンジ
        "images/peach.png",      // 桃
        "images/pineapple.png",  // パイナップル
        "images/strawberry.png", // いちご
        "images/watermelon.png"  // すいか
    };
    
    private String currentFruitImage; // 表示するランダムな果物画像
    
    // 犬が食べた果物のリスト
    private List<String> eatenFruits = new ArrayList<>();

    public void init() throws ServletException {
        loadQuestions();
    }

    // クイズの問題をCSVファイルから読み込み、シャッフル
    private void loadQuestions() {
        questions.clear(); // クイズリストをクリアしてから読み込み
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
            eatenFruits.clear(); // 食べた果物のリストをリセット
            loadQuestions(); // ホームボタン押下時にもシャッフル
        } else if (request.getParameter("nextQuestion") != null) {
            currentQuestionIndex++;
        }

        if (currentQuestionIndex < questions.size() && currentQuestionIndex < MAX_QUESTIONS) {
            String[] currentQuestion = questions.get(currentQuestionIndex);
            request.setAttribute("question", currentQuestion[0]);
            request.setAttribute("choices", Arrays.copyOfRange(currentQuestion, 1, 5));
            request.setAttribute("correctAnswer", currentQuestion[5]);
            request.setAttribute("explanation", currentQuestion[6]);
            
            // 果物画像をランダムに選択して設定
            int randomIndex = (int) (Math.random() * fruitImages.length);
            currentFruitImage = fruitImages[randomIndex];
            request.setAttribute("fruitImage", currentFruitImage); // JSPに渡す
            
            request.setAttribute("showNextButton", false);
            RequestDispatcher dispatcher = request.getRequestDispatcher("quiz.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("score", score);
            request.setAttribute("maxQuestions", MAX_QUESTIONS); // 最大問題数をリクエストにセット
            request.setAttribute("eatenFruits", eatenFruits); // 食べた果物リストを結果ページに渡す
            RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resetParam = request.getParameter("reset");
        if ("true".equals(resetParam)) {
            score = 0; // スコアをリセット
            currentQuestionIndex = 0; // 現在の質問インデックスをリセット
            eatenFruits.clear(); // 食べた果物のリストをリセット
            loadQuestions(); // シャッフルして最初から
        } else {
            String selectedAnswer = request.getParameter("answer");
            String correctAnswer = request.getParameter("correctAnswer");
            if (selectedAnswer.equals(correctAnswer)) {
                score++;
                request.setAttribute("sound", "correct");

                // 正解した場合、現在の果物画像を食べた果物リストに追加
                eatenFruits.add(currentFruitImage);
            } else {
                request.setAttribute("sound", "incorrect");
            }
           
            String explanation = questions.get(currentQuestionIndex)[6];
            request.setAttribute("selectedAnswer", selectedAnswer);
            request.setAttribute("correctAnswer", correctAnswer);
            request.setAttribute("explanation", explanation); // 解説をリクエストにセット
            request.setAttribute("fruitImage", currentFruitImage); // 同じ果物画像をセット
            request.setAttribute("showNextButton", true); // 次の問題に進むボタンを表示
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("quiz.jsp");
        dispatcher.forward(request, response);
    }
}
