Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEC678FE39
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349721AbjIANUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjIANUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:20:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F0094
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693574408; x=1725110408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bVS1ZI8wPeWDhI67JkVGmsuo/p94NgEEvHOQ73yeu8g=;
  b=BXbS0LR8PIVYrfBxvUaWPqKlQGHmhMLL1a/2rieljgfXkH02ktribFH4
   MTwGawzzOfigAQvn21kA3IKjbKA54hSbBOKUS3C8aBZG0MYzG5DvuC+U1
   iD7oaBT6flC7pod7ddFtzuxgqSfgrohOsxat2nJerhKnym8HOmOSDgw2P
   KprIkUvPGXerP3AhiAwkaNcSblYj32TblHdfEFy+dPnSugQmbE0AA2Jh8
   mlpr7g8Te+hkL7VQ7nzKL3R0uBT/ku1fPntQReS24tF0Q2I3S08qyptMh
   NvpjcqXWBf9cYLM85gT/hvmzWAyPD0IncKhIfDjSW3PMPVngkcEl/1pG7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="380005964"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="380005964"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="986676875"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="986676875"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:19:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qc43y-005gKB-2p;
        Fri, 01 Sep 2023 16:19:50 +0300
Date:   Fri, 1 Sep 2023 16:19:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v4 2/3] ASoC: wm8580: Remove trailing comma in the
 terminator entry
Message-ID: <ZPHk9tSC64clliFc@smile.fi.intel.com>
References: <20230901065952.18760-1-biju.das.jz@bp.renesas.com>
 <20230901065952.18760-3-biju.das.jz@bp.renesas.com>
 <ZPGmiWDErxnjGlMR@smile.fi.intel.com>
 <baefefc8-55d7-430a-9ec5-2c17c4577d11@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baefefc8-55d7-430a-9ec5-2c17c4577d11@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 01:54:58PM +0100, Mark Brown wrote:
> On Fri, Sep 01, 2023 at 11:53:29AM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 01, 2023 at 07:59:51AM +0100, Biju Das wrote:
> 
> > > Remove trailing comma in the terminator entry for OF table.
> 
> > You are so fast :-)
> > This will produce an unneeded churn as you touch the same line twice in a row.
> 
> So do reviews which focus on very pedantic issues like this one...

If you fine with a series as is, take it!
It's really nothing to bikeshed about.

-- 
With Best Regards,
Andy Shevchenko


