Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4DB7AB541
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjIVPvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjIVPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:51:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB31A5;
        Fri, 22 Sep 2023 08:51:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DFEC433C8;
        Fri, 22 Sep 2023 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695397868;
        bh=3b+hYQ2/a1Tm4DZtb0TZrPYMb1hWdBmLeqVPuYi1b8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJkSamFKo5k3W7L6WowyYvGfhzsmI4tGVDDkVNqAok8EbAX0I93fKZjvYvlyIg+I6
         OcICjT7jOhmFm0LWxOUKDB/3mrrbFi18jJc1NPiF40QjakUUe01rRZIVjQ3WGvcZL+
         ngsEEEuryZqYi/rM0VbWmjY9nxkQFTIjw3ruszj2HjdvEciGVJtTedybe0bMO+C2Ce
         OikvuY6ojAcSyz8f4vT5AlUaZXWSH/0mx5lBNljVOZMekaYwtxdc8Gx/TKPhzHh/j5
         Ggvv0od3iGXviCLxNERVQEZvmbLMomI7KMUrXaTOC9yaWzAaucl/xyC9oxEVilQctz
         Qwpdpz7Eg2hFg==
Date:   Fri, 22 Sep 2023 16:51:02 +0100
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
Subject: Re: [PATCH v6 12/16] dt-bindings: display: mediatek: color: add
 compatible for MT8195
Message-ID: <20230922-overhung-deception-e9b461ba0372@spud>
References: <20230922072116.11009-1-moudy.ho@mediatek.com>
 <20230922072116.11009-13-moudy.ho@mediatek.com>
 <20230922-zebra-modify-87ff23c70bb3@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="69Rgp8WDZjRLhaqe"
Content-Disposition: inline
In-Reply-To: <20230922-zebra-modify-87ff23c70bb3@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--69Rgp8WDZjRLhaqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 04:49:14PM +0100, Conor Dooley wrote:
> On Fri, Sep 22, 2023 at 03:21:12PM +0800, Moudy Ho wrote:
> > Add a compatible string for the COLOR block in MediaTek MT8195 that
> > is controlled by MDP3.
> >=20
> > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> > ---
> >  .../devicetree/bindings/display/mediatek/mediatek,color.yaml     | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediate=
k,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,=
color.yaml
> > index f21e44092043..b886ca0d89ea 100644
> > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color=
=2Eyaml
> > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color=
=2Eyaml
> > @@ -26,6 +26,7 @@ properties:
> >            - mediatek,mt2701-disp-color
> >            - mediatek,mt8167-disp-color
> >            - mediatek,mt8173-disp-color
> > +          - mediatek,mt8195-mdp3-color
>=20
> How come this one is a "mdp3" not a "disp"?

I don't know what mdp3 means & googling gives me no answers. What's the
"disp" one controlled by, since it isn't controlled by mdp3?

>=20
> >        - items:
> >            - enum:
> >                - mediatek,mt7623-disp-color
> > --=20
> > 2.18.0
> >=20



--69Rgp8WDZjRLhaqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ235gAKCRB4tDGHoIJi
0lr8AP4pX5+R5I8aDBRKOjqDyPh+najy713mmV8eYHNfQMiT8wEAjkYfap6BkRMI
5Jt5G7JZd61u4Y6qeP5GiKajIyK6kw4=
=yqe5
-----END PGP SIGNATURE-----

--69Rgp8WDZjRLhaqe--
