Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02FB76F82E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjHDDEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjHDDEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6761C423C;
        Thu,  3 Aug 2023 20:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F050461F21;
        Fri,  4 Aug 2023 03:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24337C433C7;
        Fri,  4 Aug 2023 03:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691118238;
        bh=PplwZWUSWRelG+HtJwh19hJ07dNTMpB+8ATd3U9MXpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NsGOS3SHUD68Ryh6BsLW3/hfZShmEBJVcGVkATBUgiesMUdkUtRYfM4ksx1CMWZ6v
         uwhNloO2c/Knaa/68tkjrKsr89qc7ZhlQvT7n3FVkoA6tPD8eXPdvwoKFGCY0wWklm
         aGoxqeaGyrLTnEINtiQWwxVgh0fQK3Tdp9ENart7fXaC1NpOXA8gRcrgin1PhPhidV
         99xjofdMknzbL9aAr3b+S9ZIyC4HhrKSZTEUkn87uooyX5ce6b/B9eBQaBIo3J7vS3
         vqZBmCOlgaqW90jWtS/mZwszNi5EisMiBqADn1Q3xj1+DbieCAqRiFlN/mW48S+NN0
         EZVBdACDy0C+w==
Received: by mercury (Postfix, from userid 1000)
        id CEAE81061B64; Fri,  4 Aug 2023 05:03:54 +0200 (CEST)
Date:   Fri, 4 Aug 2023 05:03:54 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm/panel: sitronix-st7789v: add panel
 orientation support
Message-ID: <20230804030354.oi3xnegv4afnqe5l@mercury.elektranox.org>
References: <20230718-feature-st7789v-v2-0-207cb1baea0f@wolfvision.net>
 <20230718-feature-st7789v-v2-2-207cb1baea0f@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fckfwghtydhzpdqt"
Content-Disposition: inline
In-Reply-To: <20230718-feature-st7789v-v2-2-207cb1baea0f@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fckfwghtydhzpdqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 03, 2023 at 10:13:49PM +0200, Michael Riesch wrote:
> Determine the orientation of the display based on the device tree and
> propagate it.
>=20
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---

Reviewed-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu=
/drm/panel/panel-sitronix-st7789v.c
> index c7cbfe6ca82c..6575f07d49e3 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> @@ -116,6 +116,7 @@ struct st7789v {
>  	struct spi_device *spi;
>  	struct gpio_desc *reset;
>  	struct regulator *power;
> +	enum drm_panel_orientation orientation;
>  };
> =20
>  enum st7789v_prefix {
> @@ -170,6 +171,7 @@ static const struct drm_display_mode default_mode =3D=
 {
>  static int st7789v_get_modes(struct drm_panel *panel,
>  			     struct drm_connector *connector)
>  {
> +	struct st7789v *ctx =3D panel_to_st7789v(panel);
>  	struct drm_display_mode *mode;
> =20
>  	mode =3D drm_mode_duplicate(connector->dev, &default_mode);
> @@ -188,9 +190,22 @@ static int st7789v_get_modes(struct drm_panel *panel,
>  	connector->display_info.width_mm =3D 61;
>  	connector->display_info.height_mm =3D 103;
> =20
> +	/*
> +	 * TODO: Remove once all drm drivers call
> +	 * drm_connector_set_orientation_from_panel()
> +	 */
> +	drm_connector_set_panel_orientation(connector, ctx->orientation);
> +
>  	return 1;
>  }
> =20
> +static enum drm_panel_orientation st7789v_get_orientation(struct drm_pan=
el *p)
> +{
> +	struct st7789v *ctx =3D panel_to_st7789v(p);
> +
> +	return ctx->orientation;
> +}
> +
>  static int st7789v_prepare(struct drm_panel *panel)
>  {
>  	struct st7789v *ctx =3D panel_to_st7789v(panel);
> @@ -349,6 +364,7 @@ static const struct drm_panel_funcs st7789v_drm_funcs=
 =3D {
>  	.disable =3D st7789v_disable,
>  	.enable	=3D st7789v_enable,
>  	.get_modes =3D st7789v_get_modes,
> +	.get_orientation =3D st7789v_get_orientation,
>  	.prepare =3D st7789v_prepare,
>  	.unprepare =3D st7789v_unprepare,
>  };
> @@ -382,6 +398,8 @@ static int st7789v_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
> =20
> +	of_drm_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
> +
>  	drm_panel_add(&ctx->panel);
> =20
>  	return 0;
>=20
> --=20
> 2.37.2
>=20

--fckfwghtydhzpdqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmTMapoACgkQ2O7X88g7
+poNkw/9FKqiodGUO8oFovN4JVW9FCQGSACAJH7yPrN1OCyaT1zTiCbCfXsiCWHX
ZO4DvPpUsB7EB1yMjbmCriZYBM65fAt53Ut1cZCSSCtsqyPEe774FRaqkCOxZ14x
bskZcYLewAeBDVNYoMrzowcJeN31G0VynUhirWDGdLdz6j7chyZTatawAsodaA2N
pxXgZf6Qp086U3xgJ8HiTHy/Lsrgm7jTQwhTCHGwpQtSE4LfsH6QFcGPKJO3RL2q
Jem0fKNmF9IggzAE9kM13Uvv+BJxDSIYOh1Mn6Q7Du7TBLKYQJDgEXR2t9omslWT
ui45HC8InH/GDfygMyDoxJBR+E1lHY8atY48BY1BC0LAd9ntzb3usQ6C41sOPjKR
BWHc9jjCStmS0ANW/EddEd4HbaJgYt8n6527ofuA+ELav2u1CTP+oeQPZOChw3w0
ctR8mk0ljazzNd6G7es3XCbhacod0aeNUV+EIi92lQZGY0Jud3ZIm/UcGYEUqC8F
e3691/BY7G60vjg2IBRSab+Hrh6bZTercd0qWqpNhDDF24TM8X6NVoj0fvqO/svu
V0YDej1OlmwmldjV0afQ7PcEBqaAm945Y3JQZWQyXYfDKFuSqLJyWo0qxZ2ER2h0
oNH+eu6v53SvWLw1+jH3MoDMdWoklFOX6V4xbW0016kja7uOIo4=
=fXVP
-----END PGP SIGNATURE-----

--fckfwghtydhzpdqt--
