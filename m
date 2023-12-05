Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959FE805BAA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442524AbjLEQA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346938AbjLEQAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:00:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E42120;
        Tue,  5 Dec 2023 08:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701792061; x=1733328061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jKYS+QhpoIvLq7GxMLGJgmwBA/2Fcl2kkmLSM/DkwU4=;
  b=grH7XrSubjOtwEuUM+2eFg1FPpjHYI2mQzPJZClPeb+ZgH9VObZ+b4/+
   F9njKKsorULMZViGdVMWgDYW6PRf1iE264mod7y/Ig+pMFf2RVf6i7hf4
   TSlqNsofWmIrfPmQ7OdEVACOf6DYYeRUuca402aPF+Q4b8i8+hJQlCNDr
   xC3fF/e+HCYOuQ0R5eLk2EP3lBz6e5GoPIlcNm8YCGBx/MqPK8WzKQHfB
   4mamkHtrX2qZ7tbB95bfcVxpmlVzJ6w8NHCni8PAhnVUmioYY+lAVM7Xi
   9wLh1pC8ncdMoi9/axFq2CyytEcykfmaaHpd2Op7cosXzxLjsFiw1gU6w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="374100187"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="374100187"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:01:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="800008703"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="800008703"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:00:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rAXqx-000000024w4-3d2g;
        Tue, 05 Dec 2023 18:00:55 +0200
Date:   Tue, 5 Dec 2023 18:00:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: sim: fix the email address in MODULE_AUTHOR()
Message-ID: <ZW9JN_khy9shJjOd@smile.fi.intel.com>
References: <20231205155430.31761-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205155430.31761-1-brgl@bgdev.pl>
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

On Tue, Dec 05, 2023 at 04:54:30PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Fix unterminated angle brackets in the email address in MODULE_AUTHOR().

Wondering if we have some tool to check this, as it's not the first time
I see very similar fixes (missing >).

-- 
With Best Regards,
Andy Shevchenko


