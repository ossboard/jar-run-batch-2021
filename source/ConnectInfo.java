package com.konantech.spring.core;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

@Component
public class ConnectInfo {

    @Value("${server.title}")
    private String title;

    @Value("${server.port}")
    private int serverPort;

    @Value("${server.servlet.context-path}")
    private String serverContextPath;

    @PostConstruct
    public void init() {
        String port = (serverPort == 80) ? "" : ":" + serverPort;
        String path = "http://127.0.0.1" + port + serverContextPath;
        StringBuffer sb = new StringBuffer();
        sb.append("--------------------------------------------").append("\n");
        sb.append(title).append("\n");
        sb.append("--------------------------------------------").append("\n");
        sb.append("Available on: ").append(path).append("\n");
        sb.append("Hit CTRL-C to stop the server").append("\n");
        sb.append("--------------------------------------------").append("\n");
        System.out.println(sb.toString());
    }

}