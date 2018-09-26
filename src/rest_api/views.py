__author__ = 'abhishek'

from django.http import Http404, JsonResponse
from django.views.decorators.cache import cache_page

import csv
import logging

logging.basicConfig(filename='api.log', level=logging.DEBUG)
logger = logging.getLogger(__name__)


def default_response():
    from collections import OrderedDict
    response_object = OrderedDict(
        {
            'response': {
                'status': False,
                'msg': 'Failure'
            }
        }
    )
    return response_object


def get_client_ip(request):
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip



@cache_page(60 * 1)  # 1 min duration of cache
def api_home(request, param=None):
    """
    Logging of request and Validation should be at Middleware Level
    implementing the basics
    """

    logger.info('Request IP: %s, Browser: %s' % (get_client_ip(request), request.META['HTTP_USER_AGENT']))
    logger.info('Request param %s' % param)

    content = default_response()
    file_name = 'Corpus.csv'  # For reading data from csv

    try:
        with open(file_name, 'r') as data_model:
            rows = csv.reader(data_model)
            next(rows, None)  # skip the headers
            # Index of key and value objects in the list
            key_object_index = 0
            value_object_index = 1

            for index, row in enumerate(rows):
                key_object = row[key_object_index]
                value_object = row[value_object_index]

                if key_object == param:
                    content['key'] = param
                    content['value'] = value_object
                    content['response']['status'] = True
                    content['response']['msg'] = 'Success'
                    break

    except Exception as error:
        # Report this error
        logger.error('Something fatal occured', exc_info=True)

    finally:
        return JsonResponse(content, safe=False)
