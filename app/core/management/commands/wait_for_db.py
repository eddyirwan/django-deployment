
'''
Django commandd to wait for the database to be available
'''

import time
from psycopg2 import OperationalError as Psycop2OpError

from django.db.utils import OperationalError
from django.core.management.base import BaseCommand


class Command(BaseCommand):

	def handle (self, *args, **options):
		self.stdout.write('Waiting for database')
		db_up = False
		while db_up is False:
			try:
				self.check(databases=['default'])
				db_up = True
			except (Psycop2OpError, OperationalError):
				self.stdout.write('Database unvailable, waiting 1 second ...')
				time.sleep(2)
		print('DB seem ready. Good luck')
		self.stdout.write(self.style.SUCCESS('Database ready!'))