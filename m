Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC5E7BB32F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjJFI20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjJFI2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:28:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA89895;
        Fri,  6 Oct 2023 01:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696580897; x=1728116897;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=S8+HFso4Rk71WY+Z9bwagGWrgqG8WYun7/txDw+H/rw=;
  b=n9VKBSYdSPqx05TOk4MHSEJbZNaOJ0q36Qp4cdmMxCPC4klpm241/HQs
   FXmwWDb2eUGN6NrEGh9+jFrS5eHL4qxnbzVACcVKdO4dexSTg4C2U60zs
   x2/S05T1CY8nv/FToVX3R0GueJlCmZ9ohiHvExOJfXyzcBKBxb0VYJMKA
   CirNTFSaptPXFV0lQMkvJ++DhFvgFhmk65ApceQEe00JM/4b9gMtIRO0v
   dgExFV4BrC5+xkR4C5MG+MbhONvVxePExoBTW7ELNZ1AJRS43hFKLRAcq
   mi/yGVlY9hYJadPAbBOicMiJnmX6UMXvJdz7FeZhyRFkepre+PfkN3b9W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="380983703"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="380983703"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 01:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="728763253"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="728763253"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 01:28:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qogBx-00000003Emx-2k3w;
        Fri, 06 Oct 2023 11:28:13 +0300
Date:   Fri, 6 Oct 2023 11:28:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pinctrl: core: Remove unneeded {} around one line
 conditional body
Message-ID: <ZR/FHUIPdMzrbLmQ@smile.fi.intel.com>
References: <20231003120648.2838047-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003120648.2838047-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 03:06:48PM +0300, Andy Shevchenko wrote:
> The one line conditional body doesn't require {} surrounding it.
> Remove unneeded {}.

Linus, if you are okay with the change, I can include in my usual PR.
Whatever you prefer, though.

-- 
With Best Regards,
Andy Shevchenko


