package com.movimatica.jmg.web;

import com.movimatica.util.json.JSONArray;
import com.movimatica.util.json.JSONObject;
import org.apache.commons.fileupload.FileUploadException;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class FrontCommand {

	  /** Logging. */
	 // protected static final Logger LOG = LoggerFactory.getLogger(FrontCommand.class);
	  /**
	   * Il path e nome da utilizzare per redirigere le richieste per comandi non esistenti.
	   */
	  protected String unknownPath;
	  /**
	   * Il context della servlet.
	   */
	  protected ServletContext context;
	  /**
	   * La richiesta del client.
	   */
	  protected HttpServletRequest request;
	  /**
	   * La response su cui scrivere la risposta.
	   */
	  protected HttpServletResponse response;
	  
	  protected String defaultPath;
	  
	  /**
	   * Il testo con il percorso di base per effettuare il forward.
	   */
	  private String forwardRoot;


	  /*protected static void writeBytes(final byte[] bytes, final OutputStream outputstream) {
	    try {
	      outputstream.write(bytes);
	    } catch (IOException e) {
	     // LOG.error(String.format("Cannot write bytes: %s", e.getMessage()), e);
	    }
	  }

	  protected static void writeFile(final String filePath, final OutputStream outputstream) {
	    // creo il buffer
	    final byte[] buffer = new byte[4096];
	    try {
	      final BufferedInputStream bis = new BufferedInputStream(new FileInputStream(filePath));
	      int i;
	      while ((i = bis.read(buffer, 0, 4096)) != -1) {
	        outputstream.write(buffer, 0, i);
	      }
	      bis.close();
	    } catch (Exception e) {
	     // LOG.error(String.format("Cannot write file {%s}: %s", filePath, e.getMessage()), e);
	    }
	  }*/

	  void init(final String forwardRoot, final String unknownPath, ServletContext servletContext, HttpServletRequest servletRequest, HttpServletResponse servletResponse) {
	    this.context = servletContext;
	    this.request = servletRequest;
	    this.response = servletResponse;
	    this.forwardRoot = forwardRoot;
	    this.unknownPath = unknownPath;
	  }
	  
	  /*void init(final String defaultPath, final String forwardRoot, final String unknownPath, ServletContext servletContext, HttpServletRequest servletRequest, HttpServletResponse servletResponse) {
		    this.context = servletContext;
		    this.request = servletRequest;
		    this.response = servletResponse;
		    this.forwardRoot = forwardRoot;
		    this.unknownPath = unknownPath;
		    this.defaultPath = defaultPath;
	  }*/


	 /* protected void goToUnauthorized() throws ServletException, IOException {
	    this.goToError("unauthorized_access");
	  }*/

	  /*  protected void unauthorized() throws ServletException, IOException {
	      	request.setAttribute("error", "unauthorized_access");
	      	forward("/error");
		}*/

	  
	///////////////////////////////////////////////////////////////////////////////////////
	  /**
	   * Effettua il redirect ad una nuova pagina, cambiando quindi l'url.
	   * @param url l'url a cui redirigere la risposta, assoluto dalla root della webapp.
	   * @throws IOException se si verifica un errore durante il redirect
	   */


	public abstract void process() throws ServletException, IOException, FileUploadException;

	protected void redirect(final String url) throws IOException {
	// Devo aggiungere l'url di base della servlet FrontController
	this.response.sendRedirect(this.response.encodeRedirectURL(this.request.getContextPath() + "/web" + url));
	}

	protected void forward(final String target) throws ServletException, IOException {
		RequestDispatcher dispatcher = this.context.getRequestDispatcher(String.format(this.forwardRoot, target));
		dispatcher.forward(this.request, this.response);
	}
	private void goToError(final String errorCode) throws ServletException, IOException {
		this.request.setAttribute("error", errorCode);
		this.forward("/error");
	}

	  /*protected void redirectVecchioSito(final String url) throws IOException {
	    // Devo aggiungere l'url di base della servlet FrontController
	    this.response.sendRedirect(this.response.encodeRedirectURL(this.request.getContextPath() + url));
	  }*/

		/*protected void prova(final String prefix){
			LOG.info(String.format("==== {%s} response committed:%b ", prefix, this.response.isCommitted()));
		}*/



	  /*protected void writeText(final String text) throws IOException {
	    PrintWriter out = this.response.getWriter();
	    this.response.setContentType("text/plain");
	    this.response.setCharacterEncoding("UTF-8");
	    out.print(text);
	    out.flush();
	  }

	  protected void writeJson(final JSONArray json) throws IOException {
	    PrintWriter out = this.response.getWriter();
	    this.response.setContentType("application/json");
	    this.response.setCharacterEncoding("UTF-8");
	    out.print(json.toJSONString());
	    out.flush();
	  }

	  protected void writeJson(final JSONObject<String, Object> json) throws IOException {
	    PrintWriter out = this.response.getWriter();
	    this.response.setContentType("application/json");
	    this.response.setCharacterEncoding("UTF-8");
	    out.print(json.toString());
	    out.flush();
	  }

	  protected void writeJson(final String text) throws IOException {
		PrintWriter out = this.response.getWriter();
	    this.response.setContentType("application/json");
	    this.response.setCharacterEncoding("UTF-8");
		out.print(text);
	    out.flush();
	  }


	  protected void writeCsv(final String text, final String fileName) throws IOException {
	    this.response.setHeader("Content-Type", "test/csv");
	    this.response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
	    this.response.setCharacterEncoding("UTF-8");
	    OutputStream out = this.response.getOutputStream();
	    out.write(text.getBytes(StandardCharsets.UTF_8));
	    out.flush();
	    out.close();
	  }

	  protected void downloadFile(final String fileName, final byte[] fileContent) throws IOException {
	    this.response.setHeader("Content-Type", this.context.getMimeType(fileName));
	    this.response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
	    OutputStream out = this.response.getOutputStream();
	    out.write(fileContent);
	    out.flush();
	    out.close();
	  }

	  protected void include(final String target) throws ServletException, IOException {
	      RequestDispatcher view = request.getRequestDispatcher(String.format(this.forwardRoot, target));
	      view.include(request, response);
	      RequestDispatcher dispatcher = this.context.getRequestDispatcher(String.format(this.forwardRoot, target));
	      dispatcher.include(this.request, this.response);
	  }*/
	}