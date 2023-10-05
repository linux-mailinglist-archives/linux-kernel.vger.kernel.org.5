Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8367BA3D9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbjJEP7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbjJEP4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A487A5FE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696514199; x=1728050199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u1Ps76EPPTogYal6o242bGH52l2wk2mLPz+wdyerggE=;
  b=JPiye1jru9wu+x3C8U/cc3DIj0DYY6auukVOJ8Xh+a1Fodbe+KuW8qAA
   z8DE3t/UR3N3rEHkYjhc0JOUcjc8HQNgDqzg069dgbF41bQcGvjupscVZ
   YNOswU7p5PdW2JIfkM1lugAoenCFm8cGYTa2wpbfXS7B4IzlAZofWMfVd
   r/hnTOi64SQjuh2ZBMg39ecaA7P4qKhsKQTfkl0PcJoRZAwPcC8eGjtQw
   08Id/Mnkzn7mmgoIqNd+I8/9lyl4MeXCdXuF5Qj3mDOANY4FHUSw1GBwm
   cijAVOAYR/bX6rnapDGdmMAtnXCc/2qScKI1nymXVvyg7bWW+VGmsymoB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="447687773"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="447687773"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:56:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="701661881"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="701661881"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:56:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qoOq8-000000032Yx-2PZx;
        Thu, 05 Oct 2023 16:56:32 +0300
Date:   Thu, 5 Oct 2023 16:56:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: (subset) [PATCH] mfd: intel-lpss: Add Intel Lunar Lake-M PCI IDs
Message-ID: <ZR7AkFUoB1PkCkeg@smile.fi.intel.com>
References: <20231002083344.75611-1-jarkko.nikula@linux.intel.com>
 <169651386914.775665.8508120735864164763.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169651386914.775665.8508120735864164763.b4-ty@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 02:51:09PM +0100, Lee Jones wrote:
> On Mon, 02 Oct 2023 11:33:44 +0300, Jarkko Nikula wrote:
> > Add Intel Lunar Lake-M SoC PCI IDs.
> 
> Applied, thanks!
> 
> [1/1] mfd: intel-lpss: Add Intel Lunar Lake-M PCI IDs
>       commit: ae1fbe1b021a3075020856b2717fd971a72f9429

Just a side note, are you sure the word 'subset' makes sense when you take
_all_ patches?

-- 
With Best Regards,
Andy Shevchenko


