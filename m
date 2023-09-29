Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE637B340E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjI2N6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2N6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:58:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD08DB;
        Fri, 29 Sep 2023 06:58:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0392C433C8;
        Fri, 29 Sep 2023 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695995917;
        bh=CHEXPlpFmHD8rVxXqeAQGRdFG1pNx0Kk9AeUvrx4txE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jICsUAQdJA2wHFVYpRu0kl90yxId8Gfhtvm1Jl/X6SJ+/DXMq/vjzap5vOuFTtwjh
         +QzG99dKnAyH85c+D0/GnH0CxZ4mdGim0f+7MsehocvKAFmSRnkmao0TU1hnCm3td7
         wnznvXqRkOfqKzo6wDlV+xrDRrjmKlBSQnVla0W6zbK3aQ+GLbiNaMsqnjUuK0dT2l
         EsIcZ7mC4cEw6wRZ3y4PcPckx75TRQDVLRrcrkE691z6isF1B9xWAnYOIRU73y1954
         TkddNsCTIAjNYTDQuzD0ZFVdRS3WWXA6EMUhRQ/Q2xanFqKF+ovZKvS4hubVD62yld
         y+ZdJ/cft3Q9w==
Date:   Fri, 29 Sep 2023 14:58:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Moudy Ho =?utf-8?B?KOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 12/16] dt-bindings: display: mediatek: color: add
 compatible for MT8195
Message-ID: <20230929-renewably-landing-3f5a1d2eb27c@spud>
References: <20230922072116.11009-1-moudy.ho@mediatek.com>
 <20230922072116.11009-13-moudy.ho@mediatek.com>
 <20230922-zebra-modify-87ff23c70bb3@spud>
 <20230922-overhung-deception-e9b461ba0372@spud>
 <7c445195e17e15d5af5fcb30ae53f76c713e958b.camel@mediatek.com>
 <20230927-crunching-prancing-36fe3eb79607@wendy>
 <825ac03b692043d48563620ad9542a4ee43211e7.camel@mediatek.com>
 <20230928-keep-attractor-1e7cd0df03b2@spud>
 <7dbadd86-f408-bc94-92fc-22f460eebb43@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/VzKeb9rEqhIUOcg"
