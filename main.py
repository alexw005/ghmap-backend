from fastapi import FastAPI
from pydantic_settings import BaseSettings,SettingsConfigDict
from pydantic import Field
from enum import Enum
import requests
from aiocache import cached

class AppSettings(BaseSettings):
    model_config = SettingsConfigDict(env_prefix='APP_')
    api_key: str = Field('')

