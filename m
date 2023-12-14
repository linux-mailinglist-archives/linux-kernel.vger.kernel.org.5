Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207B78134BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573769AbjLNP14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjLNP1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:27:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B43510F;
        Thu, 14 Dec 2023 07:28:01 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="397917991"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="397917991"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 07:28:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="892507728"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="892507728"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 07:27:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rDncy-00000005sVg-1Tny;
        Thu, 14 Dec 2023 17:27:56 +0200
Date:   Thu, 14 Dec 2023 17:27:56 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: [PATCH v2 5/5] gpiolib: cdev: improve documentation of get/set
 values
Message-ID: <ZXse_GEyDOo_bR3q@smile.fi.intel.com>
References: <20231214095814.132400-1-warthog618@gmail.com>
 <20231214095814.132400-6-warthog618@gmail.com>
 <ZXsbZOEjpTN_8oZQ@smile.fi.intel.com>
 <ZXsd1Uhzg328Zdsy@rigel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsd1Uhzg328Zdsy@rigel>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 11:23:01PM +0800, Kent Gibson wrote:
> On Thu, Dec 14, 2023 at 05:12:36PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 14, 2023 at 05:58:14PM +0800, Kent Gibson wrote:
> > > Add documentation of the algorithm used to perform scatter/gather
> > > of the requested lines and values in linereq_get_values() and
> > > linereq_set_values_unlocked() to improve maintainability.
> >
> > I believe this is based on the old discussion in the thread where I proposed
> > the patch to convert this (unreadable in my opinion) code to use bitmap APIs.
> 
> I believe you are correct - that the code is unreadable in your
> opinion.  And I noted that you were the origin of this change in the
> cover letter.
> 
> I'm not usually comforable with this level of hand holding, but I made
> an exception in your case.

At least it helps somebody to understand that, thank you!

-- 
With Best Regards,
Andy Shevchenko


