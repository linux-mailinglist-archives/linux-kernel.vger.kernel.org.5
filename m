Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593157AED3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjIZMxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjIZMxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:53:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F49C9;
        Tue, 26 Sep 2023 05:53:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0A2C433C7;
        Tue, 26 Sep 2023 12:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695732817;
        bh=bis2VMKHfbkY+mqA/mrUJLJ6UGG4PPEWntsQJucYsDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBnctzk0hXAsV9OcjQkOyyekh1qZoXKVwFEeG5AtApG3SUmdftsRptz2PTX1pU0UW
         bS3NNxYiSDX/+LBthO3WQoG2MG9ISMX9nb2B+X/rzSJzTpqbTFtlQyfH0RLZrsmcLY
         3UlAcNFyIps2wDqKcfNoSxqMlOKvVvOjL+ddmsEGE8XMAy64wLRzEdBPeSGSDFrz84
         kqCBvtWtAIo2F2IOJ+2fC8FZ2jWr+SDJ2Je+YnKKXZuDVK19XdXB05lXfDcMLh5LpR
         ed/boMquYTP2U7K++lYjTrqUvT/EBfYFmNrVT6uWPL6r9wtwu1qDFP+0grxLWW5cUI
         IlNZ7cOUXFZeg==
Date:   Tue, 26 Sep 2023 13:53:31 +0100
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
Message-ID: <20230926-reverence-unlit-d0027225cc43@spud>
References: <20230919-cc4646dbfb953bd34e05658c@fedora>
 <CAGD2q_bkTpvXiomWb_yerNjQfMVKOctYgBqF_RBSo_jYqyyyxw@mail.gmail.com>
 <20230922-unclothed-bottom-5531329f9724@spud>
 <CAGD2q_YsFdDVhE4JCmQSGMWOdpe_yzG8-CdWYPXtjeZsManvgQ@mail.gmail.com>
 <20230922-removable-footwork-f1d4d96d38dd@spud>
 <CAGD2q_Y467jJJnwCVH+3F-hh6a-1-OYRugcy0DdjPnTCC77Z8A@mail.gmail.com>
 <20230925-cod-vacancy-08dc8d88f90e@wendy>
 <CAGD2q_a1nLtFj7H42f+u+J5Bih59MGS0aJLHCFJy5gM2ydys4w@mail.gmail.com>
 <20230926-action-sludge-ec8e51fdd6d4@spud>
 <CAGD2q_YBfDT950tyxEF87ZeiANgea_x8S16Ud5K2bcQ+eL9T=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aKiteRl7FCx1h6xV"
Content-Disposition: inline
In-Reply-To: <CAGD2q_YBfDT950tyxEF87ZeiANgea_x8S16Ud5K2bcQ+eL9T=w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aKiteRl7FCx1h6xV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 05:52:39PM +0800, yang tylor wrote:
> On Tue, Sep 26, 2023 at 5:02=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Mon, Sep 25, 2023 at 06:16:29PM +0800, yang tylor wrote:
> > > On Mon, Sep 25, 2023 at 4:41=E2=80=AFPM Conor Dooley <conor.dooley@mi=
crochip.com> wrote:
> > > >
> > > > On Mon, Sep 25, 2023 at 09:44:21AM +0800, yang tylor wrote:
> > > > > On Fri, Sep 22, 2023 at 11:31=E2=80=AFPM Conor Dooley <conor@kern=
el.org> wrote:
> > > > > >
> > > > > > On Fri, Sep 22, 2023 at 05:43:54PM +0800, yang tylor wrote:
> > > > > > > On Fri, Sep 22, 2023 at 5:22=E2=80=AFPM Conor Dooley <conor@k=
ernel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Sep 22, 2023 at 03:56:25PM +0800, yang tylor wrote:
> > > > > > > > > On Tue, Sep 19, 2023 at 7:09=E2=80=AFPM Conor Dooley <con=
or@kernel.org> wrote:
> > > > > > > > > > On Tue, Sep 19, 2023 at 05:31:29PM +0800, yang tylor wr=
ote:
> > > > > > > >
> > > > > > > > > > > The behavior of "himax,boot_time_fw_upgrade" seems no=
t stable and
> > > > > > > > > > > should be removed. "himax,fw_in_flash", I use the ker=
nel config for
> > > > > > > > > > > user to select.
> > > > > > > > > >
> > > > > > > > > > That seems like a bad idea, we want to be able to build=
 one kernel that
