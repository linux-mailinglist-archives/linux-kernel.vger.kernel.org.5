Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B067FD6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjK2Mdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjK2Mdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:33:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133F88F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:33:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF62C433C7;
        Wed, 29 Nov 2023 12:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701261237;
        bh=rcKNM4SrzvOTPOMTTnNAkDwa6umDcm/Z1HWPpEbPqyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjRhol3cWY3zuGru3VVvU0O2nvIZ1iroKFgUGd5udxtr1+fOZwwjI4yf34DDZBv6e
         3prqd/wUw5nFVikChUwzQVlOj3jKDgliaH6N/gbEFyGYqMRPILgkTeJgSOPo6go4Ru
         QA0lsDQ1IkYy0myr5ssNkCMZE4Fye5x+f/6igxF5houf7db1oPc0rp0j7PyJpwicjP
         dnGM+Ga37Jy74eyQgKrb/5PqccEYDaKnLbwudYSK4RJ+LSyr3qDaXHuk+396BqI0ae
         ZJRjIlDqvg/ucpgMXN/p3WqucvWHyOw6mCXMInn8nuHvw2Wfvi4HdmHJxvZUsU5dII
         SB0+fpQJHj75w==
Date:   Wed, 29 Nov 2023 12:33:46 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Yu-Chien Peter Lin <peterlin@andestech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, acme@kernel.org,
        adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        dminus@andestech.com, evan@rivosinc.com, geert+renesas@glider.be,
        guoren@kernel.org, heiko@sntech.de, irogers@google.com,
        jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, locus84@andestech.com,
        magnus.damm@gmail.com, mark.rutland@arm.com, mingo@redhat.com,
        n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
        tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
        wens@csie.org, will@kernel.org, ycliang@andestech.com,
        inochiama@outlook.com
Subject: Re: [PATCH v4 09/13] dt-bindings: riscv: Add T-Head PMU extension
 description
Message-ID: <20231129-curvature-stainable-bf77c735438f@spud>
References: <20231122121235.827122-1-peterlin@andestech.com>
 <20231122121235.827122-10-peterlin@andestech.com>
 <20231123-obscurity-copied-7a7bcc66d69d@wendy>
 <ZWb6qqaNzzNUJ7aX@APC323>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Utvw2SdgzW4fg31u"
Content-Disposition: inline
In-Reply-To: <ZWb6qqaNzzNUJ7aX@APC323>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Utvw2SdgzW4fg31u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 04:47:38PM +0800, Yu-Chien Peter Lin wrote:
> Hi Conor,
>=20
> On Thu, Nov 23, 2023 at 02:48:20PM +0000, Conor Dooley wrote:
> > On Wed, Nov 22, 2023 at 08:12:31PM +0800, Yu Chien Peter Lin wrote:
> > > Document the ISA string for T-Head performance monitor extension
> > > which provides counter overflow interrupt mechanism.
> > >=20
> > > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > > ---
> > > Changes v2 -> v3:
> > >   - New patch
> > > Changes v3 -> v4:
> > >   - No change
> > > ---
> > >  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml =
b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > index c91ab0e46648..694efaea8fce 100644
> > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > @@ -258,5 +258,11 @@ properties:
> > >              in commit 2e5236 ("Ztso is now ratified.") of the
> > >              riscv-isa-manual.
> > > =20
> > > +        - const: xtheadpmu
> > > +          description:
> > > +            The T-Head performance monitor extension for counter ove=
rflow. For more
> > > +            details, see the chapter 12 in the Xuantie C906 user man=
ual.
> > > +            https://github.com/T-head-Semi/openc906/tree/main/doc
> >=20
> > I'm pretty sure that I asked on the previous revision for you to
> > identify a specific revision of this document.
>=20
> Sorry, I'm still searching for it.

Identifying a specific commit from that repo as the revision would be
okay. Follow the format used elsewhere for the standard extensions.

Cheers,
Conor.

--Utvw2SdgzW4fg31u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWcvqgAKCRB4tDGHoIJi
0pQuAQDZZfwrh03OUXbGE0xwEKsxZcfxxPGdlMVElJGo9ksISAD+KCK6j7yitR3a
gkIK95gOtiUMn/8ZposqtImCwROI7gg=
=RvjF
-----END PGP SIGNATURE-----

--Utvw2SdgzW4fg31u--
