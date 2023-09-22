Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A25E7AB4D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjIVPb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjIVPbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:31:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D48A3;
        Fri, 22 Sep 2023 08:31:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA0EC433C7;
        Fri, 22 Sep 2023 15:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695396680;
        bh=qD9moz6S20UXXt0XM3f9mJxnaNg4ZQmeahTNciW81/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLt5xynextdfqFI5PfPyrFeXbrb7lhcUiPr5WL5DcPTI62PGhiP80IGlLlMtxyyBk
         nH8St5PfLOZBxWbad0PVoXoMSg+1SbWANDymtWrhanRq7Y57MRzJImcfjlOCih0sFi
         HtZx48zsX5+KYEbnyAStXNYW91BxC0Lb3LgaK+ReTrmF9VZStYHocWg/14/w3nsYWd
         MwJ4q7cCLziXvpQpXQwoYwx8GgqGM2IOcWwbrocWnLgPE71kr9UpCgFmVV8r4VXcwH
         MilNQ4RfEw+zCrs+Tryci015CB9mzSRRstyumQ5jQbfw31prJJuRIvYpOrKSrvssEJ
         Z4Z+eWr+bFuZw==
Date:   Fri, 22 Sep 2023 16:31:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     yang tylor <tylor_yang@himax.corp-partner.google.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org,
        "jingyliang@chromium.org" <jingyliang@chromium.org>
Subject: Re: [PATCH V2 1/2] dt-bindings: input: Introduce Himax HID-over-SPI
 device
Message-ID: <20230922-removable-footwork-f1d4d96d38dd@spud>
References: <20230919024943.3088916-1-tylor_yang@himax.corp-partner.google.com>
 <20230919024943.3088916-2-tylor_yang@himax.corp-partner.google.com>
 <20230919-70b2f1e368a8face73468dfa@fedora>
 <CAGD2q_anfBP78jck6AbMNtgAggjOgaB3P6dkmq9tONHP45adFA@mail.gmail.com>
 <20230919-cc4646dbfb953bd34e05658c@fedora>
 <CAGD2q_bkTpvXiomWb_yerNjQfMVKOctYgBqF_RBSo_jYqyyyxw@mail.gmail.com>
 <20230922-unclothed-bottom-5531329f9724@spud>
 <CAGD2q_YsFdDVhE4JCmQSGMWOdpe_yzG8-CdWYPXtjeZsManvgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XUvCLKUJUJV29/kf"
Content-Disposition: inline
In-Reply-To: <CAGD2q_YsFdDVhE4JCmQSGMWOdpe_yzG8-CdWYPXtjeZsManvgQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XUvCLKUJUJV29/kf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 05:43:54PM +0800, yang tylor wrote:
> On Fri, Sep 22, 2023 at 5:22=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Fri, Sep 22, 2023 at 03:56:25PM +0800, yang tylor wrote:
> > > On Tue, Sep 19, 2023 at 7:09=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> > > > On Tue, Sep 19, 2023 at 05:31:29PM +0800, yang tylor wrote:
> >
> > > > > The behavior of "himax,boot_time_fw_upgrade" seems not stable and
> > > > > should be removed. "himax,fw_in_flash", I use the kernel config f=
or
> > > > > user to select.
> > > >
> > > > That seems like a bad idea, we want to be able to build one kernel =
that
> > > > works for all hardware at the same time.
> > > >
> > > I see, so I should take that back?
> > > I'll explain more about it.
> >
> > Are there particular ICs where the firmware would always be in flash and
> > others where it would never be? Or is this a choice made by the board or
> > system designer?
> >
> Most cases it's about the system designer's decision. But some ICs may be=
 forced
> to use flash because of its architecture(multiple IC inside, need to
> load firmware to
> multiple IC's sram by master IC). But if there is no limitation on
> this part, most system
> designers will prefer flashless.

Forgive me if I am not understanding correctly, there are some ICs that
will need to load the firmware from flash and there are some where it
will be a decision made by the designer of the board. Is the flash part
of the IC or is it an external flash chip?

Cheers,
Conor.

--XUvCLKUJUJV29/kf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ2zQwAKCRB4tDGHoIJi
0hcKAQDgvSy/xvLvZMyY3V+wUeGnHAaZ90EqCmYIqh82AzlzUwEA/ErWVc3ZEz3i
+4/MhJeaqxOQ1xtZpXyOykEiZRrlLws=
=JcuJ
-----END PGP SIGNATURE-----

--XUvCLKUJUJV29/kf--
