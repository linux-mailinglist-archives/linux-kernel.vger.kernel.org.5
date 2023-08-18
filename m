Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E247780A59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376359AbjHRKjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358714AbjHRKjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:39:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F13F13E;
        Fri, 18 Aug 2023 03:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692355151; x=1723891151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CQ4f/Wck856yNOrBmWfQjkyduFmCXCVkvM22jy0bkrM=;
  b=cc/ZVNYO9UQ4+Sh8dBuuD6qpE89Gn/QFpWJ3pZOP1iWYAYdrmMbZQAHq
   L9FPacD2G5NdskyMRwhyVtQzd1oKLFJiv7ToplC9pdJzCWnlqc42z8PBi
   rWNkI3m40cuQDxaFW1EzU9BeRoTx6al/WuK/3g2MPAefrkfknVLTJG9Yp
   vrkSKDot1bbc0p0sWMggINJURNqfHkprb0Mj45G128oyfpU8ShiWPsZXm
   CqAqU+qD/tRoFY7V5Zsxe8LynqWudrz9szLFqqwohmjuPvdTvhYVCppAi
   gXvSUiwqKul5cyQUZj0HRq/F4JOmYKiJ6ypQW6ffNG/gHjgQH6xjB+qJB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="375851637"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="375851637"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:39:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="770094859"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="770094859"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2023 03:39:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWwsl-0043T5-2q;
        Fri, 18 Aug 2023 13:39:07 +0300
Date:   Fri, 18 Aug 2023 13:39:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] gpio: pca9570: fix kerneldoc
Message-ID: <ZN9KS66ZsHrCWM1a@smile.fi.intel.com>
References: <20230817194449.26447-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817194449.26447-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 09:44:49PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> While renaming one of the fields in the driver data struct, the kerneldoc
> was not updated which apparently angers the test robot now.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


