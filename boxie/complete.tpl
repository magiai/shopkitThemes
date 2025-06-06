{#
Description: Complete order page
#}

{% import 'macros.tpl' as generic_macros %}

{% extends 'base.tpl' %}

{% block content %}

    <div class="checkout section">

        {{ generic_macros.cart_notice() }}

        <div class="{{ layout_container }}">
            <div class="text-center margin-bottom">
                {{ icons('check', 'fa-4x text-success') }}
                <h2 class="text-muted margin-top-sm margin-bottom-xs">{{ 'lang.storefront.cart.complete.order_successfull'|t }}</h2>
                <h3 class="light text-light-gray">#{{ order.id }}</h3>
            </div>

            <div class="row">
                <div class="col-sm-10 offset-sm-1 col-md-8 offset-md-2 col-lg-6 offset-lg-3">

                    <ul class="list-group well-featured {{ store.theme_options.well_featured_shadow }}">
                        <li class="list-group-item list-radio-block text-h5">
                            <span class="badge badge-pill badge-secondary badge-outline text-h6 float-right">{{ order.id }}</span>
                            {{ 'lang.storefront.cart.complete.order_number.label'|t }}:
                        </li>
                        <li class="list-group-item list-radio-block text-h5">
                            <span class="badge badge-pill badge-secondary badge-outline price text-h6 float-right">{{ order.total | money_with_sign }}</span>
                            {{ 'lang.storefront.order.total'|t }}:
                        </li>
                        <li class="list-group-item list-radio-block text-h5">
                            <span class="badge badge-pill badge-secondary badge-outline text-h6 float-right">{{ order.payment.title }}</span>
                            {{ 'lang.storefront.cart.complete.order_payment.label'|t }}:

                            <div>

                                {% if order.payment.type == 'bank_transfer' and order.payment.data %}
                                    <div class="margin-top-sm">
                                        <strong>{{ 'lang.storefront.order.payment.bank_transfer.label'|t }}:</strong> {{ order.payment.data }}
                                    </div>

                                {% elseif order.payment.type == 'multibanco' %}
                                    {% if order.payment.data and order.payment.data.reference %}
                                        <div class="margin-top-sm text-nowrap">
                                            <strong>{{ 'lang.storefront.order.payment.multibanco.entity'|t }}:</strong> <span>{{ order.payment.data.entity }}</span>
                                            <br>
                                            <strong>{{ 'lang.storefront.order.payment.multibanco.reference'|t }}:</strong>
                                            <span style="padding: 0 2px">{{ order.payment.data.reference|slice(0, 3) }}</span>
                                            <span style="padding: 0 2px">{{ order.payment.data.reference|slice(3, 3) }}</span>
                                            <span style="padding: 0 2px">{{ order.payment.data.reference|slice(6, 3) }}</span>
                                            <br>
                                            <strong>{{ 'lang.storefront.order.payment.multibanco.value'|t }}:</strong> <span class="text-muted price">{{ order.payment.data.value | money_with_sign }}</span>
                                        </div>
                                    {% else %}
                                        <div class="margin-top-sm text-danger">
                                            <strong>{{ 'lang.storefront.layout.events.form.error'|t }}:</strong> {{ 'lang.storefront.order.payment.multibanco.error_message'|t }}
                                        </div>
                                    {% endif %}

                                {% elseif order.payment.type == 'wallets' %}
                                    <div class="wallets-data margin-top-sm">
                                        <div id="payment-request-button"></div>
                                    </div>

                                {% elseif order.payment.type == 'payshop' %}
                                    {% if order.payment.data and order.payment.data.reference %}
                                        <div class="margin-top-sm text-nowrap">
                                            <strong>{{ 'lang.storefront.order.payment.multibanco.reference'|t }}:</strong> {{ order.payment.data.reference }}
                                            <br>
                                            <strong>{{ 'lang.storefront.order.payment.multibanco.value'|t }}:</strong> <span class="text-muted price">{{ order.payment.data.value | money_with_sign }}</span>
                                        </div>
                                    {% else %}
                                        <div class="margin-top-sm text-danger">
                                            <strong>{{ 'lang.storefront.layout.events.form.error'|t }}:</strong> {{ 'lang.storefront.order.payment.payshop.error_message'|t }}
                                        </div>
                                    {% endif %}

                                {% elseif order.payment.type == 'pick_up' and order.payment.data %}
                                    <div class="pick_up-data margin-top-sm text-h6">
                                        <strong>{{ 'lang.storefront.order.pick_up_address'|t }}</strong><br>
                                        {{ order.payment.data.name }}<br>
                                        {{ order.payment.data.address }} {{ order.payment.data.address_extra }}<br>
                                        {{ order.payment.data.zip_code }} {{ order.payment.data.city }}<br>
                                        {{ order.payment.data.country }}
                                    </div>

                                {% endif %}
                            </div>
                        </li>
                    </ul>

                    {% if order.payment.message %}
                        <div class="well well-default {{ store.theme_options.well_default_shadow }} payment-msg">
                            {{ order.payment.message }}
                        </div>
                    {% endif %}

                </div>
            </div>

        </div>
    </div>

{% endblock %}
