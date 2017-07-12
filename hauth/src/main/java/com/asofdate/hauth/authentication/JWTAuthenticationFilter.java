package com.asofdate.hauth.authentication;

import io.jsonwebtoken.SignatureException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.AccessDeniedException;

/**
 * Created by hzwy23 on 2017/5/18.
 */
public class JWTAuthenticationFilter extends GenericFilterBean {

    private final Logger logger = LoggerFactory.getLogger(JWTAuthenticationFilter.class);

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain filterChain)
            throws IOException, ServletException {
        HttpServletRequest r = (HttpServletRequest) request;

        try {

            Authentication authentication = JwtService.getAuthentication(r);

            SecurityContextHolder.getContext().setAuthentication(authentication);

            filterChain.doFilter(request, response);

        } catch (AuthenticationException | SignatureException e) {
            HttpServletResponse w = (HttpServletResponse) response;
            clearJWT(w);
            logger.error(e.getMessage());
        } catch (AccessDeniedException e) {
            logger.error(e.getMessage());
            HttpServletResponse w = (HttpServletResponse) response;
            clearJWT(w);
            w.sendRedirect("/");
        }
    }

    //清除客户端的jwt token
    private void clearJWT(HttpServletResponse response) {
        Cookie cookie = new Cookie("Authorization", "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}
