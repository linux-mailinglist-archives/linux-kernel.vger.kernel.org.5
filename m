Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD279C0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347822AbjIKV2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbjIKJeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:34:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C9F102;
        Mon, 11 Sep 2023 02:34:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F203C433C7;
        Mon, 11 Sep 2023 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694424856;
        bh=TvpWrAcaPvo6YwEqJ4wx8ac0H6SKtwYaj6N+B+IF3DI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXXdv1gBYsBGMvX+RKb2cpVYYDqX/HK/auK9M52TcGOmA/wX2wdhgfKjgRAliM06R
         wHk+rxIK1WeGprHmyc/lgjgNxnVVA9/dmXazfrw/uH2qFuHyeMgp+ZFT6mcUhHehHk
         yACtBXmuFRXhfV66s4XHAqp9blvCNPFzjtzBjC8N675dkny+soTXDeCBQ3OAJ11hTb
         bSJJKzOTCxyBPiVQF8aZqbnhnmKAPKLsFs6rrdko3UK3ZvO1v9WcxqSW4Vy9JfoHeL
         r/00QyRcdVGCeWkGJXijfxkNroh/5ciA75w3kaCat81bHc7bAaM1k5Jv3sSgy73SND
         rryZSkWzFQHeQ==
Date:   Mon, 11 Sep 2023 11:34:13 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Daniel Stone <daniels@collabora.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Helen Koike <helen.koike@collabora.com>, emma@anholt.net,
        linux-doc@vger.kernel.org, vignesh.raman@collabora.com,
        dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        jbrunet@baylibre.com, robdclark@google.com, corbet@lwn.net,
        khilman@baylibre.com, sergi.blanch.torne@collabora.com,
        david.heidelberg@collabora.com, linux-rockchip@lists.infradead.org,
        martin.blumenstingl@googlemail.com, robclark@freedesktop.org,
        anholt@google.com, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org,
        gustavo.padovan@collabora.com,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, neil.armstrong@linaro.org,
        guilherme.gallo@collabora.com, linux-kernel@vger.kernel.org,
        tzimmermann@suse.de
Subject: Re: [PATCH v11] drm: Add initial ci/ subdirectory
Message-ID: <mnjcsiqjqdnvbbkaaz5r4n42e56qsax667r7radzyagnmmfkip@dfi64z5deqzj>
References: <20230811171953.176431-1-helen.koike@collabora.com>
 <ZOTFfhtzzWkrQ23Y@phenom.ffwll.local>
 <zorvxwffshrsqx5cy76pe3gn52qrqav7qusz5acav2un2ydvwr@fwjd56qg2xve>
 <87bkeo23vs.fsf@intel.com>
 <4rpsqk4tgrdcxtxtfoum6o4oyglwkirmkh3jj4y5tays2ivb5p@uwqdf3snshkv>
 <25df6189-7b0a-b13d-e93d-c2a388fd45e3@collabora.com>
 <zmq7pz7rtz6h765azg5kl2qgjd264yafctx4q474t5tqai57og@cajbcub4yuwr>
 <5fdf9d29-3f8d-0ee0-027f-57ff3a5cecb8@collabora.com>
 <CAKMK7uGg6n322UugJwErqF_Dvsbqceqae6SVWV3ZWEOR7x36rQ@mail.gmail.com>
 <9a2b1ad8-4359-4f12-b4f9-c1de477bc440@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sbcpezxsgpyrgvfn"
Content-Disposition: inline
In-Reply-To: <9a2b1ad8-4359-4f12-b4f9-c1de477bc440@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sbcpezxsgpyrgvfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

(Removing most of the context that got scrambled)

On Thu, Sep 07, 2023 at 01:40:02PM +0200, Daniel Stone wrote:
> Yeah, this is what our experience with Mesa (in particular) has taught us.
>=20
> Having 100% of the tests pass 100% of the time on 100% of the platforms i=
s a
> great goal that everyone should aim for. But it will also never happen.
>=20
> Firstly, we're just not there yet today. Every single GPU-side DRM driver
> has userspace-triggerable faults which cause occasional errors in GL/Vulk=
an
> tests. Every single one. We deal with these in Mesa by retrying; if we
> didn't retry, across the breadth of hardware we test, I'd expect 99% of
> should-succeed merges to fail because of these intermittent bugs in the D=
RM
> drivers.

So the plan is only to ever test rendering devices? It should have been
made clearer then.

> We don't have the same figure for KMS - because we don't test it - but
> I'd be willing to bet no driver is 100% if you run tests often enough.

And I would still consider that a bug that we ought to fix, and
certainly not something we should sweep under the rug. If half the tests
are not running on a driver, then fine, they aren't. I'm not really
against having failing tests, I'm against not flagging unreliable tests
on a given hardware as failing tests.

