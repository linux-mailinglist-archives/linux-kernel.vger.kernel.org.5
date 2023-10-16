Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59D7CA3A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjJPJL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjJPJL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:11:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D55AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697447514; x=1728983514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DynLogKPBnBQr3sg56bzst9ewar26xYjx3QE+KnxVhk=;
  b=mIYw+jKLrYCd1cJlEeejqxfHs4xAU7RTyEzEEFuAB0U0yOCDqGgEhBRS
   UFE40/TsQUg58emeemG4/Xe99S8DVvpdBgiDgDvRURvmYxVLvLh4IBseQ
   CGjYhlHnfaGnPrXM7K5HTF+WHa2sHdHKLk5PgKSAyEa7mIA5tGqn0FNGi
   h0h2+Dc6Mjx6rVk41swOL/7a955qtTMAMcfeaEOtgtsUe9b90uS+C4jio
   izDbUXODBgWBdZihum18Sy8cyFO76ldaHyKjmJmm0Qwh3lJeDDVMWdhGV
   1pYHGtipgF6IorxTXfGuxJHN9vrVYrEEfSbmN3+3M5gfsp4bLRA2xD5Fa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="7047293"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="7047293"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 02:11:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899425823"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="899425823"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 02:09:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsJde-00000005xqK-0fsU;
        Mon, 16 Oct 2023 12:11:50 +0300
Date:   Mon, 16 Oct 2023 12:11:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lakshmi.sowjanya.d@intel.com
Cc:     linux-kernel@vger.kernel.org, giometti@enneenne.com,
        pandith.n@intel.com
Subject: Re: [PATCH v1] Documentation: driver-api: pps: Update PPS generator
 documentation
Message-ID: <ZSz+VfmpejJbZdb+@smile.fi.intel.com>
References: <20231006121531.22450-1-lakshmi.sowjanya.d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006121531.22450-1-lakshmi.sowjanya.d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 05:45:31PM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Pandith N <pandith.n@intel.com>
> 
> PPS documentation has a generalized section for generators. Update the
> section so any new generator documentation can be appended.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

You forgot to include the Documentation maintainer...

I suggest to try my "smart" script [1] that has a heuristics on whom
to send the changes.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


