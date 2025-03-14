package utils;

import com.google.gson.Gson;
import com.kedu.config.SpringProvider;
import com.kedu.config.WebSocketConfig;
import com.kedu.dto.ChatDTO;
import com.kedu.dto.MembersDTO;
import com.kedu.service.ChatService;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.text.SimpleDateFormat;
import java.util.*;
@Component
@ServerEndpoint(value = "/chat", configurator = WebSocketConfig.class)
public class ChatEndPoint {

    private ChatService chatService = SpringProvider.Spring.getBean(ChatService.class);
    private static final List<Session> client = Collections.synchronizedList(new ArrayList<Session>());
    private HttpSession hSession = null;
    private Gson gson = new Gson();
    @OnOpen
    public void onConnect(Session session, EndpointConfig config) {
        client.add(session);
        this.hSession = (HttpSession) config.getUserProperties().get("hSession");
        List<ChatDTO> chatHistory = chatService.selectAll();
        Map<String, Object> data = new HashMap<>();
        data.put("list",chatHistory);
        try{
            session.getBasicRemote().sendText(gson.toJson(data));
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    @OnMessage
    public void onMessage(String message, Session session) {
        String now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
//        System.out.println("사용자 메시지 : " + message);
//        session.getBasicRemote().sendText(message);
//        System.out.println(client.size());
        Map<String, Object> data = new HashMap<>();
        MembersDTO dto = (MembersDTO) hSession.getAttribute("dto");
        data.put("sender", dto.getId());
        data.put("message", message);
        data.put("write_date", now);

        chatService.insert(new ChatDTO(dto.getId(),message,null));
        synchronized (client) { //동시성 이슈 해결
            for (Session clients : client) {
                try {
                    clients.getBasicRemote().sendText(gson.toJson(data));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
    @OnClose
    public void onClose(Session session) {
        client.remove(session);
    }
    @OnError
    public void onError(Session session, Throwable throwable) {
        client.remove(session);
        throwable.printStackTrace();
    }
}
