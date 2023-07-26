Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E80763E5C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGZS0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjGZS0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:26:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992C91BF2;
        Wed, 26 Jul 2023 11:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26B6B61C2C;
        Wed, 26 Jul 2023 18:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FFEC433C7;
        Wed, 26 Jul 2023 18:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690395978;
        bh=A30cu5a7m+wlNOFxI/r/j2NeXh30+KblqTv+yBDr794=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+ukAvaW39tVcWmnKR+x6J25wFQIeuFbEY9bpC1b8u956PHkXo/MlppzPRUQPyAXL
         YQmbzmqAcl+oOukFMbe/RamPmk6T6FQcNHCf2RfNxjzqujPmZ8oOtrSBFPvi3VFSNx
         8XxSEnlMH02ryibCDXYOPrTOfbQdxIsjkAQ+9JwnlzN4GnlRZFn6Irx/T/pjBGAn9b
         Dy7k6U+3Vir1hNdzn1wRGGUNiInlqBFaXxH5ZlJK/Pih4ZW+TFhvLoQw9rTkLshV0v
         qEqnSoZhx6RuVX+Fzuaw8q2xqbV5gffAj60BTMVPPPViNIsHlKqDn6CbcsJXTnr0Le
         lXGy/yElqfLBA==
Date:   Wed, 26 Jul 2023 19:26:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM with
 Custom Board
Message-ID: <20230726-frosted-scroll-a42298d2ee9c@spud>
References: <20230726123747.4097755-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5u1rgdJT7upE+Fpg"
Content-Disposition: inline
In-Reply-To: <20230726123747.4097755-1-james.hilliard1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5u1rgdJT7upE+Fpg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 06:37:39AM -0600, James Hilliard wrote:
> Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM with Custom Board.
>=20
> Cc: Pierluigi Passaro <pierluigi.p@variscite.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 2510eaa8906d..76bb098605e7 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -385,6 +385,12 @@ properties:
>            - const: toradex,apalis_imx6q
>            - const: fsl,imx6q
> =20
> +      - description: i.MX6Q Variscite VAR-SOM-MX6 Boards
> +        items:
> +          - const: variscite,mx6customboard
> +          - const: variscite,var-som-imx6q
> +          - const: fsl,imx6q

I find it hard to tell what the sort order here is meant to be, but it
appears to be first by what I.MX processor and then by the board
compatibles? If so, this is added out of order.

> +
>        - description: TQ-Systems TQMa6Q SoM (variant A) on MBa6x
>          items:
>            - const: tq,imx6q-mba6x-a
> --=20
> 2.34.1
>=20

--5u1rgdJT7upE+Fpg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMFlRAAKCRB4tDGHoIJi
0imqAQDK7HDhloLkHXik8jUnh00k9J9Pqvx+AZeghi3u6cnb6wD+JRFY6LRtMUrU
4dSgmqYWc8QqFFPYdTLV52u/69JxRwo=
=0g2f
-----END PGP SIGNATURE-----

--5u1rgdJT7upE+Fpg--
