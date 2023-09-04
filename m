Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2980179158B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345257AbjIDKNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344311AbjIDKNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:13:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C425519B;
        Mon,  4 Sep 2023 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693822382; x=1725358382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XS++ZPMYyd6tePay/xpk8nQULoPGc+paf1zNdqr0igk=;
  b=g3kTJ2c2iU9cgi/6t30DuUwrf1zBA+TBMglRLd4eUZybeeZpVdpATYnJ
   8piEZ1QoZ1d7hFDd/9mwkFJ1HYy0MoexnMZqDCwY2Lkk05rB9KIoj8hZj
   2/fvsjerhjXRKS3MT3/8p7/R2tei1+EV0fDZYw9+VfRl9zjfWQ/PgMseS
   AgmC5RpByVjU3wCAZM1lllFcPBu3lzFUN3AuIgr+M/5QGl5lONcd+pTuQ
   ptG7F9aQqmRRPxTliMj3x3GCmIGO0P4c4xOY0nGI3GO5wHQBcQ6NSuZ04
   UBWjOL/NIXU0vM/kMLB9OXs9DTettGEhHhYFN2/ns/EKLs4AK6LunOtIu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="440530952"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="440530952"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="690543123"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="690543123"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:12:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd6Zj-006Oec-2J;
        Mon, 04 Sep 2023 13:12:55 +0300
Date:   Mon, 4 Sep 2023 13:12:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH 0/2] Match data improvements for bq256xx driver
Message-ID: <ZPWtpxi/8t1oTC8d@smile.fi.intel.com>
References: <20230902202505.97609-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902202505.97609-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 09:25:03PM +0100, Biju Das wrote:
> This patch series aims to add match data improvements for bq256xx driver.
> 
> This patch series is only compile tested.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


