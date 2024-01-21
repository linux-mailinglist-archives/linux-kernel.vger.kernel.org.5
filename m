Return-Path: <linux-kernel+bounces-32045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 109528355B3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9541F21334
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA936B16;
	Sun, 21 Jan 2024 12:36:03 +0000 (UTC)
Received: from pokefinder.org (pokefinder.org [135.181.139.117])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDDE26AFA;
	Sun, 21 Jan 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705840562; cv=none; b=DI9JykkUUzm1AvhQW6t5/Z5/mWWHA9bGL4SRtRMwTWOHdcKP3SYotllDp/ctsQJlFOHt8HjrsGEUxFU1D3QV+9McZK1hSUQ8rpyD9i9W5wsjQKM3w8rP/RdOZdbRRy9aPjFC02AwilUsd9AK26Leo6XyBMDV0BtTxO5hOnNgULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705840562; c=relaxed/simple;
	bh=U6x/Pqa5bsuJf3Rb2m+g6xKom/nhxnVCtBpXz5jdJtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urSD9dbl2WOpHOCWBR0QsDXQVszNxMiQUPLpTZH8ctXhKhiqXgptjHyZIpUs9ROk9XPNvxLMQ0bnw1lteRN8N+QkzNMMECpuOlDPUPnj9iss66h8LvumjuJQrleBffumnmda440U2PRRG5DkApbepXQtrEtFnz7d9EqO+8rCYPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de; spf=pass smtp.mailfrom=the-dreams.de; arc=none smtp.client-ip=135.181.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=the-dreams.de
Received: from localhost (77-123-142-46.pool.kielnet.net [46.142.123.77])
	by pokefinder.org (Postfix) with ESMTPSA id 1FB37A43FF3;
	Sun, 21 Jan 2024 13:27:08 +0100 (CET)
Date: Sun, 21 Jan 2024 13:27:07 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the i2c tree
Message-ID: <Za0Nm2GvQjy51sqN@kunai>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240121200534.57bf614a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g8ipBbQwaxWKBXSQ"
Content-Disposition: inline
In-Reply-To: <20240121200534.57bf614a@canb.auug.org.au>


--g8ipBbQwaxWKBXSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):

Thanks, I fixed my trees and pushed out now.


--g8ipBbQwaxWKBXSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWtDZcACgkQFA3kzBSg
KbZmZA/8CYElVjl73HSe5F+FKVjktM3MGeW2vZNzwBy8phQB9qpgO236hVWycFMp
XgHIi4UuTMQQoPo+danmaGUH0KaJtJYnnLhqc0hs3NKeZNe1/r8LaSSBcFkIEOwt
Kan5K/C3IvvxbmO+ijfaq2E5pW1YoWfTOM2w6JZ3mLyi8TitYvAEfMLR7Z36s4TZ
mbIizwbtamaypz06LWzrAhIxyOA4MLKiE/Egr0tEm8GJ6tewz0JS8dYHsvw3Q0AX
aCJfaBiuhWX/IwmOewM4x4pdVST0GkDFr4svF1UmI1fhDfmar77bgjzIPpPcp6NM
LSj8QFi+1Jt9avw7+/9jsgPcvCsl+SHhWmOZdpy7Fkp+mTm1arfllLetyLzQO/mF
z7wbmeVtXkYKnXg5UbqLo3efCEFCkMNUFJB4rrnJc0KfsFd+eWavheigGqMMI1xB
I6BrN6kGQvHmEPTL0bn6Q7ihQxePVxdQQVEQac8+LcnsQBgkP/1beP7Ext2qZ2w+
8jGDK3CiQHDdJ+LhbiiNURkns2nX/inwNw+5xu6LMPOCmYUt707G7xPbOlo0tv7l
FPKoPgjmBS+HXmGSpZ4fkYPzFVU1D5lI7ZGYIWa4LtcdP/uk33wAv2xKbfSshLbh
H+4jCOLHAOeUucCtq6NNWwJzccwYnpUT5ogUWrjZGvGH08SOuL4=
=Rn33
-----END PGP SIGNATURE-----

--g8ipBbQwaxWKBXSQ--

