package com.movimatica.jmg.web;
import com.movimatica.util.StringUtils;
import org.apache.commons.fileupload.FileUploadException;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * La servlet che viene utilizzata come Front Controller, che quindi elabora
 * tutte le richieste e le redireziona alle azioni appropriate.<br>
 * Per utilizzare la servlet occorre definirla nel file {@code web.xml} con un
 * testo simile al seguente
 * <pre>
 *   &lt;servlet&gt;
 *     &lt;servlet-name&gt;front-controller&lt;/servlet-name&gt;
 *     &lt;servlet-class&gt;com.movimatica.common.mvc.FrontControllerServlet&lt;/servlet-class&gt;
 *     &lt;init-param&gt;
 *       &lt;param-name&gt;commandClassPattern&lt;/param-name&gt;
 *       &lt;param-value&gt;com.movimatica.infomobitaly.mvc.%sCommand&lt;/param-value&gt;
 *     &lt;/init-param&gt;
 *     &lt;init-param&gt;
 *       &lt;param-name&gt;forwardRoot&lt;/param-name&gt;
 *       &lt;param-value&gt;/WEB-INF/jsp/%s.jsp&lt;/param-value&gt;
 *     &lt;/init-param&gt;
 *         &lt;init-param&gt;
 *       &lt;param-name&gt;errorPath&lt;/param-name&gt;
 *       &lt;param-value&gt;error&lt;/param-value&gt;
 *     &lt;/init-param&gt;
 *   &lt;/servlet&gt;
 *   &lt;servlet-mapping&gt;
 *     &lt;servlet-name&gt;front-controller&lt;/servlet-name&gt;
 *     &lt;url-pattern&gt;/mvc/*&lt;/url-pattern&gt;
 *   &lt;/servlet-mapping&gt;
 * </pre> In questo esempio abbiamo creato la servlet con il nome
 * {@code front-controller} che risponde a tutte le richieste sotto /mvc,
 * {@code /mvc/*}.<br>
 * Ci sono tre parametri di inizializzazione che possono essere specificati:
 * <ul>
 * <li><strong>commandClassPattern</strong>: il package di base in cui cercare
 * le classi che gestiscono i singoli comandi. Se non specificato viene usato il
 * valore di default {@code %sCommand}. E' quindi <strong>caldamente</strong>
 * consigliato di specificarlo</li>
 * <li><strong>forwardRoot</strong>: quando si effettua il forward ad una pagina
 * JSP, questo parametro indica da quale base partire. Occorre definire
 * {@code %s} che verr&agrave; sostituito a runtime con il path indicato
 * (spiegato sotto). Se non specificato viene usato il valore predefinito
 * {@code /WEB-INF/jsp/%s.jsp}</li>
 * <li><strong>unknownPath</strong>: permette di specificare il percorso della
 * pagina da visualizzare quando viene inserito un comando non riconosciuto. Il
 * percorso completo della pagina sar&agrave; composto da {@code forwardRoot} a
 * cui il {@code %s} verr&agrave; sostituito da {@code unknownPath}. Se non
 * specificato viene usato il valore predefinito {@code unknown}</li>
 * </ul>
 * La servlet pu&ograve; gestire diversi tipi di comando.
 * <ul>
 * <li><strong>simpleCommand</strong>, come ad esempio
 * {@code vehicleList o userEdit}. Questo nome verr&agrave; sostituito al
 * {@code %s} del parametro di configurazione {@code commandClassPattern}
 * mettendo la prima lettera del comando in maiuscolo. Se usiamo l'esempio
 * precedente, verranno cercate le classi
 * {@code com.movimatica.infomobitaly.mvc.VehicleListCommand} e
 * {@code com.movimatica.infomobitaly.mvc.UserEditCommand}</li>
 * <li><strong>complexCommand</strong>, come ad esempio
 * {@code vehicles/list o users/edit}. In questo caso il testo prima dell'ultimo
 * token (cio&egrave; prima dell'ultimo /) verr&agrave; trasformato in package,
 * mentre all'ultimo token verr&agrave; messa in maiuscolo la prima lettera.
 * Utilizzando l'esempio, verranno cercate le classi
 * {@code com.movimatica.infomobitaly.vehicles.ListCommand} e
 * {@code com.movimatica.infomobitaly.users.EditCommand}.<br>
 * Questo secondo metodo serve per raggruppare meglio i vari comandi in diverse
 * tipologie.
 * </li>
 * </ul>
 */
@WebServlet(name="FrontControllerServlet", urlPatterns = {"/FrontControllerServlet"})
public class FrontControllerServlet extends HttpServlet {
	  /** Numero per la serializzazione nel formato yyyyMMddHHmm. */
		private static final long serialVersionUID = 201909171755L;

    /**
     * Logging.
     */
    //private static final Logger LOG = LoggerFactory.getLogger(FrontControllerServlet.class);

    private String commandClassPattern = "%s%sCommand";
    private String forwardRoot = "/WEB-INF/jsp/%s.jsp";
    private String errorPath = "error";
    private String defaultIndex = "index";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    	FrontCommand command = this.fromPathInfoToClass(request);
        command.init(this.forwardRoot, this.errorPath, this.getServletContext(), request, response);
        try {
            command.process();
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        this.doGet(request, response);
    }

    public void init(final ServletConfig servletConfig) throws ServletException {
        super.init(servletConfig); // da lasciare altrimenti diventa null
        this.commandClassPattern = StringUtils.getFirstNotEmpty(servletConfig.getInitParameter("commandClassPattern"), this.commandClassPattern);
        this.forwardRoot = StringUtils.getFirstNotEmpty(servletConfig.getInitParameter("forwardRoot"), this.forwardRoot);
        this.errorPath = StringUtils.getFirstNotEmpty(servletConfig.getInitParameter("errorPath"), this.errorPath);
        this.defaultIndex = StringUtils.getFirstNotEmpty(servletConfig.getInitParameter("defaultIndex"), this.defaultIndex);
    }

    private FrontCommand fromPathInfoToClass(final HttpServletRequest request) {
        String myPathInfo = request.getPathInfo();
        if (StringUtils.isEmpty(myPathInfo)) {return UnknownCommand.INSTANCE;}  //pagina sbagliata: UnknownCommand
        if (myPathInfo.endsWith("/") && !this.defaultIndex.isEmpty()){ myPathInfo += this.defaultIndex;}    //home page: index
        String classToFind = null;
        String[] tokens = myPathInfo.substring(1).split("/"); // dal pathInfo tolgo il primo /
        StringBuilder toAppend = new StringBuilder();
        for (int index = 0; index < tokens.length - 1; index++)
            toAppend.append(tokens[index]).append('.');
        toAppend.append(StringUtils.capitalize(tokens[tokens.length - 1]));
        try {
            classToFind = String.format(this.commandClassPattern, toAppend.toString()); //commandClassPattern: %s%sCommand
            Class type = Class.forName(classToFind);
            return (FrontCommand) type.asSubclass(FrontCommand.class).newInstance();
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            System.out.println(e.getMessage());
        }
        return UnknownCommand.INSTANCE;
    }

}
