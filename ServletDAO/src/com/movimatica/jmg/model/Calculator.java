package com.movimatica.jmg.model;

public class Calculator {
	
		//private final double cargo;
	  //private final double range;
	  //private final double altitude;
	  private final int rotatingHeadPosition;
	  private final double cargo;
	  private final double altitude;
	  private final double radius;

	  private final Ballast ballast;
	  private final Accessory accessory;
	  private final Machine machine;
	  
	  private final double swingAngle;						/*angoloBreandegio*/
	  private final double lbr; 							/*distanzaFulcroBraccioAsseGancioLbr*/
	  private final double dbr;								/*distanzaFulcroBraccioBaricentroBraccioDbr*/
	  private final double rar;								/*raggioAsseRotazioneRar*/
	  private final double totalWeight;						/*pesoTotalePtot*/
	  private final double DistanceAverageCenterOfGravity;	/*distanzaMediaBaricentroDtot*/
	  private final double axialLoad;						/*caricoAssiale_Ax*/
	  private final double overturningMoment;				/*momentoRibaltante_Mr*/
	  private final double loadEccentricity;				/*eccentricitaCarico*/
	  private final double frontAxisLoad;					/*caricoAsseAnteriore_Rant*/
	  private final double rearAxisLoad;					/*caricoAssePosteriore_Rpost*/
	  private final double frontWheelsLoad;					/*caricoOgniRuotaAnterioreRrant*/
	  private final double rearWheelsLoad;					//caricoOgniRuotaPosterioreRrpost;
	  private final double stabilizersLoad;					//caricoOgniStabiRstab;
	  private final double groundPressure;					//pressioneAlSuolo;

	  private final StringBuilder steps = new StringBuilder();
	  
	  public String getSteps(){return this.steps.toString();}

	  public Machine getMachine(){return this.machine;}
	  
	  public Accessory getAccessory() {return this.accessory;}
	  
	  public Ballast getBallast() {return this.ballast;}
	  
	  public double getCargo() {return this.cargo;}
	  
	  public double getAltitude() {return this.altitude;}
	  
	  public double getRadius() {return this.radius;}
	  
	  public double getRotatingHeadPosition() {return this.rotatingHeadPosition;}
	  
	  
	  public double getstabilizersLoad()  {    return this.stabilizersLoad;  }

	  public double getrearAxisLoad()  { return this.rearAxisLoad; }

	  public String getrearAxisLoadFormula(){
	    StringBuilder text = new StringBuilder();
	    text.append("( -Ax:");
	    text.append(this.axialLoad);
	    text.append(" * eccentricita:");
	    text.append(String.format("%.4f", this.loadEccentricity));
	    text.append(" + Pvg:");
	    text.append(this.machine.getEmptyWeight());
	    text.append(" * Dvg:");
	    text.append(this.machine.getDvg());
	    text.append(" + Ptot:");
	    text.append(this.totalWeight);
	    text.append(" * Dtot:");
	    text.append(String.format("%.4f", this.DistanceAverageCenterOfGravity) );
	    text.append(" ) / Ip:");
	    text.append(this.machine.getWheelBase());
	    return text.toString();
	  }

	  private double calcolaRPOST()	  {
	    return (-this.axialLoad * this.loadEccentricity + this.machine.getEmptyWeight() * this.machine.getDvg() + this.totalWeight * this.DistanceAverageCenterOfGravity) / this.machine.getWheelBase();
	  }

	  public double getfrontAxisLoad()	  {	    return this.frontAxisLoad;	  }

