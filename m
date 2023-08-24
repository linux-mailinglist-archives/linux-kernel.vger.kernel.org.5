Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D729786E75
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbjHXLvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbjHXLus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:50:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A89119B9;
        Thu, 24 Aug 2023 04:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692877816; x=1724413816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dKqrsbD6XhE/EpX3DcAkGJl2fulCPG3jh08irYfcRn4=;
  b=HefHNvPyqnd/kotY0OlHELmSdqx9ZXEEipSPJsZLbMb8IDQOOzaiU+Nj
   59Wm8PnysB9hgh9cb6l71b6OcepJIMaBeC6g136k5vQ3CnBC/g3XN+8BE
   YQ8w64GPl94y0o4BEcHBXv9ciwSDnOTi07d54NHx+Scjtv/NSygxGvc8i
   LeyZE6AGs3yEnoZkUbmMsAczizKr5ymUaaNHQEz4sKWX0D6yluskTuIlU
   B/joKftRosKHiZDRP1Cvg3UH4tBcxVrPTKeIw6z2IR+C0hpe0lpnM6VH5
   loMH9qr3WxxSH91+ozlcApD0HWK8inFT7N6WkLY7yJ1juM/LztzyB5Yap
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="354745928"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="354745928"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 04:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="686837234"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="686837234"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 24 Aug 2023 04:49:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZ8qD-001wsA-0P;
        Thu, 24 Aug 2023 14:49:33 +0300
Date:   Thu, 24 Aug 2023 14:49:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 2/7] iio: accel: kionix-kx022a: Remove blank lines
Message-ID: <ZOdDzNg/H5IvvFIK@smile.fi.intel.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
 <b1809c807b0638c9a171ac56e99e9773531610be.1692824815.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1809c807b0638c9a171ac56e99e9773531610be.1692824815.git.mehdi.djait.k@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:16:36PM +0200, Mehdi Djait wrote:
> Remove blank lines pointed out by the checkpatch script

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


