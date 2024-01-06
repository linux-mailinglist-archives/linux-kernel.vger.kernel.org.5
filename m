Return-Path: <linux-kernel+bounces-18619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CC2826019
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9712832BA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61C48485;
	Sat,  6 Jan 2024 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gl4Wn+if"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A788475;
	Sat,  6 Jan 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704554701; x=1736090701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iMv++4A4+AQuPVgn3RTePZD1G5i4IOO/7gyeEkTY/yg=;
  b=Gl4Wn+ifQNGWqzZ6RzWP5u4/Q9d3RjKHiewuMUMw1SgUaAdVrk8Yhrtv
   zzKaMou1xy8I1M8ejixc/jFnl+P3pMLRRLptLwLlNfiD6thZvOSR8L8C6
   KRhuCJp5htnQqejhzDwkvW/c/IHsGEY/bjO0mJBv4gxipLarjUMRpR5q6
   qwKkCw9gz2eBrhF7iMk09nWrBsY/00LEtCFcDYknnu9X8mmKBbPHfc8L2
   ocTVSrkPsKF62Xp/KNHbXeaebJuT/pvxuxeDOj7y5+SAiQJ9Y+jWpDKHE
   4oopC939x2gbDeBbghDc3LCeFVOS1Qa5E7lIPTOzzf5zRHwBOD8AuOo1M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="461961892"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="461961892"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 07:25:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="871478190"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="871478190"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 07:24:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rM8Xg-0000000BwMI-07qV;
	Sat, 06 Jan 2024 17:24:56 +0200
Date: Sat, 6 Jan 2024 17:24:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 07/10] iio: pressure: mprls0025pa whitespace cleanup
Message-ID: <ZZlwx1JSdjAvto55@smile.fi.intel.com>
References: <20231229092445.30180-1-petre.rodan@subdimension.ro>
 <20231229092445.30180-8-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229092445.30180-8-petre.rodan@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 29, 2023 at 11:24:35AM +0200, Petre Rodan wrote:
> Fix indentation and whitespace in code that will not get refactored.
> 
> Make URL inside comment copy-paste friendly.

...

>  		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
> -				IRQF_TRIGGER_RISING, client->name, data);
> +				       IRQF_TRIGGER_RISING,
> +				       client->name,
> +				       data);

The last two are perfectly located on a single line and be even coupled
semantically together.

No need to resend the patch just because of this, Jonathan can amend, I think,
when applying.

-- 
With Best Regards,
Andy Shevchenko