	  public String getfrontAxisLoadFormula()	  {
	    StringBuilder text = new StringBuilder();
	    text.append("( Ax:");
	    text.append(this.axialLoad);
	    text.append(" * ( eccentricita:");
	    text.append(String.format("%.4f", this.loadEccentricity) );
	    text.append(" + Ip:").append(this.machine.getWheelBase());
	    text.append(" ) + Pvg:");
	    text.append(this.machine.getEmptyWeight());
	    text.append(" * ( Ip:").append(this.machine.getWheelBase());
	    text.append(" - Dvg:");
	    text.append(this.machine.getDvg());
	    text.append(" ) + Ptot:");
	    text.append(this.totalWeight);
	    text.append(" * ( Ip:").append(this.machine.getWheelBase());
	    text.append(" - Dtot:");
	    text.append(String.format("%.4f", this.DistanceAverageCenterOfGravity) );
	    text.append(" ) ) / Ip:");
	    text.append(this.machine.getWheelBase());
	    return text.toString();
	  }

	  private double calcolaRANT()	  {
	    return (this.axialLoad * (this.loadEccentricity + this.machine.getWheelBase()) + this.machine.getEmptyWeight() * (this.machine.getWheelBase() - this.machine.getDvg())
	        + this.totalWeight * (this.machine.getWheelBase() - this.DistanceAverageCenterOfGravity)) / this.machine.getWheelBase();
	  }

	  public double getoverturningMoment()	  {	    return this.overturningMoment;	  }

	  public String getoverturningMomentFormula()	  {
	    StringBuilder text = new StringBuilder();
	    text.append("Q:").append(this.cargo);
	    text.append(" * Rar:").append(this.rar);
	    text.append(" + Pbr:").append(this.machine.getArmWeight());
	    text.append(" * ( Dbr:").append(String.format("%.4f", this.dbr));
	    text.append(" * cos(").append(String.format("%.4f", this.swingAngle) );
	    text.append(") - Dfb:").append(this.machine.getDf()) ;
	    text.append(" ) + Pjib:").append(this.accessory.getWeight());
	    text.append(" * ( Rar:").append(this.rar);
	    text.append(" - Djib:").append(this.accessory.getDistance());
	    text.append(" * cos(").append(String.format("%.4f", this.swingAngle));
	    text.append(" ) )");
	    return text.toString();
	  }

	  private double calcolaOverturningMoment()	  {
	    return this.cargo * this.rar
	        + this.machine.getArmWeight() * (this.dbr * Math.cos(Math.toRadians(this.swingAngle)) - this.machine.getDf())
	        + this.accessory.getWeight() * (this.rar - this.accessory.getDistance() * Math.cos(Math.toRadians(this.swingAngle)));
	    	// + this.accessory.getWeight() * (this.rar - this.accessory.getDistance());
	  }

	  public double getDistanceAverageCenterOfGravity()	  {	    return this.DistanceAverageCenterOfGravity;	  }

	  public double getFrontWheelGroungPressure()	  {
	    return this.machine.getMultiplierFrontGroundPressure() * (this.getfrontAxisLoad() / this.machine.getFrontWheel()) + this.machine.getOffsetFrontGroudPressure();
	    // 0.00075D * x + 7; 0.000698 * x + 7.3243;
	  }

	  public double getRearWheelGroungPressure()	  {
	    return this.machine.getMultiplierRearGroudPressure() * (this.getrearAxisLoad() / this.machine.getRearWheel()) + this.machine.getOffsetRearGroudPressure();
	    // 0.00075D * x + 7; 0.000698 * x + 7.3243;
	  }

	  public double getFrontWheelCrushingArea()	  {	    return this.frontWheelsLoad / this.getFrontWheelGroungPressure();	  }

	  public double getRearWheelCrushingArea()	  {	    return this.rearWheelsLoad / this.getRearWheelGroungPressure();	  }

	  public boolean isValidrearAxisLoad()	  {	    return this.rearAxisLoad >= 300D;	  }
	  
	  public String getDistanceAverageCenterOfGravityFormula()	  {
	    StringBuilder text = new StringBuilder();
	    text.append("( peso_batteria_Pb:");
	    text.append(this.machine.getBatteryWeight());
	    text.append(" * distanza_baricentro_batteria_Db:");
	    text.append(this.machine.getDb());
	    text.append(" + ballastKgMm:");
	    text.append(String.format("%.0f", this.ballast.getKgMm()));
	    text.append(") / Ptot:");
	    text.append(this.totalWeight);
	    return text.toString();
	  }

