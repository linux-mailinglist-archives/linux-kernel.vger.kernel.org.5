Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CEB758089
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjGRPNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjGRPNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:13:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290731715;
        Tue, 18 Jul 2023 08:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F76361632;
        Tue, 18 Jul 2023 15:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7801AC433CD;
        Tue, 18 Jul 2023 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689693186;
        bh=MQCBoldfsIWuP0gtUrC3ZlbXNQ20ZbKT7ydnIEd0bvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIscyqQ0K0RDQ9Tfe9lkcyc//V3wMggRr29mlP0a7splQzBN8Uwd6lB/h8alUKcuA
         6lT9Rp1a0sHHcuqCZN3SX+Da3JwDBO1EyZdd5hAoyYyoIkt/7TFakIR04XgiotBgv2
         d40YmoS4mo9uD11Inf6T8OY/YL3eJVmO0698/bVXcngxFRoc72Z+UPX2pcrVabpQpG
         6zD3OkKHotRJ9KddBPKEYWPeTFWBgOp7jcBmKLJGz0c2v2PIq6JKdxuC1KTuWgrRxD
         Aakf/LBn4D2ahWC9kQuAARxtd0prue28hFqk/JrIA+e7f/8QTb1OGCWlxzLl4ncVXi
         dnvWnJzf2uHjg==
Date:   Tue, 18 Jul 2023 16:13:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jason-ch Chen <jason-ch.chen@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 3/4] dt-bindings: soc: mediatek: pwrap: Modify
 compatible for MT8188
Message-ID: <20230718-sporting-refurbish-85fdfab85d32@spud>
References: <20230718110947.13426-1-jason-ch.chen@mediatek.com>
 <20230718110947.13426-4-jason-ch.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EXKcfWAFHTVX6jj4"
Content-Disposition: inline
In-Reply-To: <20230718110947.13426-4-jason-ch.chen@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EXKcfWAFHTVX6jj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 07:09:46PM +0800, Jason-ch Chen wrote:
> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
>=20
> The reason for changing the patch was that while MT8188 uses the same
> pwrap as MT8195,

> the original code was only applicable to 'compatible =3D
> "mediatek,mt8188-pwrap"'.

I don't really understand what this means. Did you mean, "the original
binding only allowed..."? If so,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> To resolve the DTBS check warning that
> '['mediatek,mt8188-pwrap', 'mediatek,mt8195-pwrap', 'syscon'] is too
> long', it is necessary to modify the code.
>=20
> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml    | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwra=
p.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> index a06ac2177444..4737e5f45d54 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> @@ -41,7 +41,6 @@ properties:
>                - mediatek,mt8173-pwrap
>                - mediatek,mt8183-pwrap
>                - mediatek,mt8186-pwrap
> -              - mediatek,mt8188-pwrap
>                - mediatek,mt8195-pwrap
>                - mediatek,mt8365-pwrap
>                - mediatek,mt8516-pwrap
> @@ -50,6 +49,11 @@ properties:
>                - mediatek,mt8186-pwrap
>                - mediatek,mt8195-pwrap
>            - const: syscon
> +      - items:
> +          - enum:
> +              - mediatek,mt8188-pwrap
> +          - const: mediatek,mt8195-pwrap
> +          - const: syscon
> =20
>    reg:
>      minItems: 1
> --=20
> 2.18.0
>=20

--EXKcfWAFHTVX6jj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLar/QAKCRB4tDGHoIJi
0gzUAQCA+hb03Fyyv+lFYbelmyhip/sbhwTGybZsMTusz4F8PwEAnaGi4QhoI8g3
Wi+ugNFLwULR/RaU57KUagR75DitXgc=
=dcTK
-----END PGP SIGNATURE-----

--EXKcfWAFHTVX6jj4--
