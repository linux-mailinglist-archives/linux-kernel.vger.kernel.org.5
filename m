Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F6477422C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjHHRgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjHHRff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:35:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206B397D61;
        Tue,  8 Aug 2023 09:15:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9308D624CF;
        Tue,  8 Aug 2023 11:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA69C433C7;
        Tue,  8 Aug 2023 11:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691493810;
        bh=9dfaHkQsTbz6SSdb5UJdAoztmVevINLHKGS/qmJt5n4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pq4dqwphkPXIi18+0GXMV9gShAYkiZK/k4OcBM8SwOG1LdpZXNrapZgz5t5c2/2jZ
         8QBNNMX0AHJIw+39UDpWf+ogaSuEHSA0gCK0uZZoa0qabWv7wCx0okIcUArS5U+AV/
         QD5lfhc4yo97Sy1uDKyThSEyQuFUb1rNGTbbj1+hLhWSnaFVz8cHEFFLssFyPh000Q
         whMw26ZEUo1F4M1Qk4eJDgNAVejOjccjXCcw7w5c8+xyD8XarjeG5oqspA6AqVKiqu
         Kvu+JbOvQhUpEu4qDi0MpLsS2NK6OmtNXhxfiAECuYIvjxUQe5pW9vR1N6g9qc4gcZ
         h3BGYGhFBK8/g==
Date:   Tue, 8 Aug 2023 12:23:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de
Subject: Re: [PATCH v4 3/8] dt-bindings: clock: Add Marvell PXA1908 clock
 bindings
Message-ID: <20230808-produce-thievish-3ce1b86a114b@spud>
References: <20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr>
 <2155917.irdbgypaU6@radijator>
 <20230808-quizzical-footwork-4846d6461f74@spud>
 <10320606.nUPlyArG6x@radijator>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PFsVVMVhVavFC5ld"
Content-Disposition: inline
In-Reply-To: <10320606.nUPlyArG6x@radijator>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PFsVVMVhVavFC5ld
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 01:03:33PM +0200, Duje Mihanovi=C4=87 wrote:
> On Tuesday, August 8, 2023 12:46:23 PM CEST Conor Dooley wrote:
> > On Tue, Aug 08, 2023 at 12:41:22PM +0200, Duje Mihanovi=C4=87 wrote:
> > > They are used by the clock driver when calling mmp_clk_init which the=
n=20
> uses
> > > that as the size of a struct clk array it allocates. In retrospect, 5=
0 for
> > > each block may be too much as from what I can tell by reading the
> > > mmp_register_* functions (number of clocks + 1) for each block should=
 be
> > > enough, anything less than that causes a null pointer dereference som=
etime
> > > during clock initialization.
> >=20
> > I think you might have misread my question, I'm not really interested in
> > the implementation detail of the driver. If these are not used in
> > devicetree, remove them - otherwise they are being needlessly added to
> > the ABI.
>=20
> Should I also do this in the rest of the MMP clock drivers?

Krzysztof has just done it for all of the Samsung ones! I think it
wouldn't be a bad idea to get rid of them else where & new additions
should definitely be avoided.

--PFsVVMVhVavFC5ld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNIlqwAKCRB4tDGHoIJi
0hb5AQDFHqBxeGJ5Pql2GZJHm+5OVEKHSGgnIdm0oWZdW4UkmAD8CiCkuPlCdNPe
eY4hEyptsolQmpK08Yltu36YIg7G8gE=
=WiyK
-----END PGP SIGNATURE-----

--PFsVVMVhVavFC5ld--
