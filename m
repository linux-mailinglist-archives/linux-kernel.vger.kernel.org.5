Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA47A473B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241218AbjIRKgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbjIRKgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:36:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5988D10D9;
        Mon, 18 Sep 2023 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695033302; x=1726569302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Db5GF8qHoBPPBVrjTXINfwo+2GDI1nGNXfDyb1TKivk=;
  b=CcgYlSljFSbBUnRlQMIaOzCfu24XSwwUd0HOBhla9e4DbnFT2563VSLE
   ld8sIko/+5zXnDH3NqsQoUS9MWj5gGGALERc2zcXjqelozsCjS7BoDLDz
   7jfuKhxIi5V51O2Ejt9pK3ZmOP8qhjA2MfjVgS+6ggEyJCh5ochWHSCEv
   DILPni8IoRgnJ2D/xgD3w+mreQztakeZEU4uOrQaNN038yD+WTIN5hNYf
   yVn6G/RLUIK6h+dNOLKxaFqFfnZIVeVVjPvw3a9ZM1cbQNjMDWo/0yBrQ
   rn2W3JGdsLVM1kHTH6V8AfVe7zW7E0d6tUnhJNu1wm4dahXliU2JaKmqj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="446082754"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="446082754"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 03:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="1076535876"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="1076535876"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 03:34:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qiBai-0000000326F-1GBV;
        Mon, 18 Sep 2023 13:34:56 +0300
Date:   Mon, 18 Sep 2023 13:34:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add myself into x86 platform driver
 maintainers
Message-ID: <ZQgnz4G2nzYqsaqk@smile.fi.intel.com>
References: <20230918102901.17669-1-ilpo.jarvinen@linux.intel.com>
 <20230918102901.17669-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918102901.17669-2-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:29:01PM +0300, Ilpo Järvinen wrote:
> Hans has been asking for another person to help as the maintainer of
> the x86 platform driver because Mark has not been able to find time to
> do that. I got asked for the task and have been reviewing the relevant
> patches for a while now but lets make it more official by adding the
> MAINTAINERS entries.

Shan't we simply replace Mark by you?

Either way,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
and thank you for taking care of this!

-- 
With Best Regards,
Andy Shevchenko


