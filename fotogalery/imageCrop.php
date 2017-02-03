<?php
	
/** Pøevzorkování a oøezání obrázku GIF, PNG nebo JPG na danou velikost
* @author Rostislav Wolný <costa>
* @param string $file_in název zmenšovaného souboru
* @param string $file_out název výsledného souboru
* @param int $width šíøka výsledného obrázku
* @param int $height výška výsledného obrázku
* @return bool true, false v pøípadì chyby
*/
function imageResizeCrop($file_in, $file_out, $width, $height)
{
    $imagesize = getimagesize($file_in);
    if ((!$width && !$height) || !$imagesize[0] || !$imagesize[1]) {
        return false;
    }
    if ($imagesize[0] == $width && $imagesize[1] == $height) {
        return copy($file_in, $file_out);
    }
    switch ($imagesize[2]) {
        case 1: $img = imagecreatefromgif($file_in); break;
        case 2: $img = imagecreatefromjpeg($file_in); break;
        case 3: $img = imagecreatefrompng($file_in); break;
        default: return false;
    }
    if (!$img) {
        return false;
    }
	
	$width_ratio = $width/$imagesize[0];
	$height_ratio = $height/$imagesize[1];

	if($height_ratio >= $width_ratio)
	{
	  $test_height = $imagesize[1] * $width_ratio;
	  if($test_height >= $height)
		$lead_width = 1;
	  else
		$lead_width = 0;
	}
	else
	{
	  $test_width = $imagesize[0] * $height_ratio;
	  if($test_width >= $width)
		$lead_width = 0;
	  else
		$lead_width = 1;
	}
	if($lead_width)
	{
	  $temp_width = $width;
	  $temp_height = $imagesize[1] * $width_ratio;
	}
	else
	{
	  $temp_height = $height;
	  $temp_width = $imagesize[0] * $height_ratio;
	}
	
	$img_temp = imagecreatetruecolor($temp_width, $temp_height);
	imagecopyresampled($img_temp, $img, 0, 0, 0, 0, $temp_width, $temp_height, $imagesize[0], $imagesize[1]);
	
	$coords['y'] = ($temp_height - $height)/2;
	$coords['x'] = ($temp_width - $width)/2;
	
	$img2 = imagecreatetruecolor($width, $height);
	imagecopyresampled($img2, $img_temp, 0, 0, $coords['x'], $coords['y'], $width, $height, $width, $height);
	
    if ($imagesize[2] == 2) {
        return imagejpeg($img2, $file_out);
    } elseif ($imagesize[2] == 1 && function_exists("imagegif")) {
        imagetruecolortopalette($img2, false, 256);
        return imagegif($img2, $file_out);
    } else {
        return imagepng($img2, $file_out);
    }
}