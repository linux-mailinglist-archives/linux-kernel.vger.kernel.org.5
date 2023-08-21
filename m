Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3287828C3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbjHUMPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbjHUMPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:15:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF9DCC;
        Mon, 21 Aug 2023 05:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692620148; x=1724156148;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SWJbo7tRR27hpxLU8wMVzusoaS/OMxN+TKIypsZNcuw=;
  b=VfzaiVjENMBibdLEuxc1+CT9fOpOLDudpfZy77JxtamSRfrRiZSG+fV5
   seQpAtpqRbjvTehT/4wyCZVyX6/lzxZtYY11Jw4fU5Jh8yIwyN9Uo+54O
   qcmUMHY1srctJyZX53YdzKx/O780WrdlwxIjpChnXgg4vxNT7yRMXfqFL
   k+twYLwdY4oQGtIKXLXzIMptt0C4J05KJdx2+L/ILvPYm3RG2w+k93X8r
   rCoUhfxFb9EAf7CwMrfeXkzd9fhV7ilNDWdLGl1Fi5jC1Mr0ollGaD1c0
   T0Tk4D0liRq9ptYEdmW5Tfqw7IErDdf5f3gokYCunwYW1KdwIUHqf3vp0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="376322452"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="376322452"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 05:15:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="738878294"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="738878294"
Received: from hpabst-mobl.ger.corp.intel.com (HELO localhost) ([10.252.54.190])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 05:15:45 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag
 to give credits to who sponsored the patch
In-Reply-To: <ZONTiijMLWbt6naQ@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
 <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
 <20230817232348.GC1175@pendragon.ideasonboard.com>
 <ZN65iiRiSLmXz89k@casper.infradead.org> <87ttss7q8o.fsf@intel.com>
 <ZONTiijMLWbt6naQ@casper.infradead.org>
Date:   Mon, 21 Aug 2023 15:15:43 +0300
Message-ID: <87o7j07frk.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Aug 21, 2023 at 11:29:27AM +0300, Jani Nikula wrote:
>> On Fri, 18 Aug 2023, Matthew Wilcox <willy@infradead.org> wrote:
>> > but you might have (eg)
>> >
>> > Laurent Pinchard (Coca-Cola) <laurent.pinchart@ideasonboard.com>
>> >
>> > and then when working for another sponsor:
>> >
>> > Laurent Pinchard (Ford) <laurent.pinchart@ideasonboard.com>
>> 
>> Just an observation, git shortlog -s/-se groups/distinguishes,
>> respectively, the author and sponsor in Laurent's approach. Not so with
>> Matthew's approach.
>
> Hm?
>
> $ git shortlog -s next-20230817..
>      1  Matthew Wilcox (Novartis)
>     25  Matthew Wilcox (Oracle)
>
> $ git shortlog -se next-20230817..
>      1  Matthew Wilcox (Novartis) <willy@infradead.org>
>     25  Matthew Wilcox (Oracle) <willy@infradead.org>

$ git shortlog v6.4.. -s --author="Laurent Pinchart"
    12  Laurent Pinchart

$ git shortlog v6.4.. -se --author="Laurent Pinchart"
     2  Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    10  Laurent Pinchart <laurent.pinchart@ideasonboard.com>

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
