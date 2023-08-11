Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E52A77898D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjHKJQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjHKJQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:16:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B341FF1;
        Fri, 11 Aug 2023 02:16:20 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="356598933"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="356598933"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:16:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="856241920"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="856241920"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 11 Aug 2023 02:16:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qUOFk-00885B-2V;
        Fri, 11 Aug 2023 12:16:16 +0300
Date:   Fri, 11 Aug 2023 12:16:16 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Alexander Ofitserov <oficerovas@altlinux.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pinctrl: tigerlake: Add Alder Lake-P ACPI ID
Message-ID: <ZNX8YLy2akM9mQ0v@smile.fi.intel.com>
References: <20230810115938.3741058-1-oficerovas@altlinux.org>
 <20230810115938.3741058-5-oficerovas@altlinux.org>
 <20230811050728.GV14638@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811050728.GV14638@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 08:07:28AM +0300, Mika Westerberg wrote:
> On Thu, Aug 10, 2023 at 02:59:38PM +0300, Alexander Ofitserov wrote:
> > Intel Alder Lake-P has the same pin layout as the Tiget Lake-LP
> > so add support for this to the existing Tiger Lake driver.
> 
> Isn't it the same as Alder Lake-N so this ID should be added to the
> pinctrl-alderlake.c instead? Andy, do you know?

This is for v5.10 stable kernel. We need not to worry :-)

-- 
With Best Regards,
Andy Shevchenko