	  private double calcolaDTOT()	  {	    return (this.machine.getBatteryWeight() * this.machine.getDb() + this.ballast.getKgMm()) / this.totalWeight;	  }

	  public double getlbr()	  {	    return this.lbr;	  }

	  public String getlbrFormula()	  {
	    StringBuilder text = new StringBuilder();
	    text.append("SQRT( ( H:");
	    text.append(this.altitude);
	    text.append(" - Hf:");
	    text.append(this.machine.getHf());
	    text.append(" )^2 + ( R:");
	    text.append(this.radius);
	    // text.append(" - Lacc_").append(this.accessory.getLength());
	    text.append(" + Ds:");
	    text.append(this.machine.getDs());
	    text.append(" + Df:");
	    text.append(this.machine.getDf());
	    text.append(")^2 ) - lunghezza_accessory:").append(this.accessory.getLength());
	    text.append(" - offsetTestaFlottante:").append(this.accessory.getOffset(this.rotatingHeadPosition));
	    return text.toString();
	  }

	  private double calcolaLBR()	  {
	    // FORMULA JMG: SQRT( (INPUTALTEZZA- distanzaFulcroBraccioSuolo)^2 + (INPUTRAGGIO + distanzaScudoCentroRotazione + distanzaFulcroBraccioSuolo)^2) - lunghezza_accessory

	    double result = Math.pow(this.altitude - this.machine.getHf(), 2);
	    result += Math.pow(this.radius + this.machine.getDs() + this.machine.getDf(), 2);
	    result = Math.sqrt(result);
	    // Includo la lunghezza dell'accessory oppure della testa flottante (che ha lunghezza 0)
	    return result - this.accessory.getLength() - this.accessory.getOffset(this.rotatingHeadPosition);
	  }

	  public double getAxialLoad()	  {	    return this.axialLoad;	  }

	  public String getAxialLoadFormula()	  {	    return "Q:" + this.cargo + " + Pbr:" + this.machine.getArmWeight() + " + Pjib:" + this.accessory.getWeight();	  }

	  public double getloadEccentricity()	  {	    return this.loadEccentricity;	  }

	  public String getloadEccentricityFormula()	  {	    return "Mr:" + this.overturningMoment + " / Ax:" + this.axialLoad;	  }

	  public double getSwingAngle()	  {	    return this.swingAngle;	  }

	  public double getdbr()	  {	    return this.dbr;	  }

	  public String getdbrFormula()	  {
	    StringBuilder result = new StringBuilder();
	    result.append("0.4771 * Lbr:");
	    result.append(this.getlbr());
	    result.append(" + 157.69");
	    return result.toString();
	  }

	  public double getWorkRadiusRotationAxis()	  {	    return this.radius + this.machine.getDs();	  }

	  public String getWorkRadiusRotationAxisFormula()	  {	    return ("R:" + this.radius + " + Ds:" + this.machine.getDs());	  }

	  public double getTotalWeight()	  {	    return this.machine.getBatteryWeight() + this.ballast.getWeight();	  }

	  public String getTotalWeightFormula()	  {	    return ("peso_batteria:" + this.machine.getBatteryWeight() + " + peso_zavorre:" + this.ballast.getWeight());	  }

	  public String getSwingAngleFormula()	  {
	    StringBuilder text = new StringBuilder();
	    text.append("acos( ( R:");
	    text.append(this.radius);
	    text.append(" + Ds:");
	    text.append(this.machine.getDs());
	    text.append(" + Dfb:");
	    text.append(this.machine.getDf());
	    text.append(" ) / ( Lbr:");
	    text.append(String.format("%.4f", this.lbr));
	    text.append(" + lunghezza_accessory: ").append(this.accessory.getLength());
	    text.append(" + testa_flottante: ").append(this.accessory.getOffset(this.rotatingHeadPosition));
	    text.append(" ) )");
	    return text.toString();
	  }

