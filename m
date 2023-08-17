Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0799877F3A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349755AbjHQJkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349750AbjHQJjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:39:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD1F2D61
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692265194; x=1723801194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bFVRGDyi/zO6uRjHDgnw2hUYSL8NqOgh9MFR2uskeb4=;
  b=Z+XQD1kh/0/Jl34KzJgKi/5JleNOg7tmGtYbydquD/ND8AGDIt1aPvfJ
   JZ3VGmcDBLBibiNRSPbKCBEaAgXJ8RMjk6qCiQciT0PmiIpYvUX4FBlkq
   ZdP9jtbW4izGVCwnymjiUmuZFKaPtaxfiHXl/xHvCI0CFetYA2WZRtV4H
   nsopBWJ4eQ3z//tOmVi18FwkW+V/J5xyfNxoXMGxAsKNVyiwJbSqRNGnN
   +riS4cwQoHRB0Ga8uhd5zyDi4SFw1QG/WOKx+xeqfXAeZCUed2Kqzv/Ys
   VPXhUUKIljPOCHqBghG1nyUnDn36X9MQirEpq1EQPlUgoJ1ZwQ4TxzZxS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403744078"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="403744078"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:39:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848826092"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="848826092"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 02:39:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZTp-005Z80-30;
        Thu, 17 Aug 2023 12:39:49 +0300
Date:   Thu, 17 Aug 2023 12:39:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 1/8] bitmap: align __reg_op() wrappers with modern
 coding style
Message-ID: <ZN3q5bWbnKM9+gwg@smile.fi.intel.com>
References: <20230815233628.45016-1-yury.norov@gmail.com>
 <20230815233628.45016-2-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815233628.45016-2-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 04:36:21PM -0700, Yury Norov wrote:
> Fix comments so that scripts/kernel-doc doesn't warn, and fix for-loop
> style in bitmap_find_free_region().

Suggested-by?

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


