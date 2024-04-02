Return-Path: <linux-kernel+bounces-128853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F6C89608E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1287E1F23DF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65A41109;
	Wed,  3 Apr 2024 00:15:54 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E06645
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103354; cv=none; b=K024gpRgIOV8voKMKRruSSalYT/v3Z0+QcT5LAQXHs3ngSDVu1LFm6Ulld51lCNurLEdtyRyz9ngE5uqnlN65boEDueGy5615zq77DRPHsdH21RnEfvYYEQOEuhc1Xe+/k5UyoprGitRpR+3djwOi92Bdq4ikL5ecXqEOBqVb2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103354; c=relaxed/simple;
	bh=6hhE3jkVIfFUl0muZGqLIb+mhsTHD96wVbv+UcDq51I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZQnMK8FGOx2K/Qs/zihaT5dH29AlqY8sIYv9Ly55IXZV1tCAA7hn4WegZ1WNEzgKHCQJ5MqeD9PPULUj5H/5iE+HpFz4zndqKlIfTorm4J//ieelqdVlVys6P9SLdHizcpo7fF1RXb4W2kWNiq2RHuIc0o8Niy0SsLWQgbF0DsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C66FD1C0CF7;
	Tue,  2 Apr 2024 23:58:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 6EE5E17;
	Tue,  2 Apr 2024 23:58:54 +0000 (UTC)
Message-ID: <d02ec26aef6936e07f55a8bda5ae512da8832a73.camel@perches.com>
Subject: Re: [PATCH 1/4] gpu/drm: Add SPDX-license-Identifier tag
From: Joe Perches <joe@perches.com>
To: Nicolas Devos <ndevos-dev@pm.me>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,  dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Tue, 02 Apr 2024 16:58:53 -0700
In-Reply-To: <20240402224320.12146-2-ndevos-dev@pm.me>
References: <20240402224320.12146-1-ndevos-dev@pm.me>
	 <20240402224320.12146-2-ndevos-dev@pm.me>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6EE5E17
X-Stat-Signature: 4wmozogddxmk5hfhmmd9479c5odqeeip
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19NiLFGrVxiJasVrRhQDoiUnMvu4sCsRM8=
X-HE-Tag: 1712102334-125308
X-HE-Meta: U2FsdGVkX1/fs3ut+OQjMslc2yAXCaqSV62VOB/hfUAJRhPNYP7hQN+N7MUlEeZGuDOLuc4N6FniN0CLvJS41G3TwpPjMMhl3hKnk9EWMFmtn7B1KRAG86FSj0087yBxKyF/L7BKfRuOAbFDsP+TIcGZIOGG2s3KLu9glSGQ47Yjk3oDucXljkoE/4WZtUGEX5FYTM6EDuVL08uh4jrJhx7B3OHZFkkx4bSyWhN7Ktg1ip47kjBnBX3Iajx6A5Olu8rVYTL9wfKM+iEjOb0Bay6NN16sx02P7+bsM1EVUtJBcTrsUzwdnBaWDzRk+Fgu

On Tue, 2024-04-02 at 22:43 +0000, Nicolas Devos wrote:
> This commit fixes following checkpatch warning:
> WARNING: Missing or malformed SPDX-License-Identifier tag

NAK without specific agreement from Intel.

The existing license in the file is neither GPL nor MIT

>=20
> Signed-off-by: Nicolas Devos <ndevos-dev@pm.me>
> ---
>  drivers/gpu/drm/drm_connector.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index b0516505f7ae..40350256b1f6 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
>  /*
>   * Copyright (c) 2016 Intel Corporation
>   *


