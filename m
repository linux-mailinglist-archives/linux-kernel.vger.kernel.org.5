Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6217A0D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241678AbjINSyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242026AbjINSxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:53:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4E026B1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694717598; x=1726253598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6A5zTxWlFGq21TRaa7sBnBDNjHyUvmcdFYF89X/XvLs=;
  b=TF43ZVmbJE9+tv8sqS1bzn9NSoOQck7VSogJ0imfnqzEu9RSYk6GkTV6
   mUb7a+lz8kSKgjSKpGPWZqspfunL9vlbje7lrYpYWvfC7AJiNzBtVEXHC
   r+Tns25NOnnH/Yj5/hF4c5HxXcVrkhS3SX57te5bJp60B86yZjsFm02oW
   aUNMtqe7ohg+AtcCg8ZcOta4esVGWW394QTLaT/LdPOdRa0tW/ImpiTS5
   1nejVL2iJENUBaHFZTmgHEpn5vK38Cp/ibHTsudHrrtUPehj2nF4S7aD8
   aq2lelwJBt9aSjQJPd2pekAMDhUa1+xzC5tIds/LmuU+59uTBozMOgdb3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="359303854"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="359303854"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 11:52:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="834847899"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="834847899"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 11:52:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qgrSR-00000008Wzz-26Dx;
        Thu, 14 Sep 2023 21:52:55 +0300
Date:   Thu, 14 Sep 2023 21:52:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <kernel@xen0n.name>
Subject: Re: [PATCH v1 1/2] LoongArch: Add missing headers
Message-ID: <ZQNWh2DY319jGbfq@smile.fi.intel.com>
References: <20230914103445.511285-1-andriy.shevchenko@linux.intel.com>
 <CAAhV-H6Q0sirFEDdc1v4BSfDY94eZvJazy0XLKM8V94GMJvQnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6Q0sirFEDdc1v4BSfDY94eZvJazy0XLKM8V94GMJvQnQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:25:22PM +0800, Huacai Chen wrote:
> Hi,  Andy,
> 
> Thank you for your patch, can this patch solve the problem below?
> https://lore.kernel.org/oe-kbuild-all/202309072237.9zxMv4MZ-lkp@intel.com/T/#u

Nope, this just adds missing includes.
No functional change, so warnings will still be there.

> If yes, please add a reference in the commit message. I have
> investigated this problem for a long time but failed to solve it.

-- 
With Best Regards,
Andy Shevchenko


