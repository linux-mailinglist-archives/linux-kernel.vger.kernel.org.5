Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47305782563
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjHUI3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjHUI3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:29:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F8EC3;
        Mon, 21 Aug 2023 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692606571; x=1724142571;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=NgVXbpo684fEyEZ7FCGaQoWGT47RfPiF567uTqSqcoQ=;
  b=mks2UPfF3mHpy6n9iP1TOQ9YmG7JxCnsMTO/oCvR+caglRDdclI7PtuU
   Vr3i/P6iwfVMZCAVw4yRCxSBCpUt4HZYJ/plS6edh8dLXLRzE8ShIgfpq
   oQKeO+VFo/TkbCgNOJ5hnwtvRdwiWnFOcb+Ge7uGWGy7zMOBr7Sx9VY90
   M4+QEbKZNoqyuCYq4SSORP/mqLOVDKW7928tPdh/y4+G3CPK3wwyOVlR5
   Qg6AJXkyTQURNjvy7rom84yAM+lo9+evY9ydod1rdQBoo0X9CYGVmb/HJ
   WLSRl5DZNR6Xfkc3/sVRNlxztr+tRv62zaIk2B0BG9aLpzvf/6jz4B24j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="439905520"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="439905520"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:29:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="738814847"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="738814847"
Received: from hpabst-mobl.ger.corp.intel.com (HELO localhost) ([10.252.54.190])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:29:29 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag
 to give credits to who sponsored the patch
In-Reply-To: <ZN65iiRiSLmXz89k@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
 <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
 <20230817232348.GC1175@pendragon.ideasonboard.com>
 <ZN65iiRiSLmXz89k@casper.infradead.org>
Date:   Mon, 21 Aug 2023 11:29:27 +0300
Message-ID: <87ttss7q8o.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023, Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, Aug 18, 2023 at 02:23:48AM +0300, Laurent Pinchart wrote:
>> Just adding one data point here, without judging on the merits of this
>> proposal. I've been requested previously by customers to increase their
>> visibility in the kernel development statistics, and the way we found to
>> do so was to sign-off patches with
>> 
>> Laurent Pinchart <laurent.pinchart+customer@ideasonboard.com>
>> 
>> (where "customer" is to be replaced with the customer name).
>
> I quite like Sponsored-by: but yet another approach could be the
> same as that used by those of us whole use personal email addresses
> while being employed by someone.  So my SoB is:
>
> Matthew Wilcox (Oracle) <willy@infradead.org>
>
> but you might have (eg)
>
> Laurent Pinchard (Coca-Cola) <laurent.pinchart@ideasonboard.com>
>
> and then when working for another sponsor:
>
> Laurent Pinchard (Ford) <laurent.pinchart@ideasonboard.com>

Just an observation, git shortlog -s/-se groups/distinguishes,
respectively, the author and sponsor in Laurent's approach. Not so with
Matthew's approach.

Probably depends on the POV which approach this favors. ;)


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
