Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33587D0B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376572AbjJTJIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376552AbjJTJIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:08:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADD2AB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697792878; x=1729328878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Fo7P9SabarNMDvAtym6whJdq1TKNFcIppH/+OETBG8=;
  b=mNh3omRKG8iodY7d2FAd+YOGYR2ohw25M8/Jfr0UlaViKj8Yl1HUupbm
   Bn/9b/o+796QKRKRuxXjJx8qPDLHnA4v8I4X4NUyTnIc41On0ruBTAZH+
   60OCNIvwuDPzlzcjXHkc2ihxev/YdZq2WAyMOEWfEMOOb5b5WHPXba8J3
   2Q7LgDV7vek5CZtzAL2H+GuucqTSLgGaJvZfrfzZMffdlfNpnaESq0uWQ
   ScKfg1q1MWJuT1cjMaQaLVh2EAIU+fI09Av0M44lFFvazC5yY8oYiW1qz
   qmEtEA6L/VBGBf4uVKfHr1AQkldBNFFmjo42dt8rgnq+MH1OQ+FcvTzOZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450688011"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450688011"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:07:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="873839479"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873839479"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:07:56 -0700
Date:   Fri, 20 Oct 2023 11:07:54 +0200
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: ivpu TODO list items
Message-ID: <20231020090754.GA563066@linux.intel.com>
References: <ZSjwuyCOL9Vb9+yb@runicha.com>
 <ZS68dysac34rA32D@runicha.com>
 <20231018075053.GB525429@linux.intel.com>
 <ZTATkznuHyX4rUit@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTATkznuHyX4rUit@runicha.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:49:15PM +0530, Deepak R Varma wrote:
> > > > 2. Is it absolutely necessary for me to have a specialized hardware to test my
> > > > patches? Is it limited to the 14thGen or above CPU or do I need more than that?
> > Yes, I don't think someone can work on ivpu without hardware.
> 
> Okay. Could you suggest what would be the minimum hardware required to explore
> this driver?

As you wrote, you need to have 14th gen Intel CPU i.e. Meteor Lake.
Only this ... or as much as this.

Regards
Stanislaw
