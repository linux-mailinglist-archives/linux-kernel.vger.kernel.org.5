Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E9B7884D5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244433AbjHYKVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244501AbjHYKUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:20:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E1D2111;
        Fri, 25 Aug 2023 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692958841; x=1724494841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ChN0TZycIWtVLs/mIq104bmkKs4G9waM/je8eiAFAs=;
  b=IkiZymGDPSu0IhfH2kkkj4K51LI7KGNn3ndHFFVDP1g7AML6tgXjqPJk
   8zi+kw/dOzmco+rHw4NBrHgRnevlsbQUSvlJMDFwW2lJbzBoDwSSv7GsB
   2ur/aB2v6Xc3s/TpP+loexYlVPEkcWHaIUI+dOi7ia/9175XTO1VDsXAX
   BC5XruRZ14gHmQh58e29qMpDlRsDy4IU2OmQ2tmAZmLAvPItqddd5Bz2d
   yMizOZG4urSgLr/v+ZVQGtQP5IeacJzbboxswQq2jUMZYCD/tt6JuGHQz
   2iUwmXo+Y9XsE6iwtjuUHxpaf1hEB5U7nRH0jhcsoEZ44wHCbKy0IMmla
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374658700"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374658700"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 03:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802920717"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802920717"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2023 03:20:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZTvg-00Ckve-0w;
        Fri, 25 Aug 2023 13:20:36 +0300
Date:   Fri, 25 Aug 2023 13:20:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        lh xu <xulh0829@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH 6/6] pinctrl: sprd: Add pinctrl support for UMS9621
Message-ID: <ZOiAdJEMQjgfpaiF@smile.fi.intel.com>
References: <20230825031826.31599-1-Linhua.xu@unisoc.com>
 <20230825031826.31599-7-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825031826.31599-7-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 11:18:26AM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> This patch adds the pin control driver for UNISOC UMS9621 platform.

Same comments as per previous patch.

-- 
With Best Regards,
Andy Shevchenko


