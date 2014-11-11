////find the path to the target location using raycasts
//function FindPath (startLocation : Vector3, targetLocation : Vector3, directDistance : float, theMover : int)
//{
//	//if there's something in the way
//	//var checkDist : float = Mathf.Min(directDistance, 5);
//	var rayDireciton : Vector3 = (startLocation - targetLocation).normalized;
//	var hit : RaycastHit;
//	var myCol : Collider = targetObjects[theMover].collider;
//	//ensure ray hits all possible objects
//	targetLocation.y = 0.2;
//	//if something's between me and my target
//	if(Physics.Raycast(targetLocation, rayDireciton, hit, directDistance)){
//		//if it's not me
//		if(hit.collider != myCol){		
//			//go around it
//			print(hit.collider.gameObject.tag);
//			var colPoint : Vector3 = hit.collider.ClosestPointOnBounds(startLocation);
//			var colDist : float = Vector3.Distance(startLocation, colPoint);
//			var newTarget : Vector3 = FindWayPoint(startLocation, colDist, colPoint, theMover, myCol);
//			var targetRotation : Quaternion = Quaternion.LookRotation(newTarget - targetObjects[theMover].transform.position);
//			targetObjects[theMover].transform.rotation = targetRotation;
//			targetObjects[theMover].rigidbody.MovePosition(Vector3.MoveTowards(startLocation, newTarget, movementSpeeds[theMover] * Time.deltaTime));
//		}
//		else{
//			//move in a straight line
//			MoveDirect(startLocation, targetLocation, directDistance, theMover);;
//		}
//	}
//	//nothing in the way
//	else{
//		//move in a straight line
//		MoveDirect(startLocation, targetLocation, directDistance, theMover);
//	}
//}
//
////move in a straight line
//function MoveDirect (startLocation : Vector3, targetLocation : Vector3, directDistance : float, theMover : int)
//{
//	var targetRotation : Quaternion = Quaternion.LookRotation(targetLocation - targetObjects[theMover].transform.position);
//	targetObjects[theMover].transform.rotation = targetRotation;
//	targetObjects[theMover].rigidbody.MovePosition(Vector3.MoveTowards(startLocation, targetLocation, movementSpeeds[theMover] * Time.deltaTime));
//}
//
//function FindWayPoint (startLocation : Vector3, collisionDistance : float, collisionPoint : Vector3, theMover : int, myCollider : Collider)
//{
//	var wayPointLoc : Vector3;
//	var originalRotation : Quaternion = Quaternion.LookRotation(moveTarget[theMover] - targetObjects[theMover].transform.position);
//	if(targetObjects[theMover].transform.rotation == originalRotation)
//	{
//		var rightCheckPoint : Vector3 = targetObjects[theMover].transform.TransformPoint(Vector3.right*3);
//		var rayDireciton : Vector3 = (startLocation - rightCheckPoint).normalized;
//		var hit : RaycastHit;
//		
//		if(Physics.Raycast(rightCheckPoint, rayDireciton, hit, 3)){
//			if(hit.collider != myCollider){	
//				wayPointLoc = targetObjects[theMover].transform.TransformPoint(Vector3.left);
//			}
//			else{		
//				wayPointLoc = targetObjects[theMover].transform.TransformPoint(Vector3.right);
//			}
//		}
//		else{
//			wayPointLoc = targetObjects[theMover].transform.TransformPoint(Vector3.right);
//		}
//	}
//	else
//	{
//		wayPointLoc = targetObjects[theMover].transform.TransformPoint(Vector3.forward);
//	}
//	print("startLoc" + startLocation + " : " + "wayLoc" + wayPointLoc);
//	return wayPointLoc;
//}