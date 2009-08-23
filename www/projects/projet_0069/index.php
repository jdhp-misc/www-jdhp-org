<?php
/*
 * Copyright (c) 2006 Jérémie Decock (http://www.jdhp.org)
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

	define('WEB_ROOT','http://www.jdhp.org/travaux/projet_0069/');
	define('FS_ROOT','./');
	require(FS_ROOT.'language/fr.php');
	
	define('NB_ITERATION_MAX','100');
	
	function is_valid_integer($nb,$min,$max) {
		if(ctype_digit($nb) && $nb >= $min && $nb <= $max) return true;
		else return false;
	}
	
	$error_stack = "";
	$form_is_valid = false;
	
	// Initialise les valeurs par défaut
	$n = 1;
	$w0 = 2;
	$w1 = 0;
	$w2 = 0;
	$w3 = 0;
	$w4 = 0;

	if(isset($_POST['seq1_si1']) && $_POST['seq1_si1']=="1") $seq1_si1= 1; else $seq1_si1= 0;
	if(isset($_POST['seq1_si2']) && $_POST['seq1_si2']=="1") $seq1_si2= 1; else $seq1_si2= 0;
	if(isset($_POST['seq1_si3']) && $_POST['seq1_si3']=="1") $seq1_si3= 1; else $seq1_si3= 0;
	if(isset($_POST['seq1_si4']) && $_POST['seq1_si4']=="1") $seq1_si4= 1; else $seq1_si4= 0;
		
	// Traitement des données envoyées
	if(isset($_POST['submitted_form'])) {
		if(is_valid_integer($_POST['n'],1,20)) $n = $_POST['n'];
		else $error_stack .= "<p>".TR_N_ERROR."</p>\n";

		if(is_valid_integer($_POST['w0'],0,20)) $w0 = $_POST['w0'];
		else $error_stack .= "<p>".TR_W0_ERROR."</p>\n";

		if(is_valid_integer($_POST['w1'],0,20)) $w1 = $_POST['w1'];
		else $error_stack .= "<p>".TR_W1_ERROR."</p>\n";

		if(is_valid_integer($_POST['w2'],0,20)) $w2 = $_POST['w2'];
		else $error_stack .= "<p>".TR_W2_ERROR."</p>\n";

		if(is_valid_integer($_POST['w3'],0,20)) $w3 = $_POST['w3'];
		else $error_stack .= "<p>".TR_W3_ERROR."</p>\n";

		if(is_valid_integer($_POST['w4'],0,20)) $w4 = $_POST['w4'];
		else $error_stack .= "<p>".TR_W4_ERROR."</p>\n";
		
		if($error_stack == NULL) $form_is_valid = true;
		else echo '<div id="error">'.$error_stack.'</div>';
	}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
	<head>
		<title>Perceptron simple</title>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
		<meta name="author" content="Jérémie DECOCK"/>
		<meta name="copyright" content="copyright (c) 2006 Jérémie DECOCK" />
		<link rel="stylesheet" type="text/css" href="./screen.css" media="screen" title="Normal" />
	</head>
	<body>
		<div id="container">
			<h1><?php echo TR_TITRE; ?></h1>
			<div id="form">
				<h2><?php echo TR_PARAMS; ?></h2>
				<div>
					<h3><?php echo TR_NB_UNITS_NOTICE; ?></h3>
					<div id="form_nb_units">
						<form method="post">
							<label for="nb_units"><?php echo TR_NB_UNITS_INPUT; ?></label><input type="text" value="4" name="nb_units" id="nb_units" size="2" maxlength="2" readonly />
						</form>
					</div>
					<form method="post" action="<?php echo WEB_ROOT; ?>index.php#tables">
						<input type="hidden" value="true" name="submitted_form" />
						<h3><?php echo TR_N_NOTICE; ?></h3>
						<div id="form_n">
							<label for="n">&#414; : </label><input type="text" value="<?php echo $n; ?>" name="n" id="n" size="2" maxlength="2" />
						</div>
						<h3><?php echo TR_W_NOTICE; ?></h3>
						<div id="form_w">
							<span><label for="w0">w<sub>ij</sub>0 : </label><input type="text" value="<?php echo $w0; ?>" name="w0" id="w0" size="2" maxlength="2" /></span>
							<span><label for="w1">w<sub>ij</sub>1 : </label><input type="text" value="<?php echo $w1; ?>" name="w1" id="w1" size="2" maxlength="2" /></span>
							<span><label for="w2">w<sub>ij</sub>2 : </label><input type="text" value="<?php echo $w2; ?>" name="w2" id="w2" size="2" maxlength="2" /></span>
							<span><label for="w3">w<sub>ij</sub>3 : </label><input type="text" value="<?php echo $w3; ?>" name="w3" id="w3" size="2" maxlength="2" /></span>
							<span><label for="w4">w<sub>ij</sub>4 : </label><input type="text" value="<?php echo $w4; ?>" name="w4" id="w4" size="2" maxlength="2" /></span>
						</div>
						<h3><?php echo TR_SI_NOTICE; ?></h3>
						<div id="form_si">
							<span><label for="seq1_si1">s<sub>i</sub>1 : </label><input type="checkbox" <?php if($seq1_si1 == 1) echo 'checked'; ?> name="seq1_si1" id="seq1_si1" value="1" /></span>
							<span><label for="seq1_si2">s<sub>i</sub>2 : </label><input type="checkbox" <?php if($seq1_si2 == 1) echo 'checked'; ?> name="seq1_si2" id="seq1_si2" value="1" /></span>
							<span><label for="seq1_si3">s<sub>i</sub>3 : </label><input type="checkbox" <?php if($seq1_si3 == 1) echo 'checked'; ?> name="seq1_si3" id="seq1_si3" value="1" /></span>
							<span><label for="seq1_si4">s<sub>i</sub>4 : </label><input type="checkbox" <?php if($seq1_si4 == 1) echo 'checked'; ?> name="seq1_si4" id="seq1_si4" value="1" /></span>
						</div>
						<div id="form_submit">
							<input type="submit" class="submit_button" value="<?php echo TR_SUBMIT_BUTTON; ?>" />
						</div>
					</form>
				</div>
			</div>
			<?php
				if($form_is_valid == true) {
					
					// Simulation /////////////////////////////////////////////////////
					
					// Afficher le memo
					echo '
						<div id="memo">
							<h2>'.TR_MEMO_TITLE.'</h2>
							<div>
								<h3>'.TR_MEMO_TITLE_EJ.'</h3>
								<p>'.TR_MEMO_EJ.'</p>
								<h3>'.TR_MEMO_TITLE_W.'</h3>
								<p>'.TR_MEMO_W.'</p>
							</div>
						</div>';
	
					$nb_iteration = 0;
					
					echo '
						<div id="tables">';
					// Lancer l'apprentissage et afficher le resultat
					do {
						$nb_iteration++;
						$is_stable = true;
						
						echo '
							<hr />
							<table summary="'.TR_TABLE_SUMMARY.$nb_iteration.'">
								<caption>'.TR_ITERATION.' '.$nb_iteration.'</caption>
								<tr>
									<th>'.TR_STIMULUS.'</th>
									<th>e<sub>j</sub></th>
									<th>s<sub>j</sub></th>
									<th>d<sub>j</sub></th>
									<th>w<sub>ij</sub>0</th>
									<th>w<sub>ij</sub>1</th>
									<th>w<sub>ij</sub>2</th>
									<th>w<sub>ij</sub>3</th>
									<th>w<sub>ij</sub>4</th>
								</tr>';
						
	//					for($si1=0 ; $si1<=1 ; $si1++) {
	//						for($si2=0 ; $si2<=1 ; $si2++) {
	//							for($si3=0 ; $si3<=1 ; $si3++) {
	//								for($si4=0 ; $si4<=1 ; $si4++) {
						for($si1=1 ; $si1>=0 ; $si1--) {
							for($si2=1 ; $si2>=0 ; $si2--) {
								for($si3=1 ; $si3>=0 ; $si3--) {
									for($si4=1 ; $si4>=0 ; $si4--) {
										// Initialise la couleur de la ligne (surligné si $dj != sj, normal si non)
										$color = 'normal';
										
										// Calcul de dj
										if($si1.$si2.$si3.$si4 == $seq1_si1.$seq1_si2.$seq1_si3.$seq1_si4) $dj = 1;
										else $dj = 0;
										
										// Calcul de ej (sum)
										$ej = $si1*$w1 + $si2*$w2 + $si3*$w3 + $si4*$w4 - $w0;
										
										// Calcul de sj
										if($ej < 0) $sj = 0;
										else $sj = 1;
										
										// Si la sortie obtenue est différente de la sortie attendue, met les poids à jours
										if($dj != $sj) {
											$color = 'highlighted';
											$is_stable = false;
											$w0 = $w0 + $n * ($dj - $sj) * (-1);
											$w1 = $w1 + $n * ($dj - $sj) * $si1;
											$w2 = $w2 + $n * ($dj - $sj) * $si2;
											$w3 = $w3 + $n * ($dj - $sj) * $si3;
											$w4 = $w4 + $n * ($dj - $sj) * $si4;
										}
										
										echo '
											<tr>
												<td class="'.$color.'">'.$si1.$si2.$si3.$si4.'</td>
												<td class="'.$color.'">'.$ej.'</td>
												<td class="'.$color.'">'.$sj.'</td>
												<td class="'.$color.'">'.$dj.'</td>
												<td class="'.$color.'">'.$w0.'</td>
												<td class="'.$color.'">'.$w1.'</td>
												<td class="'.$color.'">'.$w2.'</td>
												<td class="'.$color.'">'.$w3.'</td>
												<td class="'.$color.'">'.$w4.'</td>
											</tr>';
											
									}
								}
							}
						}
								
						echo '</table>';
					} while(!$is_stable && $nb_iteration < NB_ITERATION_MAX);
					
					echo '
						</div>';
				}
			?>
		</div>
		<div id="footer">
			<div id="copyright">
				<?php echo TR_COPYRIGHT; ?>
			</div>
		</div>
	</body>
</html>
