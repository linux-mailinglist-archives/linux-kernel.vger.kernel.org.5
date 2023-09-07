Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791C0797655
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbjIGQGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjIGQGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:06:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1569893F9;
        Thu,  7 Sep 2023 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694102229; x=1725638229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F1fILzBUvGq5yLs13dD/sx0JlCAtmCpOqemv/mVDb68=;
  b=UC1tkyVFld72mG+llWBn1obGaepZIfYWgfHMNgRzf6/pJkfJYq+ucr5K
   189cb0YmpmuoySYYYl3QFPcJkxUr4lWzlTg60O2gvt31i5JGdxbnfqU3X
   Sdehu30MUwv6dl962oL+zpbTTyTEZClQ1cqm/l7LsYqDdB7DOxS5zbHbo
   dhb6tBVBJ15ybQUZK6iuVadsViqxx/IBadC68rfYuo/f6SDF3lbIgpV8o
   IppxL+59dLR28AEIbfX4Qe83nNqianp+1qWztxZPbqX+1vo5ho2kjbHed
   mQ0IMZJ77xPJd+prh8GlG1eIxknwVRPK3W6hBZX78t/RGzKBtj5dqdq0J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="381199667"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="381199667"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:48:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="832241238"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="832241238"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:48:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qeHFR-007MPH-3D;
        Thu, 07 Sep 2023 18:48:49 +0300
Date:   Thu, 7 Sep 2023 18:48:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/5] gpio: mockup: fix kerneldoc
Message-ID: <ZPnw4XVLVwblUtLb@smile.fi.intel.com>
References: <20230907145230.44085-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907145230.44085-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 04:52:26PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The pull field of the line state struct is undocumented. Fix it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

for the entire series.

-- 
With Best Regards,
Andy Shevchenko