> > > > > > > > > > works for all hardware at the same time.
> > > > > > > > > >
> > > > > > > > > I see, so I should take that back?
> > > > > > > > > I'll explain more about it.
> > > > > > > >
> > > > > > > > Are there particular ICs where the firmware would always be=
 in flash and
> > > > > > > > others where it would never be? Or is this a choice made by=
 the board or
> > > > > > > > system designer?
> > > > > > > >
> > > > > > > Most cases it's about the system designer's decision. But som=
e ICs may be forced
> > > > > > > to use flash because of its architecture(multiple IC inside, =
need to
> > > > > > > load firmware to
> > > > > > > multiple IC's sram by master IC). But if there is no limitati=
on on
> > > > > > > this part, most system
> > > > > > > designers will prefer flashless.
> > > > > >
> > > > > > Forgive me if I am not understanding correctly, there are some =
ICs that
> > > > > > will need to load the firmware from flash and there are some wh=
ere it
> > > > > > will be a decision made by the designer of the board. Is the fl=
ash part
> > > > > > of the IC or is it an external flash chip?
> > > > > >
> > > > >
> > > > > Both are possible, it depends on the IC type. For TDDI, the IC is=
 long
> > > > > and thin, placed on panel PCB, flash will be located at the exter=
nal
> > > > > flash chip. For the OLED TP, IC is usually placed at FPC and its =
flash
> > > > > is embedded, thus the IC size is large compared to TDDI. But from=
 the
> > > > > driver's perspective either external flash or embedded flash, the=
 IC
> > > > > itself will load firmware from flash automatically when reset pin=
 is
> > > > > released. Only if firmware is loading from the host storage syste=
m,
> > > > > the driver needs to operate the IC in detail.
> > > >
> > > >
> > > > Since there are ICs that can use the external flash or have it load=
ed
> > > > from the host, it sounds like you do need a property to differentia=
te
> > > > between those cases.
> > > Yep.
> > >
> > > > Is it sufficient to just set the firmware-name property for these c=
ases?
> > > > If the property exists, then you know you need to load firmware & w=
hat
> > > > its name is. If it doesn't, then the firmware either isn't needed or
> > > > will be automatically loaded from the external flash.
> >
> > > We have a default prefix firmware name(like himax_xxxx.bin) in the dr=
iver code.
> >
> > How do you intend generating the name of the firmware file? I assume the
> > same firmware doesn't work on every IC, so you'll need to pick a
> > different one depending on the compatible?
> >
> If considering a firmware library line-up for all the incoming panels
> of this driver.
> We would use PID as part of the file name. Because all the support panels=
 would
> have a unique PID associated. Which will make the firmware name like
> himax_xxx_{$PID}.bin. The problem is, we need to know PID before firmware=
 load
> at no flash condition. Thus PID information is required in dts when
> no-flash-flag
> is specified.

Firstly, where does the "xxx" come from?
And you're making it sound more like having firmware-name is suitable
for this use case, given you need to determine the name of the file to
use based on something that is hardware specific but is not
dynamically detectable.

Thanks,
Conor.

> > > So we'll look for it when no-flash-flag is specified. In our experien=
ce,
> > > forcing a prefix firmware name helps the user to aware what firmware
> > > they are dealing with.
>=20
> If a more simple solution for no-flash condition is needed, as you mentio=
ned,
> specifying a firmware name in dts would be the best. Otherwise, a
> no-flash-flag and
> PID information needs to be added in dts.



--aKiteRl7FCx1h6xV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRLUNAAKCRB4tDGHoIJi
0lw1AQCtzcottmF2HEejKyT7ni6EWwqsANzf9Q45iBNCON4uqQEAi7ND92FhS7T+
hlUuDk8lJPdWZlxT3WST5rvdB6qARgA=
=7PKF
-----END PGP SIGNATURE-----

--aKiteRl7FCx1h6xV--
