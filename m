Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52539785D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbjHWQ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHWQ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:27:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D99F1706;
        Wed, 23 Aug 2023 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692808052; x=1724344052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c/AoVJfF4PYu5efh5pY08Ha8ys/5etCoS/t6ukRs3Pg=;
  b=mJ+fNMg33FTXDn9fF8HR2CFlAZjdrAtClmBnxzEovJf0kcMolMIMxjMc
   Mhtjt7d0Wg4zC+M5lROlbGWdBemkdWHV9+tu6PivsyJz6zXzfPt93TMeH
   TZ7+oxCNn9j761ctEa4Zy9JgAvKxjQUlIaQMEaaF2vyge9QbNeUMxANWl
   wHLO3bEo0B+KGANtfAnw86UphLcNh+WUXgCkhrTzzLz7wm9YGg3n6xWfF
   22Hl59R7mHc/eSI6VWugsxAh8WtTYS+cd9Ka+NGf4nR1w3VB7j79DCSlr
   ZbLYkMqZAgZtPOW1pj/P1eGOjkirTwyY/SSaZM1jbU1Lyhsfthi7VgUsw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="405209560"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="405209560"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 09:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="851100500"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="851100500"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2023 09:27:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYqhE-00FJdC-1o;
        Wed, 23 Aug 2023 19:27:04 +0300
Date:   Wed, 23 Aug 2023 19:27:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 3/3] iio: pressure: bmp280: Add support for BMP390
Message-ID: <ZOYzWD3YIHCq5lq2@smile.fi.intel.com>
References: <cover.1692805377.git.ang.iglesiasg@gmail.com>
 <52adecef119e65e145669925e4a355a84e7f84d9.1692805377.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52adecef119e65e145669925e4a355a84e7f84d9.1692805377.git.ang.iglesiasg@gmail.com>
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

On Wed, Aug 23, 2023 at 05:58:07PM +0200, Angel Iglesias wrote:
> Adds BMP390 device id to the supported ids on bmp380 sensor family

Add
ID
IDs

-- 
With Best Regards,
Andy Shevchenko


