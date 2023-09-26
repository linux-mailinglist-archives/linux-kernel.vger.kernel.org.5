Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BC07AE88D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjIZJCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjIZJCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:02:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048E3DD;
        Tue, 26 Sep 2023 02:02:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5237AC433C8;
        Tue, 26 Sep 2023 09:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695718929;
        bh=FG/XZvk3hacyQ2ppSKA5dgtBb471TsLXsnHEv8M7XF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bS58imdOvbQ5qdOIgFzc0p+S8qWiJsvYm5RWmonqnsrELN5km7fXzBubfLZOKu/oW
         Jy67+/UFRibENz+EUggyMW2jNYYwtyZ+y1dWQxRMsQ42sO+3pkigRG4m851+UpFeMG
         g963EkYEdXypdjx7hHOK5+tOKnRk8wcH7ANdPG7QX/PQB0d5/c1qW3Be5C74F+FzW/
         a7EFzZJ8AJC+iAGuR433CgODxegei6QVxLqBcIlO2A++2gXCIATyI0OPazq63Q+sbZ
         p3XRbn6zAOlH25A/RNFhLKXVarkNZVstFHHQZupdRJ/B8lF/E6/P3O5jJeCWLFu9c/
         sOL/+ClYJYHgw==
Date:   Tue, 26 Sep 2023 10:02:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     yang tylor <tylor_yang@himax.corp-partner.google.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org,
        "jingyliang@chromium.org" <jingyliang@chromium.org>,
        wuxy23@lenovo.com, luolm1@lenovo.com,
        hung poyu <poyu_hung@himax.corp-partner.google.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: input: Introduce Himax HID-over-SPI
 device
Message-ID: <20230926-action-sludge-ec8e51fdd6d4@spud>
References: <20230919-70b2f1e368a8face73468dfa@fedora>
 <CAGD2q_anfBP78jck6AbMNtgAggjOgaB3P6dkmq9tONHP45adFA@mail.gmail.com>
 <20230919-cc4646dbfb953bd34e05658c@fedora>
 <CAGD2q_bkTpvXiomWb_yerNjQfMVKOctYgBqF_RBSo_jYqyyyxw@mail.gmail.com>
 <20230922-unclothed-bottom-5531329f9724@spud>
 <CAGD2q_YsFdDVhE4JCmQSGMWOdpe_yzG8-CdWYPXtjeZsManvgQ@mail.gmail.com>
 <20230922-removable-footwork-f1d4d96d38dd@spud>
 <CAGD2q_Y467jJJnwCVH+3F-hh6a-1-OYRugcy0DdjPnTCC77Z8A@mail.gmail.com>
 <20230925-cod-vacancy-08dc8d88f90e@wendy>
 <CAGD2q_a1nLtFj7H42f+u+J5Bih59MGS0aJLHCFJy5gM2ydys4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+WGjGNb92VtLdF6U"
Content-Disposition: inline
In-Reply-To: <CAGD2q_a1nLtFj7H42f+u+J5Bih59MGS0aJLHCFJy5gM2ydys4w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+WGjGNb92VtLdF6U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 06:16:29PM +0800, yang tylor wrote:
> On Mon, Sep 25, 2023 at 4:41=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > On Mon, Sep 25, 2023 at 09:44:21AM +0800, yang tylor wrote:
> > > On Fri, Sep 22, 2023 at 11:31=E2=80=AFPM Conor Dooley <conor@kernel.o=
rg> wrote:
> > > >
> > > > On Fri, Sep 22, 2023 at 05:43:54PM +0800, yang tylor wrote:
> > > > > On Fri, Sep 22, 2023 at 5:22=E2=80=AFPM Conor Dooley <conor@kerne=
l.org> wrote:
> > > > > >
> > > > > > On Fri, Sep 22, 2023 at 03:56:25PM +0800, yang tylor wrote:
> > > > > > > On Tue, Sep 19, 2023 at 7:09=E2=80=AFPM Conor Dooley <conor@k=
ernel.org> wrote:
> > > > > > > > On Tue, Sep 19, 2023 at 05:31:29PM +0800, yang tylor wrote:
> > > > > >
> > > > > > > > > The behavior of "himax,boot_time_fw_upgrade" seems not st=
able and
> > > > > > > > > should be removed. "himax,fw_in_flash", I use the kernel =
config for
> > > > > > > > > user to select.
> > > > > > > >
> > > > > > > > That seems like a bad idea, we want to be able to build one=
 kernel that
> > > > > > > > works for all hardware at the same time.
> > > > > > > >
> > > > > > > I see, so I should take that back?
> > > > > > > I'll explain more about it.
> > > > > >
> > > > > > Are there particular ICs where the firmware would always be in =
flash and
> > > > > > others where it would never be? Or is this a choice made by the=
 board or
> > > > > > system designer?
> > > > > >
> > > > > Most cases it's about the system designer's decision. But some IC=
s may be forced
> > > > > to use flash because of its architecture(multiple IC inside, need=
 to
> > > > > load firmware to
> > > > > multiple IC's sram by master IC). But if there is no limitation on
> > > > > this part, most system
> > > > > designers will prefer flashless.
> > > >
> > > > Forgive me if I am not understanding correctly, there are some ICs =
that
> > > > will need to load the firmware from flash and there are some where =
it
> > > > will be a decision made by the designer of the board. Is the flash =
part
> > > > of the IC or is it an external flash chip?
> > > >
> > >
> > > Both are possible, it depends on the IC type. For TDDI, the IC is long
> > > and thin, placed on panel PCB, flash will be located at the external
> > > flash chip. For the OLED TP, IC is usually placed at FPC and its flash
> > > is embedded, thus the IC size is large compared to TDDI. But from the
> > > driver's perspective either external flash or embedded flash, the IC
> > > itself will load firmware from flash automatically when reset pin is
> > > released. Only if firmware is loading from the host storage system,
> > > the driver needs to operate the IC in detail.
> >
> >
> > Since there are ICs that can use the external flash or have it loaded
> > from the host, it sounds like you do need a property to differentiate
> > between those cases.
> Yep.
>=20
> > Is it sufficient to just set the firmware-name property for these cases?
> > If the property exists, then you know you need to load firmware & what
> > its name is. If it doesn't, then the firmware either isn't needed or
> > will be automatically loaded from the external flash.

> We have a default prefix firmware name(like himax_xxxx.bin) in the driver=
 code.

How do you intend generating the name of the firmware file? I assume the
same firmware doesn't work on every IC, so you'll need to pick a
different one depending on the compatible?

> So we'll look for it when no-flash-flag is specified. In our experience,
> forcing a prefix firmware name helps the user to aware what firmware
> they are dealing with.

--+WGjGNb92VtLdF6U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRKeCwAKCRB4tDGHoIJi
0lruAP4hZ8nocuGWnEzSIUZrj/kgtBMgEPNP7n43DBHOkQFe2QD9Ho3Jptfn0Ua2
sOQKUiY1nPOeuklGoFnRpPDFDYbEgw4=
=k7oS
-----END PGP SIGNATURE-----

--+WGjGNb92VtLdF6U--
