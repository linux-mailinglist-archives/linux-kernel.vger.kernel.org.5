Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159677EC6AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbjKOPHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343952AbjKOPHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:07:13 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7038E;
        Wed, 15 Nov 2023 07:07:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D60DB2000A;
        Wed, 15 Nov 2023 15:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700060828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IGzp5+9/qNwtTCLx26W2NfMVNLIdgrQHWOCKXLfAu/A=;
        b=HvnzKYPAeVrTEaYvIQ4zCZo+HzCucbvjEr3/ML6g4XRJfxgLcaV/WYc6wG4afCQ17/SUOZ
        fIh/QFQMm1XPiwnMqETv2chA1NIHSht4cWQIDYX6KZ391ZLAhv+yT8vUS/qstZOHhnp41G
        sYjUajXwJBIxXiWeP7c28GT5DU1mo73K1xlnjFvKGtEodvmFSPN8bKXq89PJjNAYxr7ebj
        LdT4IHTRpm50bycHv3Irnlw7pww/jI8vjOYIClcOTuojPz8TcK99DGcsWbjopqrylizCjJ
        t/Jn5It4eyjnW6b5v+1ONIJXJEFWr7uWYg8mXBdfL913Ihp+YyE7JBreDQoaxQ==
Date:   Wed, 15 Nov 2023 16:07:07 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, michael.riesch@wolfvision.net
Subject: Re: [PATCH v10 1/3] media: dt-bindings: media: add bindings for
 Rockchip CIF
Message-ID: <ZVTemwY6gvFdQMib@aptenodytes>
References: <cover.1699460637.git.mehdi.djait@bootlin.com>
 <037bcabf97294d37b271537e4b11fb88cf9bb6f6.1699460637.git.mehdi.djait@bootlin.com>
 <20231109-closable-superglue-5e7f39739cf1@spud>
 <ZU0avuRRaITV4jws@aptenodytes>
 <e5b1f0dd-0aab-4ce5-82ba-879a4d736e7e@linaro.org>
 <ZU0f33clFwlsTw16@aptenodytes>
 <20231110-appetizer-fame-2152806c7442@roley>
 <ZVJUsDb1mPVtcjdX@aptenodytes>
 <20231114-abnormal-uncross-dcebea2e82ae@squawk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RLyCz4Fbk+INaST5"
Content-Disposition: inline
In-Reply-To: <20231114-abnormal-uncross-dcebea2e82ae@squawk>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RLyCz4Fbk+INaST5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue 14 Nov 23, 17:51, Conor Dooley wrote:
> On Mon, Nov 13, 2023 at 05:54:08PM +0100, Paul Kocialkowski wrote:
> =20
> > > Ultimately, I don't care what the file ends up being called when there
> > > are multiple devices documented in it. I'd ack a patch renaming to the
> > > =C5=93riginal incarnation of the IP when the documentation for that I=
P is
> > > added without a second thought.
> >=20
> > That would be agreeable to me if my proposal still ends up feeling unre=
asonable
> > to you. But I might very well take you at your word since I ended up pu=
rchasing
> > a RK3066 board in a moment of weakness last week.
>=20
> The ideal outcome I suppose would be documenting both variants. If
> you've gone ahead and bought one, give that a go.

Yeah I'll try to do that eventually, but we really want to have this series
merged as soon as possible. So it wouldn't be reasonable for us to wait for
RK3066 support.

What's your final decision for now: is it okay to keep the file named
rockchip,rk3066-cif.yaml (without this compatible in the file) or do you st=
ill
want it called rockchip,px30-vip.yaml?

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--RLyCz4Fbk+INaST5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmVU3psACgkQ3cLmz3+f
v9HjEAf/SU3y3RdjGRSQQ5ldwayPyDN9QCNmqna23Z7SUj7Iy3DoWx9iAIHrXKuE
9PpvVh2nMXxoIjvjQMnmcIZgdqZoAJvDwFCrIR/a+tlwg68Gco5lPwAG00dm3vXV
kIBXjL7VLWjwV1v66SwxEvi4fXDNT6/3qbO5r83jAshhC/VsxFMyLrNSdNrIKwIJ
4w496dDQ9yv/Y0NwW2C05ibT+FAk2Av+7DxG4HzQkN1dMYLbSAn5t57Q+86FfqQf
h8Tjy6xuHtj8ja2sWFBQzyJmzqYFOzcnb28CyOmfDnz8jVmCy/kwk/WLyqK+kRqM
Bvk1pN6Xw6xFLAjrCcEq49bLqLZBNQ==
=jU15
-----END PGP SIGNATURE-----

--RLyCz4Fbk+INaST5--
