Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1EB7D559F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbjJXPTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbjJXPSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:18:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7B01FFA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:17:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F636C433B7;
        Tue, 24 Oct 2023 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698160641;
        bh=iUIoeX8BN34NwWD9hBWLO7g5NpDyH+v6HeWwgzPOy1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=byMvMN9h5ae0wl3zjeJQma1pcFbfadVQvDGAkqoUOPfHHvmG4EL3v8oWEFwTPrtu6
         +AiSAPhNwqFVuxcudaq65lC5m+kBTLfhYVVRMFT1EgjKkpI27KImRl9dvHcaMQ72TI
         fiUN6V3RuxvVnpGFkL90fIYO+qplqiQPcNDi5U5r/04EmKypC/Z+pyYOYmqBJiRq4r
         t4DWTSmLBVZOUB/uG4PVfT7kgLUu49q/khKuE9nJHLd7xxvDOKyce1WCcQoGjMrFa/
         E3LYkFbzSbg+lol0f252T8LQACPfLnR12gkuy9Dyk1LuN3K1yWe+RA9/W/koStD9cN
         9gjdGoMXQANcw==
Date:   Tue, 24 Oct 2023 16:17:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>,
        Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/6] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-makomo
Message-ID: <20231024-bobbed-although-06f341259ebb@spud>
References: <20231024000724.57714-1-hsinyi@chromium.org>
 <20231024000724.57714-4-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kghOtZTw0vsKrKkb"
Content-Disposition: inline
In-Reply-To: <20231024000724.57714-4-hsinyi@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kghOtZTw0vsKrKkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 05:02:26PM -0700, Hsin-Yi Wang wrote:
> Add makomo sku0 and sku1 which uses different audio codec.
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index fe8c488a3207..b131e0bdbf01 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -250,6 +250,18 @@ properties:
>                - google,kodama-sku32
>            - const: google,kodama
>            - const: mediatek,mt8183
> +      - description: Google Makomo (Lenovo 100e Chromebook 2nd Gen MTK 2)
> +        items:
> +          - const: google,makomo-rev4-sku0
> +          - const: google,makomo-rev5-sku0

With these bindings, how does one describe a makomo-rev5-sku0?
What you have here is only suitable for describing the makomo-rev4-sku0.

Cheers,
Conor.

> +          - const: google,makomo
> +          - const: mediatek,mt8183
> +      - description: Google Makomo (Lenovo 100e Chromebook 2nd Gen MTK 2)
> +        items:
> +          - const: google,makomo-rev4-sku1
> +          - const: google,makomo-rev5-sku1
> +          - const: google,makomo
> +          - const: mediatek,mt8183
>        - description: Google Willow (Acer Chromebook 311 C722/C722T)
>          items:
>            - enum:
> --=20
> 2.42.0.758.gaed0368e0e-goog
>=20

--kghOtZTw0vsKrKkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTff/AAKCRB4tDGHoIJi
0vryAP0SoSHM6UtxRF69U0/a77j0hR/fdNme03q3wM+4GTwriQEAq+HB9Lceez7W
imKIWRG7GVNAo27CEJYOSyZEkYP9egQ=
=fwLS
-----END PGP SIGNATURE-----

--kghOtZTw0vsKrKkb--
