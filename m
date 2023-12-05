Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77D78055E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345437AbjLEN30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjLEN3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:29:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D83CBA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:29:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75542C433C7;
        Tue,  5 Dec 2023 13:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701782971;
        bh=Zn4GYLZmwXmZqyevn2I97x9daNh38VTwlzu5aculNSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WD9J9AJFAk2/0D4VYVAU+ifx6QQLbsfR/xrNu9brFiuRqBcsECW8yhOmirrZNo47f
         7m6ARj4MSrzFU7Gj1AlzP//n3uQrgdlEMydSex59apB9u9zWniz7tNZv8URpPrvxGi
         ZOvRjg0fz3fJG1gxtoML0uPSx7OSd5UUhPBaWnNSFIMtEooNk7BXmBjOHRy2Oy3Iod
         AMFofToE1m0upfK+FeWxWEkfCHcjagDADz9vyz7kecbsQmvSBp6uaWSbeEN5SQA6sa
         OBD+VIZUqPY7DieFrZ+th6xFijAxCK6e0AxoWlAF8asfe+f5WM0XITBejsB5bKe8AK
         rF4xwjpQ7MWaA==
Date:   Tue, 5 Dec 2023 14:29:27 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andrew Davis <afd@ti.com>, Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Adam Ford <aford173@gmail.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH RFC 01/10] dt-bindings: gpu: Add PowerVR Series5 SGX GPUs
Message-ID: <vawv2mwhonuyvgmp7uox4rfgdcjwg5fa7hmbcfgl3wiase6e4p@tyavpclppfvu>
References: <20231204182245.33683-1-afd@ti.com>
 <20231204182245.33683-2-afd@ti.com>
 <23livt5mcc64bb6lkeec2uxp5cyn4wfekwaj6wzrjnrkndvwgj@6tveqglqpr4v>
 <B3A1B8A7-0363-4ECB-AFBF-576FECA569FA@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sk5rtloxlgm34n5t"
Content-Disposition: inline
In-Reply-To: <B3A1B8A7-0363-4ECB-AFBF-576FECA569FA@goldelico.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sk5rtloxlgm34n5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 05, 2023 at 09:18:58AM +0100, H. Nikolaus Schaller wrote:
> > Am 05.12.2023 um 07:57 schrieb Maxime Ripard <mripard@kernel.org>:
> >=20
> > On Mon, Dec 04, 2023 at 12:22:36PM -0600, Andrew Davis wrote:
> >> The Imagination PowerVR Series5 "SGX" GPU is part of several SoCs from
> >> multiple vendors. Describe how the SGX GPU is integrated in these SoC,
> >> including register space and interrupts. Clocks, reset, and power doma=
in
> >> information is SoC specific.
> >>=20
> >> Signed-off-by: Andrew Davis <afd@ti.com>
> >> ---
> >> .../devicetree/bindings/gpu/img,powervr.yaml  | 69 +++++++++++++++++--
> >> 1 file changed, 63 insertions(+), 6 deletions(-)
> >=20
> > I think it would be best to have a separate file for this, img,sgx.yaml
> > maybe?
>=20
> Why?

Because it's more convenient?

> The whole family of IMG GPUs is PowerVR and SGX and Rogue are generations=
 5 and 6++:
>=20
> https://en.wikipedia.org/wiki/PowerVR

That's not really relevant as far as bindings go. We have multiple
binding files for devices of the same generation, or single bindings
covering multiple generations.

The important part is that every compatible is documented. It doesn't
really matter how or where.

Maxime

--sk5rtloxlgm34n5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZW8ltgAKCRDj7w1vZxhR
xUSvAP9PUbf4+YT0EyccyJajSXPeDQSwn4etNEbxV50lUUuE8AD9EaQjz+C035S5
zToIGETivgzX+fLoler4pvNrddntIg4=
=WGdx
-----END PGP SIGNATURE-----

--sk5rtloxlgm34n5t--
