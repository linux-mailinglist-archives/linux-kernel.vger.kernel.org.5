Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF087D54FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjJXPNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjJXPNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:13:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FDE122
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:13:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A970C433C7;
        Tue, 24 Oct 2023 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698160425;
        bh=kz+EcQENOMM9JFxNzp/7U0xgoKM7XMrQN9wRluSh3nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgQwQxCpxGgu/+NEqBmzfVjiFRkfueXgyxvkR2B+iJe7BZ5X2cBCVjS6FL4ZY+eQH
         4xXflAg4lZWHjtq2e3w3E5EK+lqlGD/NtU2+HU8CC0Lb6wmW6DwwdMgxEfyMxqu7gB
         RICHchKMs5I2qyPPqp/H930fnNaknkhAQ0q2jTdckm/tFQRkjcLrR1/SC97LuUIwAa
         4OYG4ZW0SVXhsuo1A6LB7wo6zG/ZkWivtobA5e9SC7TXWDMP8HbGSTK8lwsJo5zqCj
         vCaRdWsSEhHc4xZSdMGAc7RNUmC90ti+IzB5NBAFsuUlIXhfdg920uZuObs6ZNvY2v
         uMT7xk6rpU9Fg==
Date:   Tue, 24 Oct 2023 16:13:40 +0100
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
Subject: Re: [PATCH 5/6] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-pico
Message-ID: <20231024-relearn-engraver-59da32127a9f@spud>
References: <20231024000724.57714-1-hsinyi@chromium.org>
 <20231024000724.57714-6-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6erb5bK3QgxEzTmd"
Content-Disposition: inline
In-Reply-To: <20231024000724.57714-6-hsinyi@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6erb5bK3QgxEzTmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 05:02:28PM -0700, Hsin-Yi Wang wrote:
> Add pico (sku1) and pico6 (sku2).
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index b131e0bdbf01..6bb1d80dd4eb 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -262,6 +262,13 @@ properties:
>            - const: google,makomo-rev5-sku1
>            - const: google,makomo
>            - const: mediatek,mt8183
> +      - description: Google Pico (Acer Chromebook Spin 311)
> +        items:
> +          - enum:
> +              - google,pico-sku1
> +              - google,pico-sku2
> +          - const: google,pico
> +          - const: mediatek,mt8183
>        - description: Google Willow (Acer Chromebook 311 C722/C722T)
>          items:
>            - enum:
> --=20
> 2.42.0.758.gaed0368e0e-goog
>=20
>=20

--6erb5bK3QgxEzTmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTffJAAKCRB4tDGHoIJi
0ptJAP938TCZbnBe2uIS4gmeLyq8QdFXbFTndMGiYpUQWmmqwAD+MkL42LN819op
G2JkDkUW5pEkttfORsYdu/+hHyZktA4=
=Heqq
-----END PGP SIGNATURE-----

--6erb5bK3QgxEzTmd--