	  private double calcolaAngoloBrandeggio()	  {
	    // NUOVA FORMULA JMG: angolo = acos ( (INPUTRAGGIO + distanzaScudoCentroRotazione + distanzaFulcroBraccioCentroRotazione) / ( distanzaFulcroBraccioAsseGancio + lunghezza_accessory) )

	    // calcolo l'angolo brandeggio
	    double result = (this.radius + this.machine.getDs() + this.machine.getDf());
	    result = result / (this.lbr + this.accessory.getLength() + this.accessory.getOffset(this.rotatingHeadPosition));

	    // double result = (this.altitude - this.machine.getHf());
	    // result = result / (this.range - this.accessory.getLength() + this.machine.getDs() + this.machine.getHf());
	    return Math.toDegrees(Math.acos(result)); // trasformo i radianti in gradi
	  }

	  public Calculator()	  {
	    this.accessory = new Accessory(0,"none");
	    this.altitude = 0D;
	    this.swingAngle = 0D;
	    this.frontAxisLoad = 0D;
	    this.rearAxisLoad = 0D;
	    this.axialLoad = 0D;
	    this.cargo = 0D;
	    this.frontWheelsLoad = 0D;
	    this.rearWheelsLoad = 0D;
	    this.stabilizersLoad = 0D;
	    this.lbr = 0D;
	    this.dbr = 0D;
	    this.DistanceAverageCenterOfGravity = 0D;
	    this.loadEccentricity = 0D;
	    this.machine = new Machine("none", new Family("none"));
	    this.overturningMoment = 0D;
	    this.totalWeight = 0D;
	    this.rotatingHeadPosition = 0;
	    this.groundPressure = 0D;
	    this.rar = 0D;
	    this.radius = 0D;
	    this.ballast = new Ballast(0,"none");
	  }

