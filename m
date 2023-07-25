Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571187620A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjGYRzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGYRzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:55:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F5194;
        Tue, 25 Jul 2023 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690307747; x=1721843747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=27IVIeQ+PEqUgtLMK6prQUdOsVkJCQ7pzE+Cmq0s4/I=;
  b=SeeZFu6MkHqmY3+wAXZurgcBU/ct8BLe+AaRdFq10ecrqCgpjyIoWoeL
   4cD0FfP9Ao4zTXqJzvbG76NeSzDaMQ3ZCiLGmjguo1DrYq5jypEV5Qamw
   pig9dQCmhffeIHVwThlM6vhgiEThwO9MTZ3rBI18nfteZYJScPDuSR0Bi
   94k4esOGtfIl0YEfGiDX7FeX1BPkKlJyh0SfNm9Ss6AoFM92MJGoaG9/Q
   4knkbQH4aKxqA0cID4qvx3BXvZkXU3jKb7fkGCBcp0FcUmtjKBQ4qqXj+
   Htz5l0kXPZtPoStvaJ3JXvY6/Sp4cRXUNnPIqfO3MadCLnM0ZSwpL/061
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="371412871"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="371412871"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 10:55:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="761312687"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761312687"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.14.85])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 10:55:42 -0700
Date:   Tue, 25 Jul 2023 10:55:41 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Raghu Halharvi <raghuhack78@gmail.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH RESEND v6 0/2] Fixing check patch styling issues
Message-ID: <ZMAMnd8Pg5vGKKH7@aschofie-mobl2>
References: <20230725121930.3732-1-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725121930.3732-1-raghuhack78@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 12:19:28PM +0000, Raghu Halharvi wrote:
> v6 changes:
> - PATCH RESEND, the v5 was approved was not committed, Ira suggested to
>   resend both patches.

Hi Raghu,

If this was a true RESEND, the version number should not have changed.
See: Documentation/process/submitting-patches.rst

Alas, this v6 has changes from v5 that are not listed here, so this
is not a RESEND, it is a new version.

Both patches were rebased, and in Patch 1 that led to a changed
function name too.

What to do? 
How about you send a reply to this cover letter with the v5->v6
changelog, and let's see if that's clear enough.

Thanks,
Alison





> 
> v5 changes:
> - Updated the missing reviewed tag in "cxl/mbox: Remove redundant
>   dev_err() after failed mem alloc" patch (Dave Jiang)
> 
> v4 changes:
> - Updated the respective patches with reviewers tags for respective
>   patches(Dave Jiang)
> 
> v3 changes:
> - Update the cover letter and commit message with full author
>   name(Fabio/Alison)
> - Correct the "typo error" in commit message(Fabio)
> 
> v2 changes:
> Thanks Alison, Ira for your comments, modified the v1 patches as
> suggested.
> Dropped the patch containing tab changes in port.c
> 
> v1 cover letter:
> The following patches are cleanup or fixing the styling issues found
> using checkpatch
> 
> In cxl/core/mbox.c, in case of null check failure, returning errno or
> -ENOMEM in this case is good enough, removing the redundant dev_err
> message.
> 
> In cxl/core/region.c, the else is not required after the return
> statement, cleaned it up.
> 
> Verified the build and sanity by booting the guest VM using the freshly
> built components.
> 
> Raghu Halharvi (2):
>   cxl/mbox: Remove redundant dev_err() after failed mem alloc
>   cxl/region: Remove else after return statement
> 
>  drivers/cxl/core/mbox.c   | 4 +---
>  drivers/cxl/core/region.c | 8 ++++----
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> -- 
> 2.39.2
> 
