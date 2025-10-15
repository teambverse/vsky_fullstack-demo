from rest_framework.exceptions import APIException
from rest_framework import status
from rest_framework.views import exception_handler
from rest_framework.response import Response
import logging

logger = logging.getLogger(__name__)

class ApiError(APIException):
    isSuccess = False
    # is_customer_error = True
    statusCode = status.HTTP_400_BAD_REQUEST
    default_detail = 'A customer-specific error occurred.'
    default_code = 'customer_error'

    def __init__(self, detail=None, status_code=None):
        if status_code:
            self.status_code = status_code
        super().__init__(detail or self.default_detail)

def custom_exception_handler(exc, context):
    # Call the default exception handler first
    response = exception_handler(exc, context)

    if isinstance(exc, ApiError):
        return Response({
            'isSuccess': False,
            'statusCode': exc.status_code,
            'message': exc.detail if isinstance(exc.detail, str) else 'Validation failed.',
            'errors': exc.detail if isinstance(exc.detail, dict) else None,
        }, status=exc.status_code)

    if response is not None:
        # Add `is_success` to the default response
        response.data['isSuccess'] = False
        response.data['statusCode'] = response.status_code
        response.data['message'] = response.data.get('detail', 'An error occurred.')
        response.data.pop('detail', None)  # Remove `detail` for consistency

    else:
        # Log unhandled exceptions
        logger.error(f"Unhandled exception: {exc}", exc_info=True)
        return Response({
            'isSuccess': False,
            'statusCode': status.HTTP_500_INTERNAL_SERVER_ERROR,
            'message': 'An internal server error occurred.',
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    return response