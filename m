Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714E37D3DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjJWRc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjJWRcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:32:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9791711;
        Mon, 23 Oct 2023 10:31:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAE8C433C9;
        Mon, 23 Oct 2023 17:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698082312;
        bh=RoIE1xXK4oaL8rcaDxktETkJEouLHhkNssWXuP5Epe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqlLv54Os7Roj262+yZrxTxWxk6jTaW36NOHexBdLV1QrnXB3c7ChlTjcUyjiEM4T
         UhJxniIAuRLa6zq8WeZEzE/EPPvALijyHrcJ0fxP9UKlcFAz8SZhkugcYe4uzDniEc
         q5oeD+2GNT1qf8TxI7nm5Qho98DiuSuUX/g0YUFjmiGqFpOMis7QWLeURZLUutX/Z5
         +BgQxoD9TM8KvjdN/Qn8+evhg6A+xFMCrShDuqJT8UNIIus5cxc1PARM0W7kAH8LFf
         WY70VXysTuqxjD2S4sEEAFJ9Nx54Sv3kfej8hH868br2TwO6daWLNczPwP2qbjYoad
         PsVgcZ6Yn1Vsg==
Date:   Mon, 23 Oct 2023 18:31:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 02/18] dt-bindings: display: mediatek: ccorr: add binding
 for MT8365 SoC
Message-ID: <20231023-reshoot-liquefy-429aacb68694@spud>
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
 <20231023-display-support-v1-2-5c860ed5c33b@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ARUire+fEKHR8b9F"
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v1-2-5c860ed5c33b@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ARUire+fEKHR8b9F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 04:40:02PM +0200, Alexandre Mergnat wrote:
> Display Color Correction for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.

This commit message's first line is too vague & the second doesn't make
sense. I suspect something as succinct as "Document the display colour
correction on mt<foo>, which is compatible with that of the mt<bar>"
does what you are looking for.

I suspect this is going to apply to the rest of the series...

Cheers,
Conor.


>=20
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml |=
 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,cc=
orr.yaml
> index 8c2a737237f2..9f8366763831 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.y=
aml
> @@ -24,6 +24,9 @@ properties:
>        - enum:
>            - mediatek,mt8183-disp-ccorr
>            - mediatek,mt8192-disp-ccorr
> +      - items:
> +          - const: mediatek,mt8365-disp-ccorr
> +          - const: mediatek,mt8183-disp-ccorr
>        - items:
>            - enum:
>                - mediatek,mt8186-disp-ccorr
>=20
> --=20
> 2.25.1
>=20

--ARUire+fEKHR8b9F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTauAQAKCRB4tDGHoIJi
0rG1AQDVNLCTauTO68aeJeXwZERo8tQp+TLgjwiLq+AqZulyQwEA9uXOZb3JrBGq
ZdzQoSqOFaugEQ+Xa3te/HhYaNLcNwM=
=fTxV
-----END PGP SIGNATURE-----

--ARUire+fEKHR8b9F--
