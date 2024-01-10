Return-Path: <linux-kernel+bounces-22034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7532682983C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1937DB2350A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B046841776;
	Wed, 10 Jan 2024 11:01:30 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF640C12;
	Wed, 10 Jan 2024 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 9A8313780C21;
	Wed, 10 Jan 2024 11:01:25 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240108150602.976232871@linuxfoundation.org>
Date: Wed, 10 Jan 2024 11:01:25 +0000
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, "Gustavo Padovan" <gustavo.padovan@collabora.com>, kernel@collabora.com
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <465c-659e7900-3-3d0c2840@20656236>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E6?= 000/124] 
 =?utf-8?q?6=2E6=2E11-rc1?= review
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Monday, January 08, 2024 20:37 IST, Greg Kroah-Hartman <gregkh@linux=
foundation.org> wrote:

> This is the start of the stable review cycle for the 6.6.11 release.
> There are 124 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Wed, 10 Jan 2024 15:05:35 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6=
11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
git linux-6.6.y
> and the diffstat can be found below.
>=20

Please find the KernelCI report for linux-6.6.y below :-

## stable-rc HEAD for linux-6.6.y:

Date: 2024-01-08
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3Dc52463eb66c8ae86cf354c700d80ae02fd9a1eda

## Build failures:

No build failures seen for the stable-rc/linux-6.6.y commit head \o/

## Boot failures:

No **new** boot failures seen for the stable-rc/linux-6.6.y commit head=
 \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