Content-Disposition: inline
In-Reply-To: <7dbadd86-f408-bc94-92fc-22f460eebb43@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/VzKeb9rEqhIUOcg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 10:42:58AM +0200, AngeloGioacchino Del Regno wrote:
> Il 28/09/23 18:49, Conor Dooley ha scritto:
> > On Thu, Sep 28, 2023 at 02:52:23AM +0000, Moudy Ho (=E4=BD=95=E5=AE=97=
=E5=8E=9F) wrote:
> > > On Wed, 2023-09-27 at 10:47 +0100, Conor Dooley wrote:
> > > > On Wed, Sep 27, 2023 at 07:19:28AM +0000, Moudy Ho (=E4=BD=95=E5=AE=
=97=E5=8E=9F) wrote:
> > > > > On Fri, 2023-09-22 at 16:51 +0100, Conor Dooley wrote:
> > > > > > On Fri, Sep 22, 2023 at 04:49:14PM +0100, Conor Dooley wrote:
> > > > > > > On Fri, Sep 22, 2023 at 03:21:12PM +0800, Moudy Ho wrote:
> > > > > > > > Add a compatible string for the COLOR block in MediaTek
> > > > > > > > MT8195
> > > > > > > > that
> > > > > > > > is controlled by MDP3.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> > > > > > > > ---
> > > > > > > >   .../devicetree/bindings/display/mediatek/mediatek,color.y=
aml
> > > > > > > >   | 1 +
> > > > > > > >   1 file changed, 1 insertion(+)
> > > > > > > >=20
> > > > > > > > diff --git
> > > > > > > > a/Documentation/devicetree/bindings/display/mediatek/mediat=
ek
> > > > > > > > ,col
> > > > > > > > or.yaml
> > > > > > > > b/Documentation/devicetree/bindings/display/mediatek/mediat=
ek
> > > > > > > > ,col
> > > > > > > > or.yaml
> > > > > > > > index f21e44092043..b886ca0d89ea 100644
> > > > > > > > ---
> > > > > > > > a/Documentation/devicetree/bindings/display/mediatek/mediat=
ek
> > > > > > > > ,col
> > > > > > > > or.yaml
> > > > > > > > +++
> > > > > > > > b/Documentation/devicetree/bindings/display/mediatek/mediat=
ek
> > > > > > > > ,col
> > > > > > > > or.yaml
> > > > > > > > @@ -26,6 +26,7 @@ properties:
> > > > > > > >             - mediatek,mt2701-disp-color
> > > > > > > >             - mediatek,mt8167-disp-color
> > > > > > > >             - mediatek,mt8173-disp-color
> > > > > > > > +          - mediatek,mt8195-mdp3-color
> > > > > > >=20
> > > > > > > How come this one is a "mdp3" not a "disp"?
> > > > > >=20
> > > > > > I don't know what mdp3 means & googling gives me no answers.
> > > > > > What's
> > > > > > the
> > > > > > "disp" one controlled by, since it isn't controlled by mdp3?
> > > > > >=20
> >=20
> > > > > Mediatek's Media Data Path ver.3 (MDP3) is associated with MMSYS
> > > > > and
> > > > > acts as an independent driver that operates between VDEC and DISP.
> > > > > By controlling multiple components, it carries out tasks like
> > > > > converting color formats, resizing, and applying specific Picture
> > > > > Quality (PQ) effects.
> > > > > The driver can be found at "driver/media/platform/mediatek/mdp3".
> > > > > Since the same hardware components are configured in both MDP3 and
> > > > > DISP, considering previous discussions, I attemped to integrate
> > > > > into a
> > > > > single binding, named after the controlling user.
> > > >=20
> > > > I'm still kinda struggling to understand this. Do you mean that the
> > > > hardware can be controlled by either of the disp and mdp3 drivers,
> > > > and
> > > > a compatible containing "disp" would use one driver, and one
> > > > containing
> > > > "mdp3" would use another?
> > > >=20
> >=20
> > > Sorry for any confusion caused by the software information. In the
> > > video pipeline, after decoding, the data flows sequentially through t=
wo
> > > subsystems: MDP and DISP. Each subsystems has multiple IPs, with some
> > > serving the same functionality as COLOR mentioned here. However, these
> > > IPs cannot be controlled by different subsystems. Therefore, I includ=
ed
> > > the name of the subsystem after SoC to identify the configuration's
> > > location. Is this approach feasible?
> >=20
> > I'll have to leave things to the likes of Laurent to comment here I
> > think. I don't understand this hardware well enough to have a useful
> > opinion. It would seem like a different part of the datapath is a
> > different device that should be documented separately, but I don't know
> > enough to say for sure, sorry.
>=20
> Hardware speaking, it's not a different device: those all reside in the
> same block, except they are configured to route their I/O *either* to the
> display pipeline, *or* to the MDP3 pipeline.

Is it runtime configurable?

> I would agree though in that this could be more flexible, as in, not
> having a requirement to say "mdp3" or "disp", and managing the COLOR
> blocks generically and letting the drivers to choose the actual path
> transparently from what the devicetree compatible is, but there's no
> practical point in doing this in the end, because there is an enough
> number of (for example, COLOR) blocks such that one can be completely
> reserved to MDP3 and one completely reserved to DISP.
>=20
> So, we don't *need* this flexibility, but would be nice to have for
> different (unexistant, basically) usecases...
>=20
> The thing is, if we go for the maximum flexibility, the drawback is
> that we'd see a number of nodes like
>=20
> shared_block: something@somewhere {
> 	compatible =3D "mediatek,something";
> }
>=20
> mdp3: dma-controller@14001000 {
> 	......
> 	mediatek,color =3D <&color0>;
> 	mediatek,stitch =3D <&stitch0>;
> 	mediatek,hdr =3D <&hdr0>;
> 	mediatek,aal =3D <&aal0>;
> 	....
> 	long list of another 10 components
> }
>=20
> display: something@somewhere {
> 	......
> 	an even longer list than the MDP3 one
> }
>=20
> ...or perhaps even a graph, which is even longer in the end.
>=20
> I'm not against this kind of structure, but I wonder if it's worth it.

I have no idea, but it sounds like it isn't. Really what happened here,
is not me having a particular thing I want to see, is getting a response
that implied that there were two different compatibles for the same
hardware, controlled by different drivers.
It does seem to be that way at present, and this is not something I am
willing to ack etc. That's not to say that I am _nacking_ it, just that
I don't understand this enough to ack something that we usually tell
people not to do.

--/VzKeb9rEqhIUOcg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRbYBwAKCRB4tDGHoIJi
0gDgAQD4uuPf+CMkS9i8umAoxxX46tlaJiF0ICduWocAJ7z4JwEAmoWZAI0hf7If
KE6e8+SKB238W6F5JretaCDxsAbF5gU=
=6dAo
-----END PGP SIGNATURE-----

--/VzKeb9rEqhIUOcg--
