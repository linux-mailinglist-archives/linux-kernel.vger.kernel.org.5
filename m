Return-Path: <linux-kernel+bounces-10448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1FC81D482
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F176B1C20C72
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2C1DF43;
	Sat, 23 Dec 2023 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="mjWC7BbO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF49DDA1
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1703341089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgAKrzFUuBY/aRZdG/sV9t0Klms7KMGcDs+12G81t/o=;
	b=mjWC7BbO22IYp9BhC/jUQ1r8tbAUbhktMbgJwM99pf3WvyVc1sI1SOnFItgAj87ZFAdsqk
	uiamEOz6g8pKsPX/FBQUTBsnqhoHGbq6uFNSXHJ5Oz7MPU0mX2f+dqKL2rHm/Rv0KLDUaX
	+Ls+BuIi6iTiv6fyafYawZ63NGyHqoNqc0KupplpFdw+e6kDTFbTwOcTBWHwfY+/yFSg48
	wVwcq1FjcVQ6GWnQbSr2e3rWcRZ3nt91chwlQ60tAvt47FmoR8Z7wwsbukc/lNsL6i44Dj
	J3ImyV5P2/dzL2d7m28SIqgb5/0K43I43OvM0U0onbOsmVfQYsP0e2pgs1oUqg==
From: Diederik de Haas <didi.debian@cknow.org>
To: Manuel Traut <manut@mecka.net>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>,
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH 4/6] arm64: dts: rockchip: Add devicetree for Pine64 Pinetab2
Date: Sat, 23 Dec 2023 15:17:58 +0100
Message-ID: <1883322.fLvJxeCpJd@bagend>
Organization: Connecting Knowledge
In-Reply-To: <ZYbnxkkCIJtzqa0h@mecka.net>
References:
 <20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net> <2121710.IWpXjAX0fk@bagend>
 <ZYbnxkkCIJtzqa0h@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart28392273.q4UQjrvTh7";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart28392273.q4UQjrvTh7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: Manuel Traut <manut@mecka.net>
Date: Sat, 23 Dec 2023 15:17:58 +0100
Message-ID: <1883322.fLvJxeCpJd@bagend>
Organization: Connecting Knowledge
In-Reply-To: <ZYbnxkkCIJtzqa0h@mecka.net>
MIME-Version: 1.0

Hi Manuel,

On Saturday, 23 December 2023 14:59:34 CET Manuel Traut wrote:
> On Fri, Dec 22, 2023 at 06:01:54PM +0100, Diederik de Haas wrote:
> > On Friday, 22 December 2023 12:05:44 CET Manuel Traut wrote:
> > > +
> > > +&cru {
> > > +       assigned-clocks = <&cru PLL_GPLL>, <&pmucru PLL_PPLL>, <&cru
> > > PLL_VPLL>; +       assigned-clock-rates = <1200000000>, <200000000>,
> > > <500000000>; +};
> > 
> > Attachment seem to work and for this I also have the attached patch in my
> > patch set.
> > IIRC without it you get an error in dmesg immediately at boot up which is
> > visible on the PT2 *if* you have immediate visual output (which is not
> > (yet?) the case in my image/kernel).
> 
> you can see the message also by calling "dmesg --level err".
> I could verify that your patch removes the error message.

As I have been using that patch for a while, I couldn't verify it myself 
anymore ;-)
If you use the (default) danctnix image, then you see it immediately at boot 
up (at least the last time I tried it). With my (WIP) image, I only get visual 
output after 5-7 seconds, so you'll likely miss that visual error if the image 
you use also has a delay before outputting things on the screen.
But indeed, it would still show up in dmesg (without the patch).

> I will pick the change for v2.

Great :-)
--nextPart28392273.q4UQjrvTh7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZYbsFgAKCRDXblvOeH7b
bnfaAQCB19vhFqKkdKyoVT/ScgOlKuwEnm2ELd5BtzT6OGdHaAEAjHsFPIBnxiw3
Tqs+4hbh0skq43sF8GQX35lzxGjgYg4=
=q5pl
-----END PGP SIGNATURE-----

--nextPart28392273.q4UQjrvTh7--




