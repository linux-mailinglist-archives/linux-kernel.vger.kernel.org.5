Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F927D5507
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjJXPP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJXPPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:15:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7687EBA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:15:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34918C433C8;
        Tue, 24 Oct 2023 15:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698160522;
        bh=u5iInjVkFqq6twQIGSCee/Oz/tW7nBGer/lK20D31Xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XftoKzKT+DVIsn5Nm/xOuJzt8/Qkfa9WmbjGoB5V/+5y1TdPa7yfNXrrrUrW5eURv
         wQ+OhD2YnANDzgsnjDbGI/99Gw11uoXTQrMeXAQqg6ryM6YAlUYnlPSt/ouxJoUaJj
         YtRNyNlcoQGvTmPJwFRgThCZW6vB0Pp+aQ4C2Bn1oP7Qg132F4b8Xr96dfCtW2vQQc
         4BNAYIWJUgq8LeBqzfnjztGsvHS6fAnZnYbz81dxPiTXC6dYRf1SpcFOfqERyb/WBa
         bXYYS0pwFfYlMbgl/mkCN34aShWq1YQvJcsRNj7Jt9a1TgwB4+Mhdp0WDrLe5KtAZR
         xKV2kU/+G8Khw==
Date:   Tue, 24 Oct 2023 16:15:16 +0100
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
Subject: Re: [PATCH 1/6] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-katsu
Message-ID: <20231024-reenact-wildfowl-de6575bbe6f6@spud>
References: <20231024000724.57714-1-hsinyi@chromium.org>
 <20231024000724.57714-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IXfQT/WBQHW6S1aX"
Content-Disposition: inline
In-Reply-To: <20231024000724.57714-2-hsinyi@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IXfQT/WBQHW6S1aX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 05:02:24PM -0700, Hsin-Yi Wang wrote:
> Add katsu and katsu sku38 which uses different audio codec.
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index a5999b3afc35..fe8c488a3207 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -235,6 +235,12 @@ properties:
>          items:
>            - const: google,kappa
>            - const: mediatek,mt8183
> +      - description: Google Katsu (ASUS Chromebook Detachable CZ1)
> +        items:
> +          - enum:
> +              - google,katsu
> +              - google,katsu-sku38

This seems a little odd - does the non sku38 not have an sku of its own?

> +          - const: mediatek,mt8183
>        - description: Google Kodama (Lenovo 10e Chromebook Tablet)
>          items:
>            - enum:
> --=20
> 2.42.0.758.gaed0368e0e-goog
>=20

--IXfQT/WBQHW6S1aX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTffhAAKCRB4tDGHoIJi
0iYxAQCeo78+GzbLQpTjP3HNRYuhl6l/m0VHJ1VoN5LPcGxlrgEAtbghA9EB30g5
XFskjU5z+WJ6EBfh7yse/wqNH8YRPgk=
=0wSh
-----END PGP SIGNATURE-----

--IXfQT/WBQHW6S1aX--
