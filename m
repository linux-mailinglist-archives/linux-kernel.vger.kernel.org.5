Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749F37520E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbjGMMNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjGMMND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:13:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ADC2D5D;
        Thu, 13 Jul 2023 05:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689250369; x=1720786369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XQH1AoepLMoGdYMD+9N7gm+ToR09aJBn096cGLdxFIY=;
  b=k6bf6N4hCbYGUHEwjvF+K/soUyFjEbDMP2gOXTsJjm7/ptcJTRz8c5k0
   pEpMymhn+1zs4Hxd4+xoy36lh4wbntdSJytVVOlD6T+gXYmHKMzzlYVjI
   cuFGGSvo1NOgloUGOnXIrpvh143ZUoPtEvqAsoLYCvi7ds3e8SzPPbqMI
   Hy41sZNwcLFT/G9p6sNa3DptlfnQIeNt1fYflV6GFCbHaccy8MbtNjZn4
   BSOknbt/JMa+vfc0wkx7Et7V+0KSOeLhitsgtNVorO7/CnzCBeWuJorQT
   +NjmA8m8o7arZHWgQfX/3EZICPCLK9iDHRYQ3RqT6epkO6pFU5oY8azAz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="428914953"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="428914953"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 05:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968596930"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="968596930"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jul 2023 05:12:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJvBb-002ONc-02;
        Thu, 13 Jul 2023 15:12:43 +0300
Date:   Thu, 13 Jul 2023 15:12:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v6 0/6] meson saradc: add iio channels to read channel 7
 mux inputs
Message-ID: <ZK/qOi67aacfMcl8@smile.fi.intel.com>
References: <20230712231157.261245-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712231157.261245-1-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 02:10:41AM +0300, George Stark wrote:

> v5->v6:

We haven't settled down the things in v5, hence NAK to v6, sorry.
You have to pay respect to people who invested time in your work.
I hope you are going to answer to my questions and depending on
that we may see v7 in a better shape.

-- 
With Best Regards,
Andy Shevchenko