	  public Calculator(final double cargoTon, final double raggioLavoroScudoMeters, final double altezzaGancioSuoloMeters, final Machine macchina, final int posTestaFlottante, final Ballast ballast, final Accessory accessory)
	  {
	    this.cargo = cargoTon * 1000D; // trasformo le tonnellate in Kg
	    this.radius = raggioLavoroScudoMeters * 1000D; // trasformo i metri in millimetri
	    this.altitude = altezzaGancioSuoloMeters * 1000D; // trasformo i metri in millimetri
	    this.rotatingHeadPosition = posTestaFlottante;
	    this.machine = macchina;
	    this.ballast = ballast;
	    this.accessory = accessory;

	    this.steps.append(String.format("##################################################################################%n"));
	    this.steps.append(String.format("##################################################################################%n"));
	    this.steps.append(String.format("## INPUT carico in Kg: %f%n", this.cargo));
	    this.steps.append(String.format("## INPUT raggio di lavoro dallo scudo [mm]: %f%n", this.radius));
	    this.steps.append(String.format("## INPUT altezza del gancio dal suolo [mm]: %f%n", this.altitude));
	    this.steps.append(String.format("## INPUT posizione testa Flottante: %d%n", this.rotatingHeadPosition));
	    this.steps.append(String.format("## INPUT macchina: %s%n", this.machine.getId()));
	    this.steps.append(String.format("## INPUT ballast: %s%n", this.ballast.getId()));
	    this.steps.append(String.format("## INPUT accessory: %s%n", this.accessory.getId()));
	    this.steps.append(String.format("##################################################################################%n"));

	    this.lbr = this.calcolaLBR();
	    this.steps.append(String.format("== Distanza tra fulcro braccio ed asse gancio Lbr: %s%n", this.getlbrFormula()));
	    this.steps.append(String.format("== Distanza tra fulcro braccio ed asse gancio Lbr: %.4f%n", this.getlbr()));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.steps.append(String.format("== isValidDistanzaFulcroBraccioAsseGancio: %s%n", this.isValidlbrFormula()));
	    this.steps.append(String.format("== isValidDistanzaFulcroBraccioAsseGancio: %b%n", this.isValidlbr()));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.dbr = this.machine.getMultiplierDistanceHubToArm() * this.lbr + this.machine.getOffsetDistanceHubToArm();
	    this.steps.append(String.format("== Distanza fulcro braccio e baricentro braccio Dbr: %f * Lbr: %.4f + %f%n", this.machine.getMultiplierDistanceHubToArm(), this.lbr, this.machine.getOffsetDistanceHubToArm()));
	    this.steps.append(String.format("== Distanza fulcro braccio e baricentro braccio Dbr: %.4f%n", this.dbr));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.swingAngle = this.calcolaAngoloBrandeggio();
	    this.steps.append(String.format("== Angolo brandeggio: %s%n", this.getSwingAngleFormula()));
	    this.steps.append(String.format("== Angolo brandeggio: %.4f°%n", this.swingAngle));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));
	    
	    this.steps.append(String.format("== isValidAngoloBrandeggio: %s%n", this.isValidSwingAngleFormula()));
	    this.steps.append(String.format("== isValidAngoloBrandeggio: %b%n", this.isValidSwingAngle()));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.rar = this.radius + this.machine.getDs();
	    this.steps.append(String.format("== Raggio di lavoro da asse di rotazione Rar: %f + Ds: %f%n", this.radius, this.machine.getDs()));
	    this.steps.append(String.format("== Raggio di lavoro da asse di rotazione Rar: %f%n", this.rar));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.totalWeight = this.machine.getBatteryWeight() + this.ballast.getWeight();
	    this.steps.append(String.format("== Peso totale Ptot: peso_batteria: %f + peso_zavorre: %f%n", this.machine.getBatteryWeight(), this.ballast.getWeight()));
	    this.steps.append(String.format("== Peso totale Ptot: %f%n", this.totalWeight));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.DistanceAverageCenterOfGravity = this.calcolaDTOT();
	    this.steps.append(String.format("== Distanza media del baricentro Dtot: %s%n", this.getDistanceAverageCenterOfGravityFormula()));
	    this.steps.append(String.format("== Distanza media del baricentro Dtot: %.4f%n", this.DistanceAverageCenterOfGravity));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.axialLoad = this.cargo + this.machine.getArmWeight() + this.accessory.getWeight();
	    this.steps.append(String.format("== Carico assiale Ax: %f + Pbr: %f + Pjib: %f%n", this.cargo, this.machine.getArmWeight(), this.accessory.getWeight()));
	    this.steps.append(String.format("== Carico assiale Ax: %f%n", this.axialLoad));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.overturningMoment = this.calcolaOverturningMoment();
	    this.steps.append(String.format("== Momento ribaltante Mr: %s%n", this.getoverturningMomentFormula()));
	    this.steps.append(String.format("== Momento ribaltante Mr: %.4f%n", this.overturningMoment));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.loadEccentricity = this.overturningMoment / this.axialLoad;
	    this.steps.append(String.format("== Eccentricita carico Mr: %.4f / Ax: %f%n", this.overturningMoment, this.axialLoad));
	    this.steps.append(String.format("== Eccentricita carico Mr: %.4f%n", this.loadEccentricity));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.frontAxisLoad = this.calcolaRANT();
	    this.steps.append(String.format("== Carico asse anteriore Rant: %s%n", this.getfrontAxisLoadFormula()));
	    this.steps.append(String.format("== Carico asse anteriore Rant: %.4f%n", this.frontAxisLoad));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.rearAxisLoad = this.calcolaRPOST();
	    this.steps.append(String.format("== Carico asse posteriore Rpost: %s%n", this.getrearAxisLoadFormula()));
	    this.steps.append(String.format("== Carico asse posteriore Rpost: %.4f%n", this.rearAxisLoad));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.steps.append(String.format("== isValidCaricoAssePosteriore: %.4f > 300%n", this.rearAxisLoad));
	    this.steps.append(String.format("== isValidCaricoAssePosteriore: %b%n", this.isValidrearAxisLoad()));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.frontWheelsLoad = this.frontAxisLoad / this.machine.getFrontWheel();
	    this.steps.append(String.format("== Gomme anteriori: carico per ogni ruota Rrant: %.4f / %d %n", this.frontAxisLoad, this.machine.getFrontWheel()));
	    this.steps.append(String.format("== Gomme anteriori: carico per ogni ruota Rrant: %.4f%n", this.frontWheelsLoad));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.rearWheelsLoad = this.rearAxisLoad / this.machine.getRearWheel();
	    this.steps.append(String.format("== Gomme posteriori: carico per ogni ruota Rrpost: %.4f / %d%n", this.rearAxisLoad, this.machine.getRearWheel()));
	    this.steps.append(String.format("== Gomme posteriori: carico per ogni ruota Rrpost: %.4f%n", this.rearWheelsLoad));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.stabilizersLoad = this.frontAxisLoad / 2D;
	    this.steps.append(String.format("== Stabilizzatori: carico per ognuno Rstab: %.4f / 2%n", this.frontAxisLoad));
	    this.steps.append(String.format("== Stabilizzatori: carico per ognuno Rstab: %.4f%n", this.stabilizersLoad));
	    this.steps.append(String.format("----------------------------------------------------------------------------------%n"));

	    this.groundPressure = this.stabilizersLoad / this.machine.getPlateArea();
	    this.steps.append(String.format("== Pressione al suolo: %.4f / %f%n",this.stabilizersLoad, this.machine.getPlateArea()));
	    this.steps.append(String.format("== Pressione al suolo: %.4f%n", this.groundPressure));
	  }

	  public double getgroundPressure()	  {	    return this.groundPressure;	  }

	  public static void main(String[] args)	  {	    /** TODO Auto-generated method stub	*/  }

	  public boolean isValidlbr()	  {
	    // la distanza deve essere compresa tra minimo e massimo (specifici per ogni macchina)
	    // se però c'è un accessory, ai limiti deve essere aggiunta la lunghezza dell'accessory
	    // La stessa cosa si può fare togliendo dalla misura la lunghezza dell'accessory e lasciando invariati i min e max
	    double measure = this.getlbr(); //  - this.accessory.getLength();
	    return measure >= this.machine.getMinArmLength() && measure <= this.machine.getMaxArmLength();
	  }
	  private String isValidlbrFormula()	  {
	    StringBuilder result = new StringBuilder();
	    result.append("distanza_fulcro_braccio_asse_gancio: ").append(String.format("%.4f", this.getlbr()));
	    result.append(". MIN: ").append(this.machine.getMinArmLength()).append(", MAX: ").append(this.machine.getMaxArmLength());
	    return result.toString();
//	    double measure = this.getDistanceFulcroBraccioAsseGancio() - this.accessory.getLength();
//	    StringBuilder result = new StringBuilder();
//	    result.append("measure: distanza_fulcro_braccio_asse_gancio - accessory.lunghezza: ").append(String.format("%.4f", this.getDistanceFulcroBraccioAsseGancio()));
//	    result.append(" - ").append(this.accessory.getLength()).append(" = ").append(String.format("%.4f",  measure));
//	    result.append(". MIN: ").append(this.machine.getMinArmLength()).append(", MAX: ").append(this.machine.getMaxArmLength());
//	    return result.toString();
	  }

	  public boolean isValidSwingAngle()	  {
	    if (this.machine.getMaxSwing() == this.machine.getMinSwing()) return true; // min e max non definiti, di default è valido
	    double myAngle = (this.altitude < this.machine.getHf()) ? -this.swingAngle : this.swingAngle;
	    return myAngle >= this.machine.getMinSwing() && myAngle <= this.machine.getMaxSwing();
	  }
	  
	  private String isValidSwingAngleFormula()	  {
	    StringBuilder result = new StringBuilder();
	    double myAngle = (this.altitude < this.machine.getHf()) ? -this.swingAngle : this.swingAngle;
	    result.append("angle: ").append(String.format("%.4f", myAngle)).append(", MIN: ").append(this.machine.getMinSwing()).append(", MAX: ").append(this.machine.getMaxSwing());
	    return result.toString();
	  }

}
