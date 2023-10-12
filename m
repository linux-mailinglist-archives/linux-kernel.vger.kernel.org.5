Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF75D7C7159
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379296AbjJLPY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjJLPYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:24:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EEFB8;
        Thu, 12 Oct 2023 08:24:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12DCC433C8;
        Thu, 12 Oct 2023 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697124293;
        bh=OKJBCSFkKCqs3p1kxIpfznOr5Kx+Ln+CvKc1ryKM064=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UrKOgGpdKTucaQSIszwtfLNSHpoeaQtp3JPhkD+wupEYTpBRIYUneRfPJ9v+kaMTE
         1u5QNNHxQtivYltZ60D27w+BsTMO0gAiOGJOgK2f86r8JinpO97Weu8Hwz3vaa/OhS
         Qjmqf+md6xdZvnsMtmAmPY953hqJYY0rEmSnpmMQIMUJjGW0YO/sYTdvn6dmgF3wEO
         C0g+GYZR1MlaF1UYjWF87e0nTl5pdOWbLPKBm01s8fLC/P0Zz0Y0Vgy+/hPD5N9jCi
         nXLhNlRn9hcWqTV8TgyFcYWPa9S+C56UmvQq/dNx26eOXJ4B1BoxgZ/3fmhWBAoGfc
         XSuuf4bZ1fK2w==
Date:   Thu, 12 Oct 2023 16:24:48 +0100
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
Message-ID: <20231012-pope-denatured-c1898bc1e44b@spud>
References: <20230925-cod-vacancy-08dc8d88f90e@wendy>
 <CAGD2q_a1nLtFj7H42f+u+J5Bih59MGS0aJLHCFJy5gM2ydys4w@mail.gmail.com>
 <20230926-action-sludge-ec8e51fdd6d4@spud>
 <CAGD2q_YBfDT950tyxEF87ZeiANgea_x8S16Ud5K2bcQ+eL9T=w@mail.gmail.com>
 <20230926-reverence-unlit-d0027225cc43@spud>
 <CAGD2q_ZzNPOL+Mhg7aWFTQd+UJJYVLz1ZE9hbNb0roS2M6y34g@mail.gmail.com>
 <20230928-spectacle-civic-339c0d71d8d7@spud>
 <CAGD2q_b1gn8XAfgfzuNn3Jo6gEguBEacxERyRM5ms-V=+hWS+g@mail.gmail.com>
 <20231009-pentagram-clamshell-b14ff00743fd@spud>
 <CAGD2q_aqr+mu4K1SkTVC+65ctL6BsqRP4Ld0HD_H0_rgzFT9MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TueJpgnC2xZsHFU1"
Content-Disposition: inline
In-Reply-To: <CAGD2q_aqr+mu4K1SkTVC+65ctL6BsqRP4Ld0HD_H0_rgzFT9MQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TueJpgnC2xZsHFU1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 10:30:03AM +0800, yang tylor wrote:
> On Tue, Oct 10, 2023 at 1:52=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Mon, Oct 02, 2023 at 06:44:41PM +0800, yang tylor wrote:
> > > On Fri, Sep 29, 2023 at 12:56=E2=80=AFAM Conor Dooley <conor@kernel.o=
rg> wrote:
> > > >
> > > > On Thu, Sep 28, 2023 at 10:12:41AM +0800, yang tylor wrote:
> > > > > On Tue, Sep 26, 2023 at 8:53=E2=80=AFPM Conor Dooley <conor@kerne=
l.org> wrote:
> > > > > > On Tue, Sep 26, 2023 at 05:52:39PM +0800, yang tylor wrote:
> > > > > > > On Tue, Sep 26, 2023 at 5:02=E2=80=AFPM Conor Dooley <conor@k=
ernel.org> wrote:
> > > > > > > > On Mon, Sep 25, 2023 at 06:16:29PM +0800, yang tylor wrote:
> > > > > > > > > On Mon, Sep 25, 2023 at 4:41=E2=80=AFPM Conor Dooley <con=
or.dooley@microchip.com> wrote:
> > > > > > > > > We have a default prefix firmware name(like himax_xxxx.bi=
n) in the driver code.
> > > > > > > >
> > > > > > > > How do you intend generating the name of the firmware file?=
 I assume the
> > > > > > > > same firmware doesn't work on every IC, so you'll need to p=
ick a
> > > > > > > > different one depending on the compatible?
> > > > > > > >
> > > > > > > If considering a firmware library line-up for all the incomin=
g panels
> > > > > > > of this driver.
> > > > > > > We would use PID as part of the file name. Because all the su=
pport panels would
> > > > > > > have a unique PID associated. Which will make the firmware na=
me like
> > > > > > > himax_xxx_{$PID}.bin. The problem is, we need to know PID bef=
ore firmware load
> > > > > > > at no flash condition. Thus PID information is required in dt=
s when
> > > > > > > no-flash-flag
> > > > > > > is specified.
> > > > > >
> > > > > > Firstly, where does the "xxx" come from?
> > > > > > And you're making it sound more like having firmware-name is su=
itable
> > > > > > for this use case, given you need to determine the name of the =
file to
> > > > > > use based on something that is hardware specific but is not
> > > > > > dynamically detectable.
> > > > > Current driver patch uses a prefix name "himax_i2chid" which comes
> > > > > from the previous project
> > > > >  and seems not suitable for this condition, so I use "xxx" and pl=
an to
> > > > > replace it in the next version.
> > > > > For finding firmware, I think both solutions are reasonable.
> > > > > - provide firmware name directly: implies no-flash and use user
> > > > > specified firmware, no PID info.
> > > > > - provide no-flash-flag and PID info: loading firmware from organ=
ized
> > > > > names with PID info.
> > > > > I prefer the 2nd solution, but it needs more properties in dts. 1=
st
> > > > > has less properties and more
> > > > > intuitive.
> > > > >
> > > > > I don't know which one is more acceptable by the community, as you
> > > > > know I'm a newbie here.
> > > >
> > > > To be honest, I am not all that sure either! Does the panel id have
> > > > value in its own right, or is that only used to determine the firmw=
are
> > > > filename?
> > > Currently, PID stands for Panel/Project ID and is used for determining
> > > the firmware filename only. We haven't come up with any new attribute=
 that
> > > may attach to it. The differences between panels are handled in firmw=
are
> > > dedicated to its PID.
> > >
> > > > Also, if it does have value in its own right, rather than a "pid",
> > > > should the panel be a child node of this hid device with its own
> > > > compatible?
> > > It may need a child node if we find it necessary to add attributes to=
 each PID.
> > > But currently we have no idea about it.
> >
> > To be honest, it seems to me like you are using "PID" in place of a
> > compatible for the panel, since it needs to be provided via DT anyway.
>=20
> Hmm... So the more formal way is?
> If I add a sub-note inside this spi-device block, such as "panel" and
> add PID inside.
> Will it be more appropriate?
> ...
> spi {
> ...
>     hx_spi@0 {
> ...
>         panel {
>             himax,pid =3D ...

And this now looks exactly like compatible =3D "vendor,part" now, no?

--TueJpgnC2xZsHFU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSgPwAAKCRB4tDGHoIJi
0lVfAQC3Xdwum2IZViQ9BSMgWnqGIXLpMcp0mG/Bi4W2QnlqxAD9E1PoiPAHieT8
HzDqyvik4FLQxj0E0m444srRUWHwKQU=
=dlR1
-----END PGP SIGNATURE-----

--TueJpgnC2xZsHFU1--
