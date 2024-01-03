Return-Path: <linux-kernel+bounces-15554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9574D822E10
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435D7285485
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E23199D2;
	Wed,  3 Jan 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JaaMuVv9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C52199BA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704287524; x=1735823524;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=VlJTA9kn9qE7nS9SkLOmO5VdHSU4SFs95W2IcezjeJA=;
  b=JaaMuVv9pXg6ggWfbhvI11wOVjJUnGDh+ZLacnBx4r50F43MwtMOtE8O
   nMo+F7UUEaNzzCPBiu4LuvJ2+StON6OptxkILacgGQiWgOcFkRmMrkC7Z
   I0fvXBEw3RlotfpHyFvmqn5d4sHTTaqhpgamJkC5A3M6SXNzWM9UKYAv3
   iqbFbFFvGb9IOA/sjV2LMZYA6sJevEC8hT+Zl3NsyS80v3xO7ZaiPNBDa
   0nZYAVyJ9tEw0ROTDv7kah2DuqNuwndeM/NhIj6PJDV6kkMC4Ucs+j2IO
   CDxtt5Bu++CpDGxm4+UlzZTViYZe7giTPn/jwsRyyMWRVf0/rzEpy9Ph9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3807463"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="3807463"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 05:12:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="729781338"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="729781338"
Received: from lapeders-mobl1.ger.corp.intel.com (HELO [10.249.254.243]) ([10.249.254.243])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 05:12:00 -0800
Message-ID: <1f5633526f6f2d39382fa638adc0e5c0b3cb61ab.camel@linux.intel.com>
Subject: Re: [PATCH -next] drm/xe: Remove unneeded semicolon
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Yang Li <yang.lee@linux.alibaba.com>, daniel@ffwll.ch,
 airlied@gmail.com,  mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com
Cc: lucas.demarchi@intel.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Jan 2024 14:11:57 +0100
In-Reply-To: <20240103011515.56529-1-yang.lee@linux.alibaba.com>
References: <20240103011515.56529-1-yang.lee@linux.alibaba.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi, Yang,

On Wed, 2024-01-03 at 09:15 +0800, Yang Li wrote:
> ./drivers/gpu/drm/xe/xe_rtp.c:168:2-3: Unneeded semicolon
>=20

Could you please reformulate using imperative "Remove..." rather than
citing a style alert?

With that,
Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
> =C2=A0drivers/gpu/drm/xe/xe_rtp.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_rtp.c
> b/drivers/gpu/drm/xe/xe_rtp.c
> index fb44cc7521d8..316ed2f6d1f0 100644
> --- a/drivers/gpu/drm/xe/xe_rtp.c
> +++ b/drivers/gpu/drm/xe/xe_rtp.c
> @@ -165,7 +165,7 @@ static void rtp_get_context(struct
> xe_rtp_process_ctx *ctx,
> =C2=A0		*gt =3D (*hwe)->gt;
> =C2=A0		*xe =3D gt_to_xe(*gt);
> =C2=A0		break;
> -	};
> +	}
> =C2=A0}
> =C2=A0
> =C2=A0/**


