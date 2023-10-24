Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB057D54B9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjJXPJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjJXPJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:09:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D15210DB;
        Tue, 24 Oct 2023 08:09:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740BAC433C7;
        Tue, 24 Oct 2023 15:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698160141;
        bh=WjZOHjehQIEdnvElJew7f9x5ZqLGCeUVjwRuHOMlEjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CgZv75zmnuoQ3ekkikQC5x9qSL7DET36FFJXesbijJrWTAliIFHfRSIjF6/JXUDQ0
         d+cP6SIFduzbCM5SmWKiaiRL18S85MiUGZ8OX1xnjboThQELef/voEBlHUIIa4Yc80
         0P++v7esCbdc9Z1jAU+oRLa52c7PCgm+7OaJJG19BLbu2WUUIDxnUugkzoKgEgtHig
         xbqa1LPQHGhx0lPElbc/GcNikq8DiiOhwHgeUguRliY3sJJiAYe+wSeAuj/zX1NwXL
         s9T/KMpbHqCf2cLHEaSW4y52qBo5mgOAtijYPOOu3uxicZgzGpkSpEPL5Unstd12Hi
         /HclSTJxGaD5w==
Date:   Tue, 24 Oct 2023 16:08:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: backlight: mp3309c: remove two required
 properties
Message-ID: <20231024-paddling-spongy-be82eae03228@spud>
References: <20231020135434.2598578-1-f.suligoi@asem.it>
 <20231020135434.2598578-2-f.suligoi@asem.it>
 <20231020-moonrise-senate-86d0edb2d404@spud>
 <DU2PR01MB803498DFD93E82DD3947D72DF9D8A@DU2PR01MB8034.eurprd01.prod.exchangelabs.com>
 <20231023-anybody-silver-4548023f8f26@spud>
 <DU2PR01MB8034CF8EE4358B9446809AA2F9DFA@DU2PR01MB8034.eurprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8Q3LPtznJIWd+xHE"
Content-Disposition: inline
In-Reply-To: <DU2PR01MB8034CF8EE4358B9446809AA2F9DFA@DU2PR01MB8034.eurprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8Q3LPtznJIWd+xHE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 07:53:38AM +0000, Flavio Suligoi wrote:
> > On Mon, Oct 23, 2023 at 09:28:03AM +0000, Flavio Suligoi wrote:
> > > > On Fri, Oct 20, 2023 at 03:54:33PM +0200, Flavio Suligoi wrote:
> > > > > The two properties:
> > > > >
> > > > > - max-brightness
> > > > > - default brightness
> > > > >
> > > > > are not really required, so they can be removed from the "require=
d"
> > > > > section.
> > > >
> > > > Why are they not required? You need to provide an explanation.
> > >
> > > The "max-brightness" is not more used now in the driver (I used it in
> > > the first version of the driver).
> >=20
> > If it is not used any more, what happens when someone passes an old
> > devicetree to the kernel, that contains max-brightness, but not any of =
your
> > new properties?
>=20
> This is not a problem, because the device driver has not yet been include=
d in any kernel.
> My patch for the device driver is still being analyzed by the maintainers.
> Only this dt-binding yaml file is already included in the "for-backlight-=
next" branch
> of the "backlight" kernel repository.
> At the moment, this driver is used only in a i.MX8MM board produced in my=
 company,
> under my full control. No other developer is using it now.

Right. This is exactly the sort of commentary that you need to provide
up front, to have us spent a bunch of time going back and forth to
figure out :(

> > > The "default-brightness", if omitted in the DT, is managed by the
> > > device driver, using a default value. This depends on the dimming mode
> > used:
> >=20
> > For default-brightness, has here always been support in the driver for =
the
> > property being omitted, or is this newly added?
>=20
> In the first version of the driver this property was a "required property=
",
> but nobody has used this driver before, so this should be not a problem.

> > What I would like is an explanation in the commit message as to why the
> > revised example is more helpful than the existing (and
> > must-remain-valid) one.
>=20
> As said before, no one may have ever used this device driver,
> so I would leave only this new version of the example.

Okay. Please improve the commit message explaining why it is okay to
make these changes & send a v2.
The alternative is that Lee drops the dt-binding patch & you submit a
revised version of the binding alongside the next iteration of the
driver.

Cheers,
Conor.

--8Q3LPtznJIWd+xHE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTfeCAAKCRB4tDGHoIJi
0iFhAP9S/FlnjK5C6KCH6pLyfeeCD1U8XFRW7kZPbpJplU8SCAD/bkAcQQd5VU9d
3r2f744R9Cw33bKy5n99PAJBaey2KwU=
=8wm8
-----END PGP SIGNATURE-----

--8Q3LPtznJIWd+xHE--
