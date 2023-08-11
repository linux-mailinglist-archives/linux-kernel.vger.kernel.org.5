Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF29778A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjHKJlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbjHKJk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:40:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EF430E2;
        Fri, 11 Aug 2023 02:40:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0346464FCC;
        Fri, 11 Aug 2023 09:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D90C433CA;
        Fri, 11 Aug 2023 09:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691746854;
        bh=YKxo2Tg4s8KZIhCvMkTTrIrx1CjL6kaFws497W3O7OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TVxF9a0rrf0gCcUbAnI9XR8/9NvC9UK+VpRXwC2ZdZwYd5LKTT0Cag5SD1cQLh9HG
         Km52+DgHP+rsCE0LM54KzVo7hJXfWlF+GacIuwTmylS4kiVcXaXeo1jGH/vH0hpyNi
         j+1pFFycVitl6iZzLMaPtFMg/fi+qiUiVrLjjKsdquH/HOfm8bponw6nv9/t/JUsxa
         TwZEtOgy4v/df4MeG2WhZ4lR3+WKFvqYPlnupcmSJpSLn/R07EXS5ITyLGIM4Uudvf
         Hw6uN7dDJWXYtPX2dFvy7f++Fcq4dwK34CIoc0iwHPoWd8GQYRfnvwFo3mSAB6AjFf
         b4UjDYgu9iv3g==
Date:   Fri, 11 Aug 2023 11:40:48 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mario Tesi <mario.tesi@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: lsm6dsx: Add support for ism330dhc
Message-ID: <ZNYCIM55srmG5rF2@lore-rh-laptop>
References: <20230811-iio-spacex-lsm6ds0-v1-0-e953a440170d@linaro.org>
 <20230811-iio-spacex-lsm6ds0-v1-2-e953a440170d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cdn7TeetYcWSR9vd"
Content-Disposition: inline
In-Reply-To: <20230811-iio-spacex-lsm6ds0-v1-2-e953a440170d@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Cdn7TeetYcWSR9vd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The ISM330DHC sensor is used in the SpaceX Starlink ground
> terminals.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig           | 8 ++++----
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  | 5 +++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  | 4 ++++
>  5 files changed, 20 insertions(+), 5 deletions(-)

Hi Linus,

on st website we have just ISM330DHCX and not ISM330DHC. Should we rename i=
t in
ISM330DHCX?

>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6=
dsx/Kconfig
> index 5865a295a4df..fbb5da92f954 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -12,10 +12,10 @@ config IIO_ST_LSM6DSX
>  	help
>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
> -	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx, lsm6dsr,
> -	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, lsm6dstx,
> -	  lsm6dsv, lsm6dsv16x, lsm6dso16is, ism330is, asm330lhb, lsm6dst
> -	  and the accelerometer/gyroscope of lsm9ds1.
> +	  ism330dlc, ism330dhc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx,
> +	  lsm6dsr, lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop,
> +	  lsm6dstx, lsm6dsv, lsm6dsv16x, lsm6dso16is, ism330is, asm330lhb,
> +	  lsm6dst and the accelerometer/gyroscope of lsm9ds1.
> =20
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called st_lsm6dsx.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 4d013889c287..b702ec768067 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -20,6 +20,7 @@
>  #define ST_LSM6DSL_DEV_NAME	"lsm6dsl"
>  #define ST_LSM6DSM_DEV_NAME	"lsm6dsm"
>  #define ST_ISM330DLC_DEV_NAME	"ism330dlc"
> +#define ST_ISM330DHC_DEV_NAME	"ism330dhc"
>  #define ST_LSM6DSO_DEV_NAME	"lsm6dso"
>  #define ST_ASM330LHH_DEV_NAME	"asm330lhh"
>  #define ST_LSM6DSOX_DEV_NAME	"lsm6dsox"
> @@ -45,6 +46,7 @@ enum st_lsm6dsx_hw_id {
>  	ST_LSM6DSL_ID,
>  	ST_LSM6DSM_ID,
>  	ST_ISM330DLC_ID,
> +	ST_ISM330DHC_ID,
>  	ST_LSM6DSO_ID,
>  	ST_ASM330LHH_ID,
>  	ST_LSM6DSOX_ID,
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index c743c4871ad6..e39651ac86fb 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -20,7 +20,7 @@
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-=
2000
>   *   - FIFO size: 8KB
>   *
> - * - LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC/LSM6DS3TR-C:
> + * - LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC/ISM330DHC/LSM6DS3TR-C:
>   *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 20=
8, 416
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-=
2000
> @@ -809,6 +809,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.hw_id =3D ST_LSM6DSRX_ID,
>  				.name =3D ST_LSM6DSRX_DEV_NAME,
>  				.wai =3D 0x6b,
> +			}, {
> +				.hw_id =3D ST_ISM330DHC_ID,
> +				.name =3D ST_ISM330DHC_DEV_NAME,
> +				.wai =3D 0x6b,
>  			}, {
>  				.hw_id =3D ST_LSM6DSO_ID,
>  				.name =3D ST_LSM6DSO_DEV_NAME,
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 911444ec57c0..506a5a146bd5 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -62,6 +62,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_mat=
ch[] =3D {
>  		.compatible =3D "st,ism330dlc",
>  		.data =3D (void *)ST_ISM330DLC_ID,
>  	},
> +	{
> +		.compatible =3D "st,ism330dhc",
> +		.data =3D (void *)ST_ISM330DHC_ID,
> +	},
>  	{
>  		.compatible =3D "st,lsm6dso",
>  		.data =3D (void *)ST_LSM6DSO_ID,
> @@ -150,6 +154,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_t=
able[] =3D {
>  	{ ST_LSM6DSL_DEV_NAME, ST_LSM6DSL_ID },
>  	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
>  	{ ST_ISM330DLC_DEV_NAME, ST_ISM330DLC_ID },
> +	{ ST_ISM330DHC_DEV_NAME, ST_ISM330DHC_ID },
>  	{ ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
>  	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
>  	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_spi.c
> index f56c170c41a9..5ebe59cdc35f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -57,6 +57,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_mat=
ch[] =3D {
>  		.compatible =3D "st,ism330dlc",
>  		.data =3D (void *)ST_ISM330DLC_ID,
>  	},
> +	{
> +		.compatible =3D "st,ism330dhc",
> +		.data =3D (void *)ST_ISM330DHC_ID,
> +	},
>  	{
>  		.compatible =3D "st,lsm6dso",
>  		.data =3D (void *)ST_LSM6DSO_ID,

here we are missing st_lsm6dsx_spi_id_table[] configuration.

Regards,
Lorenzo

>=20
> --=20
> 2.34.1
>=20

--Cdn7TeetYcWSR9vd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZNYCHgAKCRA6cBh0uS2t
rFm/AQDE2ZNeVWQlITbmNQuHUVYiAEJaEKF2U2QH4pX/dKd3OAEA4APl5Qmoea2e
uYnDhRwaOwNpT+5nG2go7W2G9hHutws=
=QEop
-----END PGP SIGNATURE-----

--Cdn7TeetYcWSR9vd--
