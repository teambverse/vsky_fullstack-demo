from rest_framework.response import Response
from rest_framework import status
import logging

logger = logging.getLogger(__name__)


def success_response(message="Success", status_code=status.HTTP_200_OK):
    """
    Returns a standardized success response without data.
    """
    logger.info(f"Success Response: {message}")
    return Response(
        {
            "isSuccess": True,
            "statusCode": status_code,
            "message": message,
        },
        status=status_code,
    )


def data_response(data, message="Success", status_code=status.HTTP_200_OK):
    """
    Returns a standardized success response with data.
    """
    logger.info(f"Data Response: {message}")
    return Response(
        {
            "isSuccess": True,
            "statusCode": status_code,
            "message": message,
            "data": data,
        },
        status=status_code,
    )


def set_cookies_data_response(data, message="Success", status_code=status.HTTP_200_OK):
    """
    Returns a standardized success response with data.
    """
    logger.info(f"Data Response: {message}")
    response = Response(
        {
            "isSuccess": True,
            "statusCode": status_code,
            "message": message,
            "data": data,
        },
        status=status_code,
    )

    # response.set_cookie(
    #     key="accessToken",
    #     value=data.session["accessToken"],
    #     httponly=True,
    #     secure=True,
    #     samesite="Lax",
    #     max_age=60 * 60 * 24,
    # )

    # response.set_cookie(
    #     key="refreshToken",
    #     value=data.session["refreshToken"],
    #     httponly=True,
    #     secure=True,
    #     samesite="Lax",
    #     max_age=60 * 60 * 24 * 7,
    # )

    return response


def paginated_response(
    items, total, page_size, page_no, message="Success", status_code=status.HTTP_200_OK
):
    """
    Returns a standardized paginated response.
    """
    logger.info(f"Paginated Response: {message}")
    return Response(
        {
            "isSuccess": True,
            "statusCode": status_code,
            "message": message,
            "items": items,
            "total": total,
            "pageSize": page_size,
            "pageNo": page_no,
        },
        status=status_code,
    )

def without_pagination_response(
    items, total, message="Success", status_code=status.HTTP_200_OK
):
    """
    Returns a standardized response without pagination.
    """
    logger.info(f"Without Pagination Response: {message}")
    return Response(
        {
            "isSuccess": True,
            "statusCode": status_code,
            "message": message,
            "items": items,
            "total": total,
        },
        status=status_code,
    )
