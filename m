Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA5F7AB517
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjIVPs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjIVPsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:48:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA37F102;
        Fri, 22 Sep 2023 08:48:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015D2C433C7;
        Fri, 22 Sep 2023 15:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695397699;
        bh=8w9Ujvja964fuDGqWLgM5V4eKnCcfYA0NVGZFXl15sQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5HBOrsKFey9p3dAJ7MRKC4083LY/P8a1poYb+aB+21SUWlseDbNpfcTHVARIsvzP
         bvAHEgggwV3hJIjwvIKjTZcqqlfuXL2McNpwAQNu0CMy6lEcv9fk5RdJ506CrBpyzN
         eC9qTCgvxVSLfBwR6cU+X3FK88hzghXxWn9CAA4uuu9GjBNURsbcbsGCiZycJsoQ3U
         XZzBV1p7lDlrtSDkaqjt3ddSfG0Bfnju60iQas+EBypsB+Wtfb0vKfCaze/24k3lcz
         7tw6xUPNREoIda8qU4Goa2vQfK4LfgcE2trgVMVwoedmM2pt/kVUaCvg/BA45mEJZR
         T1AKzKqMHNzNA==
Date:   Fri, 22 Sep 2023 16:48:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 11/16] dt-bindings: display: mediatek: aal: add
 compatible for MT8195
Message-ID: <20230922-copilot-blinks-9792fbb03f98@spud>
References: <20230922072116.11009-1-moudy.ho@mediatek.com>
 <20230922072116.11009-12-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jaBhXNzcCjVRYW/j"
Content-Disposition: inline
In-Reply-To: <20230922072116.11009-12-moudy.ho@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jaBhXNzcCjVRYW/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 03:21:11PM +0800, Moudy Ho wrote:
> Add a compatible string for the AAL block in MediaTek MT8195 that
> is controlled by MDP3.
>=20
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml       | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.=
yaml
> index 7fd42c8fdc32..b4c28e96dd55 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> @@ -24,6 +24,7 @@ properties:
>        - enum:
>            - mediatek,mt8173-disp-aal
>            - mediatek,mt8183-disp-aal
> +          - mediatek,mt8195-mdp3-aal
>        - items:
>            - enum:
>                - mediatek,mt2712-disp-aal
> --=20
> 2.18.0
>=20

--jaBhXNzcCjVRYW/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ23PQAKCRB4tDGHoIJi
0j37AQC9UwbCC8s2QULJCGVr5HCywVwaJT5fLfW7JjIum7PnRwD9FhdX5hZHQxDX
q3jxn4X/g9f90EQyLRTLqwpHbwF3eA4=
=kIb2
-----END PGP SIGNATURE-----

--jaBhXNzcCjVRYW/j--
