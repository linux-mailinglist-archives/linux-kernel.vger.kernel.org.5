Return-Path: <linux-kernel+bounces-24152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A061182B852
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E33B283799
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AB65A0EB;
	Thu, 11 Jan 2024 23:56:25 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BD5FBF8;
	Thu, 11 Jan 2024 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Received: from localhost ([84.170.86.196]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mgf4k-1qwTNk0h3s-00h4Vm; Fri, 12 Jan 2024 00:56:08 +0100
Date: Fri, 12 Jan 2024 00:56:06 +0100
From: Christian Heusel <christian@heusel.eu>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Dave Chinner <dchinner@redhat.com>, 
	Jan Kara <jack@suse.cz>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Christian Brauner <brauner@kernel.org>, Min Li <min15.li@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org
Subject: Re: Re: [PATCH] block: print symbolic error name instead of error
 code
Message-ID: <rqf6ufzzvmrukcaulkhmfwtjon2jwhrb2liwwimtws5r3uqmux@k2p3tccnm4sm>
References: <20240111231521.1596838-1-christian@heusel.eu>
 <ecf3adb2-596b-471b-8e35-b8f8124167f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yarfvsbjhgg33kw3"
Content-Disposition: inline
In-Reply-To: <ecf3adb2-596b-471b-8e35-b8f8124167f2@kernel.org>
X-Provags-ID: V03:K1:ZUj61C/DBmc+kOIpNqNL/soE/JLUVBGg1kTN3wxtwTJfGDpoll1
 EKGPxx1vsOCNlVdJ65aqnu0lct6/PR62ZZf/Frd1ox5arvXPxboF76At9KAXyoS+X1JkSTq
 4GDe1W+hHCr/OhwAwy7xNE65snO+hHnYs14MzVQAT6Zj5+EDJDSGWDOJdKELZzHbAcpn28w
 HCY5WqrqkwFxxY7u6sukQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0P7DSLV+OxI=;B47Sj56trwMinxQveS9f8LONo0m
 YcCPXgop/WJzA78DN7jg5XbclOd3zLjrApNH6MQhdCmFWZGIdZ2r7sFY9dVdG2j6F4rWqbkPC
 Aeu2Mn403WquqOKEu1cxJYdiqd5S4TkGIka6Mlre6Gv7qDhqD18SYZ9/C/6Ha/s2ju946wvVp
 xYwpbU9kGbruJwm5hf3YimRgJe/sqJ3rUZirNW5MiP9/20yKwYYrexj1BqMHDipRs5Gop76H8
 uFTJI9aQgql9TcZNEBVQbNvK+GuTRtnV6kg28zQZ4nlpOmi2ixO5GV/TaQ+ToxLHZmriAypZs
 Ue/lEmJn4VghIrHqdU9mEKEdN7HcVIuxH6h5nH3MO4Ra1rFfwGowF79y7/d+quPD+zHsaovQp
 LW2z8ThrlVbkvfFJnl77u9AAP1fLhWtvd3OtY1YQ8XZh3437Jp4Q9Eodc2akYY0P0qtqOdiD3
 qh8sjEfbNraEucXModX4NHbZ7w7dsU1wj4wf6Kb2ZCJpmRmY2lYfx94mUGn7j9B+knQk4dT4m
 eRiwQ/PSZiZ8clx2bodzhdVTVIm34lM4IrZaKrmGMPUbefTVGORT1AxXWyt95WGCxKfqD7PiL
 eciB5x7w7kXdq4A0RP6SPFu5ROu6fceUuOhSs6N+r24ZxFG3Rjuzci5S3HPIbKtINNMdN0N/b
 MF04A5himVCt8NmaGVV01W6uuyQwZWx8nc4hEBjUKOYuCFVi1KzmBhlVRyvHODFSDBFAGcvj9
 JQfUxNVo9+HwPuXP8Wqt/CXfH4PWQkoSvby1EyPjv8Q/EoIuXh/ISyfuTJha6zS3XGLdrXm7b
 0Yv4iILvgKO0Z6yoqWU1zI1/WApBGJGgOnVIERk3r2fBw3Aoufx9Q37Kqx2v2Bdif7InjOBQ9
 grhZ+BF834TYoBQ==


--yarfvsbjhgg33kw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 24/01/12 08:37AM, Damien Le Moal wrote:
> On 1/12/24 08:15, Christian Heusel wrote:
> > -           printk(KERN_ERR " %s: p%d could not be added: %ld\n",
> > -                  disk->disk_name, p, -PTR_ERR(part));
> > +           printk(KERN_ERR " %s: p%d could not be added: %pe\n",
> > +                  disk->disk_name, p, part);
>
> pr_err() ?

If desired I can send a v2 containing another patch which refactors the
usages of printk into their respective pr_* aliases, but I wanted to
keep this consistent to the usages in rest of the file and do one change
at a time.

Cheers,
Chris


--yarfvsbjhgg33kw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmWggBYACgkQwEfU8yi1
JYW7BxAAtGYU/xIjCnok1HbUvBJdQMBxrK7pg9wVHvfwCRq/zyTItadRbaw2l5nC
TXEl4z1Yzcvtu47AiGYwYWvc9D16ZWGHk3CtICEs8lZ+mWZs1kpw22MoUhS4zaov
Fpv39OcP60eEp//6Ep8BbfA8VKbNI8iuH7fyLIpAy+t8X87iufpN111PcfNtedHK
oVIBqEbV9xVTbOmdurj2nAhAmeecY2ON48WTmxLEtDmDzk+UI6+3SEYRfcBZfMU5
ksSqs7hhXCzyk+yLyHrayq7j2mW9BKgRuNbJTYIPlNw8fzGCe0I6DkwisvgScj3A
enZe8wbz+/GG0C29DaCp453BBa2Y+HbBewNUKBrIDvSq7MDKK0wlBaaLMdkIm+Oq
ci7jhKka7ApXY+9J5ZKOWuyXwD30W0W9Ha3tkX+sp7TXKf6XT3pQisgRR6KdosKe
3nJkNXj9m3oXeAP/XLutd2qCAsi033oYxL54PLgDKg54Q3TkMhgayWShOyznT4aG
u+lkCUKMbqjXWXthnG+6hsFeeILSHUcoAOHh0LuZfrRz9MfVwRxGsOzB76XNUFti
f9rzP+O7xbzSCAjBtsu18bZRFAfiOjP0v12GgmoA0GxN2BNa/aETEvMDbmiypNV3
jQI17th5wbtTHqGWQ19d6egy9CerLh/3TujmqRNUPyC+uiAS4x4=
=5Gas
-----END PGP SIGNATURE-----

--yarfvsbjhgg33kw3--

