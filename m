Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2657C9863
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 10:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjJOIYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 04:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjJOIYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 04:24:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9682BAD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 01:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697358256; x=1728894256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UCl1SBB4cAuFZdCAf7wLUcAPW3DezCTL2qwAVti9xak=;
  b=bx0G7+V7zYxefWfGd185aHUaNmsNBV67SUi52RH3jtRQxRinVK5lqWGp
   KAHNtZCdXlgBij5hW1zBg8c5IeOtn0O+J7PhC2r0cJEq6wSKpBYKskz29
   8Nnau/4B/5Ny4Xvd0pzuWaaaBWYcU99T5cKZz2IYgfu6zv8nmZr8tn6gk
   QtpLI1pMs+ceEwH26WbjwYZ9wUQK5c0pTyRbAxP7tZrLbXeqMvz9OHiNe
   GlZqZ5OAzglup4TNWmwpvUXXiX6EQu3690FYwlZtoLQ2ns6jq/htx8yed
   OgnrN89mz+Ja2ss9AhL4KDojBYCAw1eUsBOXst/FmWAPT5NCdigejaj3q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="384247394"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="384247394"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 01:24:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="825617109"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="825617109"
Received: from ingmingt-mobl1.gar.corp.intel.com (HELO intel.com) ([10.214.164.147])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 01:24:12 -0700
Date:   Sun, 15 Oct 2023 10:24:06 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: Align descendant arguments
Message-ID: <ZSuhpu97lW45BEeS@ashyti-mobl2.lan>
References: <ZSuYUmX5P5M0Ok/I@gilbert-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSuYUmX5P5M0Ok/I@gilbert-PC>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gilbert,

On Sun, Oct 15, 2023 at 08:44:18AM +0100, Gilbert Adikankwu wrote:
> Adhere to Linux kernel coding style.
> 
> "...A very commonly used style is to align descendants to a function
> open parenthesis" - (Excerpted from Linux kernel coding style (#2))
> 
> Reported by checkpatch:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8180_93cx6.c     |  4 ++--
>  drivers/staging/rtl8192u/r8190_rtl8256.c   | 16 +++++++--------
>  drivers/staging/rtl8192u/r8192U_core.c     | 20 +++++++++---------
>  drivers/staging/rtl8192u/r8192U_dm.c       | 24 +++++++++++-----------
>  drivers/staging/rtl8192u/r819xU_firmware.c |  4 ++--
>  drivers/staging/rtl8192u/r819xU_phy.c      |  2 +-
>  6 files changed, 35 insertions(+), 35 deletions(-)

Do you mind splitting one patch per file? It's not really
necessary, but normally easier to review.

As you are here, if you then run checkpatch on your patch you
will gather ideas for your next patches.

Andi
