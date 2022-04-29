-- SQL Data Cleaning

USE MyPortfolioProject

SELECT * FROM dbo.NashvilleHousing

-- Change SaleDate format from DATETIME to DATE

SELECT SaleDate, CONVERT(DATE, SaleDate)
FROM dbo.NashvilleHousing

UPDATE NashvilleHousing
SET SaleDate = CONVERT(DATE, SaleDate)

ALTER TABLE NashvilleHousing
ADD NewSaleDate DATE

UPDATE NashvilleHousing
SET NewSaleDate = CONVERT(DATE, SaleDate)

SELECT NewSaleDate, SaleDate
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
DROP COLUMN SaleDate

--Populating the Null cells in the PropertyAddress column

SELECT *
FROM NashvilleHousing
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET a.PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

-- Breaking out Address into individual columns (address, city, state)

-- For Property Address

SELECT PropertyAddress
FROM NashvilleHousing

SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress, 1) - 1)
FROM NashvilleHousing

SELECT SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress, 1) + 1, LEN(PropertyAddress))
FROM NashvilleHousing

SELECT PropertyAddress, SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress, 1) - 1),
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress, 1) + 1, LEN(PropertyAddress))
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertyAddressSplit VARCHAR(200)

ALTER TABLE NashvilleHousing
ADD PropertyCitySplit VARCHAR(200)

UPDATE NashvilleHousing
SET PropertyAddressSplit = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress, 1) - 1)

UPDATE NashvilleHousing
SET PropertyCitySplit = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress, 1) + 1, LEN(PropertyAddress))

SELECT *
FROM NashvilleHousing

-- For Owner Address

SELECT OwnerAddress
FROM NashvilleHousing

SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD OwnerAddressSplit VARCHAR(200)

ALTER TABLE NashvilleHousing
ADD OwnerCitySplit VARCHAR(200)

ALTER TABLE NashvilleHousing
ADD OwnerStateSplit VARCHAR(200)

UPDATE NashvilleHousing
SET OwnerAddressSplit = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)

UPDATE NashvilleHousing
SET OwnerCitySplit = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)

UPDATE NashvilleHousing
SET OwnerStateSplit = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)

SELECT *
FROM NashvilleHousing

-- Replacing Y and N in SoldAsVacant Column with Yes and No respectively

SELECT DISTINCT(SoldAsVacant), COUNT(*)
FROM NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

SELECT CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END
FROM NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END

--Removing Duplicates

WITH RowNumCTE AS(
	SELECT *, ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				NewSaleDate,
				LegalReference
				ORDER BY
					UniqueID
					) row_num
	FROM NashvilleHousing
	)
SELECT * FROM RowNumCTE
WHERE row_num > 1

--DELETE FROM RowNumCTE WHERE row_num > 1 
--(To delete the duplicates)

-- PARTITION BY will start counting the number of rows again from where all those columns listed in the PARTITION BY clause have the same values.
-- Hence those rows are considered as duplicates.
-- This is why where the row number is greater 1, the row can be deleted, seeing that it is a duplicate of the one with row number as 1.

