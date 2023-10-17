Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86D07CC3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbjJQMsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjJQMsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:48:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F8083;
        Tue, 17 Oct 2023 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697546902; x=1729082902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HbWDNRTqXUOnMwRP5iHVUDZR1z4fFcOxevG3vythgVI=;
  b=HA76oki+Xk/0rjpEHlEEog082CGM9l7bBmdcSibvsrXGPqK0kKX2VH0v
   ZwF7stfPFk9rNEjGnisJ9X+Qv7bvJ11Lp4c6Z6B+riiLGixVJB68LsHjA
   vtL5wMD08VzVEpvyHUlwCg282Zxp5xv9loXYVH3MVrVuimXRT8VjY4QAx
   1w0sQq1B4Ok7uu74SyUpl/PYdQI75aFR7R7d2vrrgYyjg9lYGjTFaW8nL
   SKOByVzxOKbxZ99372875rK4V2ZwFcbkg17OqcrxI/oeevWE3DbMEpYWp
   b/vnZg9+wllrbVGTWkLlGVlU1YJRFn2jmFxEyMA5QG4I+85wFdl5uzZ6X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7330942"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="7330942"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="821970814"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="821970814"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:48:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsjUX-00000006Htj-3JxH;
        Tue, 17 Oct 2023 15:48:09 +0300
Date:   Tue, 17 Oct 2023 15:48:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lakshmi.sowjanya.d@intel.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        giometti@enneenne.com, corbet@lwn.net, gregkh@linuxfoundation.org,
        pandith.n@intel.com
Subject: Re: [PATCH v1] Documentation: driver-api: pps: Update PPS generator
 documentation
Message-ID: <ZS6CiVFdG7yR3tXp@smile.fi.intel.com>
References: <20231016101953.27308-1-lakshmi.sowjanya.d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016101953.27308-1-lakshmi.sowjanya.d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 03:49:53PM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Pandith N <pandith.n@intel.com>
> 
> PPS documentation has a generalized section for generators. Update the
> section so any new generator documentation can be appended.

It should be v2 with a changelog.

-- 
With Best Regards,
Andy Shevchenko


