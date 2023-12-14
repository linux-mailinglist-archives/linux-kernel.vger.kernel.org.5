Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9951D8135AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443518AbjLNQGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjLNQF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:05:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A85010F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:06:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DFFC433C7;
        Thu, 14 Dec 2023 16:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702569965;
        bh=qmS/6E2I0nmhfYaDGZBAgk8re7uSZsahK9/RuujK5KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UbO2BS8WjLB9ngjIlwpVUPNet2Pq4qaSzK33sYCCY2WWdxkZ9s72ryHwzw7rwp2mr
         aNDHOROqLdzdMUgvL4k7Avph1HDOvDwfmnluWchQU1ZSHWFbzD8wK1k1mNifRTLN7V
         Nlz7TGuK6cGjSKpiyef3YmGUEoDCn22o9KYXSCSEa3ehMA9ax+RHIodx9/EBgtS17O
         YoHQrlcDicivz7kHr/KrPIHdBMWv90SmeKLcacKRPNCz+oVGsFptrahDn4ulPBtzB2
         LDtXbTcAWoW5nR56pObzMj61zGs3PQnaiUBFQD5CnHmbPaMlc+BlArLXHwE1okcHoA
         +21PHnrYAmbDA==
Date:   Thu, 14 Dec 2023 16:05:58 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Cosmo Chou <chou.cosmo@gmail.com>
Cc:     linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jdelvare@suse.com, corbet@lwn.net, broonie@kernel.org,
        naresh.solanki@9elements.com, vincent@vtremblay.dev,
        patrick.rudolph@9elements.com, luca.ceresoli@bootlin.com,
        bhelgaas@google.com, festevam@denx.de,
        alexander.stein@ew.tq-group.com, heiko@sntech.de,
        jernej.skrabec@gmail.com, macromorgan@hotmail.com,
        forbidden405@foxmail.com, sre@kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        cosmo.chou@quantatw.com
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add asteralabs
Message-ID: <20231214-underfoot-pureness-b79a17974765@spud>
References: <20231214060552.2852761-1-chou.cosmo@gmail.com>
 <20231214060552.2852761-2-chou.cosmo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dsfGbv5NoevHxRsi"
Content-Disposition: inline
In-Reply-To: <20231214060552.2852761-2-chou.cosmo@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dsfGbv5NoevHxRsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 02:05:50PM +0800, Cosmo Chou wrote:
> Add vendor prefix for Astera Labs, Inc.
> https://www.asteralabs.com
>=20
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>

IIRC I already acked this.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 309b94c328c8..5c49f63d4ef0 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -155,6 +155,8 @@ patternProperties:
>      description: ASPEED Technology Inc.
>    "^asrock,.*":
>      description: ASRock Inc.
> +  "^asteralabs,.*":
> +    description: Astera Labs, Inc.
>    "^asus,.*":
>      description: AsusTek Computer Inc.
>    "^atheros,.*":
> --=20
> 2.34.1
>=20

--dsfGbv5NoevHxRsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXsn5gAKCRB4tDGHoIJi
0t8LAPsHyWPf9Ue2g9IRQBdCuJsUx4AFNjiKdxuIQCfwE/NYSgD/TtW+XKfnY18E
JvjWoDNCk5yVaqjA3gep8TU3RaWlDgo=
=1CRT
-----END PGP SIGNATURE-----

--dsfGbv5NoevHxRsi--
