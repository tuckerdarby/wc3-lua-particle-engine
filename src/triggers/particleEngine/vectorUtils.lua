function vectorCreate(x, y, z)
    return {x = x, y = y, z = z}
end

function vectorGetLength(vector)
    return math.sqrt(vector.x * vector.x + vector.y * vector.y + vector.z * vector.z)
end

function vectorAdd(vector1, vector2)
    return vectorCreate(vector1.x + vector2.x, vector1.y + vector2.y, vector1.z + vector2.z)
end

function vectorSubtract(vector1, vector2)
    return vectorCreate(vector1.x - vector2.x, vector1.y - vector2.y, vector1.z - vector2.z)
end

function vectorScale(vector, scale)
    return vectorCreate(vector.x * scale, vector.y * scale, vector.z * scale)
end

function vectorProductScalar(vector1, vector2)
    return vector1.x * vector2.x + vector1.y * vector2.y + vector1.z * vector2.z
end

function vectorProductVector(vector1, vector2)
    local x = vector1.y * vector2.z - vector1.z * vector2.y
    local y = vector1.z * vector2.x - vector1.x * vector2.z
    local z = vector1.x * vector2.y - vector1.y * vector2.x
    return vectorCreate(x, y, z)
end

function vectorProjectVector(vector1, vector2)
    local productScalarAB = vectorProductScalar(vector1, vector2)
    local productScalarBB = vectorProductScalar(vector2, vector2)

    if productScalarB == 0 then
        return vectorCreate(0, 0, 0)
    end

    return vectorScale(vector2, productScalarAB / productScalarBB)
end

function vectorProjectPlane(vector1, vector2)
    local projectedVector = vectorProjectVector(vector1, vector2)
    return vectorSubtract(vector1, projectedVector)
end

function vectorSetLength(vector, length)
    local currentVectorLength = vectorGetLength(vector)

    if (currentVectorLength == 0) then
        return vectorCreate(0, 0, 0)
    end

    return vectorScale(vector, length / currentVectorLength)
end

function vectorRotate(rotatedVector, axisVector, angle)
    local locZ = vectorProjectVector(rotatedVector, axisVector)

    if locZ == 0 then
        return vectorCreate(0, 0, 0)
    end

    local locX = vectorSubtract(rotatedVector, locZ)
    local locY = vectorProductVector(axisVector, locX)
    locY = vectorSetLength(locY, vectorGetLength(locX))
    locX = vectorScale(locX, math.cos(angle))
    locY = vectorScale(locY, math.sin(angle))
    return vectorSum(locX, locY)
end

function vectorRotateDeg(rotatedVector, axisVector, angle)
    local rad = angle * bj_DEGTORAD
    return vectorRotate(rotatedVector, axisVector, rad)
end

function vectorGetTerrainNormal(x, y, offset)
    local leftLocation = new
    Location(x - offset, y)
    local leftZ = GetLocationZ(leftLocation)
    local rightLocation = new
    Location(x + offset, y)
    local rightZ = GetLocationZ(rightLocation)
    local upLocation = new
    Location(x, y - offset)
    local upZ = GetLocationZ(upLocation)
    local downLocation = new
    Location(x, y + offset)
    local downZ = GetLocationZ(downLocation)
    local vector1 = vectorCreate(2 * offset, 0, rightZ - leftZ)
    local vector2 = vectorCreate(0, 2 * offset, downZ - upZ)
    return vectorProductVector(vector1, vector2)
end

function isPointInCone(vector1, vector2, vector3, distance)
    local vector3Length = vectorGetLength(vector3)

    if vector3Length == 0 then
        return false
    end

    local vectorDifferenceAB = vectorSubtract(vector1, vector2)
    local vectorDifferenceABC = vectorSubtract(vectorDifferenceAB, vector3)
    local plane = vectorProjectPlane(vectorDifferenceAB, vector3)

    return vectorProductScalar(vectorDifferenceAB, vector3) >= 0 and
        vectorProductScalar(vectorDifferenceABC, vector3) <= 0 and
        vectorProductScalar(plane, plane) <= distance * distance
end

function isPointInSphere(vector1, vector2, distance)
    local difference = vectorSubtract(vector1, vector2)
    return vectorProductScalar(difference, difference) <= distance * distance
end
