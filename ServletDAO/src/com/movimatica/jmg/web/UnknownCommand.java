package com.movimatica.jmg.web;


import com.movimatica.service.mails.Mail;
import com.movimatica.service.mails.MailHelper;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import java.io.IOException;

public class UnknownCommand extends FrontCommand {

  /** Logging. */
  //private static final Logger LOG = LoggerFactory.getLogger(UnknownCommand.class);

  public final static UnknownCommand INSTANCE = new UnknownCommand();

  @Override
  public void process() throws ServletException, IOException {

   // LOG.info("===== Io sono la pagina UNKNOWN");
   // LOG.info("===== StatusCode: " + this.response.getStatus());
   // LOG.info("===== Request URI: " + this.request.getRequestURI());
   // LOG.info("===== Request URL: " + this.request.getRequestURL());

    this.forward(this.unknownPath);
  }

}
