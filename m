Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7C87A4760
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbjIRKln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241269AbjIRKlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:41:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12A611C;
        Mon, 18 Sep 2023 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695033660; x=1726569660;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ugc2wNu981yB2nrvpP64pWRpKjG80URNHkXdKVbMyIA=;
  b=SdJ9E6W9WNMl+cOTY2jdiuRL+6rfhe0fwnU9ktAQZ3NZh+wm6YZk9FdI
   Mw9xn0wosb7tp2R07vUReOaCkNQPuClUa0C202VduoQDzIXaY0zEN16o1
   9vJXAic/0zGHuhq+51/TBiQNLOGMi1suOa2iyfa4AHd797Z3xAW0WuyuI
   z60JwFMSWEXxBrNwgHWGR7DHSRxiaZvrUV9xRqgQdiRNHMlv/8Wo5uXnO
   96P1mk0IM6eLaJolrX475wmzvjZZ+M/rmcEA83IbqKLwVd31s/OsRVT+C
   o23ZfqHa6EcaCmZpZ+L77HNA09I1qWbd4iU/CpzL3fltE8VRto4hb2BaH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="410577181"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="410577181"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 03:40:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="695470218"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="695470218"
Received: from nprotaso-mobl1.ccr.corp.intel.com ([10.252.49.156])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 03:40:17 -0700
Date:   Mon, 18 Sep 2023 13:40:15 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add myself into x86 platform driver
 maintainers
In-Reply-To: <ZQgnz4G2nzYqsaqk@smile.fi.intel.com>
Message-ID: <f45f4e63-6762-55ba-9544-ea76804b146@linux.intel.com>
References: <20230918102901.17669-1-ilpo.jarvinen@linux.intel.com> <20230918102901.17669-2-ilpo.jarvinen@linux.intel.com> <ZQgnz4G2nzYqsaqk@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1151630269-1695033619=:1832"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1151630269-1695033619=:1832
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 18 Sep 2023, Andy Shevchenko wrote:

> On Mon, Sep 18, 2023 at 01:29:01PM +0300, Ilpo Järvinen wrote:
> > Hans has been asking for another person to help as the maintainer of
> > the x86 platform driver because Mark has not been able to find time to
> > do that. I got asked for the task and have been reviewing the relevant
> > patches for a while now but lets make it more official by adding the
> > MAINTAINERS entries.
> 
> Shan't we simply replace Mark by you?

While I'd have had another patch prepared to drop Mark besides adding 
mine, I'd rather have some response from him prior to sending it out :-). 
As I did not get any response in time, I left his entries as is for now, 
they're not that harmful.

> Either way,
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> and thank you for taking care of this!


-- 
 i.

--8323329-1151630269-1695033619=:1832--
