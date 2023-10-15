Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484EC7C9802
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 07:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjJOF3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 01:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjJOF3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 01:29:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00942B7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697347787; x=1728883787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ol2mskPaIAGU2DmeZWM0ybt7o8CfsN8HfxPqGue9/EE=;
  b=F2UODCP+9Vsyg49X7f/WTMgusqxxj2AezMibC1VYEx9bw/e+GqUSnqaN
   9E1rkm9BmYd5w1R+6wxuMK7a/m3hKu5kbIO09xuFpgFNitCmLX6BMIMA9
   BhAHKa6m1sJk7UXYaF/wK2OHyT0pNm6ElPsPVcskKM06bTQ9sQz+BZJhW
   eoYk06lQg8wwsCS0tVS9XAy44CmHMH2n3pCfsUhuhvGGs8Kyxiyhkx2nl
   WjDxtkUmnfl08FGKYy/hpRUhtx+4g5sjPRnYDFKMgpGKbjFASMOM94zku
   ECBYEu9GT9Hs+JkmRN0TMVOthNY78CqnbSmaARQ+L1chMo1kJCxl+XxFT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="384239281"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="384239281"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 22:29:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="790380795"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="790380795"
Received: from ingmingt-mobl1.gar.corp.intel.com (HELO intel.com) ([10.214.164.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 22:29:42 -0700
Date:   Sun, 15 Oct 2023 07:29:29 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 0/4] staging: vme_user: Coding style cleanup patches
Message-ID: <ZSt4uZcQxm4jN+Fy@ashyti-mobl2.lan>
References: <cover.1697240381.git.soumya.negi97@gmail.com>
 <20231014200241.GA20874@Negi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014200241.GA20874@Negi>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soumya,

On Sat, Oct 14, 2023 at 01:02:42PM -0700, Soumya Negi wrote:
> On Fri, Oct 13, 2023 at 04:47:12PM -0700, Soumya Negi wrote:
> > This patchset performs trivial code cleanups on the driver 
> > staging/vme_user to improve code readability. All patches address 
> > issues reported by checkpatch.pl, and may be applied in any sequence.
> 
> I have made a mistake here in the cover letter message. These patches need to
> be applied in order. I think I will have to send a v2. Will hold off on
> sending it just in case any other problems are pointed out by someone after 
> review.  

No need to resend for this reason. Patches in patchsets are
anyway always applied in the sequence they are sent.

Andi
