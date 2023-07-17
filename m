Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445E975600B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjGQKEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjGQKEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:04:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514D79C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689588255; x=1721124255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WnlwfGJjGqDvSxdq2cqUE+5C4r/vurq5Ib3eVZloNxQ=;
  b=G6/ryHao5CsBbspAUsMuP8dYr2o9t/IWB2hSekiOkp06ehZIk3bsK9Fq
   KRwG5ruLOjikhyYDQEIZZaDkSHlGUswoW5ptylvbMgbmSzM5dmgPyADZr
   OWXANcCg+8xs6wtsOmBl+tRwMOu1EkrAdy9BYd2OcG2oWfEi6ArANxuDv
   5YWeRQ2s3V3ZDLWrAGsnl5tz9dxLURFnmZ9GOSc12Jklxm8+ztS+2Tufn
   CqzdhcUmHYoFuXo3JwrHKDpW8w8xLgX2n/4qh9otBayw21DoVdRKaHSg9
   1vZKA5Uwn2UF6JQJPKeo9QxrNaDQ08eUWED0ZMqoj69vYQ61yL590K2Fr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="396717479"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="396717479"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 03:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="897160373"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="897160373"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2023 03:04:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLL5P-008dix-0p;
        Mon, 17 Jul 2023 13:04:11 +0300
Date:   Mon, 17 Jul 2023 13:04:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>
Subject: Re: lib/test_bitmap.c:920:2: error: call to __compiletime_assert_348
 declared with 'error' attribute: BUILD_BUG_ON failed:
 !__builtin_constant_p(res)
Message-ID: <ZLUSG8bNnSqT0LO+@smile.fi.intel.com>
References: <202307171254.yFcH97ej-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307171254.yFcH97ej-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 12:42:57PM +0800, kernel test robot wrote:
> Hi Alexander,
> 
> FYI, the error/warning still remains.

Alexander, either you can escalate this or just propose something to discuss.

-- 
With Best Regards,
Andy Shevchenko


