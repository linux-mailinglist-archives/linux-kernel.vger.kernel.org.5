Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CC175DBB9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 12:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGVK1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 06:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGVK1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 06:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6529526A2;
        Sat, 22 Jul 2023 03:27:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0296A608C3;
        Sat, 22 Jul 2023 10:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258BEC433C8;
        Sat, 22 Jul 2023 10:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690021659;
        bh=iCrvGuQQggONZZnbk+kJyPGMugBTRIKZ/40i59fGJus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5oAwCwMQfanuDo40P+fUYThuMWdJXhODRTvmKjmM2XU9rnp+yGYD4gG936lFXe51
         MNSUSK+0PhftarUNEjHamLqMHfLUnfYh276RxRDRKG8wgpnbQlMnYE5wKr05Qzc75m
         2VDDaoa+RDnulhIj7js2UXzeu9OMO+zvaCBgT2oZuOeXviN2q+uAWvpi3WWtn30k+U
         +ukH/2Ez6MUZhqTo9TB411Ixok82tYd6eX40ADJVAVOBbN5ezyZrn+oXFDlRHMLqx2
         8P6gimtuQtHMA2vptj296Yy99mgL3CfW1YIk93GKMa0Z7S+fu+off/dFYMKA+CFMw1
         KJ8dpkPpVgw8g==
Date:   Sat, 22 Jul 2023 11:27:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 1/3] dt-bindings: arm: ti: Add compatible for AM642-based
 TQMaX4XxL SOM family and carrier board
Message-ID: <20230722-clanking-seventeen-4b7cbd53b792@spud>
References: <6db614465a281f802771994399ebb1040acb67bc.1689936866.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XuiSL+gUS1N7m78I"
Content-Disposition: inline
In-Reply-To: <6db614465a281f802771994399ebb1040acb67bc.1689936866.git.matthias.schiffer@ew.tq-group.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XuiSL+gUS1N7m78I
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 12:59:00PM +0200, Matthias Schiffer wrote:
> For now only the MBaX4Xx carrier board is defined.
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documenta=
tion/devicetree/bindings/arm/ti/k3.yaml
> index 577eee95c8932..ae56170bf2d25 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -72,6 +72,13 @@ properties:
>            - const: phytec,am64-phycore-som
>            - const: ti,am642
> =20
> +      - description: K3 AM642 SoC on TQ-Systems TQMaX4XxL SoM
> +        item:

s/item/items/, please test bindings no matter how simple they may
appear.

> +          - enum:
> +              - tq,am642-tqma6442l-mbax4xxl # MBaX4XxL base board
> +          - const: tq,am642-tqma6442l
> +          - const: ti,am642
> +
>        - description: K3 AM654 SoC
>          items:
>            - enum:
> --=20
> TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht M=FCnchen, HRB 105018
> Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
> https://www.tq-group.com/
>=20

--XuiSL+gUS1N7m78I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLuvFgAKCRB4tDGHoIJi
0nsXAP9csAdECJzAYfGtdRBEbr0GRCZ6qcinP5Ou4j+xJ1vvRQEAynOFTOefZ90a
IaC7rXMgopuVKvmTo6wyX8+UTI9sYAk=
=K4TT
-----END PGP SIGNATURE-----

--XuiSL+gUS1N7m78I--
