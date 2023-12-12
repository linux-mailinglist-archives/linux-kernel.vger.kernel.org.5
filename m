Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE2180F434
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjLLRPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLRPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:15:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205BE8F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:16:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403B3C433C9;
        Tue, 12 Dec 2023 17:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702401359;
        bh=VXQhagqDGb9vAh1nRc7GzOZY2WN4Caui/rFTeDa4cko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDVWYAz6eO+Y1M2LDd/np6T4h5hGeO0w73YW0SOmy8G4+7kKFRMH0f3fsGmxVRqFT
         LnNiOkMZJuEQjjQSjehHrvC5Rzm8REtMRExbqV91CA06WgeA/hTFgJfu5JduqRI0S0
         Rj7GoizXSMggJMReaz3jh4pXeIDkHvZ85cwxB7Pbd09B/4zfd6BgOHK8ZfC1vdZIWn
         QnWa/lMRIzgQj+Ig7GiieaB3j5UePPw+WzwiEdZ7Kp2mPWDMY/66fTcJYXn+SQ89Ka
         S4T8pFHh61+PSqbaC9Vh8lE/Aupq69ZXKXh4RWuyDT2Z9+pbFg3jDFY1nnH+q9+hbe
         Wp31YanBsWVuQ==
Date:   Tue, 12 Dec 2023 17:15:51 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ninad Palsule <ninad@linux.ibm.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, linux@roeck-us.net,
        broonie@kernel.org, patrick.rudolph@9elements.com,
        vincent@vtremblay.dev, peteryin.openbmc@gmail.com,
        lakshmiy@us.ibm.com, bhelgaas@google.com,
        naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com,
        festevam@denx.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
Subject: Re: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
Message-ID: <20231212-avid-grill-dbead068fac8@spud>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-8-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Truf82TN7Drb/wPF"
Content-Disposition: inline
In-Reply-To: <20231212164004.1683589-8-ninad@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Truf82TN7Drb/wPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:40:03AM -0600, Ninad Palsule wrote:
> From: Joel Stanley <joel@jms.id.au>
>=20
> The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
>=20
> https://www.nuvoton.com/products/cloud-computing/security/trusted-platfor=
m-module-tpm/
>=20
> Add a compatible string for it, and the generic compatible.
>=20
> OpenBMC-Staging-Count: 3

Delete this from every patch that it appears from.

> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> Link: https://lore.kernel.org/r/20220928043957.2636877-4-joel@jms.id.au
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2=
c.c
> index a897402cc36a..9511c0d50185 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -383,6 +383,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>  #ifdef CONFIG_OF
>  static const struct of_device_id of_tis_i2c_match[] =3D {
>  	{ .compatible =3D "infineon,slb9673", },
> +	{ .compatible =3D "nuvoton,npct75x", },
> +	{ .compatible =3D "tcg,tpm-tis-i2c", },

What's the point of the generic compatible if you are adding the device
specific ones to the driver anyway?

Thanks,
Conor.

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
> --=20
> 2.39.2
>=20

--Truf82TN7Drb/wPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiVRwAKCRB4tDGHoIJi
0moFAP9qCekg1FNgRigBOa03OCo2ImwKVNMJNUYY0hON1Ul2NQD/fRm6HnP66ToK
uVCHCdKv0uV6qfN1BFts+lYjExWXRQs=
=MJ72
-----END PGP SIGNATURE-----

--Truf82TN7Drb/wPF--
