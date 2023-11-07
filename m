Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F5B7E375B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjKGJTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjKGJTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:19:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE0B122;
        Tue,  7 Nov 2023 01:19:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE03C433C8;
        Tue,  7 Nov 2023 09:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699348767;
        bh=VDrXsVNkm+N8iNlJC3ZwEH4c+vJY+PF2deM4StXlHO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NYHtnTJnvG6VbnZXS27Xlyz8fAbAUOKKK+C0hD/yaEtP3hsK1Ft/lHn10pWx8x1ar
         lvK7xSDqD7EuZfakWhLeb+ssDHh2t/ywB0jfMWGhw0gQ7PD0kmMLqM52eTbYssUDAU
         0b+6+E6otlZyPvBUDvMpMsvMC80povFl+2nQNBvX7nCWH+5ucojPZNMfaeK1Z076i8
         Mk3Y3AaVvEcXbmZ1safxJou7RShM8a6rP+ur+hRMrkOU4u4ojoBlei0eTHmSOB9+eG
         PxF2bIabLg/DSeV0GPKgiGapHIOaZLvAViYf+VDWadCax+CBHM6PCRQZyguJRXGzRG
         b8tJ6WJhB2NUA==
Date:   Tue, 7 Nov 2023 10:19:24 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Keith Zhao <keith.zhao@starfivetech.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jagan Teki <jagan@edgeble.ai>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Shawn Guo <shawnguo@kernel.org>, christian.koenig@amd.com
Subject: Re: [PATCH v2 6/6] drm/vs: Add hdmi driver
Message-ID: <rx7oxrxs6dgwdkdu4l7y74yek4656jejixzccryml6jl6t5elp@jvk7agdcljwg>
References: <20231025103957.3776-1-keith.zhao@starfivetech.com>
 <20231025103957.3776-7-keith.zhao@starfivetech.com>
 <70805ff2-56a8-45e1-a31c-ffb0e84749e5@linaro.org>
 <3twc4zoohon7uujypgjtlnryfmebx4osvpykagnwr5nemmqz2w@w4vw55uswebh>
 <CAA8EJppxQ7J8DEDFsWzPL8bDpNW-KY0nhUA++zDBRpMCpP-bkA@mail.gmail.com>
 <344veqjvvwlo7vls2kdlgjggf77of2ijxwc2hmk7tarm75ugcs@bmozk23uqxqr>
 <CAA8EJpomaDoJVkq+_NhcxqOs6X-dFd=Vo9Wtqnp8egNaWzDH2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sx3kokd2nvv34uc7"
