Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE0278FCF9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349360AbjIAMMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjIAMMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:12:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AECCF3;
        Fri,  1 Sep 2023 05:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693570360; x=1725106360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JT0cba5ZbZYJsb7HCImJ6UnYKJtUBT74iXKfgEcKKxY=;
  b=ZxtSEAwD1DBhN/1qePk9tci0cUpAPG8QJ4XiDToz7ZGTR9vbIPJufccn
   gihyGY4saoGkuhBJamdcR0d7UuN8jfYjug9uL385jU7UTOKGgnfLLLpwi
   tMFz4RHzQMg2BMcgT/aTcmBCNaN9XYqo6v215VBONFtv8JlNFauGTH9gG
   pO4ptZM+3ZFDj7PQuECki+a53iC0P4dZyaGgaYxYLLVI5Fnc+1fg+PlSM
   L2hC84LO0Q2PoY+TKMwJ7cRq4PqPVpbYnxpq1qdgo5KVf8Pazq4k5En8A
   saPCmXxcKL7o9x+x3lnDyIM3tUWL9RoY57a8LbNwaKL86zyEkQuGSPW2J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="462574043"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="462574043"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="743086938"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="743086938"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:12:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qc30t-005fPW-2h;
        Fri, 01 Sep 2023 15:12:35 +0300
Date:   Fri, 1 Sep 2023 15:12:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: remove unnecessary extern specifiers from the
 driver header
Message-ID: <ZPHVM7DYpig0Joyd@smile.fi.intel.com>
References: <20230901113458.13323-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901113458.13323-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 01:34:58PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> 'extern' doesn't do anything for function declarations. Remove it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


