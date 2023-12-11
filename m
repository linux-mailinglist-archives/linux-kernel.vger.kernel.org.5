Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6039480CF49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbjLKPRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344024AbjLKPRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:17:49 -0500
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CE8D8;
        Mon, 11 Dec 2023 07:17:55 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id 9150D28B50B;
        Mon, 11 Dec 2023 15:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1702307873;
        bh=WOTMrVJ6rfXI+YlOmBSAUf+Szy3Hy69KHvBxie7cgm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Cuws2eTOT3LnOngdKqrHNkAbBJYvoxIhoRHXmdECyt8mP3HrkLyAFdN5oLQG9XB3i
         BlTtHRZCytLFX7zXvoYbu+B816ftGjxhrzsvzwsj2vs739jDpdcbZgbZIKcsbDY08D
         9ztUD01mCcfWzbv/cxDK+OfCBypC4dz8+F4663ZA=
Date:   Mon, 11 Dec 2023 17:17:51 +0200
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v8 2/2] iio: pressure: driver for Honeywell HSC/SSC series
Message-ID: <ZXcoH80lB-yrKfCU@sunspire>
References: <20231207164634.11998-1-petre.rodan@subdimension.ro>
 <20231207164634.11998-2-petre.rodan@subdimension.ro>
 <ZXIPUphL8ZEYDQxk@smile.fi.intel.com>
 <20231210121632.12ff9640@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ugamGy6o6jXmtwGC"
Content-Disposition: inline
In-Reply-To: <20231210121632.12ff9640@jic23-huawei>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ugamGy6o6jXmtwGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello!

On Sun, Dec 10, 2023 at 12:16:32PM +0000, Jonathan Cameron wrote:
> On Thu, 7 Dec 2023 20:30:42 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>=20
> > On Thu, Dec 07, 2023 at 06:46:29PM +0200, Petre Rodan wrote:
> > > Adds driver for digital Honeywell TruStability HSC and SSC series
> > > pressure and temperature sensors.
> >=20
> > There is room to improve, but I think it's good enough to be included a=
nd
> > amended later on if needed.
> That's almost always true :)
> >=20
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >=20
> Thanks
>=20
> Applied to the togreg branch of iio.git and pushed out as testing for
> 0-day to poke at it and see if it can find anything we missed.

thank you everyone.

I'm working on changes for the iio.pressure.mprls0025pa driver - add spi su=
pport,
add the honeywell,pressure-triplet property and fix the honeywell,transfer-=
function
enum property. hopefully without the need to reach 8 itterations again :)


best regards,
peter


>=20
> Thanks,
>=20
> Jonathan
>=20
>=20

--=20
petre rodan

--ugamGy6o6jXmtwGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmV3KBwACgkQzyaZmYRO
fzDV5A//W0S2op8BiphWvSbUm8yuoXKF1790oDibZv9mzVmEalOgJyDbjQnBqjls
DB5UkzaiMplWx1uiUSuPsWGxKplguR+bxHSne3IMdK88mQZ768Jn95668pKNbdKG
3AzPdwj2UCwPXZitt9jt+Fy1Wjqn3Um/FkMqLeB5Mf4jourZ+DuyRL/SJJpmrUA3
n9MUuFge2284bBuMkffUL5WwqpdVVxg95UKl62A/xheqb++DoBFXsShPqCIMPqoB
KqHCnKGfIIZD8dlolTuiPwvhAGlhF+bZb/upAmqXHE6IDPrKZ4iX8KcTgJtKfsxv
PIkcu1kT7jtcjUQkZLElJHjCaq/WhbQNk4XmpGvgHE2G+SSz2bOrPzl6kfxX1Qn0
V0YcSOZDMeqM9ysJY8jXrbFb3Dmvg3MMbdhOrlXHVOeF/yQ84qYWqKSfZplmWyai
pmVpEaY++ByRhFsPP/lzO1jzzQPjZt43y7NqtpDka+820xOsVQxO0DaVCduEloAz
vjCVW6lyXs9JMpMxezhFUxlmoLHckTX+QZJoEu+HTRZoLJPjR3hPp9PMpQURJ5B7
RVSibwjrPznl+PxMxZtJLDiOH2Ywbml/160qhrQLSDGFvVpxTcjms9cQly/afzok
vt5PMF8nVbFpnKIPHZ5XIdJ1e0/SAXM7WQ0BZyHjN25Yr6VWYGI=
=De48
-----END PGP SIGNATURE-----

--ugamGy6o6jXmtwGC--
