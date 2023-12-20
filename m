Return-Path: <linux-kernel+bounces-6849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B11819E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C511C225CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7421A09;
	Wed, 20 Dec 2023 11:53:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C8C219F3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5DEC433C8;
	Wed, 20 Dec 2023 11:53:30 +0000 (UTC)
Date: Wed, 20 Dec 2023 06:53:27 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Kevin Hilman <khilman@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] driver core: mark remaining local bus_type variables as
 const
Message-ID: <ZYLVt12cLi5rYXaD@ishi>
References: <2023121908-paver-follow-cc21@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lVg+P3289/OofLZ6"
Content-Disposition: inline
In-Reply-To: <2023121908-paver-follow-cc21@gregkh>


--lVg+P3289/OofLZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 04:35:09PM +0100, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> change the local driver core bus_type variables to be a constant
> structure as well, placing them into read-only memory which can not be
> modified at runtime.
>=20
> Cc: Dave Ertman <david.m.ertman@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: William Breathitt Gray <william.gray@linaro.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: William Breathitt Gray <william.gray@linaro.org>

--lVg+P3289/OofLZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZYLVtwAKCRC1SFbKvhIj
K7OXAQCk4rcHIT+BxL/rELGncaSctWCJJLA6tcXCPeFZCbQcyQD/WZta82DTC7yJ
+CdxvAr0WfIBQLgRr5DJbcS9jM1JCQM=
=pX/m
-----END PGP SIGNATURE-----

--lVg+P3289/OofLZ6--

