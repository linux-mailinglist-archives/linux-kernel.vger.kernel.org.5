Return-Path: <linux-kernel+bounces-18585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9433825FBF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DD29B225FC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0705F7482;
	Sat,  6 Jan 2024 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzi1mMo6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69DE7469;
	Sat,  6 Jan 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704549804; x=1736085804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ogaUlkTNyQ8yFeIfvapqG67agMRheSqoW502ha8cXQ=;
  b=gzi1mMo6N/Yi3FTS0b4s4qfGKnsmTrDMJM4501Qu0UlgjKQpV4EYD+3s
   MLw1JnTZPKOi+213CRRtGvpgB1+SSKrmCpWQf0Mji+XlDkerWDKU0OnvL
   vJMhQRApUntKVVNfg6LVEjfyjPvokSdD6dwArs0JSFIFZIPV6AW2QCuRH
   d52lcV5DRI1lGq85aUwZvCLmu0uI8QU+pjCZ07DQY4MaC0pFTKRJg3+sw
   UPS/HijQB4f2vQ1TZ0qylpKoclr79tf9ZgAY65kRQp2iUDpMpOul2uBum
   OkVtOZlp1iCwO9rIcd1y/cMa8cG11fFhrWoa07nIjv/v11Mn/+jeRnvNq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="11012917"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="11012917"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:03:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="846811425"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="846811425"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:03:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rM7Gg-0000000BvJ5-1RCR;
	Sat, 06 Jan 2024 16:03:18 +0200
Date: Sat, 6 Jan 2024 16:03:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 07/10] iio: pressure: mprls0025pa.c whitespace cleanup
Message-ID: <ZZldpV13HaRUrQBU@smile.fi.intel.com>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-8-petre.rodan@subdimension.ro>
 <ZYxSERlEAfwWpqWP@smile.fi.intel.com>
 <ZYxhUJlAb63wRJE-@sunspire>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYxhUJlAb63wRJE-@sunspire>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 27, 2023 at 07:39:28PM +0200, Petre Rodan wrote:
> On Wed, Dec 27, 2023 at 06:34:25PM +0200, Andy Shevchenko wrote:
> > On Sun, Dec 24, 2023 at 04:34:52PM +0200, Petre Rodan wrote:
> > > Fix indentation and whitespace in code that will not get refactored.
> > > 
> > > Make URL inside comment copy-paste friendly.
> > 
> > >  			return dev_err_probe(dev, ret,
> > > -				"honeywell,pmin-pascal could not be read\n");
> > > +				   "honeywell,pmin-pascal could not be read\n");
> > 
> > As done elsewhere, here and in other similar places fix the indentation
> > by making first character on the latter line to be in the same column as
> > the first character after the opening parenthesis.
> 
> I triple-checked that I am following the max 80 column rule, the parenthesis
> rule and the 'do not split printk messages' rules in all my code in these 10 patches.
> precisely so I don't get feedback like this one.
> if the parenthesis rule makes the line longer then 80 chars I right-align to
> column 80 as seen above.
> that is what I understand from the latest coding style document and that is what
> I will follow.
> 
> in this particular case if I were to ignore the 80 column rule we would end up on
> column 90 if I were to follow your feedback (open parenthesis is at column 45
> and the error takes 45 chars more).

checkpatch has got an exceptional rule _not_ to warn on the long string
literals for 10+ years. It had happened much earlier than 100 relaxation one.

-- 
With Best Regards,
Andy Shevchenko



