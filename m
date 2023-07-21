Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5478175C4EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjGUKpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjGUKo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:44:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3866E172A;
        Fri, 21 Jul 2023 03:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689936283; x=1721472283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k8dWWqAowhw8YU6X5EPvPOwZl5ALbJM2FyF0JGRJ1m0=;
  b=BdEZVNE/QtryxUoqfpUU5GUk3DU1ARn7rxElMUAdQ98L8VlDuI4AXqlk
   YqQerIrQuB5TrGCIB1krN8FuiAL5jy6LIplOS7p4VX5i1h41WE+z+vx/L
   /9Fs4XcA+QT54FIJlc//EwVmx03tXRqYbG+CBeQf2FguyJYbV73FcpiPo
   iShWxIF1NFXTGpLhx3CsmYSKUGUrU4V/rahAjniay+4w33/ZivDXd39VP
   fj11hDhO9bispZTp2s06KT9NSnw1h1raaFeNvprOFS0B94J+t99Yifzmf
   WIgT6lvzwp5obGRm2q0ipwXgNpBPb3Zwc2AJ9ptDxrNlzhQmytj8GStml
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="367032477"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="367032477"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:43:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838511489"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="838511489"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jul 2023 03:43:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMnbz-000aE3-0v;
        Fri, 21 Jul 2023 13:43:51 +0300
Date:   Fri, 21 Jul 2023 13:43:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v2 2/2] iio: adc: meson: improve error logging at probe
 stage
Message-ID: <ZLphZzO20QW+t1m/@smile.fi.intel.com>
References: <20230721102413.255726-1-gnstark@sberdevices.ru>
 <20230721102413.255726-3-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721102413.255726-3-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 01:23:09PM +0300, George Stark wrote:
> Add log messages for errors that may occur at probe stage

the probe

stage.

-- 
With Best Regards,
Andy Shevchenko


