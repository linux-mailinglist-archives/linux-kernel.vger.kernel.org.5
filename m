Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31AE762968
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjGZDpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZDpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:45:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A286268E;
        Tue, 25 Jul 2023 20:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690343110; x=1721879110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jlVDrS56s+CBtGs+BWA87KFM+q0NC+LOcPYHKX50EL0=;
  b=HpZRebwcl/eH3JP4MRCyJnqisTFt0IzO4NpFYuyKCb2FhPsNu9bjHlAD
   VzvscFzkeEIWBBBHV0L57+8IWfSUQwH8J4Z4aK6cRA3+lhGT11fdpSSKE
   pcTJ7XyTq1kDGMnlDN5UtFgIl6caC9uWAOSgT1RaK6TecvHw3Lg9BsUUH
   FjelZ+j1mbFa8XF4hSLK3QH8ZriS4Eer8/YlKQPcLuZTcHZxLMFkjl0eX
   t7DQVtbARYezE2lmiMcV6ovR16ETWWJzYkZqipRBFPZnjmtZcl/L7G0qg
   qbS1GMAmSaKTeybd8QmpILXbeb7ZAmA2eueHxYdJr/qbfT3k9Lr+mON/6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="431708073"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="431708073"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 20:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="972931858"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="972931858"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.14.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 20:45:09 -0700
Date:   Tue, 25 Jul 2023 20:45:07 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Raghu Halharvi <raghuhack78@gmail.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v6 0/2] Fixing check patch styling issues
Message-ID: <ZMCWw09Huez5ikef@aschofie-mobl2>
References: <20230725194339.1694-1-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725194339.1694-1-raghuhack78@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 07:43:39PM +0000, Raghu Halharvi wrote:
> v6 changes:
> - The v5 was approved was not committed, submitting both patches(v6)
>   addressing styling issues in cxl/mbox.c and cxl/region.c after
>   rebasing with latest source. The changes remain same except the
>   function in which redundant dev_err() was present has been renamed to
>   cxl_memdev_state_create. (Alison/Ira)

Hi Raghu,

This posting is a new cover letter alone, and it has the same exact
Subject line as the previous cover letter which had patches attached.
As you might imagin, that is confusing to humans and may be confusing
to automated tools.

Please try this:

Next version is v7, not a resend

v7 changes:
- Append the actual patches that were omitted in previous send
- Update the v6 changelog
- Reorder and remove blank line in Patch Tags

v6 changes:
- Rebase 
- Do the redundant dev_err() cleanup in cxl_memdev_state_create()


By Reorder the patch tags, I mean:

Replace this:
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>

With this:
Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

There should be no space among the tags, and they get listed in
the order of arrival. ie. You gave your Signed-off-by first,
and then the Reviewed-by tags follow. The maintainer who applies
your patches, will add their Signed-off-by Tag last upon merging.

(If you'd like to try something new and useful, look up git format-patch
--base option. We often use that in a patchset to tell reviewers and
those who will apply the set, the base commit)

Thanks for keeping at it Raghu!

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
