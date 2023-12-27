Return-Path: <linux-kernel+bounces-12140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D699E81F076
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C974B21053
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA152574D;
	Wed, 27 Dec 2023 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mE0a7ZFg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5751E484;
	Wed, 27 Dec 2023 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703694872; x=1735230872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/D6/q19jPjwsZYq+Dyp1dAkvnnqU3afsVG+ZeqAmSL0=;
  b=mE0a7ZFg7OZHe6GMDkmNqDfL8ykayPWkZOEfv3LPKyvwANIwbm7LVeEQ
   sG4d6pNijuOsKG98hdZG5ukR3Q4TUBV6rv+YXwifdZ+/to0adPOK6JUqX
   dq+pzDxaY2UFsVIcy1Ch4HqajuxeZb0Eo6busfQ2rFFr44j+wkr6GeC0d
   7ZWzFhS/7IDothuRdlZ1/yVO/yZ4qapUficiavgqdr5iMvvn1wSR03t9l
   zwo/SbbwRfBVVCClsXRtH6TMIRYMIRscXVamXaCcnYWr4f4AH0mOmFplC
   svrjJ/J97di6OR816ineCoKz+8PNeh01X2NujJHZLPkGgahNssid5VK6Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3748365"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="3748365"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:34:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="921876250"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="921876250"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:34:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIWrR-00000009SqD-2Msg;
	Wed, 27 Dec 2023 18:34:25 +0200
Date: Wed, 27 Dec 2023 18:34:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 07/10] iio: pressure: mprls0025pa.c whitespace cleanup
Message-ID: <ZYxSERlEAfwWpqWP@smile.fi.intel.com>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-8-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231224143500.10940-8-petre.rodan@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Dec 24, 2023 at 04:34:52PM +0200, Petre Rodan wrote:
> Fix indentation and whitespace in code that will not get refactored.
> 
> Make URL inside comment copy-paste friendly.

>  			return dev_err_probe(dev, ret,
> -				"honeywell,pmin-pascal could not be read\n");
> +				   "honeywell,pmin-pascal could not be read\n");

As done elsewhere, here and in other similar places fix the indentation
by making first character on the latter line to be in the same column as
the first character after the opening parenthesis.

			return dev_err_probe(dev, ret,
					     "honeywell,pmin-pascal could not be read\n");

-- 
With Best Regards,
Andy Shevchenko



