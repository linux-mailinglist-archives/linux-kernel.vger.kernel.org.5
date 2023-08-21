Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8185A78263B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbjHUJ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbjHUJ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:27:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AC597
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:27:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D38961C37
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6766FC433C7;
        Mon, 21 Aug 2023 09:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692610051;
        bh=NW4Ycp3M+pHTjemza+su3ZhshTvZ9JFW/Vsro3BLEpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZBTKJR0KBWIG4VuMcSVzQjw+2J53sX+IJt7Rq5hwg7pdrBU3PkmdQocsBZxi8jTqY
         aNBrdHTkq+SxVsWSM66H84S9RA4QHMm2dzgbe5BGjvzepijWQmqyDJ+hqzykISNru+
         VhIQyiWAKACU/4SWR7nlSJgWhVZjMdYLGzspKbNP3Niik9X01iHC8Cv+ANjbk0/Y8l
         M976tPJivUsAGX7V4dLvysawBRqqJ53F4gyv8lQ39Z38MhmgAuAA3IPB03aBiCjtWK
         Z6n9IgLMyQkNDHal279iJmTQLxPgy4KT7VG5lnqSQpSk349HnqVBZ6+x4aiRV7jyHp
         bzHp8p3FxyN+w==
Date:   Mon, 21 Aug 2023 11:27:29 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     imre.deak@intel.com,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [REGRESSION] HDMI connector detection broken in 6.3 on Intel(R)
 Celeron(R) N3060 integrated graphics
Message-ID: <2xlfp5bz77tyoffqvr7orvmo45wcb7uz6nbpl7jbv6zhnqvlx3@2hxa4ltb3s3y>
References: <87v8dmr6ty.fsf@gmail.com>
 <f32b4636-969c-3b9e-6802-5991f511739e@leemhuis.info>
 <87il9l2ymf.fsf@gmail.com>
 <3df95e6d-8237-1c43-e220-a9bdb5d6e044@leemhuis.info>
 <ZNo7oXeH0JK+4GPG@ideak-desk.fi.intel.com>
 <87edk4d8qp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5ueyegkogb3zpaqt"
Content-Disposition: inline
In-Reply-To: <87edk4d8qp.fsf@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5ueyegkogb3zpaqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 11:12:46AM +0300, Jani Nikula wrote:
> On Mon, 14 Aug 2023, Imre Deak <imre.deak@intel.com> wrote:
> > On Sun, Aug 13, 2023 at 03:41:30PM +0200, Linux regression tracking (Th=
orsten Leemhuis) wrote:
> > Hi,
> >
> >> On 11.08.23 20:10, Mikhail Rudenko wrote:
> >> > On 2023-08-11 at 08:45 +02, Thorsten Leemhuis <regressions@leemhuis.=
info> wrote:
> >> >> On 10.08.23 21:33, Mikhail Rudenko wrote:
> >> >>> The following is a copy an issue I posted to drm/i915 gitlab [1] t=
wo
> >> >>> months ago. I repost it to the mailing lists in hope that it will =
help
> >> >>> the right people pay attention to it.
> >> >>
> >> >> Thx for your report. Wonder why Dmitry (who authored a4e771729a51) =
or
> >> >> Thomas (who committed it) it didn't look into this, but maybe the i=
915
> >> >> devs didn't forward the report to them.
> >>=20
> >> For the record: they did, and Jani mentioned already. Sorry, should ha=
ve
> >> phrased this differently.
> >>=20
> >> >> Let's see if these mails help. Just wondering: does reverting
> >> >> a4e771729a51 from 6.5-rc5 or drm-tip help as well?
> >> >=20
> >> > I've redone my tests with 6.5-rc5, and here are the results:
> >> > (1) 6.5-rc5 -> still affected
> >> > (2) 6.5-rc5 + revert a4e771729a51 -> not affected
> >> > (3) 6.5-rc5 + two patches [1][2] suggested on i915 gitlab by @ideak =
-> not affected (!)
> >> >=20
> >> > Should we somehow tell regzbot about (3)?
> >>=20
> >> That's good to know, thx. But the more important things are:
> >>=20
> >> * When will those be merged? They are not yet in next yet afaics, so it
> >> might take some time to mainline them, especially at this point of the
> >> devel cycle. Imre, could you try to prod the right people so that these
> >> are ideally upstreamed rather sooner than later, as they fix a regress=
ion?
> >
> > I think the patches ([1] and [2]) could be merged via the drm-intel-next
> > (drm-intel-fixes) tree Cc'ing also stable. Jani, is this ok?
>=20
> It's fine by me, but need drm-misc maintainer ack to merge [1] via
> drm-intel.

That's fine for me

Maxime

--5ueyegkogb3zpaqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZOMuAAAKCRDj7w1vZxhR
xcY1AQDOKN6ASHLZWMlRtYX09Ur6wy9cO7kZRFg47cHR2T7F0AEAstd/HKTbxG6t
B+77nQxr4KI6tALgEwk6/twhOWMDcgw=
=dD+q
-----END PGP SIGNATURE-----

--5ueyegkogb3zpaqt--