> Secondly, we will never be there. If we could pause for five years and sit
> down making all the current usecases for all the current hardware on the
> current kernel run perfectly, we'd probably get there. But we can't: ther=
e's
> new hardware, new userspace, and hundreds of new kernel trees.

Not with that attitude :)

I'm not sure it's actually an argument, really. 10 years ago, we would
never have been at "every GPU on the market has an open-source driver"
here. 5 years ago, we would never have been at this-series-here. That
didn't stop anyone making progress, everyone involved in that thread
included.

> Even without the first two, what happens when the Arm SMMU maintainers
> (choosing a random target to pick on, sorry Robin) introduce subtle
> breakage which makes a lot of tests fail some of the time? Do we
> refuse to backmerge Linus into DRM until it's fixed, or do we disable
> all testing on Arm until it's fixed? When we've done that, what
> happens when we re-enable testing, and discover that a bunch of tests
> get broken because we haven't been testing?

I guess that's another thing that needs to be made clearer then. Do you
want to test Mesa, or the kernel?

For Mesa, I'd very much expect to rely on a stable kernel, and for the
kernel on a stable Mesa.

And if we're testing the kernel, then let's turn it the other way
around. How are we even supposed to detect those failures in the first
place if tests are flagged as unreliable?

No matter what we do here, what you describe will always happen. Like,
if we do flag those tests as unreliable, what exactly prevents another
issue to come on top undetected, and what will happen when we re-enable
testing?

On top of that, you kind of hinted at that yourself, but what set of
tests will pass is a property linked to a single commit. Having that
list within the kernel already alters that: you'll need to merge a new
branch, add a bunch of fixes and then change the test list state. You
won't have the same tree you originally tested (and defined the test
state list for).

It might or might not be an issue for Linus' release, but I can
definitely see the trouble already for stable releases where fixes will
be backported, but the test state list certainly won't be updated.

> Thirdly, hardware is capricious. 'This board doesn't make it to u-boot' i=
s a
> clear infrastructure error, but if you test at sufficient scale, cold sol=
der
> or failing caps surface way more often than you might think. And you can't
> really pick those out by any other means than running at scale, dealing w=
ith
> non-binary results, and looking at the trends over time. (Again this is
> something we do in Mesa - we graph test failures per DUT, look for outlie=
rs,
> and pull DUTs out of the rotation when they're clearly defective. But that
> only works if you actually run enough tests on them in the first place to
> discover trends - if you stop at the first failed test, it's impossible to
> tell the difference between 'infuriatingly infrequent kernel/test bug?' a=
nd
> 'cracked main board maybe?'.)
>=20
> What we do know is that we _can_ classify tests four ways in expectations.
> Always-passing tests should always pass. Always-failing tests should alwa=
ys
> fail (and update the expectations if you make them pass). Flaking tests w=
ork
> often enough that they'll always pass if you run them a couple/few times,
> but fail often enough that you can't rely on them. Then you just skip tes=
ts
> which exhibit catastrophic failure i.e. local DoS which affects the whole
> test suite.
>=20
> By keeping those sets of expectations, we've been able to keep Mesa pretty
> clear of regressions, whilst having a very clear set of things that should
> be fixed to point to. It would be great if those set of things were zero,
> but it just isn't. Having that is far better than the two alternatives:
> either not testing at all (obviously bad), or having the test always be r=
ed
> so it's always ignored (might as well just not test).

Isn't that what happens with flaky tests anyway? Even more so since we
have 0 context when updating that list.

I've asked a couple of times, I'll ask again. In that other series, on
the MT8173, kms_hdmi_inject@inject-4k is setup as flaky (which is a KMS
test btw).

I'm a maintainer for that part of the kernel, I'd like to look into it,
because it's seriously something that shouldn't fail, ever, the hardware
isn't involved.

How can I figure out now (or worse, let's say in a year) how to
reproduce it? What kernel version was affected? With what board? After
how many occurences?

Basically, how can I see that the bug is indeed there (or got fixed
since), and how to start fixing it?

And then repeat for any other test listed in there.

I got no other reply before because I very well know the answer: nobody
knows. And that's a serious issue to me, because that effectively means
that the flaky test list will only ever increase (since we can't even
check that it's fixed, and the CI infrastructure won't check that it got
fixed either), and we won't be able to address any of the bugs listed
there.

Maxime

--sbcpezxsgpyrgvfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZP7fFQAKCRDj7w1vZxhR
xfmbAPsGFXkWn8teA+2byA7oDzD3ZNjvw+OEQL7K5iF0J77leQEA+UdATLwr99dy
m3NfwxhPXgiA66FHzZlOxiB1N+f8WwU=
=TOo0
-----END PGP SIGNATURE-----

--sbcpezxsgpyrgvfn--
