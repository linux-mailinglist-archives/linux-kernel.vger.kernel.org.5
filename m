Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E4F786E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbjHXLwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241315AbjHXLwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:52:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8419F1736;
        Thu, 24 Aug 2023 04:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692877953; x=1724413953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hilqaJ+LrQ5N1ZvOthhZhNMYm83EOMsRLikbmeFxTIA=;
  b=H1/5Kw/Z2Wxvd7y4POvly9r9FsgSytNJAlCjIHlFzbX5OWdVxeDbhdZH
   6e2xd/Z2KRSitdd7rOM0KHSHgxohnKhqmU57xAFugKdY9Uqa835VeciwS
   T0cN7TzbrB6ALbqiZAd/EagshqUU4prOM5xFWeI6sawirjCJo7SyxU+3I
   CvniIB8Waj4HOXk+SgW8GzoJBojkUmL3cXzIEJdFxMJ6zZHE6kOByyt/7
   Im8vb2kMUh/IkCO6OtI1y1cUP1uTBfPOigvPXqXgpbmn0tKtF/oHFL1ZX
   S/8rG4WGwRQjbUY4gRUQYn9yyH6oZdzdYxVuJL4s8yAAoLfPka6XyG5bN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="354746591"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="354746591"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 04:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="713942926"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="713942926"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2023 04:52:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZ8t2-0023Bq-2R;
        Thu, 24 Aug 2023 14:52:28 +0300
Date:   Thu, 24 Aug 2023 14:52:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 4/7] iio: accel: kionix-kx022a: Add an i2c_device_id
 table
Message-ID: <ZOdEfMJC0lGboBbv@smile.fi.intel.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
 <9950e3963600465e1177a20ad8a93a3927c026ef.1692824815.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9950e3963600465e1177a20ad8a93a3927c026ef.1692824815.git.mehdi.djait.k@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:16:38PM +0200, Mehdi Djait wrote:
> Add the missing i2c device id.

This needs an explanation. Why do we need legacy table, what for?

-- 
With Best Regards,
Andy Shevchenko


