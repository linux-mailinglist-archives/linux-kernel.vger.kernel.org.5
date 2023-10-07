Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04347BC531
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbjJGGxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjJGGxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:53:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C80DCE;
        Fri,  6 Oct 2023 23:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696661619; x=1728197619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zYyn229Imi9+jfEFbjdwAuVZqcq7yJRjraALGvsoCu0=;
  b=G2RbUon17wJC/xWSTVKdygPWZigKJ2bbONrZugMu6lybbNKDpsuqJCys
   tR/bxol4+8wy4byjF9mKRhRtCLyj8tsUJYsPsaUmf3kYFSRN8Bgq54G3I
   s8PLWsaC5l0pjvfPnu/ABDEVKMWjeHOQmOJSHbqUr/mt0vrs/sehuUKoL
   ZYma+PpQt0Ov5fUIqxZhTHj5/0tkndtCGFrCcDnLPO553ZxT8GAeow2Jr
   tBpYDe56A7l0gk9pLdiD8s78xTdNZgcuuLXmDkzErR0JYp1LHUYzjbBmV
   WHDD1vOgxNm87mJoIOdeRJsEX7NjJ6UC2hyqAL/vQuQ9KgoKFyYXwNFj7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="363256380"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="363256380"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 23:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="896174420"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="896174420"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2023 23:52:02 -0700
Date:   Sat, 7 Oct 2023 14:52:46 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     "Colberg, Peter" <peter.colberg@intel.com>
Cc:     "russ.weight@linux.dev" <russ.weight@linux.dev>,
        "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>, "Rix, Tom" <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH 2/3] fpga: m10bmc-sec: Change contact for secure update
 driver
Message-ID: <ZSEAPvn6FS2Rcesq@yilunxu-OptiPlex-7050>
References: <20230928164753.278684-1-russell.h.weight@intel.com>
 <7e67b2684e5b58bd61fcc7110ca90e1387f5e0ea.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e67b2684e5b58bd61fcc7110ca90e1387f5e0ea.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:19:30PM +0000, Colberg, Peter wrote:
> On Thu, 2023-09-28 at 09:47 -0700, Russ Weight wrote:
> > Change the maintainer for the Intel MAX10 BMC Secure Update driver from
> > Russ Weight to Peter Colberg. Update the ABI documentation contact
> > information as well.
> > 
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> 
> Acked-by: Peter Colberg <peter.colberg@intel.com>

Applied.

Thanks,
Yilun

> 
> > ---
> >  .../testing/sysfs-driver-intel-m10-bmc-sec-update  | 14 +++++++-------
> >  MAINTAINERS                                        |  2 +-
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> > index 0a41afe0ab4c..9051695d2211 100644
> > --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> > +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> > @@ -1,7 +1,7 @@
> >  What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_root_entry_hash
> >  Date:		Sep 2022
> >  KernelVersion:	5.20
> > -Contact:	Russ Weight <russell.h.weight@intel.com>
> > +Contact:	Peter Colberg <peter.colberg@intel.com>
> >  Description:	Read only. Returns the root entry hash for the static
> >  		region if one is programmed, else it returns the
> >  		string: "hash not programmed".  This file is only
> > @@ -11,7 +11,7 @@ Description:	Read only. Returns the root entry hash for the static
> >  What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_root_entry_hash
> >  Date:		Sep 2022
> >  KernelVersion:	5.20
> > -Contact:	Russ Weight <russell.h.weight@intel.com>
> > +Contact:	Peter Colberg <peter.colberg@intel.com>
> >  Description:	Read only. Returns the root entry hash for the partial
> >  		reconfiguration region if one is programmed, else it
> >  		returns the string: "hash not programmed".  This file
> > @@ -21,7 +21,7 @@ Description:	Read only. Returns the root entry hash for the partial
> >  What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_root_entry_hash
> >  Date:		Sep 2022
> >  KernelVersion:	5.20
> > -Contact:	Russ Weight <russell.h.weight@intel.com>
> > +Contact:	Peter Colberg <peter.colberg@intel.com>
> >  Description:	Read only. Returns the root entry hash for the BMC image
> >  		if one is programmed, else it returns the string:
> >  		"hash not programmed".  This file is only visible if the
> > @@ -31,7 +31,7 @@ Description:	Read only. Returns the root entry hash for the BMC image
> >  What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/sr_canceled_csks
> >  Date:		Sep 2022
> >  KernelVersion:	5.20
> > -Contact:	Russ Weight <russell.h.weight@intel.com>
> > +Contact:	Peter Colberg <peter.colberg@intel.com>
> >  Description:	Read only. Returns a list of indices for canceled code
> >  		signing keys for the static region. The standard bitmap
> >  		list format is used (e.g. "1,2-6,9").
> > @@ -39,7 +39,7 @@ Description:	Read only. Returns a list of indices for canceled code
> >  What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/pr_canceled_csks
> >  Date:		Sep 2022
> >  KernelVersion:	5.20
> > -Contact:	Russ Weight <russell.h.weight@intel.com>
> > +Contact:	Peter Colberg <peter.colberg@intel.com>
> >  Description:	Read only. Returns a list of indices for canceled code
> >  		signing keys for the partial reconfiguration region. The
> >  		standard bitmap list format is used (e.g. "1,2-6,9").
> > @@ -47,7 +47,7 @@ Description:	Read only. Returns a list of indices for canceled code
> >  What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/bmc_canceled_csks
> >  Date:		Sep 2022
> >  KernelVersion:	5.20
> > -Contact:	Russ Weight <russell.h.weight@intel.com>
> > +Contact:	Peter Colberg <peter.colberg@intel.com>
> >  Description:	Read only. Returns a list of indices for canceled code
> >  		signing keys for the BMC.  The standard bitmap list format
> >  		is used (e.g. "1,2-6,9").
> > @@ -55,7 +55,7 @@ Description:	Read only. Returns a list of indices for canceled code
> >  What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../security/flash_count
> >  Date:		Sep 2022
> >  KernelVersion:	5.20
> > -Contact:	Russ Weight <russell.h.weight@intel.com>
> > +Contact:	Peter Colberg <peter.colberg@intel.com>
> >  Description:	Read only. Returns number of times the secure update
> >  		staging area has been flashed.
> >  		Format: "%u".
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b97ee6f50679..8006c35956bb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10755,7 +10755,7 @@ F:	drivers/mfd/intel-m10-bmc*
> >  F:	include/linux/mfd/intel-m10-bmc.h
> >  
> >  INTEL MAX10 BMC SECURE UPDATES
> > -M:	Russ Weight <russell.h.weight@intel.com>
> > +M:	Peter Colberg <peter.colberg@intel.com>
> >  L:	linux-fpga@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> 
