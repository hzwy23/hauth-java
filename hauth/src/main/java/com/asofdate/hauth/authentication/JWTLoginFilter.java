package com.asofdate.hauth.authentication;

import com.asofdate.hauth.dto.LoginMsgDTO;
import com.asofdate.utils.Hret;
import com.google.gson.GsonBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static com.asofdate.utils.CryptoAES.aesEncrypt;

/**
 * Created by hzwy23 on 2017/5/18.
 */
public class JWTLoginFilter extends AbstractAuthenticationProcessingFilter {

    private final Logger logger = LoggerFactory.getLogger(JWTLoginFilter.class);

    public JWTLoginFilter(String url, AuthenticationManager authManager) {
        super(new AntPathRequestMatcher(url));
        setAuthenticationManager(authManager);
    }

    @Override
    public Authentication attemptAuthentication(
            HttpServletRequest req, HttpServletResponse res)
            throws AuthenticationException, IOException, ServletException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        if (password != null) {
            password = aesEncrypt(password);
        }

        // 返回一个验证令牌
        return getAuthenticationManager().authenticate(
                new UsernamePasswordAuthenticationToken(
                        username,
                        password
                )
        );
    }

    /*
    * 验证成功后，调用这个方法
    * */
    @Override
    protected void successfulAuthentication(
            HttpServletRequest req,
            HttpServletResponse res, FilterChain chain,
            Authentication auth) throws IOException, ServletException {
        JwtService.addAuthentication(res, auth.getName());
    }

    /*
    * 验证失败后，调用这个方法
    * */
    @Override
    protected void unsuccessfulAuthentication(
            HttpServletRequest request,
            HttpServletResponse response,
            AuthenticationException failed) throws IOException, ServletException {
        response.setContentType("application/json");
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);

        LoginMsgDTO loginMsgDTO = new GsonBuilder().create().fromJson(failed.getMessage(), LoginMsgDTO.class);
        String retMsg = Hret.error(loginMsgDTO.getRetCode(), loginMsgDTO.getMessage(), loginMsgDTO);
        response.getOutputStream().println(retMsg);
    }
}