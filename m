Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1992275D01D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjGUQz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGUQz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:55:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005411FD2;
        Fri, 21 Jul 2023 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689958526; x=1721494526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jyU4V2ph1DZcN/0ivRvr6VQANvpSErsJVYS5sZ5+3oM=;
  b=aGVEtKU2BDtEy8ZARxnjlPdQQnq4Dg1STPRJxO2rfcLMZCPCgXm/vAk/
   VWT7ZoCAion9UNcG9dwRvNNiRWm2cFspKmfVyZLPrKvgioBbbku3b4u4n
   t3qQbMNYHyJPlsfI9YVU0nfOHlYD9H1W00l7ByiUpYepyMViYnEL7IPTN
   AKUUxwAhuGEsKhl85DvIpug3eaTF9oEavrCxvOw0Sk9G+6LUPcnxspvNs
   NIlWZWvjfLOnBcfvwU06LofDfvNRsmkLr1/VTq9jyLoGO/HwMte45Y9vQ
   vkV+tsqCFe7zE36YsJMjMiNg7YHQaPVdJ87uoEdv14XLP4W92HVcWTChY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="351950527"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="351950527"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="898764327"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="898764327"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2023 09:55:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMtPW-00DObT-1h;
        Fri, 21 Jul 2023 19:55:22 +0300
Date:   Fri, 21 Jul 2023 19:55:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 0/8] iio: core: A few code cleanups and documentation
 fixes
Message-ID: <ZLq4emQI+P6azH8a@smile.fi.intel.com>
References: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
 <d65e25da75142b7414cbf082c7f485464b82b6d1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d65e25da75142b7414cbf082c7f485464b82b6d1.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:06:05AM +0200, Nuno Sá wrote:
> On Thu, 2023-07-20 at 23:53 +0300, Andy Shevchenko wrote:

...

> Reviewed-by: Nuno Sa <nuno.sa@analog.com>

Btw, is it deliberately you don't put accent on "a"?


-- 
With Best Regards,
Andy Shevchenko


