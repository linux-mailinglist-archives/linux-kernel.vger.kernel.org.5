Return-Path: <linux-kernel+bounces-5189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B018F8187BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506BC1F2513D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CC918627;
	Tue, 19 Dec 2023 12:45:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08F1B278;
	Tue, 19 Dec 2023 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 2525F37813EB;
	Tue, 19 Dec 2023 12:45:30 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date: Tue, 19 Dec 2023 12:45:29 +0000
Cc: linux-kernel@vger.kernel.org, kernelci@lists.linux.dev, "Greg KH" <gregkh@linuxfoundation.org>, "Gustavo Padovan" <gustavo.padovan@collabora.com>
To: stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6ad5-65819080-5-70a26700@225406465>
Subject: KernelCI =?utf-8?q?stable-rc/linux-5=2E15=2Ey?= report (19/12/2023)
User-Agent: SOGoMail 5.8.4
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

Please find the KernelCI report for stable-rc/linux-5.15.y for this wee=
k.

## stable-rc HEAD for linux-5.15.y:

Date: 2023-12-18
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D2d628f368ca8aad32fc680e377c3bff3e508f47b

## Build failures:

No build failures seen for the stable-rc/linux-5.15.y commit head \o/

## Boot failures:

No **new** boot failures seen for the stable-rc/linux-5.15.y commit hea=
d \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


