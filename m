Return-Path: <linux-kernel+bounces-22271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B7A829BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C23B26E54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A55E4A9A1;
	Wed, 10 Jan 2024 13:47:58 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C04A987;
	Wed, 10 Jan 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Received: from localhost ([80.140.206.200]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mr8SG-1qqzKS0cH0-00oBtt; Wed, 10 Jan 2024 14:34:22 +0100
Date: Wed, 10 Jan 2024 14:34:19 +0100
From: Christian Heusel <christian@heusel.eu>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
	linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: Re: [0/2] ARM: Adjustments for init_atags_procfs()
Message-ID: <vltzbtbcuzrfgjoeg5oovdyoe34fnhte25uhb3gln56pzvmqzb@5u7u7cwgzzen>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
 <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
 <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
 <ZZ6MZl14bcIaCaQn@shell.armlinux.org.uk>
 <1c38e495-5c9c-4ff8-b453-93b882dd2c4c@web.de>
 <ZZ6R6KSQo9ph3ARZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5omxkbyuztlvommc"
Content-Disposition: inline
In-Reply-To: <ZZ6R6KSQo9ph3ARZ@shell.armlinux.org.uk>
X-Provags-ID: V03:K1:742zGJqrsTcPdmXqkg5IqwvNg66u0oPuuKZ7EwzpxdRtA0kmo/O
 xV4QlMlgrEVflGmBPdhFlHJ1h90Uhm8SV3lXRYxkcFkrN1M+KYfSlJm6J6VW3gTbbIko/9p
 /zuscFVts6U8n4rkKOe6yA4jZGbZ8/2LCjVEUsC6QTanRqfjmuOOEcVbj4pqLbXYCWSQGvl
 RvpgSS1x28Ttf6e5kcvPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c0YYenV97Ok=;Po7rqHU4Q9YlYXi+PgjTKPwGXj2
 DX+It2d+/TnXFrXHCytyr+K6YNwrVTXpwZNClK9HkH7JFqL5dA1IBDsGMPlPC2UoghDiZPhpL
 t2QMYnuoV/F0Jet2HAlN6R+PO7fsrr0KlZ7xl2mfsladOT+drtZwMgGA5y5a6oAU5tYx69rj4
 ioiY1vZLgmk67MafWHNJp20Hx+rp13IQNnZd1Nko+MSLDclaPpsWVaSEkSMLMovrtyj51Oe6D
 tCENXRBe7198T0yh1AWj8kV7g8lBElfaynGOgbTuHB/T/fG0LMQq9s6K9jTge7ZZPsO4q0vMZ
 yV22R2DNYC7FlKkfCwyfftmDY/gYgaaotkhPVFCUJ7AwjfMfT/PPgM9wDCJqOP+vV5XTEeWYy
 xyBcqPj8HmBGgN/KXrMjK1smJFsIcZGADYg2E5pymc5o+QN7RmUAbY5SyWzHC3ezY8k7Bfhfg
 X0FLpI8Bk8hTlyfFNvg2WoiVRYCfAqtQk5imBbNp/tbPCA9eROSpGZWwCuBIH6PW3XAHBzyIN
 nXNWgXHOtq+Pp6b+Tw2aLTHCxJK5Wh4IAjgmm+Shw+9gDd7TA9EqGpTJfGIcHSxBUhfDt2s1W
 y6uVfVGC2o+ip+Z3NsjbxRkat6tc6u/IsGHwRn6E52Lqq4ZkVuyDlA5r3iKq5NDFpo0cR7hd0
 Q/B82tmvSe+lhJHhM9Fh681/K+MB5fHogTje9SNs3xvzT5FghZtiDapWf3c/gL10ha7EA50Cp
 dqj1usnUGu9FuodDqN74lqlGnqB1z7dB4mjmHoLxpEzrYOyPhoZf3JoqMy+7HQLZBylyWo6Mi
 tt5Akf9sZot70CNI9t7vOY8OY+Uu2nVir9VP1YrcBv3sm7sQ4d3awOi321FivkjRuxt4uHiXV
 1xnUBOFkQloi/9w==


--5omxkbyuztlvommc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/01/10 12:47PM, Russell King (Oracle) wrote:
> On Wed, Jan 10, 2024 at 01:44:01PM +0100, Markus Elfring wrote:
> > >>> Is this patch series still in review queues?
> > >>
> > >> See also:
> > >> https://lore.kernel.org/cocci/562a6f99-3f8e-9a77-e519-b668e24dced2@w=
eb.de/
> > >> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00098.html
> > >
> > > I suspect no one looked at it, sorry.
> >=20
> > Special mailing list settings probably influenced this situation.
> >=20
> > >                                       I don't catch everything that is
> > > on the mailing list. Looks fine to me but it needs to end up in the
> > > patch system to be applied.
> >=20
> > Can you collaborate also with mentioned mailing list archive interfaces?
>=20
> Err what? Sorry, I don't understand your comment.

I am just generally following along here, but to give some context it
seems like Markus is banned from posting to various kernel mailing
lists[0][1][2].

Cheers,
Chris

[0]: https://lkml.org/lkml/2023/6/19/38
[1]: https://lore.kernel.org/lkml/CAHC9VhREfdgiCji=3DuEeCrc4w1kPGfnWGKnJuUY=
KXwTApdneSjQ@mail.gmail.com/T/#m1a55ecc3205045fe63ab0f12451705df911d31a0
[2]: https://lore.kernel.org/all/20200629081039.GA1221843@kroah.com/

--5omxkbyuztlvommc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmWenNsACgkQwEfU8yi1
JYV+IRAAqZtbPL/0aDr8ZwGVzBNCdqRCpqhLKHVKyD/NWSlxf+qKZrcY2KsFpU2M
Ino+YfJaDWdztG9kAgrR3Vp+XZ5W2739lQE6x+aXcqbbi/aY9f780Yg0Ne5HOWMI
dXFxS08wOkqjBYVJjwgyF7QKO7Wv0REDd/Zo8Wm+YblnOaI0AX/HgrrAZUPuUCjV
XGPfHOt5KH3gDVo499SomDlke1gFdL65P2zFjxUNjAvOtHxJT3OBGRSV5lCwEqK7
akFzh02n2zZM14v4H7WOqShsnTPTr1eUa0z2LV7P43xlMzWkB2MvfwFCbOQm0UGI
DmG9Lpc3jdrgBt/rUgvATwbI2iTV4BgT+JxPhYtnXlps0tOs4S+iPMLYQi1xtZxY
m6ZGbQbWl+cNtpOPgUYiF3gCt0e4Fz6eMEWwUtcFWTVjL98vvH3HWXZVtcMj0Dff
KY2d6FTqe5eLCDNH7XmAtGUXJjH08QTrcbHZjqNTqp5t7pnpal9bxHG0dOl7ohTm
r73AgAIr3noT0QYujzHT3ddv+1d7wl5zDtXsO0fi+v8iQ3N8CewtK5fCblcppkoi
Aauh5otlMsgmWSPhFHkML3ZedsE4UlYVE0D5ZMMFKaZc0gyWnotEdeOXGU2KbwLm
1oDS0k6LzcxZB7414DzhAoz6uHVX6VfJwPVlgZkV4rxbtz6azus=
=Xpvc
-----END PGP SIGNATURE-----

--5omxkbyuztlvommc--

