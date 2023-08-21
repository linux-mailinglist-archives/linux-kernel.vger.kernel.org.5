Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5F3782C19
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjHUOjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjHUOjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:39:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B21E2;
        Mon, 21 Aug 2023 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692628742; x=1724164742;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=n+H1JgW1FSq0KiMcggmPISRuggzNMJX7eaMiKiqfo+U=;
  b=ed2nRecItHqt5hMQgb8p/eROaCrNtbZYkWKkN9iuHUGf62fOQt7Zk43X
   teQKjnnriQz3z0nmpA7GM4SahXDslu+uNBdiWN49NwIzEphE7hZ72Em4l
   hN6nU9kjVT+rAZyLi0wyUjaBjyHEppeenunY+RJivirWOBi/WXyIri76j
   ARPGfRZTreTEOXXBXyORWzIofb6E5X9STg9k5YxMdr/yHFiqFKtwbSH02
   qOOwcMrqkjCZYR3lGNekggnKXNTb09jA0dHjJ2s9SOjTbm8FrN+x2QIMt
   3mSqQEw5jr+ClqYyJhMTX4JeihLsbYAoUQ4zGcS7QFE6g7vMcBKc8s0Ap
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="371036580"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="371036580"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 07:39:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="738913417"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="738913417"
Received: from hpabst-mobl.ger.corp.intel.com (HELO localhost) ([10.252.54.190])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 07:39:00 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag
 to give credits to who sponsored the patch
In-Reply-To: <ZONfKKwFaDQpuZ9w@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
 <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
 <20230817232348.GC1175@pendragon.ideasonboard.com>
 <ZN65iiRiSLmXz89k@casper.infradead.org> <87ttss7q8o.fsf@intel.com>
 <ZONTiijMLWbt6naQ@casper.infradead.org> <87o7j07frk.fsf@intel.com>
 <ZONfKKwFaDQpuZ9w@casper.infradead.org>
Date:   Mon, 21 Aug 2023 17:38:57 +0300
Message-ID: <87lee4794u.fsf@intel.com>
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

On Mon, 21 Aug 2023, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Aug 21, 2023 at 03:15:43PM +0300, Jani Nikula wrote:
>> On Mon, 21 Aug 2023, Matthew Wilcox <willy@infradead.org> wrote:
>> > On Mon, Aug 21, 2023 at 11:29:27AM +0300, Jani Nikula wrote:
>> >> On Fri, 18 Aug 2023, Matthew Wilcox <willy@infradead.org> wrote:
>> >> > but you might have (eg)
>> >> >
>> >> > Laurent Pinchard (Coca-Cola) <laurent.pinchart@ideasonboard.com>
>> >> >
>> >> > and then when working for another sponsor:
>> >> >
>> >> > Laurent Pinchard (Ford) <laurent.pinchart@ideasonboard.com>
>> >> 
>> >> Just an observation, git shortlog -s/-se groups/distinguishes,
>> >> respectively, the author and sponsor in Laurent's approach. Not so with
>> >> Matthew's approach.
>> >
>> > Hm?
>> >
>> > $ git shortlog -s next-20230817..
>> >      1  Matthew Wilcox (Novartis)
>> >     25  Matthew Wilcox (Oracle)
>> >
>> > $ git shortlog -se next-20230817..
>> >      1  Matthew Wilcox (Novartis) <willy@infradead.org>
>> >     25  Matthew Wilcox (Oracle) <willy@infradead.org>
>> 
>> $ git shortlog v6.4.. -s --author="Laurent Pinchart"
>>     12  Laurent Pinchart
>> 
>> $ git shortlog v6.4.. -se --author="Laurent Pinchart"
>>      2  Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>     10  Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> I must not be understanding your point correctly.

That's probably a correct assesment, and not necessarily your fault. ;)

My point was that git shortlog -s groups and adds up the commits
together if the name is the same, but -se can still be used to
distinguish the mbox+tag difference in email. 12 for -s, but 2 and 10
for -se in Laurent's stats above.

If the names differ, even if just by the thing in parens, git shortlog
won't combine them.

> $ git shortlog v6.4.. -s --author="Matthew Wilcox"
>      7  Matthew Wilcox
>      1  Matthew Wilcox (Novartis)
>    123  Matthew Wilcox (Oracle)
>
> That seems to me like it successfully distinguishes my fake commit on
> behalf of Novartis (who I haven't actually worked for since 1997) from
> my real commits on behalf of Oracle.  It also shows a few places where
> my commits weren't attributed to Oracle (I think this happens when I
> send patches using mutt instead of git-send-email)

I'm not saying either is right or wrong or has any shortcomings, I'm
just saying they're *different* in this regard.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
