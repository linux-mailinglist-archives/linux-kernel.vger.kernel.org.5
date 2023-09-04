Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330CC79157D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbjIDKIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjIDKIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:08:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65DECC4;
        Mon,  4 Sep 2023 03:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693822094; x=1725358094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6MJO084/9+QQ3CfIH+7hHqfnRSbi/y95iDpamtgD/T0=;
  b=ZLP/bDWroOAkzj9r5Qz+k39W5qVuXcwf5nx4BPx/lSL2MBIE9YVskS03
   4PePdKfo2SkJE8Y/s/Ix1fhBqn4Ofx/+Q/81rla+caBFA//HQxcaPVhsf
   1V6dKxrHGzXQgkiOsmCYC88RGn5PlSpZJs1sig9oDJSU2SETlJ7pjgljI
   ZA2A42jpIud60O/+qkjHM/WqsiruCk95X2SvhAuw4M5p1hu8cmLAPqyMd
   K64Ohj01jK65h+LsaztDyy3lywUpGyt3ZvaGVAiypoxTXvOGrbSXAuNfH
   r6eMz6BywVyUL+YJSGYnxqAZwVffNGe5dmqN8Q5EEV2KVpZhMBwSzb8HM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="442962683"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="442962683"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="830854988"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="830854988"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:08:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd6V7-006OaU-2N;
        Mon, 04 Sep 2023 13:08:09 +0300
Date:   Mon, 4 Sep 2023 13:08:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH 2/2] power: supply: bq24257_charger: Some cleanups
Message-ID: <ZPWsiWoZnQ905lUC@smile.fi.intel.com>
References: <20230902193331.83672-1-biju.das.jz@bp.renesas.com>
 <20230902193331.83672-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902193331.83672-3-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 08:33:31PM +0100, Biju Das wrote:
> Some cleanups:
>  * Remove trailing comma in the terminator entry for OF/ID/ACPI table.
>  * Drop a space from terminator entry for OF table.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


