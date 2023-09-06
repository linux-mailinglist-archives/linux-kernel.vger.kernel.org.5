Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD71A793FBF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242017AbjIFO47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240050AbjIFO45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:56:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031831997;
        Wed,  6 Sep 2023 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694012204; x=1725548204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T6p79sxBTSQW8gACuQTGbIFjx2l3tJJvcobYbaBsCOw=;
  b=UgQWZsULYAHgw+d6lnrkPCbUCAFBmkgISZXfhdyReCnJyjEkMri9cLF6
   ox3DHvE6NbZtdBH5pRyIgs0zTv7L2Eo6qyOBV64XkLUJnvQFxYGAEUkVt
   mhl3ozTrsN39GQmhKrRcAmlMcoFiyZ8Hbghmt7MKjf+XVXXhe0cWtpN7a
   roTRx9ZcnUnREGewTOUs2FBRnpGH35L/L3GQPxcHLbe1x3Aas4sHOeVoB
   cfqYu2ei2a5EzPy0qUD5qak3lZw4gCRHh3vHl608LwH2mwgVZicmCPB50
   CYWNnHAOvKeZEOp4kTkx1THYun0y/Ajvkk64RydSg37sXctoDGPdvHuhT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="362117767"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="362117767"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="741580761"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="741580761"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:56:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdtx7-006y8U-35;
        Wed, 06 Sep 2023 17:56:21 +0300
Date:   Wed, 6 Sep 2023 17:56:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, sumitg@nvidia.com,
        arnd@arndb.de, pshete@nvidia.com, digetx@gmail.com,
        petlozup@nvidia.com, windhl@126.com, frank.li@vivo.com,
        robh@kernel.org, stefank@nvidia.com, pdeschrijver@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] soc/tegra: fuse: Add ACPI support
Message-ID: <ZPiTFXa0/D2UN1SE@smile.fi.intel.com>
References: <20230905125824.2947-1-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905125824.2947-1-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 06:28:18PM +0530, Kartik wrote:
> This series of patches add ACPI support for Tegra194 and Tegra234 in
> Tegra fuse and apbmisc drivers. It also adds support for Tegra241
> which uses ACPI boot.

Neither here, nor in the individual patches I do _not_ see the changelog.
What's going on?

-- 
With Best Regards,
Andy Shevchenko


