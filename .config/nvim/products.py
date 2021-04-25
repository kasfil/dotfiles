from typing import Optional, List
from fastapi import (
    APIRouter,
    Depends,
    Response,
    status,
    Header,
    HTTPException,
    Query
)
from tortoise.exceptions import DoesNotExist
from tortoise.query_utils import Q

from models.response import SuccessResponse
from models.user import UserState
from models.entity import EntityInfo
from models.product import UserProductDetail, ProductList
from dependency.authbearer import optional_token_bearer
from common.blog_service import BlogService
from schemas.shops import ShopProduct

router = APIRouter()
blog_service = BlogService()


@router.get('/product-entity', response_model=SuccessResponse)
async def get_all_product(
    name: Optional[str] = Query(None, description='Product name contain'),
    entity: List[str] = Query(None, description='Filter by slug'),
    category: List[str] = Query(None, description='Filter by category slug'),
    limit: Optional[int] = Query(30, gt=0, le=100, description='Limit list'),
    offset: Optional[int] = Query(0, ge=0, description='Ofsett list'),
    locale: str = Header('en', description='Localization header option'),
    user: UserState = Depends(optional_token_bearer)
) -> Response:
    """
    get all product from entity
    """
    query_list = []

    # Filter with name
    if name:
        query_list.append(Q(product__name__icontains=name))

    # Filter with entity
    if entity:
        entity_filter = []
        # add filter for each entity slug given
        for entity_slug in entity:
            entity_filter.append(Q(product__warehouse__entity__slug=entity_slug))
        # append entity filter to query filter with join type OR
        query_list.append(Q(*entity_filter, join_type='OR'))

    # Filter with entity
    if category:
        category_filter = []
        # add filter for each entity slug given
        for category_slug in category:
            category_filter.append(Q(product__category__slug__iexact=entity_slug))
            category_filter.append(Q(product__variant__category__slug__iexact=entity_slug))
        # append entity filter to query filter with join type OR
        query_list.append(Q(*category_filter, join_type='OR'))

    products = await ShopProduct.filter(
        Q(*query_list, join_type='AND')
    ).prefetch_related(
        'product', 'product__category', 'product__variant',
        'product__variant__image', 'product__image',
        'product__warehouse__entity'
    ).order_by('-updated_at', '-created_at')

    product_list = []
    for product in products:
        # get single first product image
        if product.product.image:
            product_image = product.product.image[0].path
        elif product.product.variant.image:
            product_image = product.product.variant.image[0].path
        else:
            # if has no product image set to None
            product_image = None

        product_favorite = await blog_service.get_product_favorite_info(
            id=str(product.id),
            user_id=str(user.id) if user is not None else None
        )

        product_obj = ProductList(
            id=product.id,
            name=product.product.name,
            slug=product.product.slug,
            image=product_image,
            discount=product.discount,
            quantity=product.quantity,
            sell_price=product.sell_price,
            category=[category.name for category in product.product.category],
            favorite=product_favorite,
            rating=await blog_service.get_product_rating(str(product.id)),
            store_info=EntityInfo(
                id=product.product.warehouse.entity.id,
                name=product.product.warehouse.entity.name,
                location=product.product.warehouse.entity.location
            )
        )
        product_list.append(dict(product_obj))

    return {
        'meta': {
            'code': status.HTTP_200_OK,
            'message': 'success'
        },
        'response': product_list
    }


@router.get('/product-entity/{product_slug}', response_model=SuccessResponse)
async def get_product_detail(
    product_slug: str,
    user: UserState = Depends(optional_token_bearer)
) -> Response:
    """
    Get product detail
    """
    try:
        product = await ShopProduct.get(
            product__slug=product_slug
        ).prefetch_related(
            'product', 'product__category', 'product__variant',
            'product__variant__image', 'product__image',
            'product__warehouse__entity'
        )
    except DoesNotExist:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail='Product Not Found'
        )

    product_favorite = await blog_service.get_product_favorite_info(
        id=str(product.id),
        user_id=str(user.id) if user is not None else None
    )

    product_data = UserProductDetail(
        id=product.id,
        name=product.product.name,
        slug=product.product.slug,
        image=[img.path for img in product.product.image]
        + [img.path for img in product.product.variant.image],
        discount=product.discount,
        quantity=product.quantity,
        sell_price=product.sell_price,
        category=[category.name for category in product.product.category],
        favorite=product_favorite,
        rating=await blog_service.get_product_rating(str(product.id)),
        review=await blog_service.get_product_reviews(str(product.id)),
        store_info={
            'id': product.product.warehouse.entity.id,
            'name': product.product.warehouse.entity.name,
            'location': product.product.warehouse.entity.location
        }
    )

    return {
        'meta': {
            'code': status.HTTP_200_OK,
            'message': 'success'
        },
        'response': dict(product_data)
    }