Content-Disposition: inline
In-Reply-To: <CAA8EJpomaDoJVkq+_NhcxqOs6X-dFd=Vo9Wtqnp8egNaWzDH2Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sx3kokd2nvv34uc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 29, 2023 at 06:52:24PM +0200, Dmitry Baryshkov wrote:
> On Thu, 26 Oct 2023 at 14:53, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Thu, Oct 26, 2023 at 11:57:22AM +0300, Dmitry Baryshkov wrote:
> > > On Thu, 26 Oct 2023 at 11:07, Maxime Ripard <mripard@kernel.org> wrot=
e:
> > > >
> > > > On Thu, Oct 26, 2023 at 01:23:53AM +0300, Dmitry Baryshkov wrote:
> > > > > > +static int starfive_hdmi_register(struct drm_device *drm, stru=
ct starfive_hdmi *hdmi)
> > > > > > +{
> > > > > > +   struct drm_encoder *encoder =3D &hdmi->encoder;
> > > > > > +   struct device *dev =3D hdmi->dev;
> > > > > > +
> > > > > > +   encoder->possible_crtcs =3D drm_of_find_possible_crtcs(drm,=
 dev->of_node);
> > > > > > +
> > > > > > +   /*
> > > > > > +    * If we failed to find the CRTC(s) which this encoder is
> > > > > > +    * supposed to be connected to, it's because the CRTC has
> > > > > > +    * not been registered yet.  Defer probing, and hope that
> > > > > > +    * the required CRTC is added later.
> > > > > > +    */
> > > > > > +   if (encoder->possible_crtcs =3D=3D 0)
> > > > > > +           return -EPROBE_DEFER;
> > > > > > +
> > > > > > +   drm_encoder_helper_add(encoder, &starfive_hdmi_encoder_help=
er_funcs);
> > > > > > +
> > > > > > +   hdmi->connector.polled =3D DRM_CONNECTOR_POLL_HPD;
> > > > > > +
> > > > > > +   drm_connector_helper_add(&hdmi->connector,
> > > > > > +                            &starfive_hdmi_connector_helper_fu=
ncs);
> > > > > > +   drmm_connector_init(drm, &hdmi->connector,
> > > > > > +                       &starfive_hdmi_connector_funcs,
> > > > > > +                       DRM_MODE_CONNECTOR_HDMIA,
> > > > >
> > > > > On an embedded device one can not be so sure. There can be MHL or=
 HDMI
> > > > > Alternative Mode. Usually we use drm_bridge here and drm_bridge_c=
onnector.
> > > >
> > > > On an HDMI driver, it's far from being a requirement, especially gi=
ven
> > > > the limitations bridges have.
> > >
> > > It's a blessing that things like MHL / HDMI-in-USB-C / HDMI-to-MyDP
> > > are not widely used in the wild and are mostly non-existing except
> > > several phones that preate wide DP usage.
> >
> > And those can be supported without relying on bridges.
>=20
> Yes, they likely can, in the way that nouveau handles I2C TV encoders.
> But I don't think this can scale. We can have different devices
> attached to the DSI, LVDS, HDMI and even DP image sources. I don't see
> a scalable solution for either of them. E.g. by switching drm/msm to
> use panel bridges for DSI panels we were able to significantly unify
> and simplify code paths.

I'm glad it worked fine for drm/msm, but what I don't really like is the
current dogma that *everything* should be a bridge, and that's just a
poor guideline.

> > > Using drm_connector directly prevents one from handling possible
> > > modifications on the board level. For example, with the DRM connector
> > > in place, handling a separate HPD GPIO will result in code duplication
> > > from the hdmi-connector driver. Handling any other variations in the
> > > board design (which are pretty common in the embedded world) will also
> > > require changing the driver itself. drm_bridge / drm_bridge_connector
> > > save us from those issues.
> >
> > And we have other solutions there too. Like, EDIDs are pretty much in
> > the same spot with a lot of device variations, but it also works without
> > a common driver. I'd really wish we were having less bridges and more
> > helpers, but here we are.
> >
> > > BTW: what are the limitations of the drm_bridge wrt. HDMI output? I'm
> > > asking because we heavily depend on the bridge infrastructure for HDMI
> > > output. Maybe we are missing something there, which went unnoticed to
> > > me and my colleagues.
> >
> > A bridge cannot extend the connector state or use properties, for
> > example. It works for basic stuff but falls apart as soon as you're
> > trying to do something slightly advanced.
>=20
> Ack. I agree, we didn't have a necessity to implement properties up to
> now. But that sounds like an interesting topic for DSI-to-HDMI bridges
> and HDCP support. I'll need to check if any of the RB3/RB5/Dragonboard
> bridges are programmed with the HDCP keys.

Aside from HDCP, the current color management work will also require to
expose properties on the connectors.

Maxime

--sx3kokd2nvv34uc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZUoBHAAKCRDj7w1vZxhR
xWiBAP4sevvTIl4u+we2L7l/PqToVfQ/nXueZ0RTUgw/AJ/I1wEA+wM7mB5NCTiB
uAat91IEFc4bWWOTLkkDTh9pBOjkfwg=
=28g0
-----END PGP SIGNATURE-----

--sx3kokd2nvv34uc7--
