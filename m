Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C83C7EA40E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjKMTyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjKMTxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:53:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5620A10CE;
        Mon, 13 Nov 2023 11:53:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C2AC433C8;
        Mon, 13 Nov 2023 19:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699905210;
        bh=emrTx/dM/O1+auWw5mA0LhsDE35tCu8mEN5lB2h0qcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWcoHXchhVS/XJD8JwE8HDZGXI97JEStuv5rRHgPgI46bK3IoWhKDgnf2Fm2yZuBr
         dQ9Uakb9CFFsHtD9Scq9/zMEhRWGeX8WSMLPxfJb3jSMy8oHb9G/xyjjmZDh59UsqC
         yiAxHKqduNwiKNx14yP6LGnvOXP/UcUJVTLPA/ltWoHU//mb43m5O3jnrnHSqrb4Iy
         6PkY6FQJ91kEzI8hi4ItyDZU4B2N1z5NzjX5m74VQLp6BdTcUoEdcvDv9OtExQamCt
         AvQG0LHFTydEaCR6GBJVbjplNBfdwvn0ST0R2Pzp4dt3Y7/QRV8QV+EHuwSLJzNqSP
         EJyanll7JbEOw==
Date:   Mon, 13 Nov 2023 19:53:26 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: mediatek,mtk-wdt: add
 MT7988 watchdog and toprgu
Message-ID: <20231113-pug-treading-630646dc7ff6@squawk>
References: <e26a98fd0b7b7b431922405732275bac01eaf220.1699890006.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v+4d4Ab1VeqFRJZg"
Content-Disposition: inline
In-Reply-To: <e26a98fd0b7b7b431922405732275bac01eaf220.1699890006.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v+4d4Ab1VeqFRJZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 03:43:24PM +0000, Daniel Golle wrote:
> Add compatible mediatek,mt7988-wdt.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Thanks,
Conor.

> ---
> v2: Drop adding include/dt-binding/mt7988-resets.h as that header is not
>     actually a binding header.
>=20
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.=
yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index cc502838bc398..8d2520241e37f 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -25,6 +25,7 @@ properties:
>            - mediatek,mt6735-wdt
>            - mediatek,mt6795-wdt
>            - mediatek,mt7986-wdt
> +          - mediatek,mt7988-wdt
>            - mediatek,mt8183-wdt
>            - mediatek,mt8186-wdt
>            - mediatek,mt8188-wdt
> --=20
> 2.42.1

--v+4d4Ab1VeqFRJZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVJ+swAKCRB4tDGHoIJi
0ipjAQC7wiCmdGPVV4FvUrbXgyRDZl0xBkSLB9OgdHHHNbRTkQD/XmNHtljnCSiv
Mbh6563hwEBuk9L2hgIJcHQY6wvKiw0=
=oAgM
-----END PGP SIGNATURE-----

--v+4d4Ab1VeqFRJZg--
