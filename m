Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395A578DF98
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbjH3TW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243736AbjH3LiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10494D2;
        Wed, 30 Aug 2023 04:38:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AA2962418;
        Wed, 30 Aug 2023 11:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83623C433C7;
        Wed, 30 Aug 2023 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693395482;
        bh=3XQ7R+mQiCgel+4CVupUmCG8UGUYbU452w6fK1wZRrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPLsF6iRnbcm71F3V2P3osHte2tkWFXqi2ByncFvfN6aLsAiCdM44EfXavfq/Zsam
         lxli8eovc4mR/cCiKVUtp119vm2tCjMK133NdcS4aR07AjFo53P1+r8jBOPpBVqDii
         5eJMZh8XKaVfTkLTMXqKK7qjSGsEsFQEvoOTVgQ4cHaq8cbQTdeKZJTWtyPcEXYHxE
         93wqy9U4//qlvR0MgiiaVzeNRmNqPi1WZaqxVdMNr2o2axaJmBufnUEjTwsXuw6EP1
         WWKpdVG2FNPrKEZQHXOfkDbAQpvHfK1q1Fw+IY3O0Q7uzivGDwi1EPth38XaMaG14f
         v+VbU34HpjxWQ==
Date:   Wed, 30 Aug 2023 13:37:59 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Helen Koike <helen.koike@collabora.com>,
        dri-devel@lists.freedesktop.org, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, emma@anholt.net, robclark@freedesktop.org,
        gustavo.padovan@collabora.com, robdclark@google.com,
        anholt@google.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com, corbet@lwn.net,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        heiko@sntech.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v11] drm: Add initial ci/ subdirectory
Message-ID: <4rpsqk4tgrdcxtxtfoum6o4oyglwkirmkh3jj4y5tays2ivb5p@uwqdf3snshkv>
References: <20230811171953.176431-1-helen.koike@collabora.com>
 <ZOTFfhtzzWkrQ23Y@phenom.ffwll.local>
 <zorvxwffshrsqx5cy76pe3gn52qrqav7qusz5acav2un2ydvwr@fwjd56qg2xve>
 <87bkeo23vs.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zherdrxsl3xlh5y6"
Content-Disposition: inline
In-Reply-To: <87bkeo23vs.fsf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zherdrxsl3xlh5y6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 01:58:31PM +0300, Jani Nikula wrote:
> On Wed, 30 Aug 2023, Maxime Ripard <mripard@kernel.org> wrote:
> > On Tue, Aug 22, 2023 at 04:26:06PM +0200, Daniel Vetter wrote:
> >> On Fri, Aug 11, 2023 at 02:19:53PM -0300, Helen Koike wrote:
> >> > From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >> >=20
> >> > Developers can easily execute several tests on different devices
> >> > by just pushing their branch to their fork in a repository hosted
> >> > on gitlab.freedesktop.org which has an infrastructure to run jobs
> >> > in several runners and farms with different devices.
> >> >=20
> >> > There are also other automated tools that uprev dependencies,
> >> > monitor the infra, and so on that are already used by the Mesa
> >> > project, and we can reuse them too.
> >> >=20
> >> > Also, store expectations about what the DRM drivers are supposed
> >> > to pass in the IGT test suite. By storing the test expectations
> >> > along with the code, we can make sure both stay in sync with each
> >> > other so we can know when a code change breaks those expectations.
> >> >=20
> >> > Also, include a configuration file that points to the out-of-tree
> >> > CI scripts.
> >> >=20
> >> > This will allow all contributors to drm to reuse the infrastructure
> >> > already in gitlab.freedesktop.org to test the driver on several
> >> > generations of the hardware.
> >> >=20
> >> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >> > Signed-off-by: Helen Koike <helen.koike@collabora.com>
> >> > Acked-by: Daniel Stone <daniels@collabora.com>
> >> > Acked-by: Rob Clark <robdclark@gmail.com>
> >> > Tested-by: Rob Clark <robdclark@gmail.com>
> >>=20
> >> Ok I pushed this into a topic/drm-ci branch in drm.git and asked sfr to
> >> include that branch in linux-next.
> >>=20
> >> But also I'd like to see a lot more acks here, we should be able to at
> >> least pile up a bunch of (driver) maintainers from drm-misc in support=
 of
> >> this. Also maybe media, at least I've heard noises that they're maybe
> >> interested too? Plus anyone else, the more the better.
> >
> > I'm not really convinced by that approach at all, and most of the issues
> > I see are shown by the follow-up series here:
>=20
> I'm not fully convinced either, more like "let's see". In that narrow
> sense, ack. I don't see harm in trying, if you're also open to backing
> off in case it does not pan out.
>=20
> > https://lore.kernel.org/dri-devel/20230825122435.316272-1-vignesh.raman=
@collabora.com/
> >
> >   * We hardcode a CI farm setup into the kernel
> >
> >   * We cannot trust that the code being run is actually the one being
> >     pushed into gitlab
> >
> >   * IMO, and I know we disagree here, any IGT test we enable for a given
> >     platform should work, period. Allowing failures and flaky tests just
> >     sweeps whatever issue is there under the rug. If the test is at
> >     fault, we should fix the test, if the driver / kernel is at fault,
> >     then I certainly want to know about it.
>=20
> At least for display, where this also depends on peripheral hardware,
> it's not an easy problem, really.

Aside from the Chamelium tests, which tests actually rely on peripheral
hardware? On EDID and hotplug, sure, but that can easily be set up from
the userspace, or something like

https://www.lindy-international.com/HDMI-2-0-EDID-Emulator.htm?websale8=3Dl=
d0101.ld021102&pi=3D32115

> How reliable do you need it to be? How many nines? Who is going to
> debug the issues that need hundreds or thousands of runs to reproduce?
> If a commit makes some test less reliable, how long is it going to
> take to even see that or pinpoint that?

I mean, that's also true for failures or success then. How many times do
you need a test to run properly to qualify it as a meaningful test? How
do you know that it's not a flaky test?

Ultimately, it's about trust. If, for a given test that just failed, I
can't be certain that it's because of the branch I just submitted, I
will just ignore the tests results after a while.

This is already what plagues kernelci, and we should do better.

And I'm sorry, but if some part of the kernel or driver just isn't
reliable, then we shouldn't claim it is (except for all the times it
isn't). If no-one has the time to look into it, fine, but flagging it
under a flaky test doesn't help anyone.

Like, from that patch, how can I know what is the issue with
kms_hdmi_inject@inject-4k or kms_addfb_basic@addfb25-bad-modifier on
mt8173. I certainly can't. And neither of those have anything to do with
peripheral hardware.

Maxime

--zherdrxsl3xlh5y6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZO8qFwAKCRDj7w1vZxhR
xaeoAQCplynR4IBaAjXxwYEJBraRaDZg7/oKmyvbKaWv3yNoUwD/Zfv+1zH3hT2I
spFN+hiweGxT/xn46f6giSypaSMdWQc=
=6JkP
-----END PGP SIGNATURE-----

--zherdrxsl3xlh5y6--
