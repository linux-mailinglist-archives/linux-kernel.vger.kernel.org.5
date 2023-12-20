Return-Path: <linux-kernel+bounces-6644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A97819B82
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152691F26604
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BA21EB5D;
	Wed, 20 Dec 2023 09:39:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AFB1F191;
	Wed, 20 Dec 2023 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id D43A43781478;
	Wed, 20 Dec 2023 09:38:57 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <2023121951-clatter-flatfoot-35e9@gregkh>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date: Wed, 20 Dec 2023 09:38:57 +0000
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, kernelci@lists.linux.dev, "Gustavo Padovan" <gustavo.padovan@collabora.com>, =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <ricardo.canuelo@collabora.com>
To: "Greg KH" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7aff-6582b600-1-597f2100@46892259>
Subject: =?utf-8?q?Re=3A?= KernelCI =?utf-8?q?stable-rc/linux-6=2E1=2Ey?= report 
 (19/12/2023)
User-Agent: SOGoMail 5.8.4
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 20, 2023 00:42 IST, Greg KH <gregkh@linuxfoundat=
ion.org> wrote:

> On Tue, Dec 19, 2023 at 12:44:59PM +0000, Shreeya Patel wrote:
> > Hi Everyone,
> >=20
> > Please find the KernelCI report for stable-rc/linux-6.1.y for this =
week.
> >=20
> > ## stable-rc HEAD for linux-6.1.y:
> >=20
> > Date: 2023-12-18
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git/log/?h=3Dd4e0eced630816f1c7a6d389a4cb6233a606eeea
> > =20
> > ## Build failures:
> >=20
> > No build failures seen for the stable-rc/linux-6.1.y commit head \o=
/
> > =20
> > ## Boot failures:
> >=20
> > No **new** boot failures seen for the stable-rc/linux-6.1.y commit =
head \o/
> >=20
> > Tested-by: kernelci.org bot <bot@kernelci.org>
>=20
> These are great, thank you for doing this!
>=20
> But, any chance you can provide these as a response to the -rc email
> announcement so my tools can pick them up for the commit message?  I =
can
> mush them in here by hand this time, but doing it twice a week for th=
e
> next 10+ years is going to be a pain for me :)
>=20

Sure, I'll send reports as a response to each of your -rc email announc=
ements
from next time.

Thanks,
Shreeya Patel

> thanks,
>=20
> greg k-h


