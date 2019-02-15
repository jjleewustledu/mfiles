	
function label = makeImageOrientationLabelFromImageOrientationPatient(iop)

	% 0.5477 would be the square root of 1 (unit vector sum of squares) divided by 3 (oblique axes - a "double" oblique)
	% 0.7071 would be the square root of 1 (unit vector sum of squares) divided by 2 (oblique axes)
	
	obliquityThresholdCosineValue = 0.8;
	
	/**
	 * <p>Get a label describing the major axis from a unit vector (direction cosine) as found in ImageOrientationPatient.</p>
	 *
	 * <p>Some degree of deviation from one of the standard orthogonal axes is allowed before deciding no major axis applies and returning null.</p>
	 *
	 * @param	x
	 * @param	y
	 * @param	z
	 * @return		the string describing the orientation of the vector, or null if oblique
	 */
	public static final String getMajorAxisFromPatientRelativeDirectionCosine(double x,double y,double z) {
		String axis = null;
		
		String orientationX = x < 0 ? "R" : "L";
		String orientationY = y < 0 ? "A" : "P";
		String orientationZ = z < 0 ? "F" : "H";

		double absX = Math.abs(x);
		double absY = Math.abs(y);
		double absZ = Math.abs(z);

		// The tests here really don't need to check the other dimensions,
		// just the threshold, since the sum of the squares should be == 1.0
		// but just in case ...
		
		if (absX>obliquityThresholdCosineValue && absX>absY && absX>absZ) {
			axis=orientationX;
		}
		else if (absY>obliquityThresholdCosineValue && absY>absX && absY>absZ) {
			axis=orientationY;
		}
		else if (absZ>obliquityThresholdCosineValue && absZ>absX && absZ>absY) {
			axis=orientationZ;
		}
		return axis;
	}

	/**
	 * <p>Get a label describing the axial, coronal or sagittal plane from row and column unit vectors (direction cosines) as found in ImageOrientationPatient.</p>
	 *
	 * <p>Some degree of deviation from one of the standard orthogonal planes is allowed before deciding the plane is OBLIQUE.</p>
	 *
	 * @param	rowX
	 * @param	rowY
	 * @param	rowZ
	 * @param	colX
	 * @param	colY
	 * @param	colZ
	 * @return		the string describing the plane of orientation, AXIAL, CORONAL, SAGITTAL or OBLIQUE
	 */
	public static final String makeImageOrientationLabelFromImageOrientationPatient(
			double rowX,double rowY,double rowZ,
			double colX,double colY,double colZ) {
		String label = null;
		String rowAxis = getMajorAxisFromPatientRelativeDirectionCosine(rowX,rowY,rowZ);
		String colAxis = getMajorAxisFromPatientRelativeDirectionCosine(colX,colY,colZ);
		if (rowAxis != null && colAxis != null) {
			if      ((rowAxis.equals("R") || rowAxis.equals("L")) && (colAxis.equals("A") || colAxis.equals("P"))) label="AXIAL";
			else if ((colAxis.equals("R") || colAxis.equals("L")) && (rowAxis.equals("A") || rowAxis.equals("P"))) label="AXIAL";
		
			else if ((rowAxis.equals("R") || rowAxis.equals("L")) && (colAxis.equals("H") || colAxis.equals("F"))) label="CORONAL";
			else if ((colAxis.equals("R") || colAxis.equals("L")) && (rowAxis.equals("H") || rowAxis.equals("F"))) label="CORONAL";
		
			else if ((rowAxis.equals("A") || rowAxis.equals("P")) && (colAxis.equals("H") || colAxis.equals("F"))) label="SAGITTAL";
			else if ((colAxis.equals("A") || colAxis.equals("P")) && (rowAxis.equals("H") || rowAxis.equals("F"))) label="SAGITTAL";
		}
		else {
			label="OBLIQUE";
		}
		return label;
	}
