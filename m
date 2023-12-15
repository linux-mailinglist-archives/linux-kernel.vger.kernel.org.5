Return-Path: <linux-kernel+bounces-856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5A781471C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF559B21F11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321BF250F6;
	Fri, 15 Dec 2023 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECdepV4+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2192224B31;
	Fri, 15 Dec 2023 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702640448; x=1734176448;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PbtD99dYPA9EHTb3b9FLxpZzIQ0yDjkgxxrR4eFWJYs=;
  b=ECdepV4+vqHfM5ol045Ydpd97ykMs6H+rf16C7KwkAKza1uXKqxbzL9h
   j4J27Fo4/TmgUVJRUlzd19eNeMxbVTg2cuv3diQ0knMfYSHpo6JfpnPGm
   8MxDqlsshFd4LjF0pXg0iMhpT2N5ZMrE4Z0aBVpqT7vJEgt8Ak/u1W6CP
   BtawFQuGbagsJrMBhr0AvyueZzQ+n37CGI4WCdEtbjpPMstKoDwfVhvqX
   8eM8jFbqLLWGJg40bNKlc4UQ68vBq4uFq7dJrdycSE1reF112mTMl5oFr
   YMPqbG02nrhbo7CRflPc06frAGJ5rZoxNJkRFyP7WehybwkoKk6CXr2k/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="398056158"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="398056158"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 03:40:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="898113841"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="898113841"
Received: from plchavex-mobl.amr.corp.intel.com ([10.249.34.221])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 03:40:45 -0800
Date: Fri, 15 Dec 2023 13:40:40 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Colin Ian King <colin.i.king@gmail.com>
cc: Henry Shi <henryshi2018@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] platform/x86: silicom-platform: Fix spelling
 mistake "platfomr" -> "platform"
In-Reply-To: <20231215112746.13752-1-colin.i.king@gmail.com>
Message-ID: <9e1d8d9-5d59-a29a-73b6-e7e04f98a96@linux.intel.com>
References: <20231215112746.13752-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1452261007-1702640447=:2400"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1452261007-1702640447=:2400
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 15 Dec 2023, Colin Ian King wrote:

> There is a spelling mistake in a literal string. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/platform/x86/silicom-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/silicom-platform.c b/drivers/platform/x86/silicom-platform.c
> index 84b92b3f9f4b..6ce43ccb3112 100644
> --- a/drivers/platform/x86/silicom-platform.c
> +++ b/drivers/platform/x86/silicom-platform.c
> @@ -866,7 +866,7 @@ static int silicom_fan_control_read_labels(struct device *dev,
>  {
>  	switch (type) {
>  	case hwmon_fan:
> -		*str = "Silicom_platfomr: Fan Speed";
> +		*str = "Silicom_platform: Fan Speed";
>  		return 0;
>  	case hwmon_temp:
>  		*str = "Silicom_platform: Thermostat Sensor";
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1452261007-1702640447=:2400--

