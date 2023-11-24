Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5877F773C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345784AbjKXPGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345823AbjKXPFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:05:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038C31BCC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:05:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7D9C43395;
        Fri, 24 Nov 2023 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700838357;
        bh=W6AcqzGG834X7Fnc1UesSToakM1vJZCmLFY+BobYw5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uaoFZYrBiO3kZphuGBjihIKIKUCMOApnXvYR1zIFol9BJfuQ28O9efIrmvj1Za6xd
         quIZitQbBWw78wUv4dr5ZBdM1Pje08v9/aB/8V1Zo/vGxwLXCffJvfPF5rYQl//gam
         aGhwDvxGAHY5LeSGttX3wCaWMipeJw6Ic/4qTHiSWl9csFx95vPcmItREKo1sIG+gA
         nxcaIJHRPj37fGKOWCYJTWo9w+M/75RLhPgY6VOXE4VwnhYZH0U/D/XwaWfc0ItpzY
         qJg3IjdIlPczQ0fd24mFKl6lqGX2T211GbkYIVM8OSOV1T0aENh3kvVjX6jYo6FQ5e
         XmuGmH5A1SJlg==
Date:   Fri, 24 Nov 2023 15:05:46 +0000
From:   Conor Dooley <conor@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Yu Chien Peter Lin <peterlin@andestech.com>, acme@kernel.org,
        adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, guoren@kernel.org,
        heiko@sntech.de, irogers@google.com, jernej.skrabec@gmail.com,
        jolsa@kernel.org, jszhang@kernel.org,
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
Subject: Re: [PATCH v4 04/13] dt-bindings: riscv: Add Andes interrupt
 controller compatible string
Message-ID: <20231124-nemesis-vanity-a92814b5c3a3@spud>
References: <20231122121235.827122-1-peterlin@andestech.com>
 <20231122121235.827122-5-peterlin@andestech.com>
 <CA+V-a8t+vgrwDe9OxqMNHdcVX+qq76DuskF0ETCri4VeP-FAbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cF2+7KTXsnpo6E+a"
Content-Disposition: inline
In-Reply-To: <CA+V-a8t+vgrwDe9OxqMNHdcVX+qq76DuskF0ETCri4VeP-FAbg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cF2+7KTXsnpo6E+a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 03:03:51PM +0000, Lad, Prabhakar wrote:
> On Wed, Nov 22, 2023 at 12:18=E2=80=AFPM Yu Chien Peter Lin
> <peterlin@andestech.com> wrote:
> >
> > Add "andestech,cpu-intc" compatible string to indicate that
> > Andes specific local interrupt is supported on the core,
> > e.g. AX45MP cores have 3 types of non-standard local interrupt
> > can be handled in supervisor mode:
> >
> > - Slave port ECC error interrupt
> > - Bus write transaction error interrupt
> > - Performance monitor overflow interrupt
> >
> > These interrupts are enabled/disabled via a custom register
> > SLIE instead of the standard interrupt enable register SIE.
> >
> > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > ---
> > Changes v1 -> v2:
> >   - New patch
> > Changes v2 -> v3:
> >   - Updated commit message
> >   - Fixed possible compatibles for Andes INTC
> > Changes v3 -> v4:
> >   - Add const entry instead of enum (Suggested by Conor)
> > ---
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Docume=
ntation/devicetree/bindings/riscv/cpus.yaml
> > index f392e367d673..50307554478f 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -100,7 +100,11 @@ properties:
> >          const: 1
> >
> >        compatible:
> > -        const: riscv,cpu-intc
> > +        oneOf:
> > +          - items:
> > +              - const: andestech,cpu-intc
> given that the first patch renames andestech -> andes, do you want to
> follow the same here?

No, that's their vendor prefix, they're stuck with it.

--cF2+7KTXsnpo6E+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWC7ygAKCRB4tDGHoIJi
0skKAQDHe25no3r1QiuhIMPJ/3Knjbs0n62oqRjWcYDWRV8dMAEA1nbRbhQHzGem
C4VGWHQ58F49vu2OigDkep60E3k4tQs=
=9K1r
-----END PGP SIGNATURE-----

--cF2+7KTXsnpo6E+a--
